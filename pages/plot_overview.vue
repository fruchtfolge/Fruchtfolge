<template>
  <div>
    <div v-if="plots && plots.length > 0" class="plotOverview">
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
          <tr v-for="(plot, i) in plots" :key='i'>
            <td style="text-align: center;">{{ plot.name }}</td>
            <td style="text-align: center;">{{ plot.size }}</td>
            <td style="text-align: center;">{{ plot.distance }}</td>
            <td style="text-align: center;">{{ plot.quality }}</td>
            <td style="text-align: center;">{{ plot.soilType }}</td>
            <td style="text-align: center;"><input type="checkbox" :checked="plot.rootCrops"></td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-else style="text-align: center; margin-top: 100px;">
      <h2>Noch keine Schläge für das ausgewähle Planungsjahr und Szenario vorhanden.</h2>
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
