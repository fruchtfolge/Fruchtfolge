<template>
  <div id="map" class="map">
  </div>
</template>

<script>
// const createPlot = require('~/assets/js/createPlot')
export default {
  name: 'MapBox',
  async mounted () {
    await this.createMap()
    await this.drawPlots()
  },
  methods: {
    async createMap() {
      const mapboxgl = require('mapbox-gl')
      const MapboxDraw = require('@mapbox/mapbox-gl-draw')
      const settings = await this.$db.get('settings')

      mapboxgl.accessToken = 'pk.eyJ1IjoidG9mZmkiLCJhIjoiY2l3cXRnNHplMDAxcTJ6cWY1YWp5djBtOSJ9.mBYmcCSgNdaRJ1qoHW5KSQ'

      // init the map
      this.map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/satellite-streets-v9?optimize=true',
        // replace by database info later
        center: settings.home,
        zoom: 14,
        dragPan: false,
        drageRotate: false
      })

      // load Mapbox Draw configuration file
      const drawConfig = require('../assets/js/draw.config.js')
      this.Draw = new MapboxDraw(drawConfig)
      this.map.addControl(new mapboxgl.NavigationControl(), 'bottom-left')
      this.map.addControl(this.Draw, 'bottom-left')

      // add drawing event listeners
      this.map.on('draw.create', async data => {
        const plot = new Plot()

        try {
          await this.$db.put(plot)
        } catch (e) {
          throw new Error(e)
        }
      })

      this.map.on('draw.update', async data => {
        try {
          // get plot object from Database
          const plot = await this.$db.get(data.features[0].id)
          // update geometry
          plot.feature = data.features[0]
          // store changes in Database
          await this.$db.put(plot)
        } catch (e) {
          console.log(e)
        }
      })

      this.map.on('draw.delete', async (data) => {
        try {
          // fetch plot object from DB
          const plot = await this.$db.get(data.features[0].id)
          // remove from Database
          await this.$db.remove(plot)
        } catch (e) {
          console.log(e)
        }
      })

      this.map.on('draw.combine', (data) => {

      })

    },
    async drawPlots() {
      try {
        // get all plots from the Database
        await this.$db.createIndex({
          index: {
            fields: ['type']
          }
        })
        const plots = await this.$db.find({
          selector: {type: 'plot'}
        }).docs

        // if any plots are found, draw them on the map
        if (plots) {
          plots.rows.forEach(plot => {
            this.Draw.add(plot.doc.feature)
          })
        }
      } catch (e) {
        console.log(e)
      }
    }
  }
}
</script>

<style>
.map {
  position: relative;
  width: 100%;
  height: calc(100vh - 60px);
}
</style>
