import { area } from '@turf/turf'

function getId() {
  const date = new Date()
  return date.toISOString()
}

export default class Plot {
  constructor(properties) {
    this._id = properties._id || getId()
    this.type = 'plot',
    this.name = properties.name || 'Unbenannt',
    this.year = properties.year,
    this.geometry = properties.geometry,
    this.center = properties.center,
    this.quality = properties.quality,
    this.soilType = properties.soilType,
    this.distance = properties.distance,
    this.region = properties.region,
    this.crop = properties.crop,
    this.rootCrops = properties.rootCrops || true
  }

  get size() {
    // calculate area of polygon in m2
    const m2 = area(this.geometry)
    // convert to ha and round to 2 decimal points
    const ha = Number((m2 / 10000).toFixed(2))
    return ha
  }
}
