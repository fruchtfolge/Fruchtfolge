<template>
  <div class="">
    <div class="chart-wrapper">
      <canvas id="labour-chart"></canvas>
    </div>
  </div>
</template>
<script>
import Chart from 'chart.js'
import labourData from '~/assets/js/labour.js'
import 'chartjs-plugin-dragdata'

export default {
  data() {
    return {
      labourData
    }
  },
  mounted() {
    this.createChart('labour-chart', this.labourData)
  },
  methods: {
    createChart(chartId, chartData) {
      const ctx = document.getElementById(chartId).getContext('2d')
      
      const gradient1 = ctx.createLinearGradient(0, 0, 0, 450)
      const gradient2 = ctx.createLinearGradient(0, 0, 0, 450)

      gradient1.addColorStop(0, 'rgba(74,109,124, 1)')
      gradient1.addColorStop(0.5, 'rgba(74,109,124, 0.8)')
      gradient1.addColorStop(1, 'rgba(74,109,124, 0.4)')

      gradient2.addColorStop(0, 'rgba(121, 173, 151, 1)')
      gradient2.addColorStop(0.5, 'rgba(121, 173, 151, 0.8)')
      gradient2.addColorStop(1, 'rgba(121, 173, 151, 0.4)')

      chartData.data.datasets[0].backgroundColor = gradient1
      chartData.data.datasets[1].backgroundColor = gradient2
      
      this.labourChart = new Chart(ctx, {
        type: chartData.type,
        data: chartData.data,
        options: chartData.options,
      })
      console.log(this.labourChart);
    }
  }
}
</script>
<style>
#labour-chart {
  margin-top: 50px;
}
</style>
