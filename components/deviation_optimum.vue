<template lang="html">
  <div>
    <h2>Differenz zum Optimum:</h2>
    <h2>{{ format(difference) }}</h2>
    <div class="">
      <p v-for="(deviation,i) in deviations" :key="i">{{ deviation }}</p>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      dataset: undefined,
      curYear: 2019,
      optimum: 0,
      arableLand: 0,
      greenLand: 0
    }
  },
  mounted() {
    this.curYear = this.$store.curYear
    this.getValues(this.plots)
  },
  props: {
    shares: {
      type: Object,
      required: true
    },
    plots: {
      type: Array,
      required: true
    },
    total: {
      type: Number,
      required: true
    }
  },
  computed: {
    difference() {
      console.log('Optimum: ' + this.optimum)
      console.log('Total: ' + this.total)
      if (isNaN(this.optimum - this.total)) {
        return 'Keine Empfehlung vorhanden.'
      } else {
        return _.round(this.total - this.optimum,2)
      }
    },
    deviations() {
      let deviations = []
      this.plots.forEach(plot => {
        const cropCode = plot.selectedCrop
        if (!plot.matrix[this.curYear]) return deviations
        const data = plot.matrix[this.curYear][cropCode]
        // get selected crop and previous crop
        //const selectedCrop = _.find(this.$store.curCrops, ['code', plot.selectedCrop])
        //const prevCrop = _.find(this.$store.curCrops, ['name', plot.prevCrop1])
        const croppingFactor = data.croppingFactor
        // show warning if cropping factor is below 6
        if (croppingFactor <= 0.6) {
          deviations.push(`${plot.name}: ${data.name} ungünstige Nachfrucht von ${plot.prevCrop1}`)
        } else if (croppingFactor === 0) {
          deviations.push(`${plot.name}: ${data.name} keine mögliche Nachfrucht von ${plot.prevCrop1}`)
        }
        if (!data.rotBreakHeld) {
          deviations.push(`${plot.name}: Anbaupause von ${data.name} nicht eingehalten`)
        }
      })
      return deviations
      // show error if cropping factor is 0
      // show error if rotational break is not met
      // show error if maximum share of crop is surpassed
      // show error if soil quality is not met
    },
    greeningEfa() {
      let efa = 0
      for (let cropCode in this.shares[this.curYear]) {
        // find crop for the given code
        const share = this.shares[this.curYear][cropCode]
        const crop = _.find(this.$store.curCrops, ['code', cropCode])
        if (crop) {
          efa += share * crop.efaFactor
        }
      }
      let fivePercent = (this.arableLand + this.greenLand) * 0.05
      if (efa >= fivePercent) return true
      else return false
    },
    greening75() {
      let shares = {}
      for (let cropCode in this.shares[this.curYear]) {
        // find crop for the given code
        const share = this.shares[this.curYear][cropCode]
        const crop = _.find(this.$store.curCrops, ['code', cropCode])
        if (crop) {
          if (!shares[crop.cropGroup]) shares[crop.cropGroup] = share
          else shares[crop.cropGroup] += share
        }
      }
      let sevenFivePercent = (this.arableLand + this.greenLand) * 0.75
      for (let share of shares) {
        if (share >= sevenFivePercent) return false
      }
      return true
    },
    greening95() {
      let shares = {}
      for (let cropCode in this.shares[this.curYear]) {
        // find crop for the given code
        const share = this.shares[this.curYear][cropCode]
        const crop = _.find(this.$store.curCrops, ['code', cropCode])
        if (crop) {
          if (!shares[crop.cropGroup]) shares[crop.cropGroup] = share
          else shares[crop.cropGroup] += share
        }
      }
      let ninceFivePercent = (this.arableLand + this.greenLand) * 0.95
      for (let share of shares) {
        for (let share2 of shares) {
          if ((share + shares2) >= ninceFivePercent) return false
        }
      }
      return true
    }
  },
  methods: {
    getValues(plots) {
      let optimum = 0
      let arableLand = 0
      let greenLand = 0
      plots.forEach(plot => {
        let code = plot.recommendation
        if (code) {
          const plotData = plot.matrix[this.curYear][code]
          const grossMargin = plotData.grossMargin
          optimum += grossMargin
        }
        if (plot.permPast) {
          greenLand += plot.size
        } else {
          arableLand += plot.size
        }        
      })
      console.log(optimum);
      this.optimum = optimum
      this.greenLand = greenLand
      this.arableLand = arableLand
    },
    format(number) {
      const formatter =  new Intl.NumberFormat('de-DE', {
        style: 'currency',
        currency: 'EUR',
        minimumFractionDigits: 0
      })
      return formatter.format(number)
    }
  }
}
</script>
<style>

</style>
