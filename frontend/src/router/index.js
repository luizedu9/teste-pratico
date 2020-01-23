import Vue from 'vue'
import VueRouter from 'vue-router'
import Venda from '../views/Venda.vue'
import Consulta from '../views/Consulta.vue'

Vue.use(VueRouter)

//Define as rotas para cada componente
const routes = [
  {
    path: '/',
    name: 'venda',
    component: Venda
  },
  {
    path: '/consulta',
    name: 'consulta',
    component: Consulta
  }
]

//Default
const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
