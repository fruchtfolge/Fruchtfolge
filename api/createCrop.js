// const querystring = require('querystring')
const query = require('./query.js')
const _ = require('lodash')
const Crop = require('../constructors/Crop')
const rotValues = require('../assets/js/cropRotValues.js')
const nano = require('nano')('http://localhost:5984');

// we use CouchDB instead of Nano so that we can use
// a replication stream from a file later
// for now, use data from local couch

module.exports = {
  createCrop(data, properties, year) {
    try {
      const cropData = Object.assign(data, properties)
      if (typeof(year) === 'number') {
        cropData.year = year
      } else {
        cropData.year = year.year
        cropData.contributionMargin = this.adjustCM(cropData.contributionMargin, year)
        console.log(cropData.year);
      }
      // only activate the crop for the current planning year
      if (properties.year === cropData.year) {
        cropData.active = true
      }
      // append crop rotational information to crop
      const rotation = _.find(rotValues, ['cropGroup',properties.cropGroup])
      cropData.subseqCrops = rotation.subseqCrops
      cropData.efaFactor = rotation.efa
      cropData.legume = rotation.legume
      cropData.rootCrop = rotation.rootCrop
      cropData.minSoilQuality = rotation.minSoil
      cropData.rotBreak = rotation.rotBreak

      // create the crop
      const crop = new Crop(cropData)
      return crop
    } catch (e) {
      console.log(e)
    }
  },
  async getInfo(req, res) {
    try {
      const properties = await query(req, res)
      const id = `${properties.farmingType}::${properties.crop}::${properties.system}`
      const crops = nano.db.use('crops')
      const data = await crops.get(id)
      // upsert crop for every year from 2000, in order to show price and yield variation
      // when SDB's are present, use that data
      // if not, replicate contribution margin for every year
      const docs = []
      /*
      if (data.standardGrossMargin.length > 0) {
        console.log(properties);
        if (!properties.region) properties.region = 'Deutschland'
        const regionalData = _.filter(data.standardGrossMargin, {region: properties.region})
        regionalData.forEach(year => {
          const clonedCropData = _.cloneDeep(data)
          const crop = this.createCrop(clonedCropData, properties, year)
          docs.push(crop)
        })
      } else {
        const years = this.years(properties)
        //console.log(years);
        years.forEach(year => {
          const crop = this.createCrop(data, properties, year)
          docs.push(crop)
        })
      }
      */
      const years = properties.years
      years.forEach(year => {
        const clonedCropData = _.cloneDeep(data)
        if (data.standardGrossMargin.length > 0) {
          if (!properties.region) properties.region = 'Deutschland'
          const regionalData = _.filter(data.standardGrossMargin, {region: properties.region, year: year})
          if (regionalData.length > 0) year = regionalData[0]
        }
        const crop = this.createCrop(clonedCropData, properties, year)
        docs.push(crop)
      })
      
      console.log(docs.length)
      res.writeHead(200, {"Content-Type": "application/json"})
      res.write(JSON.stringify(docs))
      res.end()

    } catch (e) {
      console.log(e);
    }
  },
  years(properties) {
    let res = []
    for (let i = 2001; i < properties.year + 1; i++) {
      res.push(i)
    }
    return res
  },
  getData(data,category,type) {
    let total = 0
    data[category].forEach(o => {
      if (o[type].unit === 't/ha') {
        total += o[type].value * 10        
      } else if (o[type].unit === '€/t') {
        total += o[type].value / 10  
      } else {
        total += o[type].value
      }
    })
    return total
  },
  setData(cm,category,type,corrFactor) {
    return cm[category].map(o => {
      o[type].value = _.round(o[type].value * corrFactor, 2)
      if (type !== 'total') {
        o.total.value = _.round(o.amount.value * o.price.value, 2)
      }
      return o
    })
  },
  getAmountDirectCosts(cm) {
    let count = 0
    cm.directCosts.forEach(o => {
      if (o.total.value > 0) {
        count++
      }
    })
    return count
  },
  adjustCM(cm, sdb) {
    const oldValueAm = this.getData(cm,'revenues','amount')
    const corrFactorAm = sdb.mainProduct.yield / oldValueAm
    console.log(sdb.region,sdb.year,oldValueAm,sdb.mainProduct.yield,corrFactorAm);
    const newRevenuesAm = this.setData(cm,'revenues','amount',corrFactorAm)
    cm.revenues = newRevenuesAm
      
    const oldValueP = this.getData(cm,'revenues','price')
    const corrFactorP = sdb.mainProduct.price / oldValueP
    console.log(sdb.region,sdb.year,oldValueP,sdb.mainProduct.price,corrFactorP);
    const newRevenuesP = this.setData(cm,'revenues','price',corrFactorP)
    cm.revenues = newRevenuesP
      
    const oldValueD = this.getData(cm, 'directCosts', 'total')
    const amountDirectCosts = this.getAmountDirectCosts(cm)
    const corrFactorD = sdb.total.varCosts / oldValueD // (((value / oldValue) - 1) / amountDirectCosts) + 1
    const newDirectCosts = this.setData(cm,'directCosts','total',corrFactorD)
    //console.log(crop);
    cm.directCosts = newDirectCosts
    
    return cm
    
    /*
    const avgCM = (() => {
      let sum = _.sumBy(cm, o => {return o[prop].value})
      sum = sum * 10
      //if (prop === 'yield')
      //else sum = sum / 10
      //console.log('sum', sum);
      const count = cm.length
      //console.log('count', count)
      return sum/count
    })()
    //console.log('Average CM', avgCM)
    const coefficient = sdb/avgCM
    console.log('coeff', prop, coefficient, avgCM, sdb)
    return coefficient
    */
  }
}
