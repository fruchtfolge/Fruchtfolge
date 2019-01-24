<template>
  <div class="">
    <div v-if="plotCropMatrix && result">
      <table class="result-table">
        <thead>
          <tr>
            <th style="min-width: 150px;">Name</th>
            <th>Größe</th>
            <th>Hof-Feld-Distanz</th>
            <!--
            <th style="min-width: 200px;">{{ curYear - 3 }}</th>
            <th style="min-width: 200px;">{{ curYear - 2 }}</th>
          -->
            <th style="min-width: 150px;">{{ curYear - 1 }}</th>
            <th style="min-width: 150px;">Empfehlung {{ curYear }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(plot, i) in plots" :key='i'>
            <td style="text-align: center;">{{ plot.name }}</td>
            <td style="text-align: center;">{{ plot.size }}</td>
            <td style="text-align: center;">{{ plot.distance }}</td>
            <!--
            <td style="text-align: center;">{{ plotsPrevCrops[plot.id][curYear - 3] }}</td>
            <td style="text-align: center;">{{ plotsPrevCrops[plot.id][curYear - 2] }}</td>
          -->
            <td style="text-align: center;">{{ plotsPrevCrops[plot.id][curYear - 1] }}</td>
            <td style="text-align: center;">{{ plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].name }}</td>
          </tr>
        </tbody>
      </table>
      <div class="crop-shares">
        <cropShares :shares="calcCropShares"/>
      </div>
    </div>
    <div v-else>
      <button type="button" name="button" @click="solve">Test</button>
    </div>
  </div>
</template>
<script>
import cultures from '~/assets/js/cultures'
import model from '~/assets/js/createModel.js'

export default {
  data() {
    return {
      plotCropMatrix: undefined,
      plots: undefined,
      curYear: undefined,
      result: undefined,
      cropColor: {}
    }
  },
  computed: {
    plotsPrevCrops() {
      if (this.plots && this.plots.length > 0) {
        let o = {}
        const that = this
        function getName(id, year) {
          const plot = _.find(that.$store.plots, {id: id, year: year})
          if (plot && cultures[plot.crop]) {
            return cultures[plot.crop].variety
          }
        }
        
        this.plots.forEach(plot => {
          o[plot.id] = {}
          o[plot.id][this.curYear - 3] = getName(plot.id,this.curYear - 3)
          o[plot.id][this.curYear - 2] = getName(plot.id,this.curYear - 2)
          o[plot.id][this.curYear - 1] = getName(plot.id,this.curYear - 1)
        })
        return o
      }
    },
    calcCropShares() {
      const colors =["#294D4A", "#4A6D7C", "#7690A5", "#79ae98", "#BBE29D", "#9DD5C0", '#B5DCE1', "#D0D1D3", "#B5DCE1"]
      // calculate crop shares
      let o = {}
      this.plots.forEach(plot => {
        const recommendation = this.result.recommendation[plot.id]
        if (!o[recommendation]) {
          o[recommendation] = {
            data: plot.size,
            name: this.plotCropMatrix[plot.id][this.curYear][recommendation].name
          }
        }
        else o[recommendation].data += plot.size
        
      })
      // sort crop shares by descending size
      let a = []
      Object.keys(o).forEach((crop,i) => {
        o[crop].data = _.round(o[crop].data,2)
        a.push(o[crop])
      })
      a = _.orderBy(a,['data'],['desc'])
      a = a.map((crop,i) => {
        crop.backgroundColor = colors[i]
        return crop
      })
      return a
    }
  },
  created() {
    this.update()
    this.$bus.$on('changeCurrents', _.debounce(this.update, 200))
  },
  methods: {
    async solve(force) {
      try {
        if (this.$store.curPlots && this.$store.curCrops) {
          if (!this.plotCropMatrix || force) {
            this.plotCropMatrix = model.buildPlotCropMatrix(this.$store)
          }
          const gams = model.buildModel(this.plotCropMatrix,this.$store)
          const { data } = await axios.post('http://localhost:3001/model/', {model: gams})
          this.result = data
          console.log(this);
        }
      } catch (e) {
        console.log(e)
      }
    },
    update() {
      this.$set(this, 'plots', this.$store.curPlots)
      this.$set(this, 'curYear', this.$store.curYear)
      this.$set(this, 'plotCropMatrix', this.$store.plotCropMatrix)
    }
  },
  components: {
    cropShares: () => import('~/components/cropShares.vue'),
  }
}
</script>
<style>
.result-table {
  
}
</style>
