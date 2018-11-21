<template>
  <div id="map" class="map">
  </div>
</template>

<script>
import { area } from '@turf/turf'
import createPlot from '~/assets/js/createPlot'
import mapboxgl from 'mapbox-gl'
import MapboxDraw from '@mapbox/mapbox-gl-draw'

// load Mapbox Draw configuration file
import drawConfig from '../assets/js/draw.config.js'

export default {
  name: 'MapBox',
  data() {
    return {
      curYear: ''
    }
  },
  async mounted () {
    let settings
    try {
      settings = await this.$db.get('settings')
      this.curYear = settings.curYear
      await this.createMap(settings)
      // initially draw plots, if available
      if (this.$store.curPlots) {
        this.curPlots = this.$store.curPlots
        console.log(this.curPlots);
        await this.drawPlots(this.curYear, this.curPlots)
      }
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
  },
  async created() {
    // listen to changes in settings and plots (current planning year etc.)
    this.$bus.$on('changeCurrents', () => {
      this.curYear = this.$store.curYear
      this.curPlots = this.$store.curPlots
      this.removeDraw()
      if (this.curPlots) {
        this.drawPlots(this.curYear, this.curPlots)
      }
    })
    // listen to flyTo events
    this.$bus.$on('flyTo', (plot) => {
      console.log(plot.center)
      this.map.flyTo({
        center: plot.center,
        zoom: 15
      })
    })
  },
  methods: {
    async createMap(settings) {
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
      this.map.on('draw.create', this.create)
      this.map.on('draw.update', this.update)
      this.map.on('draw.delete', this.delete)
      this.map.on('draw.combine', this.combine)
      this.map.on('draw.selectionchange', this.select)
    },
    async drawPlots(year, plots) {
      try {
        plots.forEach(plot => {
          this.Draw.add(plot.geometry)
        })
      } catch (e) {
        console.log(e)
      }
    },
    getSize(geometry) {
      const m2 = area(geometry)
      return Number((m2 / 10000).toFixed(2))
    },
    async delete(data) {
      try {
        // fetch plot object from DB
        console.log(data.features[0].properties._id)
        const plot = await this.$db.get(data.features[0].properties._id)
        console.log(plot)
        // remove from Database
        await this.$db.remove(plot)
      } catch (e) {
        console.log(e)
      }
    },
    async update(data) {
      try {
        // get plot object from Database
        const plot = await this.$db.get(data.features[0].properties._id)
        // update geometry
        plot.geometry = data.features[0]
        // update size
        plot.size = this.getSize(plot.geometry)
        // store changes in Database
        await this.$db.put(plot)
      } catch (e) {
        console.log(e)
      }
    },
    async combine() {

    },
    async create(data) {
      const plotName = 'Test'//prompt('Bitte geben Sie einen Name für das Feld ein', 'Unbenannt')
      const settings = await this.$db.get('settings')
      const size = this.getSize(data.features[0])
      try {
        const plot = await createPlot({
          name: plotName,
          geometry: data.features[0],
          size: size
        }, settings)

        // delete plot from map and replace with newly created one with correct id
        this.Draw.delete(data.features[0].id)
        this.Draw.add(plot.geometry)
        // store new plot in database
        await this.$db.post(plot)
      } catch (e) {
        console.log(e);
      }
    },
    removeDraw() {
      this.Draw.deleteAll()
    },
    select(data) {
      if (data.features.length !== 1)  return
      console.log(data);
      this.$bus.$emit('selectedPlot', data.features[0].properties._id)
    }
  }
}
</script>

<style>
.map {
  position: relative;
  width: calc(100% - 255px);
  height: calc(100vh - 60px);
}
</style>
