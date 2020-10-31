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
          <EditProfileForm v-bind:userId="userId" @user_emit="updateUser" />
        </b-col>
      </b-row>

      <b-row class="mt-4" v-if="role">
        <b-col xl="12" md="12">
          <WorkingTimeList edit v-bind:userId="userId" />
        </b-col>
      </b-row>

      <b-row class="mt-4" v-if="role">
        <b-col xl="12" md="12">
          <ClockHistory edit v-bind:userId="userId" />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import EditProfileForm from "./UserProfile/EditProfileForm.vue";
import { WorkingTimeList, ClockHistory } from "@/components";
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
  },
  data() {
    return {
      userId: this.$route.params.userId,
      role: true,
      user: {
        username: null,
        id: null,
        email: null,
      },
    };
  },
  methods: {
    updateUser(user) {
      this.user = user;
    },
  },
  async mounted() {
    this.user = await getUserById(this.userId);
  },
};
</script>
<style>
</style>

