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
    this.geometry.properties._id = this._id,
    this.size = () => {return Number((area(this.geometry) / 10000).toFixed(2))},
    this.center = properties.center,
    this.quality = properties.quality,
    this.soilType = properties.soilType,
    this.distance = properties.distance,
    this.region = properties.region,
    this.crop = properties.crop,
    this.rootCrops = properties.rootCrops || true
  }
}
