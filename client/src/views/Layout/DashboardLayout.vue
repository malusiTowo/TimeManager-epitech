<template>
  <div class="wrapper">
    <!-- Side nav bar menu for desktop -->
    <!-- Show only if it's not a mobile -->
    <!-- <template v-if="!mobileView"> -->
    <template v-if="!mobileView">
      <side-bar
       v-bind:username="this.username" 
       v-bind:userId="this.userId"
      >
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
        </template>
      </side-bar>
    </template>

    <!-- If mobile view show -->
    <template v-if="mobileView">
      <navigation-mobile
       v-bind:userId="this.userId"
      ></navigation-mobile>
    </template>

    <!-- All the website content appear here -->
    <div class="main-content">
      <dashboard-navbar :type="$route.meta.navbarType"></dashboard-navbar>

      <div @click="$sidebar.displaySidebar(false)">
        <fade-transition :duration="200" origin="center top" mode="out-in">
          <router-view></router-view>
        </fade-transition>
      </div>
      <!-- <content-footer v-if="!$route.meta.hideFooter"></content-footer> -->
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
import users from "../Tables/users";
import NavigationMobile from "../../components/NavigationMobile.vue";

export default {
  data() {
    return {
      userId: null,
      username: null,
      isAdmin: false,
      isManager: false,
      mobileView: false,
      showNav: false
    };
  },
  components: {
    DashboardNavbar,
    ContentFooter,
    DashboardContent,
    FadeTransition,
    NavigationMobile
  },
  methods: {
    initScrollbar() {
      let isWindows = navigator.platform.startsWith("Win");
      if (isWindows) {
        initScrollbar("sidenav");
      }
    },
    // method to handle the mobile view
    handleView() {
      this.mobileView = window.innerWidth <= 768;
    }
  },
  created() {
    this.handleView();
  },
  mounted() {
    const { userId } = getUserFromLocalStorage();
    this.userId = userId;
    this.username = getUserFromLocalStorage().user.username;
    // Check of the role
    const role = getUserFromLocalStorage().user.role;
    if (role === "admin") {
      this.isAdmin = true;
    }
    if (role === "manager") {
      this.isManager = true;
    }
    this.initScrollbar();
  },
};
</script>
<style lang="scss">
</style>
