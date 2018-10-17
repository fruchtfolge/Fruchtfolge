<template>
  <div id="map" class="map">
  </div>
</template>

<script>
import VuePouch from 'vue-pouch-db'

export default {
  name: 'MapBox',
  mounted () {
    this.createMap()
    this.drawPlots()
  },
  methods: {
    createMap() {
      console.log(this);
      const mapboxgl = require('mapbox-gl')
      const MapboxDraw = require('@mapbox/mapbox-gl-draw')

      // const language = 'de'
      mapboxgl.accessToken = 'pk.eyJ1IjoidG9mZmkiLCJhIjoiY2l3cXRnNHplMDAxcTJ6cWY1YWp5djBtOSJ9.mBYmcCSgNdaRJ1qoHW5KSQ'

      // init the map
      this.map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/satellite-streets-v9?optimize=true',
        // replace by database info later
        center: [ 8.352475, 52.08873 ],
        zoom: 14,
        dragPan: false,
        drageRotate: false
      })

      // load Mapbox Draw configuration file
      const drawConfig = require('../assets/draw.config.js')
      this.Draw = new MapboxDraw(drawConfig)
      this.map.addControl(new mapboxgl.NavigationControl(), 'bottom-left')
      this.map.addControl(this.Draw, 'bottom-left')

      // add event listeners
      this.map.on('draw.create', (data) => {
        console.log(data)
      })
      this.map.on('draw.update', (data) => {
        console.log(data)
      })
      this.map.on('draw.delete', (data) => {
        console.log(data)
      })
      this.map.on('draw.combine', (data) => {
        console.log(data)
      })
    },
    async drawPlots() {
      //
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
