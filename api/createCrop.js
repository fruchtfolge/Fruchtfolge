const querystring = require('querystring')
const _ = require('lodash')
const Crop = require('../constructors/Crop')
const rotValues = require('../assets/js/cropRotValues.js')
const nano = require('nano')('http://localhost:5984');

// we use CouchDB instead of Nano so that we can use
// a replication stream from a file later
// for now, use data from local couch

module.exports = {
  query(req, res) {
    return new Promise ((resolve, reject) => {
      let body = ''

      req.on('data', (data) => {
        body += data

        if (body.length > 1e6)
          req.connection.destroy()
      })

      req.on('end', () => {
        const post = JSON.parse(body)
        resolve(post)
      })

      req.on('error', err => {
        reject(err)
      })
    })
  },
  createCrop(data, properties, year) {
    try {
      const cropData = Object.assign(data, properties)
      if (typeof(year) === 'number') {
        cropData.year = year
      } else {
        cropData.year = cropData.standardGrossMargin.year
        cropData.contributionMargin = this.adjustCM(cropData.contributionMargin, year)
      }
      // only activate the crop for the current planning year
      if (properties.year === cropData.year) {
        cropData.active = true
      }
      // append crop rotational information to crop
      const rotation = _.find(rotValues, ['cropGroup',properties.cropGroup])
      console.log(rotation);
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
      const properties = await this.query(req, res)
      const id = `${properties.farmingType}::${properties.crop}::${properties.system}`
      const crops = nano.db.use('crops')
      const data = await crops.get(id)
      // upsert crop for every year from 2000, in order to show price and yield variation
      // when SDB's are present, use that data
      // if not, replicate contribution margin for every year
      const docs = []
      //if (data.standardGrossMargin.length > 0) {
      //  if (!properties.region) properties.region = 'Deutschland'
      //  const regionalData = _.filter(data.standardGrossMargin, {region: properties.region})
      //  regionalData.forEach(year => {
      //    const crop = this.createCrop(data, properties, year)
      //    docs.push(crop)
      //  })
      //} else {
      const years = this.years(properties)
      //console.log(years);
      years.forEach(year => {
        const crop = this.createCrop(data, properties, year)
        docs.push(crop)
      })
      //}
      //console.log(docs)
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
  adjustCM(cm, sdb) {
    // calculate coefficients between price, yield and direct costs from SDB and default
    const coeffPrice = this.coefficient(cm.revenues, sdb.mainProduct.price, 'price')
    const coeffYield = this.coefficient(cm.revenues, sdb.mainProduct.yield, 'amount')
    const coeffCosts = this.coefficient(cm.directCosts, sdb.total.varCosts, 'total')
  },
  coefficient(cm, sdb, prop) {
    // create average cm value
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
  }
}
