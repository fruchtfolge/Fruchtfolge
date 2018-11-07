const ktbl = require('ktbl-apis')
const async = require('async')
const fs = require('fs')

const result = []

async function buildDB() {
  const farmingTypes = await ktbl.cropList()
  async.eachOfLimit(farmingTypes, 1, async farmingType => {
    const crops = await ktbl.cropList({
      farmingType: farmingType
    })
    await getSystemsForCrops(farmingType, crops)
  }, (err) => {
    if (err) console.log(err);
    fs.writeFileSync('crops.js', JSON.stringify(result), 'utf-8')
  })
}

function getSystemsForCrops(farmingType, crops) {
  return new Promise(resolve => {
    async.eachOfLimit(crops, 2, async crop => {
      const systems = await ktbl.cropList({
        farmingType: farmingType,
        crop: crop
      })
      systems.forEach(system => {
        result.push({
          farmingType: farmingType,
          crop: crop,
          system: system
        })
      })
    }, (err) => {
      if (err) console.log(err);
      resolve()
    }
    )
  })
}


buildDB()
