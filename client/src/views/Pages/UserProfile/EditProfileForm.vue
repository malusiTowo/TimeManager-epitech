<template>
  <card>
    <b-row align-v="center" slot="header">
      <b-col cols="8">
        <h3 class="mb-0">Edit profile</h3>
      </b-col>
    </b-row>

    <b-form @submit.prevent="updateProfile">
      <h6 class="heading-small text-muted mb-4">User information</h6>

      <div class="pl-lg-4">
        <b-row>
          <b-col lg="6">
            <base-input
              type="text"
              label="Username"
              placeholder="Username"
              v-model="user.username"
            >
            </base-input>
          </b-col>
          <b-col lg="6">
            <base-input
              type="email"
              label="Email address"
              placeholder="mike@email.com"
              v-model="user.email"
            >
            </base-input>
          </b-col>
          <div class="text-center">
            <base-button type="primary" native-type="submit" class="my-4"
              >Update profile</base-button
            >
          </div>
        </b-row>
      </div>
    </b-form>
  </card>
</template>
<script>
import {
  getUserFromLocalStorage,
  updateUser,
  setUserToLocalStorage,
} from "../../../api/user";
export default {
  data() {
    return {
      user: {
        username: "michael23",
        email: "johndoe@email.com",
      },
    };
  },
  methods: {
    async updateProfile() {
      try {
        const { username, email } = this.user;
        const { userId } = getUserFromLocalStorage();
        const isUserUpdated = await updateUser(userId, username, email);
        if (!isUserUpdated) alert("Unable to update account");
        else alert("Profile updated succesfully");
      } catch (err) {
        console.log("err", err);
        alert("An error occured. try again later.");
      }
    },
  },
};
</script>
<style></style>
