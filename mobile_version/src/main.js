// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

import VueLodash from 'vue-lodash'
import Raphael from 'raphael/raphael'
import Vuetify from 'vuetify'
import BootstrapVue from 'bootstrap-vue/dist/bootstrap-vue.esm'
import axios from 'axios'
import Notifications from 'vue-notification'
import VueAxios from 'vue-axios'

import 'bootstrap/dist/css/bootstrap.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)
Vue.use(VueLodash, options)
Vue.use(VueAxios, axios)
Vue.use(BootstrapVue)
Vue.use(Notifications)

Vue.config.productionTip = false

const opts = {icons: {
  iconfont: 'mdi', // default - only for display purposes
},}
export default new Vuetify(opts)

global.Raphael = Raphael
const options = { name: 'lodash' }

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
