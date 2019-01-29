<template lang="html">
  <div>
    <div class="grossMarginTimeline-wrapper">
      <canvas id="grossMarginTimeline-chart" width="280" height="280"></canvas>
    </div>
  </div>
</template>
<script>
import Chart from 'chart.js'

export default {
  data() {
    return {
      grossMarginTimeline: undefined,
      datasets: undefined,
      labels: undefined
    }
  },
  watch: {
    result(val) {
      console.log(this.shares);
      this.prepareData()
      this.grossMarginTimeline.data.datasets = this.datasets
      this.grossMarginTimeline.data.labels = this.labels
      this.grossMarginTimeline.update()
    },
  },
  mounted() {
    this.prepareData('grossMarginTimeline-chart')
    this.createChart('grossMarginTimeline-chart', this.grossMarginTimeline)
  },
  props: {
    plotsPrevCrops: {
      type: Object,
      required: true
    },
    plotCropMatrix: {
      type: Object,
      required: true
    },
    result: {
      type: Object,
      required: true
    }
    
  },
  methods: {
    prepareData(chartId) {
      this.datasets = []
      this.labels = []
      
      const colors = ["#294D4A", "#4A6D7C", "#7690A5"]
      const ctx = document.getElementById(chartId).getContext('2d')
      this.gradient = []
      
      this.gradient[0] = ctx.createLinearGradient(0, 0, 0, 450)
      this.gradient[1] = ctx.createLinearGradient(0, 0, 0, 450)
      this.gradient[2] = ctx.createLinearGradient(0, 0, 0, 450)

      this.gradient[0].addColorStop(0, 'rgba(41,77,74, 0.5)')
      this.gradient[0].addColorStop(0.5, 'rgba(41,77,74, 0.25)')
      this.gradient[0].addColorStop(1, 'rgba(41,77,74, 0)')

      this.gradient[1].addColorStop(0, 'rgba(74,109,124, 0.9)')
      this.gradient[1].addColorStop(0.5, 'rgba(74,109,124, 0.25)')
      this.gradient[1].addColorStop(1, 'rgba(74,109,124, 0)')
      
      this.gradient[2].addColorStop(0, 'rgba(118,144,165, 0.9)')
      this.gradient[2].addColorStop(0.5, 'rgba(118,144,165, 0.25)')
      this.gradient[2].addColorStop(1, 'rgba(118,144,165, 0)')
      
      const curYear = this.$store.curYear
      const years = Array(curYear - (curYear - 10)).fill(0).map((e,i)=>i+(curYear-9))
      
      for (var i = 0; i < 3; i++) {
        let data = []
        years.forEach(year => {
          const o = {}
          // calculate total db for cropping plan of curYear - i under prices/yields/directCosts of year
          let grossMargins = []
          let grossMargin = 0
          grossMargins = Object.keys(this.plotCropMatrix).map(plot => {
            const plotData = this.plotCropMatrix[plot][year]
            let crop
            let cropGrossMargin
            if (i === 0) {
              crop = this.result.recommendation[plot]
              if (plotData[crop]) {
                if (year === 2019) console.log(plotData[crop].grossMargin);
                return plotData[crop].grossMargin
              }
            } else {
              crop = this.plotsPrevCrops[plot][curYear - i].code
              if (plotData[crop]) {
                return plotData[crop].grossMarginNoCropEff * plotData[crop].size
              }
            }
              
          })
          
          grossMargin = _.sum(grossMargins)
          data.push(grossMargin)
          if (this.labels.indexOf(year) === -1) this.labels.push(year)
        })
        this.datasets.push({
          data: data,
          label: `Anbauplan ${curYear - i}`,
          borderColor: colors[i],
          backgroundColor: this.gradient[i]
        })
      }
    },
    createChart(chartId, chartData) {
      Chart.defaults.global.defaultFontFamily = "Open Sans Light";
      Chart.defaults.global.defaultFontSize = 14;

      const config = {
        type: 'line',
        data: {
          datasets: this.datasets,
          labels: this.labels
        },
        options: {
          responsive: false,
          legend: {
            position: "bottom"
          },
          tooltips: {
            xPadding: 6,
            yPadding: 7,
            displayColors: false
          },
          scales: {
            yAxes: [
              {
                ticks: {
                  callback: function(label, index, labels) {
                    return (label).toLocaleString()+'€';
                  }
                }
              }
            ]
          }
        }
      }
      const ctx = document.getElementById(chartId).getContext('2d')
      this.grossMarginTimeline = new Chart(ctx, config)
      console.log(this.grossMarginTimeline);
    }
  }
}
</script>
<style>
#grossMarginTimeline-chart {

}

.grossMarginTimeline-wrapper {
  margin-left: 60px;
  margin-top: 80px;
}
</style>
