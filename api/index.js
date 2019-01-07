const URL = require('url-parse')
const querystring = require('querystring')

const createCrop = require('./createCrop')
const model = require('./createModel')
//const {openExternal} = require('./openExternal.js')
//const releases = require('./releases.js')
//const seasons = require('./seasons.js')

exports.route = (nuxt) => {
  return async (req, res) => {
    const url = new URL(req.url)
    // const query = querystring.parse(url.query.replace('?',''))

    switch (url.pathname) {
    case '/createCrop':
      createCrop.getInfo(req, res)
      break
      
    case '/createModel':
      model.build(req, res)
      break
      
    default:
      nuxt.render(req, res)
    }
  }
}
