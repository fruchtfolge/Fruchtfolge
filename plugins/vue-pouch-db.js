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
  selector: {
    type: 'settings'
  },
  aggregate: true
})
  .on('update', (update, aggregate) => {
    Vue.set(Vue.prototype.$store, 'settings', aggregate[0])
    Vue.set(Vue.prototype.$store, 'curYear', aggregate[0].curYear)
    Vue.set(Vue.prototype.$store, 'curScenario', aggregate[0].curScenario)
    updateCurrent()
  })
  .on('error', (err) => {
    console.log(err)
  })

// plots
const plots = Vue.prototype.$db.liveFind({
  selector: {
    type: 'plot'
  },
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
  selector: {
    type: 'crop'
  },
  aggregate: true
})
  .on('update', (update, aggregate) => {
    Vue.set(Vue.prototype.$store, 'crops', aggregate)
    updateCurrent()
  })
  .on('error', (err) => {
    console.log(err)
  })
  
// constraints
const constraints = Vue.prototype.$db.liveFind({
  selector: {
    type: 'constraint'
  },
  aggregate: true
})
  .on('update', (update, aggregate) => {
    Vue.set(Vue.prototype.$store, 'constraints', aggregate)
    updateCurrent()
  })
  .on('error', (err) => {
    console.log(err)
  })

function updateCurrent() {
  if (Vue.prototype.$store.plots) {
    Vue.set(Vue.prototype.$store, 'curPlots',
      Vue.prototype.$store.plots.filter(plot => {
        return plot.year === Vue.prototype.$store.settings.curYear &&
          plot.scenario === Vue.prototype.$store.settings.curScenario
      })
    )
  }
  if (Vue.prototype.$store.crops) {
    Vue.set(Vue.prototype.$store, 'curCrops',
      Vue.prototype.$store.crops.filter(crop => {
        return crop.year === Vue.prototype.$store.settings.curYear &&
          crop.active === true &&
          crop.scenario === Vue.prototype.$store.settings.curScenario
      })
    )
  }
  if (Vue.prototype.$store.constraints) {
    Vue.set(Vue.prototype.$store, 'curConstraints',
      Vue.prototype.$store.constraints.filter(constraint => {
        return constraint.year === Vue.prototype.$store.settings.curYear &&
          constraint.scenario === Vue.prototype.$store.settings.curScenario
      })
    )
  }
  Vue.prototype.$bus.$emit('changeCurrents')
}

export default (ctx) => {

}
