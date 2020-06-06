import Vue from 'vue/dist/vue.esm.js'
Vue.config.devtools = true

import 'bootstrap'
import '../src/stylesheets/application.scss'

import LandingPage from '../src/vue_components/landing-page.vue'
Vue.component('landing-page', LandingPage)

import Sidebar from '../src/vue_components/sidebar.vue'
Vue.component('sidebar', Sidebar)

import Navbar from '../src/vue_components/navbar.vue'
Vue.component('navbar', Navbar)

import Chart from '../src/vue_components/chart.vue'
Vue.component('chart', Chart)

import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

import 'animate.css/animate.css';

window.Vue = Vue
