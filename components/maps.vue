<template>
  <div id="map" class="map">
  </div>
</template>

<script>
import createPlot from '~/assets/js/createPlot'
import mapboxgl from 'mapbox-gl'
import MapboxDraw from '@mapbox/mapbox-gl-draw'

// load Mapbox Draw configuration file
import drawConfig from '../assets/js/draw.config.js'

export default {
  name: 'MapBox',
  async mounted () {
    await this.createMap()
    await this.drawPlots()
  },
  methods: {
    async createMap() {
      let settings
      try {
        settings = await this.$db.get('settings')
      } catch (e) {
        if (e.status === 404) {
          console.log('Keine Hof-Adresse angegeben. Bitte in den Einstellungen die Hof-Adresse eintragen.')
          return $nuxt.$router.replace({path: 'settings'})
        }
        console.log(e)
      }

      if (!settings.home) {
        console.log('Keine Hof-Adresse angegeben. Bitte in den Einstellungen die Hof-Adresse eintragen.')
        return $nuxt.$router.replace({path: 'settings'})
      }

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

      this.Draw = new MapboxDraw(drawConfig)
      this.map.addControl(new mapboxgl.NavigationControl(), 'bottom-left')
      this.map.addControl(this.Draw, 'bottom-left')

      // add drawing event listeners
      this.map.on('draw.create', async data => {
        const plotName = 'Test'
        const settings = await this.$db.get('settings')
        try {
          const plot = await createPlot({
            name: plotName,
            geometry: data.features[0]
          }, settings)
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
        })
        
        // if any plots are found, draw them on the map
        if (plots.docs) {
          plots.docs.forEach(plot => {
            this.Draw.add(plot.geometry)
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
