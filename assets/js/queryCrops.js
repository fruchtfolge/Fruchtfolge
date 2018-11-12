const ktbl = require('ktbl-apis')
const async = require('async')
const fs = require('fs')

const cropGroups = [
  "Gras",
  "Leguminosen",
  "Blühmischung",
  "Kohl",
  "Bohnen",
  "Brokkoli",
  "Dauergrünland",
  "Durchwachsene Silphie",
  "Salat",
  "Erbsen",
  "Rüben",
  "Kartoffeln",
  "Gurke",
  "Mais",
  "Mini-Romana",
  "Miscanthus",
  "Möhren",
  "Pappeln",
  "Radies",
  "Porree",
  "Rote Bete",
  "Rucola",
  "Sellerie",
  "Sorghum",
  "Soja",
  "Sommergerste",
  "Sommerhafer",
  "Zwischenfrucht",
  "Sonnenblumen",
  "Spargel",
  "Zwiebel",
  "Kürbis",
  "Spinat",
  "Weiden",
  "Wintergerste",
  "Winterraps",
  "Winterroggen",
  "Wintertriticale",
  "Winterweizen",
  "Zucchini",
  "Dinkel",
  "Luzerne",
  "Öllein",
  "Sommergetreide - Saatgutproduktion",
  "Sommerroggen",
  "Sommertriticale",
  "Sommerweizen",
  "Lupine",
  "Unkrautbekämpfung",
  "Wintergetreide - Saatgutproduktion"
]

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
          system: system,
          cropGroup: getCropGroup(crop)
        })
      })
    }, (err) => {
      if (err) console.log(err);
      resolve()
    }
    )
  })
}

function getCropGroup(crop) {
  let match
  cropGroups.forEach(group => {
    if (crop.toUpperCase().includes(group.toUpperCase())) {
      match = group
    }
  })
  if (match === 'Mini-Romana') match = 'Tomaten'
  else if (match === 'Gras') match = 'Gräser'
  if (match) return match
  else return crop
}

buildDB()
