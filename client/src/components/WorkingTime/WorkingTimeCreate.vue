<template>
  <div>
    <b-button
      @click="
        modals.create = true;
        errors = [];
      "
     variant="outline-info"
      >Create</b-button
    >

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
  props: {
    userId: {
      type: [String, Number],
    },
  },

  data() {
    return {
      modals: {
        create: false,
      },
      errors: [],
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

      if (checker && !(await checkValidDate(this.form))) {
        this.errors.push("Error, date as already been taken.");
        checker = false;
      }

      if (!(await checkValidDate(this.form))) {
        this.errors.push("Error, date as been already taken.");
        checker = false;
      }

      return checker;
    },
    async createWorkingTime() {
      this.form.idUser = this.userId;

      if (!(await this.checkForm())) {
        return false;
      }

      try {
        await createWorkingTimeForUser(
          this.form.idUser,
          this.form.start,
          this.form.end
        );
        console.log(
          this.selectedUser + " " + this.form.start + " " + this.form.end
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
.btn-outline-info {
    color: #0b8fa7;
    background-color: transparent;
    background-image: none;
    border-color: #0b8fa7;
}
.btn-outline-info:hover {
    color:  white;
    background-color: #0b8fa7;
    border-color: #0b8fa7;
}
</style>