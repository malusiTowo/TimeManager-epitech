<template>
  <div>
    <!-- Header -->
    <base-header></base-header>

    <!--User Info-->
    <b-container fluid class="mt--9">
      <b-row>
        <b-col xl="12" md="12">
          <h1>{{ user.username }}</h1>
        </b-col>
      </b-row>

      <b-row>
        <b-col xl="12" md="12">
          <EditProfileForm
            v-bind:userId="userId"
            v-bind:isManager="edit"
            @user_emit="updateUser"
            v-bind:isAdmin="isAdmin"
          />
        </b-col>
      </b-row>

      <b-row class="mt-4" v-if="edit">
        <b-col xl="12" md="12">
          <TeamList v-bind:userId="userId" />
        </b-col>
      </b-row>

      <template v-if="!mobileView">
        <b-row class="mt-4" v-if="edit">
          <b-col xl="12" md="12">
            <WorkingTimeList edit v-bind:userId="userId" />
          </b-col>
        </b-row>

        <b-row class="mt-4" v-if="edit">
          <b-col xl="12" md="12">
            <ClockHistory edit :userId="userId" />
          </b-col>
        </b-row>
      </template>
    </b-container>
  </div>
</template>
<script>

import EditProfileForm from "./UserProfile/EditProfileForm.vue";
import { WorkingTimeList, ClockHistory, TeamList } from "@/components";
import {
  getUsers,
  getUserFromLocalStorage,
  getUserById,
  getUserId,
} from "@/api/user";

export default {
  components: {
    EditProfileForm,
    WorkingTimeList,
    ClockHistory,
    TeamList
  },
  data() {
    return {
      userId: this.$route.params.userId,
      edit: false,
      isAdmin: false,
      user: {
        username: null,
        id: null,
        email: null,
        role: null,
      },
    };
  },
  props: {
    mobileView: {
      type: Boolean,
      default: false
    }
  },
  watch: {
    "$route.params.userId": async function (id) {
      location.reload();
      // const user = await getUserById(id);
      // this.updateUser(user);
      // this.updateUserId(id);
    },
  },
  methods: {
    updateUser(user) {
      this.user = user;
    },
    updateUserId(userId) {
      this.userId = userId;
    },
  },
  async mounted() {
    this.user = await getUserById(this.userId);
  },
  mounted() {
    // Check of the role
    const roleGet = getUserFromLocalStorage().user.role;
    if (roleGet === "admin") {
      this.edit = true;
      this.isAdmin = true;
    }
    if (roleGet === "manager") {
      this.edit = true;
    }
  },
};
</script>
<style>
</style>

