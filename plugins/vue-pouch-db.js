import Vue from 'vue'
import PouchDB from 'pouchdb-browser'
import Find from 'pouchdb-find'
import LiveFind from 'pouchdb-live-find'

PouchDB.plugin(Find)
PouchDB.plugin(LiveFind)

const db = new PouchDB('data')
Vue.prototype.$db = db

export default (ctx) => {

}
