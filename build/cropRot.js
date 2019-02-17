const fs = require('fs')
const _ = require('lodash');
const data = fs.readFileSync('Früchte.csv', 'utf8')
var lines = data.split(/\n/g)
var headers = lines[0].split(/;/g)
// remove empty cell
headers.shift()

function getSubseq(cells) {
  var o = {}
  headers.forEach((c,i) => {
    o[c] = Number(cells[i + 1])
  })
  return o
}

var res = []
lines.forEach((line,i) => {
  if (i === 0) return
  const cells = line.split(/;/g)
  const cropGroupName = cells[0]
  res.push({
    'cropGroup': cropGroupName,
    'efa': 0,
    'legume': false,
    'rootCrop': false,
    'minSoil': 20,
    'rotBreak': 2,
    'prevCrops': getSubseq(cells)
  })
})

var crops2 = [
  ["Gräser","other grass"],
  ["Leguminosen", "other legumes"],
  ["Blühmischung", "other grass"],
  ["Kohl", "vegetables"],
  ["Bohnen", "field beans"],
  ["Brokkoli", "vegetables"],
  ["Dauergrünland", 0],
  ["Durchwachsene Silphie", "other grass"],
  ["Salat", "vegetables"],
  ["Erbsen", "peas"],
  ["Rüben", "sugar beet"],
  ["Kartoffeln", "potatoes med"],
  ["Gurke", "vegetables"],
  ["Mais", "silage corn"],
  ["Mini-Romana", "vegetables"],
  ["Miscanthus", 0],
  ["Möhren", "vegetables"],
  ["Pappeln", 0],
  ["Radies", "vegetables"],
  ["Porree", "vegetables"],
  ["Rote Bete", "vegetables"],
  ["Rucola", "vegetables"],
  ["Sellerie", "vegetables"],
  ["Sorghum", "other grain"],
  ["Soja", "soy bean"],
  ["Sommergerste", "summer barley"],
  ["Sommerhafer", "oats"],
  ["Zwischenfrucht", "winter vetch"],
  ["Sonnenblumen", "sun flower"],
  ["Spargel", "vegetables"],
  ["Zwiebel", "vegetables"],
  ["Kürbis", "pumpkin"],
  ["Spinat", "vegetables"],
  ["Weiden", 0],
  ["Wintergerste", "winter barley"],
  ["Winterraps", "rapeseed"],
  ["Winterroggen", "winter rye"],
  ["Wintertriticale", "winter triticale"],
  ["Winterweizen", "winter wheat"],
  ["Zucchini", "vegetables"],
  ["Dinkel", "spelt wheat"],
  ["Luzerne", "saradella"],
  ["Öllein", "rapeseed"],
  ["Sommergetreide - Saatgutproduktion", "mixed summer grain"],
  ["Sommerroggen", "mixed summer grain"],
  ["Sommertriticale", "mixed summer grain"],
  ["Sommerweizen", "summer wheat"],
  ["Lupine", "lupine"],
  ["Unkrautbekämpfung", 0],
  ["Wintergetreide - Saatgutproduktion", "mixed winter grain"]
]

var crops1 = [
  "Gräser",
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

function allPossibleCases(arr){
  const res =[]
  arr.forEach(a => {
    arr.forEach(b => {
      //console.log(a,b")"],
      if (res.indexOf([a,b] === -1)) {
        res.push([a,b])
      }
    })
  })
  return res
}

function getName(name) {
  let rota = 0
  crops2.forEach(c => {
    //console.log(c[0],name);
    if (c[0] === name) {
      rota = c[1]
    }
  })
  return rota
}

function getValue(main, colIndex) {
  let value = 0
  data.forEach(r => {
    if (r[0] === main) {
      //console.log(r[colIndex]);
      value = r[colIndex]
    }
  })
  return value
}
const values = allPossibleCases(crops1)
const res = []

crops1.forEach(crop => {
  res.push({
    'cropGroup': crop,
    'efa': 0,
    'legume': false,
    'rootCrop': false,
    'minSoil': 20,
    'rotBreak': 2,
    'prevCrops': []})
})
//console.log(res);
values.forEach(combi => {
  const pre = getName(combi[0])
  const main = getName(combi[1])
  const o = _.find(res, ['cropGroup', combi[1]])
  if (pre === 0 || main === 0) {
    if (combi[0] === combi[1]) {
      o.prevCrops.push({'cropGroup': combi[0], 'value': 1})
    } else {
      o.prevCrops.push({'cropGroup': combi[0], 'value': 0})
    }
    //res.push([combi[0], combi[1], 0])
  } else {
    // get column index
    const colIndex = data[0].indexOf(pre)
    // get row and value
    const value = getValue(main, colIndex)
    o.prevCrops.push({'cropGroup': combi[0], 'value': Number(value)})
    //res.push([combi[0],combi[1],value])
  }
})

fs.writeFileSync('cropRotValues.json', JSON.stringify(res), 'utf8')
