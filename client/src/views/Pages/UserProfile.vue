<template>
  <div>
    <!-- Header -->
    <base-header></base-header>

    <!--User Info-->
    <b-container fluid class="mt--9 ">
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

      <template v-if="edit">
        <b-row class="mt-4">
          <b-col xl="12" md="12">
            <WorkingTimeList edit v-bind:userId="userId" />
          </b-col>
        </b-row>

        <b-row class="mt-4">
          <b-col xl="12" md="12">
            <ClockHistory edit v-bind:userId="userId" />
          </b-col>
        </b-row>
      </template>
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
  methods: {
    updateUser(user) {
      this.user = user;
    },
  },
  async mounted() {
    this.user = await getUserById(this.userId);
  },
  mounted() {
    // Check of the role
    const roleGet = getUserFromLocalStorage().user.role;
    if(roleGet === "admin") {
      this.edit = true;
      this.isAdmin = true;
    }
    if(roleGet === "manager") {
      this.edit = true;
    }
  }
};
</script>
<style>
</style>

