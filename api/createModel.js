const query = require('./query.js')
const _ = require('lodash')
const fs = require('fs')

const model = {
  getYear() {
    const date = new Date()
    return date.getFullYear()
  },
  save(string, arr) {
    return `${string} / \n${arr.join('\n')}\n/;\n\n`
  },
  createInclude(properties,res) {
    console.log('createInclude');
    let include = 
`* -------------------------------
* Fruchtfolge Model - Include file
* Institute for Food an Resource Economics
* University of Bonn 
* (c) Christoph Pahmeyer, ${this.getYear()}
* -------------------------------

* Static data
set grossMarginAttr / price,yield,directCosts,varCosts /;
set plotAttr / size,distance,quality /;
set cropAttr / rotBreak,maxShare,minSoilQuality,efaFactor/;
set symbol / lt,gt /;
set halfMonths / feb1,feb2,mar1,mar2,apr1,apr2,may1,may2,jun1,jun2,jul1,jul2,aug1,aug2,sep1,sep2,oct1,oct2,nov1,nov2 /;

set years / 2001*${properties.curYear} /;
set curYear(years) / ${properties.curYear} /;
` 

    // create plot related data
    const plots = []
    let soilTypes = []
    const p_plotData = []
    const plots_soilTypes = []  
    const plots_rootCropCap = []
    const plots_permPast = []
    
    soilTypes = _.uniqBy(properties.plots, 'soilType').map(type => { return `'${type.soilType}'` })
    
    properties.plots.forEach(plot => {
      plots.push(` '${plot.id}'`)
      p_plotData.push(` '${plot.id}'.size ${plot.size}\n '${plot.id}'.distance ${plot.distance}\n '${plot.id}'.quality ${plot.quality}`)
      plots_soilTypes.push(` '${plot.id}'.'${plot.soilType}'`)
      plots_rootCropCap.push(` '${plot.id}' ${plot.rootCrops ? 'YES' : 'NO'}`)
      plots_permPast.push(` '${plot.id}' ${plot.permPast ? 'YES' : 'NO'}`)
    })
   
    include += save('set soilTypes',soilTypes)
    include += save('set plots',plots)
    include += save('parameter p_plotData(plots,plotAttr)', p_plotData )
    include += save('set plots_soilTypes(plots,soilTypes)', plots_soilTypes)
    include += save('set plots_rootCropCap(plots)', plots_rootCropCap)
    include += save('set plots_permPast(plots)', plots_permPast)

    // create crop related data
    const crops = [` ''`]
    const p_cropData = []
    const crops_rootCrop = []
    const crops_catchCrop = []
    const croppingFactor = []
    
    properties.crops.forEach(crop => {
      crops.push(` '${crop.name}'`)
      p_cropData.push(` '${crop.name}'.rotBreak ${crop.rotBreak}\n '${crop.name}'.maxShare ${crop.maxShare}\n '${crop.name}'.minSoilQuality ${crop.minSoilQuality}\n '${crop.name}'.efaFactor ${crop.efaFactor}`)

    })
    
    console.log(include);
    fs.writeFileSync('test.gms',include,'utf-8')
    res.writeHead(200, {"Content-Type": "application/json"})
    res.write('bla')
    res.end()
    //return include
  },
  async build(req,res) {
    try {
      const properties = await query(req, res)
      if (!properties.plots || !properties.crops) {
        throw new Error('No plots or crops')
      }
      console.log(properties);
      const includeFile = this.createInclude(properties,res)
    } catch (e) {
      console.log(e);
    }

  }
}

module.exports = model
