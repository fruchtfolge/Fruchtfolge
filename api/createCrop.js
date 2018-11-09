const Crop = require('../constructors/Crop')
const PouchDB = require('PouchDB')

// we use CouchDB instead of Nano so that we can use 
// a replication stream from a file later
// for now, use data from local couch
const crops = new PouchDB('http://localhost:5984/crops')

module.exports = async function createCrop(query, res) {
  const properties = query.properties
  const id = `${properties.farmingType}::${properties.crop}::${properties.system}`

  try {
    const data = await crops.get(id)
  } catch (e) {
    console.log(e)
  }

  // create the crop
  const crop = new Crop(data)
  console.log(crop);
  return crop
}
