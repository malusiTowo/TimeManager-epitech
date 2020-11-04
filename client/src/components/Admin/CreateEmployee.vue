<template>
  <div>
    <b-button
     @click="modalShow = true;
     errors = [];"
     variant="outline-warning"
    >Create Employee</b-button>
    <b-modal size="lg" v-model="modalShow" title="Create Employee">
      <div class="text-center mb-4">
        <p>Please fill all the information below to create a new employee</p>
      </div>
      <!-- A retravailler -->
      <b-alert
       v-if="errors.length"
       show variant="warning"
      >
        <b>Please correct the following error(s):</b>
        <ul>
          <li
           v-for="error in errors"
           v-bind:key="error"
          >{{ error }}</li>
        </ul>
      </b-alert>

      <b-form
        id="CreateEmployee"
        @submit="checkForm"
        @reset="onCancel"
        v-on:submit.prevent="onSubmit"
      >
        <b-form-group label="Username">
          <base-input
            alternative
            id="username"
            name="username"
            v-model="form.username"
            :rules="{ required: true, min: 3 }"
            placeholder="Username"
            prepend-icon="ni ni-single-02"
          >
          </base-input>
        </b-form-group>

        <!-- <b-form-group label="Firstname">
            <base-input
              alternative
              id="firstname"
              name="firstname"
              v-model="form.firstname"
              :rules="{ required: true, min: 2 }"
              placeholder="Firstname"
              prepend-icon="ni ni-badge"
            >
            </base-input>
          </b-form-group>
          <b-form-group label="Lastname">
            <base-input
              alternative
              id="lastname"
              name="lastname"
              v-model="form.lastname"
              :rules="{ required: true, min: 2 }"
              placeholder="Lastname"
              prepend-icon="ni ni-badge"
            >
            </base-input>
          </b-form-group> -->

        <b-form-group label="Email">
          <base-input
            alternative
            id="email"
            name="email"
            class="mb-3"
            v-model="form.email"
            type="email"
            :rules="{ required: true, email: true }"
            placeholder="Email"
            prepend-icon="ni ni-email-83"
          >
          </base-input>
        </b-form-group>

        <b-form-group label="Password">
          <base-input
            alternative
            id="password"
            name="password"
            type="password"
            v-model="form.password"
            :rules="{ required: true }"
            placeholder="Password"
            prepend-icon="ni ni-lock-circle-open"
          >
          </base-input>
          <b-form-text id="password-help-block">
            The password must be at least 8 characters long, contain letters and
            numbers, and must not contain spaces, special characters, or emoji.
          </b-form-text>
        </b-form-group>

        <template v-if="isAdmin">
          <b-form-group label="Role">
            <base-input>
              <b-form-select
                class="form-control"
                v-model="selected"
                :options="options"
                prepend-icon="ni ni-key-25"
              >
              </b-form-select>
            </base-input>
          </b-form-group>
        </template>
      </b-form>
      <template #modal-footer>
        <b-button
         variant="danger"
         type="reset"
         v-on:click="onCancel"
        >
          Cancel
        </b-button>
        <b-button
         v-on:click="onSubmit"
         :disabled="disabledCreate"
        >
          Create
        </b-button>
      </template>
    </b-modal>
  </div>
</template>

<script>
import { signup } from "../../api/user";

export default {
  name: "create-employee",
  data() {
    return {
      modalShow: false,
      disabledCreate: false,
      errors: [],
      users: [],
      // data for the form
      form: {
        username: "",
        email: "",
        password: "",
      },
      // data for the select
      selected: null,
      options: [
        { value: null, text: "Please select a role", disabled: true },
        { value: "a", text: "Employee" },
        { value: "b", text: "Manager" },
        { value: "c", text: "Administrator" },
      ],
    };
  },
  props: {
    isAdmin: false,
  },
  methods: {
    submitForm(e) {
      e.preventDefault();
      document.getElementById("CreateEmployee").submit();
    },
    async checkForm() {
      this.errors = [];
      if (this.form.username && this.form.email && this.form.password) {
        this.disabledCreate = false;
        return true;
      }
      if (!this.form.username) {
        this.errors.push("Username is required.");
        this.disabledCreate = true;
        return false;
      }
      if (!this.form.email) {
        this.errors.push("Email is required.");
        this.disabledCreate = true;
        return false;
      }
      if (!this.form.password) {
        this.errors.push("Password is required.");
        this.disabledCreate = true;
        return false;
      }
    },
    async onSubmit() {
      if (!this.checkForm()) {
        this.disabledCreate = true;
        return false;
      }
      try {
        // add an user creation confirmation
        await signup(
          this.form.username,
          this.form.email,
          this.form.password
        );
        this.$emit("event_child");
        this.modalShow = false;
        this.form.username = "";
        this.form.email = "";
        this.form.password = "";
        this.erros = [];
      } catch (err) {
        this.modalShow = true;
        this.errors.push("Employee creation failed.");
        console.log("Echec " + err);
      }
    },
    onCancel(e) {
      e.preventDefault();
      this.form.username = "";
      this.form.email = "";
      this.form.password = "";
      this.modalShow = false;
      this.erros = [];
    },
  },
};
</script>
<style>
</style>