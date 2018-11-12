function getId() {
  const date = new Date()
  return date.toISOString()
}

module.exports = class Crop {
  constructor(properties) {
    // database info
    //this._id = getId()
    this.type = 'crop',
    this.year = properties.year,
    this.active = properties.active || false,

    // general crop data
    this.name = properties.crop,
    this.crop = properties.crop,
    this.code = properties.code,
    this.cropGroup = properties.cropGroup,
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

    this.revenue = properties.revenue
    this.dirCostsFreeRev = properties.dirCostsFreeRev
    this.variableCosts = properties.variableCosts
    this.contributionMargin = properties.contributionMargin
  }
}
