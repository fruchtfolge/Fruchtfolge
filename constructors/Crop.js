module.exports = class Crop {
  constructor(properties) {
    // database info
    this._id = properties._id || `crop:${new Date.toIsoString()}`
    this.type = 'crop',
    this.year = properties.year,

    // general crop data
    this.cropGroup = properties.cropGroup,
    this.name = properties.name,
    this.code = properties.code,
    this.variety = properties.variety,
    this.subseqCrops = properties.subseqCrops || [],
    this.efaFactor = properties.efaFactor || 0,
    this.minSoilQuality = properties.minSoilQuality || 0,
    
    // contribution margin related data
    this.price = properties.price,
    this.yield = properties.yield,
    this.directCosts = properties.directCosts,
    this.otherCosts = properties.otherCosts,
    this.machineCosts = properties.machineCosts,
    this.workingSteps = properties.workingSteps || [],
    this.cultivationType = properties.cultivationType
  }
  get variableCosts() {
    return this.directCosts + this.machineCosts + this.otherCosts
  }
  get revenue() {
    return this.price * this.yield
  }
  get contributionMargin() {
    return this.revenue() - this.variableCosts()
  }
}
