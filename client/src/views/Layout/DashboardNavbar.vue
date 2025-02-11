<template>
  <base-nav
    container-classes="container-fluid"
    class="navbar-top navbar-expand"
    :class="{ 'navbar-dark': type === 'default' }"
  >
    <a
      href="#"
      aria-current="page"
      class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block active router-link-active"
    >
      <!-- {{ $route.name }} -->
    </a>
    <!-- Navbar links -->
    <b-navbar-nav class="align-items-center ml-md-auto">
      <!-- This item dont have <b-nav-item> because item have data-action/data-target on tag <a>, which we cant add -->
      <li class="nav-item d-sm-none">
        <a
          class="nav-link"
          href="#"
          data-action="search-show"
          data-target="#navbar-search-main"
        >
          <i class="ni ni-zoom-split-in"></i>
        </a>
      </li>
    </b-navbar-nav>
    <b-navbar-nav class="align-items-center ml-auto ml-md-0">
      <base-dropdown
        menu-on-right
        class="nav-item"
        tag="li"
        title-tag="a"
        title-classes="nav-link pr-0"
      >
        <a href="#" class="nav-link pr-0" @click.prevent slot="title-container">
          <b-media no-body class="align-items-center">
            <span class="avatar avatar-sm rounded-circle">
              <img alt="Image placeholder" src="img/user-placeholder.png" />
            </span>
            <b-media-body class="ml-2 d-none d-lg-block">
              <span class="mb-0 text-sm font-weight-bold">{{ name }}</span>
            </b-media-body>
          </b-media>
        </a>

        <template>
          <b-dropdown-header class="noti-title">
            <h6 class="text-overflow m-0">Welcome {{ name }}</h6>
          </b-dropdown-header>
          <div class="dropdown-divider"></div>
          <b-dropdown-item :to="{ name: 'profile', params: { userId: id } }">
            <i class="ni ni-single-02"></i>
            <span>Profile</span>
          </b-dropdown-item>
          <div class="dropdown-divider"></div>
          <b-dropdown-item @click="removeAccount">
            <i class="fa fa-trash"></i>
            <span>Delete account</span>
          </b-dropdown-item>
          <b-dropdown-item @click="logOut">
            <i class="ni ni-user-run"></i>
            <span>Logout</span>
          </b-dropdown-item>
        </template>
      </base-dropdown>
    </b-navbar-nav>
  </base-nav>
</template>
<script>
import { CollapseTransition } from "vue2-transitions";
import { BaseNav, Modal } from "@/components";
import {
  deleteUserbyUser,
  removeUserFromLocalStorage,
  getUserFromLocalStorage,
} from "../../api/user";

export default {
  components: {
    CollapseTransition,
    BaseNav,
    Modal,
  },
  props: {
    type: {
      type: String,
      default: "default", // default|light
      description:
        "Look of the dashboard navbar. Default (Green) or light (gray)",
    },
  },
  computed: {
    routeName() {
      const { name } = this.$route;
      return this.capitalizeFirstLetter(name);
    },
  },
  data() {
    return {
      activeNotifications: false,
      showMenu: false,
      searchModalVisible: false,
      searchQuery: "",
      name: "",
      id: null
    };
  },
  methods: {
    capitalizeFirstLetter(string) {
      return string.charAt(0).toUpperCase() + string.slice(1);
    },
    toggleNotificationDropDown() {
      this.activeNotifications = !this.activeNotifications;
    },
    closeDropDown() {
      this.activeNotifications = false;
    },
    async getUser() {
      const { user } = getUserFromLocalStorage();
      this.name = user.username;
      this.id = user.id;
    },
    removeAccount() {
      const { userId } = getUserFromLocalStorage();
      deleteUserbyUser(userId);
      const { userId: userDeleted } = getUserFromLocalStorage();
      if (!userDeleted) {
        this.$router.replace("register");
      } else {
        alert("Unable to delete account");
      }
    },
    logOut() {
      removeUserFromLocalStorage();
      const { userId } = getUserFromLocalStorage();
      if (!userId) {
        this.$router.replace("login");
      } else {
        alert("Unable to log out");
      }
    },
  },
  mounted() {
    this.getUser();
  },
};
</script>
