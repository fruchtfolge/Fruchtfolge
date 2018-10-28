export default class Crop {
  constructor(properties) {
    // database info
    this._id = properties._id || `crop:${new Date.toIsoString()}`
    this.type = 'crop',
    this.year = properties.year,

    // general crop data
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
    this.fixedCosts = properties.fixedCosts,
    this.workingSteps = properties.workingSteps || [],
    this.cultivationType = properties.cultivationType

    // gross margin functions
    this.revenue = () => {return this.price * this.yield}
    this.dirCostsFreeRev = () => {return this.revenue() - this.directCosts}
    this.variableCosts = () => {return this.directCosts + this.otherCosts}
    this.contributionMargin = () => {return this.revenue() - this.variableCosts()}
  }
}
