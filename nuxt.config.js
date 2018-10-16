module.exports = {
  mode: 'spa',
  head: {title: 'Fruchtfolge'}, // Headers of the page
  loading: {
    color: '#79ae98',
    height: '3px'
  },
  link: [{
    rel: 'stylesheet',
    href: 'https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300'
  }],
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
    }
  },
  dev: process.env.NODE_ENV === 'DEV',
  css: [
    '@/assets/css/global.css'
  ]
}
