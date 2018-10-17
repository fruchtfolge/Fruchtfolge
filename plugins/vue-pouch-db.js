import Vue from 'vue'
import VuePouchDB from 'vue-pouch-db'

const bucket = new VuePouchDB.Bucket({
  // Main config Object. This is the top level
  // config object. Where global config
  // are shared with each database.
  config: {
    // db.allDocs({options})
    allDocs: {
      include_docs: true
    },

    // new Pouch({options})
    options: {
      ajax: {
        cache: true
      }
    },
    // Global onChange events
    // for each database.
    // The functions here are passed to each DB
    // db.changes().on(() => {})
    onChanges(change) {
      console.log("Change: ", change);
    },
    onPaused(error) {
      console.log("Paused", error);
    },
    onActive() {
      console.log("Active");
    },
    onDenied(error) {
      console.log("Denied", error);
    },
    onComplete() {
      console.log("Completed");
    },
    onError(error) {
      console.log("Error", error);
    },
    cancel(cancel) {
      // 'cancel' var is a function to be called
      // when something bad happens. It will
      // Cancel the watch event on CouchDB
    }
  },

  // 'projects' key -> Database Name, ex: couchdb.com/projects
  data: {
    // PouchDB.sync Options
    sync: {
      push: {
        // config for push
      },
      pull: {
        filter: 'projects/by_user',
        query_params: { "name": "sadi" }
      }
    }
  }
})

Vue.prototype.$bucket = bucket
Vue.prototype.$install = VuePouchDB.install
Vue.use(VuePouchDB)
