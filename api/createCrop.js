const ktbl = require('ktbl-apis')
const Crop = require('./constructors/Crop')

module.exports = async function createCrop(query, res) {
  const properties = query.properties
  // create a promise array so that requests are
  // carried out in parallel
  try {
    const requests = await Promise.all([
      ktbl.contributionMargin(properties),
      ktbl.standardGrossMargin(properties),
      ktbl.getProcedures(properties),
    ])
  } catch (e) {
    console.log(e)
  }


  // fill the properties with the values acquired
  properties.contributionMargin = requests[0]
  properties.standardGrossMargin = requests[1]
  properties.procedures = requests[2]

  // create the plot
  const crop = new Crop(properties)
  console.log(crop);
  return crop
}
