import ktbl from 'ktbl-apis'
import Crop from '~/constructors/Crop'

export default async function createCrop(properties, settings) {
  // get all required information to create a new plot
  if (!properties.year) {
    properties.year = settings.curPlanYear
  }
  // create a promise array so that requests are
  // carried out in parallel
  const requests = await Promise.all([
    ktbl.contributionMargin(properties),
    ktbl.standardGrossMargin(properties),
    ktbl.getProcedures(properties),
  ]).catch(err => {
    console.log(e)
  })

  // fill the properties with the values acquired
  properties.quality = requests[0]
  properties.soilType = requests[1]
  properties.region = requests[2]

  // create the plot
  const plot = new Crop(properties)

  return plot
}
