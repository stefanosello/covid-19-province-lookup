import Vue from 'vue/dist/vue.esm.js'
Vue.config.devtools = true

import 'bootstrap'
import '../src/stylesheets/application.scss'

import Province from '../src/vue_components/province.vue'
Vue.component('province', Province)

import LandingPage from '../src/vue_components/landing-page.vue'
Vue.component('landing-page', LandingPage)

import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

window.Vue = Vue
