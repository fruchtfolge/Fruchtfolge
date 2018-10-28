import ktbl from 'ktbl-apis'
import Crop from '~/constructors/Crop'

export default async function createCrop(properties, settings) {
  // get all required information to create a new plot
  if (!properties.year) {
    properties.year = settings.curPlanYear
  }
  // save centroid of plot to polygon
  properties.center = centerOfMass(properties.geometry).geometry.coordinates
  // save field size
  properties.size = Number((area(properties.geometry) / 10000).toFixed(2))
  // create a promise array so that requests are
  // carried out in parallel
  const requests = await Promise.all([
    sqr(properties.geometry),
    soilType(properties.geometry),
    mapquest.reverse(properties),
    mapquest.distance(properties, settings.home)
  ])

  // fill the properties with the values acquired
  properties.quality = requests[0]
  properties.soilType = requests[1]
  properties.region = requests[2]
  properties.distance = requests[3]

  // create the plot
  const plot = new Plot(properties)

  return plot
}
