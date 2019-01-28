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
      this.grossMarginTimeline.data.datasets[0].data = this.dataset.data
      this.grossMarginTimeline.data.datasets[0].backgroundColor = this.dataset.backgroundColor
      this.grossMarginTimeline.data.labels = this.dataset.labels
      this.grossMarginTimeline.update()
    },
  },
  mounted() {
    this.prepareData()
    //this.createChart('grossMarginTimeline-chart', this.grossMarginTimeline)
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
    prepareData() {
      this.datasets = []
      this.labels = []
      const curYear = this.$store.curYear
      const years = Array(curYear - (curYear - 10)).fill(0).map((e,i)=>i+(curYear-9))
      for (var i = 0; i < 3; i++) {
        let data = []
        years.forEach(year => {
          const o = {}
          // calculate total db for cropping plan of curYear - i under prices/yields/directCosts of year
          let grossMargins = []
          let grossMargin = 0
          if (i === 0) {
            grossMargins = Object.keys(this.plotCropMatrix).map(plot => {
              if (this.plotCropMatrix[plot][year][this.result.recommendation[plot]]) {
                return this.plotCropMatrix[plot][year][this.result.recommendation[plot]].grossMargin
              }
            })
          } else {
            grossMargins = Object.keys(this.plotCropMatrix).map(plot => {
              if (this.plotCropMatrix[plot][year][this.plotsPrevCrops[plot][curYear - i].code]) {
                return this.plotCropMatrix[plot][year][this.plotsPrevCrops[plot][curYear - i].code].grossMargin
              }
            })
          }
          grossMargin = _.sum(grossMargins)
          this.labels.push(year)
          console.log(grossMargin,i);
        })
      }
      /*
      years.forEach(year => {
        
        this.datasets.push()
        this.dataset.backgroundColor = []
        this.dataset.data.push(year.data)
        this.dataset.backgroundColor.push(year.backgroundColor)
        this.dataset.labels.push(year.name)
      })
      */
    },
    createChart(chartId, chartData) {
      Chart.defaults.global.defaultFontFamily = "Open Sans Light";
      Chart.defaults.global.defaultFontSize = 14;

      const config = {
        type: 'pie',
        data: {
          datasets: [{
            data: this.dataset.data,
            backgroundColor: this.dataset.backgroundColor,
            label: 'Summe Kulturen'
          }],
          labels: this.dataset.labels
        },
        options: {
          responsive: false,
          legend: {
            position: "bottom"
          },
          tooltips: {
            callbacks: {
              label: function(tooltipItem, data) {
                var value = data.datasets[0].data[tooltipItem.index];
                var label = data.labels[tooltipItem.index];
                return label + ': ' + value + ' ha';
              }
            },
            xPadding: 6,
            yPadding: 7,
            displayColors: false
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
