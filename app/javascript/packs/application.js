import Vue from 'vue/dist/vue.esm.js'
Vue.config.devtools = true

import 'bootstrap'
import '../src/stylesheets/application.scss'

import Province from '../src/vue_components/province.vue'
Vue.component('province', Province)

window.Vue = Vue
