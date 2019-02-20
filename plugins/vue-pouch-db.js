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
  sort: [{
    name: 'asc'
  }],
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
  sort: [{
    name: 'asc'
  }],
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

// time constraints
const timeConstraints = Vue.prototype.$db.liveFind({
  selector: {
    type: 'timeConstraints'
  },
  aggregate: true
})
  .on('update', (update, aggregate) => {
    Vue.set(Vue.prototype.$store, 'timeConstraints', aggregate)
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
  if (Vue.prototype.$store.timeConstraints) {
    const match = Vue.prototype.$store.timeConstraints.filter(timeConstraints => {
      return timeConstraints.year === Vue.prototype.$store.settings.curYear &&
        timeConstraints.scenario === Vue.prototype.$store.settings.curScenario
    })
    if (match.length > 0) {
      Vue.set(Vue.prototype.$store, 'curTimeConstraints', match[0])
    } else {
      Vue.set(Vue.prototype.$store, 'curTimeConstraints', null)
    }
  }
  Vue.prototype.$bus.$emit('changeCurrents')
}


function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0,
      v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

// listen to import previous year event
Vue.prototype.$bus.$on('importPrevYear', async () => {
  try {
    const curYear = Vue.prototype.$store.curYear
    const result = await Vue.prototype.$db.find({
      selector: {
        year: curYear - 1
      }
    })
    if (result && result.docs && result.docs.length > 0) {
      const data = result.docs.map(o => {
        o._id = uuidv4()
        delete o._rev
        o.year = curYear
        return o
      })
      await Vue.prototype.$db.bulkDocs(data)
    }
    console.log(result)
  } catch (e) {
    console.log(e)
  }
})
/*
export default (ctx) => {

}
*/
export default ({ app }, inject) => {
  inject('store', Vue.prototype.$store),
  inject('db', Vue.prototype.$db)
}
