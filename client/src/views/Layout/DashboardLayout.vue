<template>
  <div class="wrapper">
    <notifications></notifications>
    <side-bar>
      <template slot="links">
        <sidebar-item
          :link="{
            name: 'Dashboard',
            path: '/dashboard',
            icon: 'ni ni-tv-2 text-yellow',
          }"
        >
        </sidebar-item>

        <sidebar-item
          :link="{
            name: 'Chart Manager',
            path: `/chartManager/${this.userId}`,
            icon: 'ni ni-planet text-yellow',
          }"
        >
        </sidebar-item>

        <sidebar-item
          :link="{
            name: 'Profile',
            path: `/profile/${this.userId}`,
            icon: 'ni ni-single-02 text-yellow',
          }"
        >
        </sidebar-item>
        <sidebar-item
          :link="{
            name: 'Working Time',
            path: `/workingtime/${this.userId}`,
            icon: 'ni ni-calendar-grid-58 text-yellow',
          }"
        >
        </sidebar-item>
        <sidebar-item
          :link="{
            name: 'Clock',
            path: '/clock/:username',
            icon: 'ni ni-watch-time text-yellow',
          }"
        >
        </sidebar-item>
        <!-- Admin users sidebar item to render only for Admin and Manager -->
        <template v-if="isAdmin || isManager">
          <sidebar-item
          :link="{
            name: 'Admin Users',
            path: '/adminUsers',
            icon: 'ni ni-settings text-yellow',
          }"
          >
          </sidebar-item>
        </template>
        <template v-if="isAdmin || isManager">
          <sidebar-item
          :link="{
            name: 'Admin Teams',
            path: '/Teams',
            icon: 'fa fa-users text-yellow',
          }"
          >
          </sidebar-item>
        </template>
      </template>
    </side-bar>
    <div class="main-content">
      <dashboard-navbar :type="$route.meta.navbarType"></dashboard-navbar>

      <div @click="$sidebar.displaySidebar(false)">
        <fade-transition :duration="200" origin="center top" mode="out-in">
          <router-view></router-view>
        </fade-transition>
      </div>
      <content-footer v-if="!$route.meta.hideFooter"></content-footer>
    </div>
  </div>
</template>
<script>
/* eslint-disable no-new */
import PerfectScrollbar from "perfect-scrollbar";
import "perfect-scrollbar/css/perfect-scrollbar.css";
import { getUserFromLocalStorage } from "../../api/user";
function hasElement(className) {
  return document.getElementsByClassName(className).length > 0;
}

function initScrollbar(className) {
  if (hasElement(className)) {
    new PerfectScrollbar(`.${className}`);
  } else {
    // try to init it later in case this component is loaded async
    setTimeout(() => {
      initScrollbar(className);
    }, 100);
  }
}

import DashboardNavbar from "./DashboardNavbar.vue";
import ContentFooter from "./ContentFooter.vue";
import DashboardContent from "./Content.vue";
import { FadeTransition } from "vue2-transitions";
import users from '../Tables/users';

export default {
  data() {
    return {
      userId: null,
      isAdmin: false,
      isManager: false
    };
  },
  components: {
    DashboardNavbar,
    ContentFooter,
    DashboardContent,
    FadeTransition,
  },
  methods: {
    initScrollbar() {
      let isWindows = navigator.platform.startsWith("Win");
      if (isWindows) {
        initScrollbar("sidenav");
      }
    },
  },
  mounted() {
    const { userId } = getUserFromLocalStorage();
    this.userId = userId;
    // Check of the role
    const role = getUserFromLocalStorage().user.role;
    if(role === "admin") {
      this.isAdmin = true;
    }
    if(role === "manager") {
      this.isManager = true;
    }
    this.initScrollbar();
  },
};
</script>
<style lang="scss">
</style>
