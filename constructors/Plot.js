import turf from 'turf'

export default class Plot {
  constructor(properties) {
    this._id = properties._id || `plot:${new Date.toIsoString()}`
    this.type = 'plot',
    this.name = properties.name || 'Unbenannt',
    this.year = properties.year,
    this.geometry = properties.geometry,
    this.quality = properties.quality,
    this.soilType = properties.soilType,
    this.distance = properties.distance,
    this.region = properties.region,
    this.crop = properties.crop,
    this.rootCrops = properties.rootCrops || true
  }

  get size() {
    // calculate area of polygon in m2
    const m2 = turf.area(this.geometry)
    // convert to ha and round to 2 decimal points
    const ha = (m2 / 10000).toFixed(2)
    return ha
  }

  get center() {
    return turf.centerOfMass(plot.geometry).geometry.coordinates
  }
}
