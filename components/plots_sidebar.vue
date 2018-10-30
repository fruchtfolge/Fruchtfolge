<template>
  <div class="plotsSidebar">
    <h1 class="sumHa">GESAMT {{ totalHa }} ha</h1>
    <div v-if="regions" v-for="(region, n) in regions" :key='n'>
      <div class="container" @click="collapsed = !collapsed">
        <h2 class="regionText"> {{ region[0].region.toUpperCase() }}</h2>
        <div class="arrow" v-bind:class="{ rotate: !collapsed}"></div>
      </div>
      <div v-show="!collapsed">
        <p v-for="(plot, m) in region" :key='m' class="plotsText"> {{plot.name}} ({{plot.size}} ha) </p>
      </div>
    </div>
    <div v-else>
      <p class="regionText">Klicken Sie auf den Rechteck-Button in der Karte links-unten um ein neues Feld eizuzeichnen.</p>
    </div>
  </div>
</template>
<script>


export default {
  data () {
    return {
      regions: null,
      totalHa: 0,
      isClicked: false,
      collapsed: true
    }
  },
  async created() {
    try {
      // get all plots from the Database
      await this.$db.createIndex({
        index: {
          fields: ['type']
        }
      })
      const plots = this.$db.liveFind({
        selector: {type: 'plot'},
        aggregate: true
      })
        .on('update', (update, aggregate) => {
          this.plots = aggregate
          this.regions = _.groupBy(this.plots, 'region')
          this.totalHa = Number(_.sumBy(this.plots, (plot) => {return plot.size()}).toFixed(2)) || 0
          console.log(this.plots)
        })
        .on('error', (err) => {
          console.log(err)
        })
    } catch (e) {
      console.log(e)
    }
  },
  methods: {
    expand: (e) => {

    }
  }
}
</script>
<style scoped="true">
.plotsSidebar {
  position: fixed;
  padding-top: 20px;
  overflow-y: scroll;
  top: 60px;
  right: 0px;
  width: 275px;
  cursor: default;
  height: calc(100vh - 70px);
  background: #ececec;
  z-index: 94;
}
.plotsCollaps {
  background: url("data:image/svg+xml;utf8,<svg width='24' height='24' xmlns='http://www.w3.org/2000/svg'> <g> <title>background</title> <rect fill='none' id='canvas_background' height='402' width='582' y='-1' x='-1'/> </g> <g> <title>Layer 1</title> <path transform='rotate(-180 12,11.531000137329102) ' id='svg_1' d='m7.406,7.828l4.594,4.594l4.594,-4.594l1.406,1.406l-6,6l-6,-6l1.406,-1.406z' fill='#444'/> </g> </svg>");
  background-position: 100% 50%;
  background-repeat: no-repeat;
}

.rotate {
  transform: rotate(180deg);
  transition: .5s;
}

.plotsExpand:hover {

}
.container {
  display: inline-flex;
  align-items: center;
}
.arrow {
  width: 24px;
  height: 24px;
  background: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
  background-position: 100% 100%;
  background-repeat: no-repeat;
}
.expand{
    height: 0;
    overflow: hidden;
    transition: height 0.8s ease;
}

.geclickt {
  background-color: #E0E0E0;
}

.plotsText {
  font-size: 16px;
  letter-spacing: 0.1em;
  padding-left: 45px;
  padding-top: 5px;
  padding-bottom: 5px;
  margin: 0px;
}

.regionText {
  font-size: 18px;
  letter-spacing: 0.2em;
  margin-bottom: 5px;
  margin-top: 5px;
  margin-left: 30px;
  font-weight: normal;
}

.sumHa {
  font-size: 18px;
  letter-spacing: 0.2em;
  margin-left: 30px;
  margin-bottom: 40px;
  font-weight: normal;
}

.expand{
  height: 0;
  overflow: hidden;
  transition: height 0.8s ease;
}

.cropsExpand:hover {
  background: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
  background-position: 100% 50%;
  background-repeat: no-repeat;
}

.plotInput {
  font-family: 'open_sanscondensed_light', sans-serif;
  font-size: 16px;
  letter-spacing: 0.1em;
}

</style>
