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
          <template v-if="isAdmin">
            <b-col lg="6">
              <base-input>
                <b-form-select
                  class="form-control"
                  v-model="user.role"
                  :options="options"
                  prepend-icon="ni ni-key-25"
                >
                </b-form-select>
              </base-input>
            </b-col>
          </template>
        </b-row>
        <b-row>
          <b-col lg="6">
            <base-button type="primary" native-type="submit" class="my-4"
              >Update profile</base-button
            >
          </b-col>
          <b-col lg="6">
            <!-- Rajouter methode delete -->
            <base-button type="danger" class="my-4">Delete profile</base-button>
          </b-col>
        </b-row>
      </div>
    </b-form>
  </card>
</template>
<script>
import {
  getUserFromLocalStorage,
  updateUser,
  getUserById,
  getUserId,
  deleteUser,
} from "@/api/user";

export default {
  props: {
    userId: {
      type: [String, Number],
      //default: getUserId()
    },
  },
  data() {
    return {
      user: {
        username: null,
        email: null,
        role: null,
      },
      // data for the select
      selected: null,
      options: [
        { value: null, text: "Please select a role", disabled: true },
        { value: "employee", text: "Employee" },
        { value: "manager", text: "Manager" },
        { value: "admin", text: "Admin" },
      ],
    };
  },
  methods: {
    async updateProfile() {
      try {
        const isUserUpdated = await updateUser(
          this.userId,
          this.user.username,
          this.user.email,
          this.user.role
        );

        if (!isUserUpdated) alert("Unable to update account");
        else alert(`${this.user.username} Updated`);

        this.$emit("user_emit", {
          username: this.user.username,
          id: this.userId,
          email: this.user.email,
          role: this.user.role,
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
