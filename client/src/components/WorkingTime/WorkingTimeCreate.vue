<template>
  <div>
    <b-button
      @click="
        modals.create = true;
        errors = [];
      "
      variant="success">Create</b-button>

    <b-modal v-model="modals.create" title="Create working time">
      <b-container fluid>
        <b-col xl="12" md="12">
          <b-alert show variant="warning" v-if="errors.length">
            <strong>Fields error:</strong>
            <ul>
              <li v-for="error in errors" v-bind:key="error">{{ error }}</li>
            </ul>
          </b-alert>

          <form
            id="CreateWorkingTime"
            @submit="checkForm"
            v-on:submit.prevent="createWorkingTime"
          >
            <div class="form-group">
              <label for="name">Select user</label>
              <select class="form-control" v-model="selectedUser">
                <option
                  v-for="user in users"
                  v-bind:key="user.id"
                  v-bind:value="user.id"
                >
                  {{ user.username }}
                </option>
              </select>
            </div>
            <div class="form-group">
              <label for="name">Start Date</label>
              <input
                type="datetime-local"
                class="form-control"
                id="dateStart"
                placeholder="Date Start"
                v-model="form.start"
              />
            </div>
            <div class="form-group">
              <label for="name">End Date</label>
              <input
                type="datetime-local"
                class="form-control"
                id="dateEnd"
                placeholder="Date End"
                v-model="form.end"
              />
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
          @click="createWorkingTime"
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
import { createWorkingTimeForUser, checkValidDate } from "@/api/workingtime";


export default {
  name: "working-time-create",
  data() {
    return {
      modals: {
        create: false,
      },
      errors: [],
      selectedUser: "1",
      form: {
        idUser: "",
        start: null,
        end: null,
      },
      users: [],
    };
  },
  async mounted() {
    this.users = await getUsers();
  },
  methods: {
    submitForm(evt) {
      evt.preventDefault();
      document.getElementById("CreateWorkingTime").submit();
    },
    async checkForm() {
      let checker = true;
      this.errors = [];

      if (!this.form.start) {
        this.errors.push("Start date required.");
        checker = false;
      }
      if (!this.form.end) {
        this.errors.push("End date required.");
        checker = false;
      }

      if (checker && moment(this.form.end).isBefore(this.form.start)) {
        this.errors.push("End date cannot be before Start date.");
        checker = false;
      }

      if (!await checkValidDate(this.form)) {
        this.errors.push("Error, date as been already taken.");
        checker = false;
      }

      return checker;
    },
    async createWorkingTime() {

      this.form.idUser = this.selectedUser;

      if (!await this.checkForm()) {
        return false;
      }

      try {
        await createWorkingTimeForUser(
          this.selectedUser,
          this.form.start,
          this.form.end
        );
        this.$emit("event_child");
        this.modals.create = false;
        this.form.start = null;
        this.form.end = null;
      } catch (err) {
        this.errors.push("Working time create failed.");
      }
    },
  },
};
</script>
<style>
</style>