import Vue from 'vue/dist/vue.esm.js'
Vue.config.devtools = true

import Province from '../src/vue_components/province.vue'
Vue.component('province', Province)

window.Vue = Vue
