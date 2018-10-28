const webpack = require('webpack')

module.exports = {
  mode: 'spa',
  head: {
    title: 'Fruchtfolge',
    link: [{
      rel: 'stylesheet',
      href: 'https://api.tiles.mapbox.com/mapbox-gl-js/v0.50.0/mapbox-gl.css'
    },
    {
      rel: 'stylesheet',
      href: 'https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.0.4/mapbox-gl-draw.css'
    }]},
  loading: {
    color: '#79ae98',
    height: '5px'
  },
  plugins: ['~/plugins/vue-pouch-db'],
  build: {
    extend (config, { isDev, isClient }) {
      if (isDev && isClient) {
        // Run ESLint on save
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
      // Extend only webpack config for client-bundle
      if (isClient) { config.target = 'electron-renderer' }
    },
    plugins: [
      new webpack.ProvidePlugin({
        '_': 'lodash'
      })
    ]
  },
  dev: process.env.NODE_ENV === 'DEV',
  css: [
    '@/assets/css/global.css'
  ]
}
