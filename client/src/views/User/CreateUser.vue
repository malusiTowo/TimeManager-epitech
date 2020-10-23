<template>
  <div>
    <!--Notice modal-->
    <modal
      :show="userFound === false && modal === true"
      modal-classes="modal-danger"
      modal-content-classes="bg-gradient-danger"
    >
      <!-- <h6 slot="header" class="modal-title">User not found</h6> -->

      <div class="py-3 text-center">
        <i class="ni ni-bell-55 ni-3x"></i>
        <h4 class="heading mt-4">User not found</h4>
        <!-- <p>
          A small river named Duden flows by their place and supplies it with
          the necessary regelialia.
        </p> -->
      </div>

      <template slot="footer">
        <!-- <base-button type="white">Ok, Got it</base-button> -->
        <base-button
          type="link"
          class="text-white m-auto"
          @click="modal = false"
          >Close</base-button
        >
      </template>
    </modal>
    <!-- Header -->
    <div class="header bg-gradient-success py-7 py-lg-8 pt-lg-9">
      <b-container>
        <div class="header-body text-center mb-7">
          <b-row class="justify-content-center">
            <b-col xl="5" lg="6" md="8" class="px-5"> </b-col>
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
                <small v-if="userFound === null"
                  >Create User with username & email</small
                >
                <small v-else-if="userFound && Object.keys(user).length > 0"
                  >User created with the following details</small
                >
              </div>
              <validation-observer
                v-slot="{ handleSubmit }"
                ref="formValidator"
                v-if="!userFound"
              >
                <b-form role="form" @submit.prevent="handleSubmit(onSubmit)">
                  <base-input
                    alternative
                    class="mb-3"
                    name="Name"
                    :rules="{ required: true, min: 1 }"
                    prepend-icon="ni ni-hat-3"
                    placeholder="Name"
                    v-model="model.name"
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

                  <div class="text-center">
                    <base-button
                      type="primary"
                      native-type="submit"
                      class="my-4"
                      >Create</base-button
                    >
                  </div>
                </b-form>
              </validation-observer>
              <div v-else>
                <h3>Id: {{ user.id }}</h3>
                <h3>Email: {{ user.email }}</h3>
                <h3>Username: {{ user.username }}</h3>
              </div>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import { createUser } from "../../api/user";

export default {
  data() {
    return {
      user: {},
      userFound: null,
      modal: false,
      model: {
        name: "",
        email: "",
      },
    };
  },
  methods: {
    async onSubmit() {
      try {
        const { name, email } = this.model;
        const response = await createUser(name, email);
        this.user = response.data.data;
        this.userFound = true;
      } catch (err) {
        this.userFound = false;
        this.modal = true;
        this.user;
        console.log("err", err);
      }
    },
  },
};
</script>
