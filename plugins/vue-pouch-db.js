import Vue from 'vue'
import VuePouchDB from 'vue-pouch-db'

Vue.prototype.$bucket = VuePouchDB.Bucket
Vue.prototype.$install = VuePouchDB.install
Vue.use(VuePouchDB)
