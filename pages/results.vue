<template>
  <div class="">
    <div v-if="plotCropMatrix && result">
      <div class="result-wrapper">
        <table class="result-table">
          <thead>
            <tr>
              <th style="min-width: 150px;">Name</th>
              <th>Größe</th>
              <th>Hof-Feld-Distanz</th>
              <th style="min-width: 100px;">{{ curYear - 1 }}</th>
              <th style="min-width: 100px;">Empfehlung {{ curYear }}</th>
              <th>Deckungsbeitrag</th>
            </tr>
          </thead>
          <tbody>
            <template v-for="(plot) in plots">
              <tr :key="plot.id">
                <td style="text-align: center;">{{ plot.name }}</td>
                <td style="text-align: center;">{{ plot.size }}</td>
                <td style="text-align: center;">{{ plot.distance }}</td>
                <td style="text-align: center;">{{ plotsPrevCrops[plot.id][curYear - 1].name }}</td>
                <td style="text-align: center;">
                  <select v-model="result.recommendation[plot.id]" class="selection">
                    <option v-for="(crop) in plotCropMatrix[plot.id][curYear]" :key="crop.code" :value="crop.code">
                      {{crop.name}}
                    </option>
                  </select>
                </td>
                <td style="text-align: center;" @click="showPlotInfo(plot.id)">
                  {{ format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].grossMargin) }}
                </td>
              </tr>
              <tr v-show="plot.id === selection" :key="plot._id">
                <td colspan="6" class="inner-table-wrapper" align="right">
                  <table class="inner-table">
                    <thead>
                      <th></th>
                      <th>Ertragskorrektur</th>
                    </thead>
                    <tbody>
                      <tr>
                        <td>Durchschnittsertrag</td>
                        <td style="text-align: center;">{{
                          plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].amount
                        }}</td>
                      </tr>
                      <tr>
                        <td>Korrektur Bodenqualität</td>
                        <td style="text-align:center;">{{
                          ((plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].yieldCap
                               * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].amount)
                               - plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].amount).toFixed(2)
                        }}</td>
                      </tr>
                      <tr>
                        <td>Korrektur Fruchtfolge</td>
                        <td style="text-align:center;">{{
                          ((plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].croppingFactor
                               * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].amount)
                               - plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].amount).toFixed(2)
                        }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight: bold;">Korrigierter Ertrag</td>
                        <td style="text-align:center;font-weight: bold;">{{
                          (plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].amount
                          * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].yieldCap
                          * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].croppingFactor).toFixed(2)
                        }}</td>
                      </tr>
                    </tbody>
                  </table>
                  <table>
                    <thead>
                      <th></th>
                      <th>Preis [1/ha]</th>
                      <th>Menge [1/ha]</th>
                      <th>Summe [1/ha]</th>
                      <th>Summe</th>
                    </thead>
                    <tbody>
                      <tr>
                        <td>Leistungen</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].price)
                        }}</td>
                        <td style="text-align:center;">{{
                          plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].correctedAmount
                        }}</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].revenue)
                        }}</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].revenue
                          * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].size)
                        }}</td>
                      </tr>
                      <tr>
                        <td colspan="3">Direktkosten</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].directCosts)
                        }}</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].directCosts
                          * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].size)
                        }}</td>
                      </tr>
                      <tr>
                        <td colspan="3">Maschinenkosten</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].variableCosts)
                        }}</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].variableCosts
                          * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].size)
                        }}</td>
                      </tr>
                      <tr>
                        <td colspan="3">Transportkosten</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].distanceCosts)
                        }}</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].distanceCosts
                          * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].size)
                        }}</td>
                      </tr>
                      <tr>
                        <td colspan="3">Deckungsbeitrag</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].grossMarginHa)
                        }}</td>
                        <td style="text-align:center;">{{
                          format(plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].grossMarginHa
                          * plotCropMatrix[plot.id][curYear][result.recommendation[plot.id]].size)
                        }}</td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
            </template>
            <tr>
              <td colspan="5" style="font-weight: bold;">Summe</td>
              <td style="text-align: center;font-weight: bold;">{{format(grossMarginCurYear)}}</td>
            </tr>
          </tbody>
        </table>
        <div class="">
          <div class="crop-shares">
            <cropShares :shares="calcCropShares"/>
          </div>
          <div class="gross-margin-timeline">
            <grossMarginTimeline :plotsPrevCrops="plotsPrevCrops" :plotCropMatrix="plotCropMatrix" :result="result"/>
          </div>
        </div>
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
      selection: undefined,
      cropColor: {}
    }
  },
  computed: {
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
    },
    plotsPrevCrops() {
      if (this.plots && this.plots.length > 0) {
        let o = {}
        const that = this
        this.plots.forEach(plot => {
          o[plot.id] = {}
          o[plot.id][this.curYear - 3] = this.getName(plot.id,this.curYear - 3)
          o[plot.id][this.curYear - 2] = this.getName(plot.id,this.curYear - 2)
          o[plot.id][this.curYear - 1] = this.getName(plot.id,this.curYear - 1)
        })
        return o
      }
    },
    grossMarginPrevYear() {
      return this.yearlyTotal(this.curYear - 1)
    },
    grossMarginCurYear() {
      return this.yearlyTotal(this.curYear)
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
          const test = model.createInclude(this.plotCropMatrix,this.$store)
          console.log({a: test});
          //const { data } = await axios.post('http://localhost:3001/model/', {model: gams})
          this.result = data
          console.log(this);
        }
      } catch (e) {
        console.log(e)
      }
    },
    yearlyTotal(year) {
      let sum = 0
      this.plots.forEach(plot => {
        let code
        if (year === this.curYear) {
          code = this.result.recommendation[plot.id]
        } else {
          code = this.plotsPrevCrops[plot.id][year].code
        }
        if (code) {
          const plotData = this.plotCropMatrix[plot.id][year][code]
          const grossMargin = plotData.grossMargin
          sum += grossMargin
        }
      })
      return sum
    },
    getName(id, year) {
      const plot = _.find(this.$store.plots, {id: id, year: year})
      if (plot && cultures[plot.crop]) {
        return {
          name: cultures[plot.crop].variety,
          code: plot.crop
        }
      } else {
        return {
          name: '',
          code: ''
        }
      }
    },
    beforeEnter(el) {
      el.style.height = '0px';
    },
    enter(el) {
      el.style.height = el.scrollHeight + 'px';
    },
    beforeLeave(el) {
      el.style.height = el.scrollHeight + 'px';
    },
    leave(el) {
      el.style.height = '0px';
    },
    showPlotInfo(id) {
      if (this.selection === id) {
        this.selection = ''
      } else {
        this.selection = id
      }
    },
    update() {
      this.$set(this, 'plots', this.$store.curPlots)
      this.$set(this, 'curYear', this.$store.curYear)
      this.$set(this, 'plotCropMatrix', this.$store.plotCropMatrix)
    },
    format(number) {
      const formatter =  new Intl.NumberFormat('de-DE', {
        style: 'currency',
        currency: 'EUR',
        minimumFractionDigits: 0
      })
      return formatter.format(number)
    }
  },
  components: {
    cropShares: () => import('~/components/cropShares.vue'),
    grossMarginTimeline: () => import('~/components/grossMarginTimeline.vue')
  }
}
</script>
<style>
.result-wrapper {
  display: inline-flex;
}
.result-table {
  float: left;
  margin: 0;
  margin-top: 20px;
  margin-left: 20px;
  max-width: 50vw;
}

.expand-enter-active, .expand-leave-active {
  transition: height .5s ease-in-out;
  overflow: hidden;
}

.expand-enter, .expand-leave-to {
  height: 0;
}

.result-table tr {
  background-color: #ECECEC;
}

.result-table tr:nth-child(4n+1), .result-table tr:nth-child(4n+2) {
  background-color: #F5F5F5;
}
.inner-table-wrapper {
  padding: 20px;
}
.inner-table {
  min-width: 0px;
  max-width: 0px;
}

.inner-table th {
  height: 25px;
}
.inner-table tr:nth-child(odd) {
  background-color: #F5F5f5;
}
.inner-table tr:nth-child(even) {
  background-color: #ECECEC;
}
.selection {
  font-size: 14px;
  text-align-last: center;
  font-family: 'Open Sans Light';
  letter-spacing: normal;
  border-width: 0px;
  background: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
  background-repeat: no-repeat;
  background-position: 100% 50%;}
</style>
