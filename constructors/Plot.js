function getId() {
  const date = new Date()
  return date.toISOString()
}

export default class Plot {
  constructor(properties) {
    this._id = getId()
    this.type = 'plot',
    this.name = properties.name || 'Unbenannt',
    this.year = properties.year,
    this.scenario = properties.scenario,
    this.geometry = properties.geometry,
    this.geometry.properties._id = this._id,
    this.size = properties.size,
    this.center = properties.center,
    this.quality = properties.quality,
    this.soilType = properties.soilType,
    this.distance = properties.distance,
    this.region = properties.region,
    this.crop = properties.crop,
    this.rootCrops = properties.rootCrops || true
  }
}
