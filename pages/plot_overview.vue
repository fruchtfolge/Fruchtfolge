<template>
  <div>
    <div class="plotOverview">
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Größe</th>
            <th>Hof-Feld-Distanz</th>
            <th>Bodenqualität (SQR)</th>
            <th>Bodenart</th>
            <th>Hackfruchtfähig</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(plot, i) in plots" :key='i' style="text-align: center;">
            <td>{{ plot.name }}</td>
            <td>{{ plot.size }}</td>
            <td>{{ plot.distance }}</td>
            <td>{{ plot.quality }}</td>
            <td>{{ plot.soilType }}</td>
            <td><input type="checkbox" :checked="plot.rootCrops"></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      plots: null,
      selectedPlot: null,
    }
  },
  created() {
    this.update()
    console.log(this.plots)
    this.$bus.$on('changeCurrents', _.debounce(this.update, 200))
  },
  methods: {
    changeCrop(crop) {
      this.selectedCrop = crop
    },
    update() {
      this.$set(this, 'plots', this.$store.curPlots)
    }
  }
}
</script>

<style>
  .plotOverview table input {
    -webkit-appearance: checkbox;
  }
</style>
