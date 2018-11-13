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
      const ctx = document.getElementById(chartId)
      const myChart = new Chart(ctx, {
        type: chartData.type,
        data: chartData.data,
        options: chartData.options,
      })
    }
  }
}
</script>
<style>

</style>
