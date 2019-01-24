import cultures from '~/assets/js/cultures'

export default {
  getYear() {
    const date = new Date()
    return date.getFullYear()
  },
  save(string, arr) {
    if (arr && arr.length > 0) {
      return `${string} /\n${arr.join('\n')}\n/;\n\n`
    } else {
      return ''
    }
  },
  getMedianYieldCap(plots) {
    // disregard plots with a SQR of 0
    const sqrs = plots.map(plot => {if (plot.quality > 0) return plot.quality})
    const sorted = sqrs.slice().sort()
    const middle = Math.floor(sorted.length / 2)

    if (sorted.length % 2 === 0) {
      return _.round((sorted[middle - 1] + sorted[middle]) / 2,2)
    }

    return _.round(sorted[middle],2)
  },
  getCropFactAndRotBreak(curPlot,crops,plots,curCrop) {
    let croppingFactor = 1
    let rotBreakHeld = true
    // get previous crops grown on the plot
    const plotPrevYears = plots.filter(plot => {return (plot.id === curPlot.id && plot.year < curPlot.year)})
    if (plotPrevYears.length > 0) {
      // check if rotational break for crop is sufficient
      const sortedPlots = _.sortBy(plotPrevYears, ['year'])
      sortedPlots.forEach((plotYear,i) => {
        if (plotYear.year > curPlot.year - curCrop.rotBreak 
          && plotYear.crop === curCrop.code) rotBreakHeld = false
        // calculate rotational value of previous crop / current crop combination
        // however, adjust over time -> last years crop has greatest impact
        // impact is exponentially decreasing over time
        // we calculate the exponential moving average of the cropping factors
        const plotYearCrop = _.find(crops, {code: plotYear.crop, year: plotYear.year})
        if (i === sortedPlots.length - 1 && plotYearCrop) {
          croppingFactor = plotYearCrop.subseqCrops[curCrop.cropGroup] / 10
        } else if (i > 0) {
          //const prevCrop = sortedPlots[i-1].crop
          //const cropData = _.find(crops, {code: prevCrop, year: sortedPlots[i-1].year})
          //let prevFactor = cropData.subseqCrops[plotYearCrop.cropGroup]
          //prevFactor = prevFactor / (curPlot.year - plotYear.year) ** 2
        }
      })
    }
    return [croppingFactor,rotBreakHeld]
  },
  calculateDistanceCosts(curPlot,cropYield) {
    if (cropYield > 100) cropYield = 100
    const value = cropYield * (0.2915 * Math.abs(curPlot.distance - 2) + 1.4287) * curPlot.size
    if (curPlot.distance > 2) return value
    return value * -1
  },
  buildPlotCropMatrix(store) {
    const attributes = ['price', 'yield', 'directCosts', 'variableCosts', 'fixCosts', 'grossMargin', 'revenue', 'distanceCosts', 'croppingFactor', 'yieldCap']
    const matrix = {}
    const medianYieldCap = this.getMedianYieldCap(store.curPlots)
    
    store.curPlots.forEach(plot => {
      matrix[plot.id] = {}
      const yieldCap = _.round(plot.quality / medianYieldCap)
      store.crops.forEach(crop => {
        if (!matrix[plot.id][crop.year]) matrix[plot.id][crop.year] = {}
        const that = this
        const cropFactAndRotBreak = this.getCropFactAndRotBreak(plot,store.crops,store.plots,crop)
        const amount = _.round(_.sumBy(crop.contributionMargin.revenues, o => { return o.amount.value }))
        const correctedAmount = _.round(amount * cropFactAndRotBreak[0] * yieldCap, 2)
        const price = _.round(_.sumBy(crop.contributionMargin.revenues, o => { return o.total.value }) / amount, 2)
        const revenue = _.round(cropFactAndRotBreak[0] * plot.quality / medianYieldCap * price * correctedAmount, 2)
        const directCosts = _.round(_.sumBy(crop.contributionMargin.directCosts, o => { return o.total.value }), 2)
        const variableCosts =  _.round(_.sumBy(crop.contributionMargin.variableCosts, o => { return o.total.value }), 2)
        const distanceCosts = that.calculateDistanceCosts(plot,correctedAmount)
        
        matrix[plot.id][crop.year][crop.code] = {
          'croppingFactor': cropFactAndRotBreak[0],
          'rotBreakHeld': cropFactAndRotBreak[1],
          'name': crop.name,
          'active': crop.active,
          'code': crop.code,
          yieldCap,
          amount,
          correctedAmount,
          price,
          revenue,
          directCosts,
          variableCosts,
          distanceCosts,
          'grossMargin': _.round(revenue - directCosts - variableCosts - distanceCosts),
          'fixCosts': _.round(_.sumBy(crop.contributionMargin.fixCosts, o => { return o.total.value }), 2),
          'size': plot.size
        }
      })
    })
    return matrix
  },
  buildModel(matrix,store) {
    const year = store.curYear
    let include = ''
    // create set with all possible plots
    include += 'set plots /\n'
    Object.keys(matrix).forEach(plot => {
      include += `'${plot}'\n`
    })
    include += '/;\n\n'
    // create set with all possible crops
    include += 'set crops /\n'
    store.curCrops.forEach(crop => {
      include += `'${crop.code}'\n`
    })
    include += '/;\n\n'
    // create parameter containing gross margins per plot
    include += 'parameter p_grossMargin(plots,crops) /\n'
    store.curPlots.forEach(plot => {
      store.curCrops.forEach(crop => {
        crop = matrix[plot.id][year][crop.code]
        if (crop.rotBreakHeld && crop.active) {
          include += `'${plot.id}'.'${crop.code}' ${crop.grossMargin}\n`
        }
      })
    })
    include += '/;\n\n'
    // add constraints
    
    // load Fruchtfolge base model
    const baseModel = `Variable v_obje;
    Binary Variable v_binCropPlot(crops,plots);

    Equations
      e_obje
      e_oneCropPlot(plots)
    ;

    e_oneCropPlot(plots)..
      sum(crops, v_binCropPlot(crops,plots))
      =E= 1
    ;

    e_obje..
      v_obje =E=
        sum((plots,crops),
        v_binCropPlot(crops,plots)
        * p_grossMargin(plots,crops));
        
    model Fruchtfolge / all /;
    solve Fruchtfolge using MIP maximizing v_obje;
    
    File results / %random% /;
    results.lw = 40;
    put results;
    put "{"
    put '"model_status":',  Fruchtfolge.modelstat, "," /;
    put '"solver_status":', Fruchtfolge.solvestat, "," /;
    put '"objective":', v_obje.l, "," /;
    put '"recommendation":', "{"/;
    loop((plots),
      loop(crops,
        put$(v_binCropPlot.l(crops,plots) > 0) '"', plots.tl, '":', '"', crops.tl, '"' /
      )
      put$(ord(plots) < card(plots)) "," /
    );
    put "}" /;
    put "}" /;
    putclose;`
    // const baseModel = require('fruchtfolge-model')
    
    return include.concat(baseModel)
  },
  /*
  createInclude(properties) {
    console.log('createInclude');
    let include =
`* -------------------------------
* Fruchtfolge Model - Include file
* Institute for Food an Resource Economics
* University of Bonn
* (c) Christoph Pahmeyer, ${this.getYear()}
* -------------------------------

* Static data
set grossMarginAttr / price,yield,directCosts,variableCosts,fixCosts,grossMargin,revenue,distanceCosts,croppingFactor,yieldCap /;
set plotAttr / size,distance,quality /;
set cropAttr / rotBreak,maxShare,minSoilQuality,efaFactor/;
set symbol / lt,gt /;
set halfMonths / jan1,jan2,feb1,feb2,MRZ1,MRZ2,apr1,apr2,mai1,mai2,jun1,jun2,jul1,jul2,aug1,aug2,sep1,sep2,okt1,okt2,nov1,nov2,dez1,dez2 /;

set years / 2001*${properties.curYear} /;
set curYear(years) / ${properties.curYear} /;
`

    // create plot related data
    const curPlots = []
    let soilTypes = []
    const p_plotData = []
    const plots_soilTypes = []
    const plots_rootCropCap = []
    const plots_permPast = []
    const plots_excludedCrops = []

    soilTypes = _.uniqBy(properties.plots, 'soilType').map(type => { return `'${type.soilType}'` })

    properties.curPlots.forEach(plot => {
      curPlots.push(` '${plot.id}'`)
      p_plotData.push(` '${plot.id}'.size ${plot.size}\n '${plot.id}'.distance ${_.round(plot.distance, 2)}\n '${plot.id}'.quality ${plot.quality || 0}`)
      plots_soilTypes.push(` '${plot.id}'.'${plot.soilType}'`)
      if (plot.rootCrops) plots_rootCropCap.push(` '${plot.id}' 'YES'`)
      if (plot.permPast) plots_permPast.push(` '${plot.id}' 'YES'`)
      if (plot.excludedCrops && plot.excludedCrops.length > 0) {
        plot.excludedCrops.forEach(crop => {
          plots_excludedCrops.push(` '${plot.id}'.'${crop}' 'YES'`)
        })
      }
    })

    // create crop related data
    const curCrops = [` ''`]
    const cropGroup = [` ''`]
    const crops_cropGroup = [` ''.''`]
    const p_cropData = []
    const crops_rootCrop = []
    const crops_catchCrop = []
    const croppingFactor = []
    const laborReq = []
    const halfMonths = ['JAN1', 'JAN2','FEB1','FEB2','MRZ1','MRZ2','APR1','APR2','MAI1','MAI2','JUN1','JUN2','JUL1','JUL2','AUG1','AUG2','SEP1','SEP2','OKT1','OKT2','NOV1','NOV2','DEZ1','DEZ2']

    properties.curCrops.forEach(crop => {
      if (!crop) return
      if (cropGroup.indexOf(` '${crop.cropGroup}'`) === -1) cropGroup.push(` '${crop.cropGroup}'`)
      crops_cropGroup.push(` '${crop.name}'.'${crop.cropGroup}'`)
      // replace crop name with some sort of id in order to avoid strings that are too long / illegal characters?
      curCrops.push(` '${crop.name}'`)
      p_cropData.push(` '${crop.name}'.rotBreak ${crop.rotBreak}\n '${crop.name}'.maxShare ${crop.maxShare}\n '${crop.name}'.minSoilQuality ${crop.minSoilQuality}\n '${crop.name}'.efaFactor ${crop.efaFactor}`)
      if (crop.rootCrop) crops_rootCrop.push(` '${crop.name}' YES`)
      if (crop.catchCropCap) crops_catchCrop.push(` '${crop.name}' YES`)
      properties.curCrops.forEach(subseqCrop => {
        croppingFactor.push(` '${crop.name}'.'${subseqCrop.name}' ${crop.subseqCrops[subseqCrop.cropGroup]}`)
      })
      halfMonths.forEach(halfMonth => {
        var steps = crop.workingSteps.filter(o => {return halfMonth === o.month})
        if (steps && steps.length > 0) {
          steps = steps.map(step => {
            return _.sumBy(step.steps, 'time')
          })
          console.log(_.sum(steps), steps);
          const time = _.sum(steps)
          laborReq.push(` '${crop.name}'.${halfMonth} ${_.round(time,2)}`)
        }
      })
    })

    // create plot & crop related data
    const plots = []
    const plots_years_crops = []

    properties.plots.forEach(plot => {
      if (plots.indexOf(` '${plot.id}'`) === -1) plots.push(` '${plot.id}'`)
      if (plot.crop) plots_years_crops.push(` '${plot.id}'.${plot.year}.'${cultures[plot.crop] ? cultures[plot.crop].variety : '""'}' 'YES'`)
    })

    // create gross margin related data
    const crops = [` ''`]
    const p_grossMarginData = []

    properties.crops.forEach(crop => {
      if (crops.indexOf(` '${crop.name}'`) === -1) crops.push(` '${crop.name}'`)
      const amount = _.round(_.sumBy(crop.contributionMargin.revenues, o => { return o.amount.value }), 2)
      const price = _.round(_.sumBy(crop.contributionMargin.revenues, o => { return o.total.value }) / amount, 2)
      const directCosts = _.round(_.sumBy(crop.contributionMargin.directCosts, o => { return o.total.value }), 2)
      const variableCosts = _.round(_.sumBy(crop.contributionMargin.variableCosts, o => { return o.total.value }), 2)
      const fixCosts = _.round(_.sumBy(crop.contributionMargin.fixCosts, o => { return o.total.value }), 2)
      p_grossMarginData.push(` '${crop.name}'.${crop.year}.yield ${amount}\n '${crop.name}'.${crop.year}.price ${price}\n '${crop.name}'.${crop.year}.directCosts ${directCosts}\n '${crop.name}'.${crop.year}.variableCosts ${variableCosts}\n '${crop.name}'.${crop.year}.fixCosts ${fixCosts}`)

    })

    // constraints related data
    const constraints = []
    const p_constraint = []
    const constraints_lt = []

    if (properties.curConstraints) {
      properties.curConstraints.forEach(constraint => {
        constraints.push(` '${constraint.name}'`)
        p_constraint.push(` '${constraint.name}'.'${constraint.crop1}'.${constraint.crop2 ? constraint.crop2 : '""'} ${constraint.area}`)
        if (constraint.operator === '<') constraints_lt.push(` '${constraint.name}'.lt YES` )
      })
    }

    // build include file
    include += this.save('set soilTypes',soilTypes)
    include += this.save('set plots',plots)
    include += this.save('set curPlots(plots)',curPlots)
    include += this.save('parameter p_plotData(curPlots,plotAttr)', p_plotData )
    include += this.save('set plots_soilTypes(curPlots,soilTypes)', plots_soilTypes)
    include += this.save('set plots_rootCropCap(curPlots)', plots_rootCropCap)
    include += this.save('set plots_permPast(curPlots)', plots_permPast)
    include += this.save('set plots_excludedCrops(curPlots,crops)',plots_excludedCrops)

    include += this.save('set crops',crops)
    include += this.save('set curCrops(crops)',curCrops)
    include += this.save('set cropGroup',cropGroup)
    include += this.save('set crops_cropGroup(curCrops,cropGroup)',crops_cropGroup)
    include += this.save('parameter p_cropData(curCrops,cropAttr)', p_cropData )
    include += this.save('set crops_rootCrop(curCrops)', crops_rootCrop)
    include += this.save('set crops_catchCrop(curCrops)', crops_catchCrop)
    include += this.save('parameter p_croppingFactor(curCrops,curCrops)', croppingFactor)

    include += this.save('set plots_years_crops(plots,years,crops)',plots_years_crops)
    include += this.save('parameter p_grossMarginData(crops,years,grossMarginAttr)',p_grossMarginData)
    include += this.save('parameter p_laborReq(crops,halfMonths)',laborReq)
    include += this.save('set constraints',constraints)
    include += this.save('parameter p_constraint(constraints,curCrops,curCrops)',p_constraint)
    include += this.save('set constraints_lt(constraints,symbol)',constraints_lt)

    //
    fs.writeFileSync('test.gms',include,'utf-8')
    res.writeHead(200, {"Content-Type": "application/json"})
    res.write('bla')
    res.end()
    //
    return include
  }
  */
}
