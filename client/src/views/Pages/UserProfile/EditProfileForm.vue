<template>
  <card>
    <b-row align-v="center" slot="header">
      <b-col cols="8">
        <h1 class="mb-0">Edit profile</h1>
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
import { getUserFromLocalStorage, updateUser, getUserById } from "@/api/user";

export default {
  props: {
    userId: {
      type: [String, Number],
      default: getUserFromLocalStorage().userId
        ? getUserFromLocalStorage().userId
        : "",
    },
  },
  data() {
    return {
      user: {
        username: null,
        email: null,
      },
    };
  },
  methods: {
    async updateProfile() {
      try {
        const isUserUpdated = await updateUser(
          this.userId,
          this.user.username,
          this.user.email
        );

        if (!isUserUpdated) alert("Unable to update account");
        else alert(`${this.user.username} Updated`);

        this.$emit("user_emit", {
          username: this.user.username,
          id: this.userId,
          email: this.user.email,
        });
      } catch (err) {
        console.log("err", err);
        alert("An error occured. try again later.");
      }
    },
  },
  async mounted() {
    this.user = await getUserById(this.userId);
  },
};
</script>
<style></style>
