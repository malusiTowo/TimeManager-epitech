<template>
  <div>
    <!-- Header -->
    <div class="header bg-gradient-success py-7 py-lg-8 pt-lg-9">
      <b-container>
        <div class="header-body text-center mb-7">
          <b-row class="justify-content-center">
            <b-col xl="5" lg="6" md="8" class="px-5">
              <h1 class="text-white">Welcome!</h1>
              <!-- <p class="text-lead text-white">
                Use these awesome forms to login or create new account in your
                project for free.
              </p> -->
            </b-col>
          </b-row>
        </div>
      </b-container>
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg
          x="0"
          y="0"
          viewBox="0 0 2560 100"
          preserveAspectRatio="none"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
        >
          <polygon
            class="fill-default"
            points="2560 0 2560 100 0 100"
          ></polygon>
        </svg>
      </div>
    </div>
    <!-- Page content -->
    <b-container class="mt--8 pb-5">
      <b-row class="justify-content-center">
        <b-col lg="5" md="7">
          <b-card no-body class="bg-secondary border-0 mb-0">
            <b-card-body class="px-lg-5 py-lg-5">
              <div class="text-center text-muted mb-4">
                <small>Sign in with credentials</small>
              </div>
              <validation-observer
                v-slot="{ handleSubmit }"
                ref="formValidator"
              >
                <b-form role="form" @submit.prevent="handleSubmit(onSubmit)">
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
                    name="Password"
                    :rules="{ required: true }"
                    prepend-icon="ni ni-key-25"
                    placeholder="Password"
                    type="password"
                    v-model="model.password"
                  >
                  </base-input>

                  <div class="text-center">
                    <base-button
                      type="primary"
                      native-type="submit"
                      class="my-4"
                      >Sign in</base-button
                    >
                  </div>
                </b-form>
              </validation-observer>
            </b-card-body>
          </b-card>
          <b-row class="mt-3">
            <b-col cols="12" class="text-center">
              <router-link to="/register" class="text-light"
                ><small>Create new account</small></router-link
              >
            </b-col>
          </b-row>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import { login, getUserFromLocalStorage } from "../../api/user";

export default {
  data() {
    return {
      model: {
        name: "",
        email: "",
        password: "",
        rememberMe: false,
      },
    };
  },
  methods: {
    async onSubmit() {
      try {
        const { password, email } = this.model;
        const isLoggedIn = await login(email, password);
        const { userId } = getUserFromLocalStorage();
        if (isLoggedIn && userId) {
          this.$emit("loggedIn");
          if (this.$route.params.nextUrl != null) {
            this.$router.push(this.$route.params.nextUrl);
          } else {
            this.$router.push("dashboard");
          }
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
