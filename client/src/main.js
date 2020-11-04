import Raphael from 'raphael/raphael'
global.Raphael = Raphael

global.jQuery = require('jquery');
var $ = global.jQuery;
window.$ = $;

$.extend(true, $.fn.datetimepicker.defaults, {
  icons: {
    time: 'far fa-clock',
    date: 'far fa-calendar',
    up: 'fas fa-arrow-up',
    down: 'fas fa-arrow-down',
    previous: 'fas fa-chevron-left',
    next: 'fas fa-chevron-right',
    today: 'fas fa-calendar-check',
    clear: 'far fa-trash-alt',
    close: 'far fa-times-circle'
  }
});

import Vue from 'vue';
import DashboardPlugin from './plugins/dashboard-plugin';
import App from './App.vue';
import axios from 'axios';

import SmartTable from 'vuejs-smart-table'

import './plugins/date-timepicker'
// router setup
import router from './routes/router';

// nav tab bar mobile
import VueMaterial from 'vue-material';
import 'vue-material/dist/vue-material.min.css';
import 'vue-material/dist/theme/default.css';
Vue.use(VueMaterial);

// plugin setup
Vue.use(DashboardPlugin);

Vue.prototype.$http = axios;

// setup smart table
Vue.use(SmartTable)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  render: h => h(App),
  router
});
