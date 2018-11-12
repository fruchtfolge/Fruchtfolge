import Vue from 'vue'
import PouchDB from 'pouchdb-browser'
import Find from 'pouchdb-find'
import LiveFind from 'pouchdb-live-find'
import _ from 'lodash'

PouchDB.plugin(Find)
PouchDB.plugin(LiveFind)

const db = new PouchDB('data')
Vue.prototype.$db = db
// add global event bus
Vue.prototype.$bus = new Vue({})
// initate store
Vue.prototype.$store = {}

// store settings and keep updated
const settings = Vue.prototype.$db.liveFind({
  selector: {type: 'settings'},
  aggregate: true
})
  .on('update', (update, aggregate) => {
    Vue.set(Vue.prototype.$store, 'settings', aggregate[0])
    Vue.set(Vue.prototype.$store, 'curYear', aggregate[0].curYear)
    updateCurrent()
  })
  .on('error', (err) => {
    console.log(err)
  })

// plots
const plots = Vue.prototype.$db.liveFind({
  selector: {type: 'plot'},
  aggregate: true
})
  .on('update', (update, aggregate) => {
    Vue.set(Vue.prototype.$store, 'plots', aggregate)
    updateCurrent()
  })
  .on('error', (err) => {
    console.log(err)
  })

// crops
const crops = Vue.prototype.$db.liveFind({
  selector: {type: 'crop'},
  aggregate: true
})
  .on('update', (update, aggregate) => {
    Vue.set(Vue.prototype.$store, 'crops', aggregate)
    updateCurrent()
  })
  .on('error', (err) => {
    console.log(err)
  })

function updateCurrent() {
  if(Vue.prototype.$store.plots) {
    Vue.set(Vue.prototype.$store, 'curPlots',
      Vue.prototype.$store.plots.filter(plot => { return plot.year === Vue.prototype.$store.settings.curYear})
    )
  }
  if (Vue.prototype.$store.crops) {
    Vue.set(Vue.prototype.$store, 'curCrops',
      Vue.prototype.$store.crops.filter(crop => { return crop.year === Vue.prototype.$store.settings.curYear && crop.active === true})
    )
  }
  Vue.prototype.$bus.$emit('changeCurrents')
}

export default (ctx) => {

}
