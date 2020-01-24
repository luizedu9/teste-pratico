import BootstrapVue from 'bootstrap-vue'
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap-vue/dist/bootstrap-vue.css"
import VueMask from 'v-mask'
import 'vue-search-select/dist/VueSearchSelect.css'


Vue.use(BootstrapVue);
Vue.config.productionTip = false
Vue.use(VueMask);
Vue.use(require('vue-moment'));


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
