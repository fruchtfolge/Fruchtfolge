<template>
  <div class="">
    <div v-if="plotCropMatrix">
      <p>hey</p>
    </div>
    <div v-else>
      <button type="button" name="button" @click="solve">Test</button>
    </div>
  </div>
</template>
<script>
import model from '~/assets/js/createModel.js'

export default {
  data() {
    return {
      plotCropMatrix: undefined
    }
  },
  methods: {
    solve() {
      if (this.$store.curPlots && this.$store.curCrops) {
        this.plotCropMatrix = model.buildPlotCropMatrix(this.$store)
        console.log(model.buildModel(this.plotCropMatrix,this.$store))
      }
      //const string = include.concat(staticModel)
      //console.log({a: string})
      //const { data } = await axios.post('createModel', this.$store)
    }
  }
}
</script>
<style>

</style>
