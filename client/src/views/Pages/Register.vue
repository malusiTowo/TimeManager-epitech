<template>
  <div>
    <!-- Header -->
    <div class="header bgBlackGotham py-6 py-lg-6 pt-lg-7">
      <b-container class="container">
        <div class="header-body text-center mb-7">
          <b-row class="justify-content-center">
            <b-col xl="5" lg="6" md="8" class="px-5">
              <h1 class="text-white">Create an account</h1>
            </b-col>
          </b-row>
        </div>
      </b-container>
      <div class="separator separator-bottom separator-skew zindex-100 bgYellowGotham">
        <svg
          x="0"
          y="0"
          viewBox="0 0 2560 100"
          preserveAspectRatio="none"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
        >
          <polygon
            class="bgBlackGotham"
            points="2560 0 2560 100 0 100"
          ></polygon>
        </svg>
      </div>
    </div>
    <!-- Page content -->
    <b-container class="mt--8 pb-5">
      <!-- Table -->
      <b-row class="justify-content-center">
        <b-col lg="6" md="8">
          <b-card no-body class="bg-secondary border-0">
            <b-card-body class="px-lg-5 py-lg-5">
              <!-- <div class="text-center mb-4">
                <p>Create your account!</p>
              </div> -->
              <validation-observer
                v-slot="{ handleSubmit }"
                ref="formValidator"
              >
                <b-form role="form" @submit.prevent="handleSubmit(onSubmit)">
                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-single-02"
                    placeholder="Username"
                    name="Username"
                    :rules="{ required: true }"
                    v-model="model.username"
                  >
                  </base-input>
                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-email-83"
                    placeholder="Email"
                    name="Email"
                    :rules="{ required: true, email: true }"
                    v-model="model.email"
                  >
                  </base-input>

                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-key-25"
                    placeholder="Password"
                    name="Password"
                    type="password"
                    :rules="{ required: true }"
                    v-model="model.password"
                  >
                  </base-input>
                  <b-form-text id="password-help-block">
                    The password must be at least 8 characters long, contain
                    letters (at least one uppercase letter) and numbers, and must not contain spaces, special characters, or emoji.
                  </b-form-text>

                  <div class="text-center">
                    <b-button type="submit" variant="primary" class="mt-4"
                      >Create account</b-button
                    >
                  </div>
                </b-form>
              </validation-observer>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import { signup } from "../../api/user";
export default {
  name: "register",
  data() {
    return {
      model: {
        username: "",
        email: "",
        password: "",
        agree: false,
      },
    };
  },
  methods: {
    async onSubmit() {
      try {
        const { username, email, password } = this.model;
        const isLoggedIn = await signup(username, email, password);
        if (isLoggedIn) {
          this.$emit("loggedIn");
          this.$router.push("login");
          alert(
            "Account created successfully. Please login with your credentials"
          );
        } else {
          alert("Invalid credentialas");
        }
      } catch (err) {
        console.log("err", err);
        alert("An error occured. try again later.");
      }
    },
  },
};
</script>
<style></style>
