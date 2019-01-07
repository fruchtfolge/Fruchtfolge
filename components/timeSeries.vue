<template lang="html">
  <div>
    <div class="timeseries-wrapper">
      <canvas id="timeseries-chart"></canvas>
    </div>
    <div style="width:calc(100% - 275px);text-align:center;margin-top: 40px;">
      <button type="button" name="button" @click="remove">ENTFERNEN</button>
    </div>
  </div>
</template>
<script>
import Chart from 'chart.js'
import timeseries from '~/assets/js/timeseries.js'
import 'chartjs-plugin-dragdata'

export default {
  data() {
    return {
      timeseries
    }
  },
  mounted() {
    this.filterData()
    this.createChart('timeseries-chart', this.timeseries)
  },
  props: {
    crop: {
      type: Object,
      required: true
    }
  },
  methods: {
    createChart(chartId, chartData) {
      const ctx = document.getElementById(chartId)
      this.timeseriesChart = new Chart(ctx, {
        type: timeseries.type,
        data: timeseries.data,
        options: timeseries.options,
      })
      console.log(this.timeseriesChart);
    },
    filterData() {
      if(this.$store && this.$store.crops) {
        // filter all available years from the crops database
        this.cropTimeSeries = this.$store.crops.filter(o => {return o.name === this.crop.name
          && o.year > this.$store.curYear - 10})
        // sort by ascending order
        this.cropTimeSeries = _.sortBy(this.cropTimeSeries, 'year')
        const years = this.cropTimeSeries.map(o => {return o.year})
        const amount = this.getData(this.cropTimeSeries, 'revenues', 'amount')
        const price = this.getData(this.cropTimeSeries, 'revenues', 'price')
        const directCosts = this.getData(this.cropTimeSeries, 'directCosts', 'total')
        // get highest value of price and amount (left y-axis) and direct costs (right y-axis)
        // in order to set maximum y-axis ticks
        const highestA = this.getMaxTick(amount,[1])
        const highestB = this.getMaxTick(price,[1])
        const highestC = this.getMaxTick(directCosts)
        //console.log(highestA,highestB,highestC);
        // set initial chart properties
        timeseries.data.labels = years

        timeseries.data.datasets[0].label = `Ertrag [${this.getLabel(this.cropTimeSeries, 'revenues', 'amount')}]`
        timeseries.data.datasets[0].data = amount
        timeseries.options.scales.yAxes[0].ticks.max = _.round(highestA * 1.7, 0)

        timeseries.data.datasets[1].data = price
        timeseries.data.datasets[1].label = `Preis [${this.getLabel(this.cropTimeSeries, 'revenues', 'price')}]`
        timeseries.options.scales.yAxes[1].ticks.max = _.round(highestB * 1.9, 0)

        timeseries.data.datasets[2].data = directCosts
        timeseries.options.scales.yAxes[2].ticks.max = _.round(highestC * 1.5, -2)

        timeseries.options.onDragEnd = this.saveChanges
      }
    },
    getData(data,category,type) {
      return data.map(year => {
        let total = 0
        year.contributionMargin[category].forEach(o => {
          total += o[type].value
        })
        return total
      })
    },
    setData(crop,category,type,corrFactor) {
      return crop.contributionMargin[category].map(o => {
        o[type].value = _.round(o[type].value * corrFactor, 1)
        if (type !== 'total') {
          o.total.value = _.round(o.amount.value * o.price.value, 1)
        }
        return o
      })
    },
    getAmountDirectCosts(crop) {
      let count = 0
      crop.contributionMargin.directCosts.forEach(o => {
        if (o.total.value > 0) {
          count++
        }
      })
      return count
    },
    getLabel(data,category,type) {
      return data[0].contributionMargin[category][0][type].unit
    },
    async saveChanges(e, datasetIndex, index, value) {
      try {
        // get crop object from database
        const year = timeseries.data.labels[index]
        const crop = _.find(this.cropTimeSeries, ['year', year])
        if (datasetIndex === 0) {
          // amount
          const oldValue = this.getData([crop],'revenues','amount')
          const corrFactor = value / oldValue
          const newRevenues = this.setData(crop,'revenues','amount',corrFactor)
          crop.contributionMargin.revenues = newRevenues
        } else if (datasetIndex === 1) {
          // price
          const oldValue = this.getData([crop],'revenues','price')
          const corrFactor = value / oldValue
          const newRevenues = this.setData(crop,'revenues','price',corrFactor)
          crop.contributionMargin.revenues = newRevenues
        } else {
          const oldValue = this.getData([crop], 'directCosts', 'total')
          const amountDirectCosts = this.getAmountDirectCosts(crop)
          const corrFactor = value / oldValue // (((value / oldValue) - 1) / amountDirectCosts) + 1
          console.log(corrFactor,amountDirectCosts);
          const newDirectCosts = this.setData(crop,'directCosts','total',corrFactor)
          //console.log(crop);
          crop.contributionMargin.directCosts = newDirectCosts
        }
        const update = await this.$db.put(crop)
        crop._rev = update.rev
      } catch (e) {
        console.log(e);
      }
    },
    getMaxTick(a,b) {
      return _.max([_.max(a), _.max(b)])
    },
    async remove() {
      this.$db.remove(this.crop)
    }
  }
}
</script>
<style>
#timeseries-chart {
  margin-top: 80px;
}
.timeseries-wrapper {
  width: calc(100% - 275px);
  height: calc(85vh - 150px);
}
</style>