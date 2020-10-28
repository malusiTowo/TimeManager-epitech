<template>
  <div>
    <b-button
      @click="
        modals.create = true;
        errors = [];
      "
      variant="success"
      >Create</b-button
    >

    <b-modal v-model="modals.create" title="Create clock">
      <b-container fluid>
        <b-col xl="12" md="12">
          <b-alert show variant="warning" v-if="errors.length">
            <strong>Fields error:</strong>
            <ul>
              <li v-for="error in errors" v-bind:key="error">{{ error }}</li>
            </ul>
          </b-alert>

          <form
            id="CreateClock"
            @submit="checkForm"
            v-on:submit.prevent="createClock"
          >
            <div class="form-group">
              <label for="name">Clock Date & Time</label>
              <input
                type="datetime-local"
                class="form-control"
                id="dateStart"
                placeholder="Date Start"
                v-model="form.time"
              />
            </div>
            <div class="form-group">
              <label for="name">Status</label>
              <select class="form-control" v-model="form.status">
                <option
                  v-for="status in status"
                  v-bind:key="status.value"
                  v-bind:value="status.value"
                >
                  {{ status.text }}
                </option>
              </select>
            </div>
          </form>
        </b-col>
      </b-container>

      <template #modal-footer>
        <b-button
          variant="primary"
          class="float-right"
          @click="modals.create = false"
        >
          Close
        </b-button>
        <b-button
          variant="success"
          class="float-right"
          @click="createClock"
        >
          Create
        </b-button>
      </template>
    </b-modal>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

import { getUsers } from "@/api/user";
import { createClock } from "../../api/clock";

export default {
  name: "clock-create",
  data() {
    return {
      modals: {
        create: false,
      },
      errors: [],
      selectedUser: "1",
      form: {
        idUser: "",
        time: null,
        status: null
      },
      users: [],
      status: [
        { text: "", value: null},
        { text: "Clock-In", value: true},
        { text: "Clock-Out", value: false}
      ]
    };
  },
  async mounted() {
    this.users = await getUsers();
  },
  methods: {
    submitForm(evt) {
      evt.preventDefault();
      document.getElementById("CreateClock").submit();
    },
    checkForm() {
      let checker = true;
      this.errors = [];

      if (!this.form.time) {
        this.errors.push("Time required.");
        cherker = false;
      }

      if (!this.form.status) {
        this.errors.push("Status required.");
        cherker = false;
      }

      return checker;
    },
    async createClock() {
      if (!this.checkForm()) {
        return false;
      }
      try {
        await createClock(
          this.selectedUser,
          this.form.time,
          this.form.status
        );
        this.$emit("event_child");
        this.modals.create = false;
        this.form.time = null;
        this.form.status = null;
      } catch (err) {
        this.errors.push("Clock create failed.");
      }
    },
  },
};
</script>
<style>
</style>