import distance from './mapquest'
import * as bgr from 'bgr-apis'
import Plot from '~/constructors/Plot'

export default async function createPlot(properties) {
  // start by getting the settings object
  // where the current planning year and the
  // farms location are stored
  const settings = await this.$db.get('settings')

  // get all required information to create a new plot
  if (!properties.year) {
    properties.year = settings.curPlanYear
  }
  // create a promise array so that requests are
  // carried out in parallel
  const requests = await Promise.all([
    bgr.quality(this.geometry),
    bgr.soilType(this.geometry),
    region(this.geometry),
    distance(this.geometry, settings.home)
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
