import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue/dist/bootstrap-vue.esm';
import axios from 'axios';
import Notifications from 'vue-notification'
import VueAxios from 'vue-axios';
import App from './App.vue';
import router from './_services/router';
import { store } from './_services/store';
import 'bootstrap/dist/css/bootstrap.css';
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import 'bootstrap-vue/dist/bootstrap-vue.css';
import VueLodash from 'vue-lodash'
import Raphael from 'raphael/raphael'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

const opts = {icons: {
  iconfont: 'mdi', // default - only for display purposes
},}
export default new Vuetify(opts)

global.Raphael = Raphael
const options = { name: 'lodash' } // customize the way you want to call it

Vue.use(Vuetify)
Vue.use(VueLodash, options)
Vue.use(VueAxios, axios)
Vue.use(BootstrapVue);
Vue.use(Notifications);
Vue.config.productionTip = false;

/*
 *_________________________________________
 * Variables d'environnements
 *_________________________________________
 **/
Vue.prototype.$baseUrl = 'http://localhost:4000/api';

new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app');
