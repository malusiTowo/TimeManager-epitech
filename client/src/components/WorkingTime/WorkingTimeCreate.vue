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
import { getUsers } from "../../api/user";
import { createWorkingTimeForUser } from "../../api/workingtime";

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
    // axios
    //   .get("http://localhost:4000/api/users")
    //   .then((response) => (this.users = response.data.data));
  },
  methods: {
    submitForm(evt) {
      evt.preventDefault();
      document.getElementById("CreateWorkingTime").submit();
    },
    checkForm() {
      if (this.form.start && this.form.end) {
        return true;
      }

      this.errors = [];

      if (!this.form.start) {
        this.errors.push("Start date required.");
      }
      if (!this.form.end) {
        this.errors.push("End date required.");
      }
      return false;
    },
    createWorkingTime() {
      if (!this.checkForm()) {
        return false;
      }

      let dateFormat = require("dateformat");
      let start = new Date(this.form.start);
      let end = new Date(this.form.end);

      start = dateFormat(start, "yyyy-mm-dd'T'HH:MM:ss");
      end = dateFormat(end, "yyyy-mm-dd'T'HH:MM:ss");

      //   axios
      //     .post("http://localhost:4000/api/workingtimes/" + this.selectedUser, {
      //       workingtime: {
      //         start: start,
      //         end: end,
      //       },
      //     })
      createWorkingTimeForUser(this.selectedUser, start, end)
        .then((res) => {
          //Perform Success Action
          //console.log("ok");

          this.modals.create = false;
        })
        .catch((error) => {
          // error.response.status Check status code
          console.log(error);
          this.errors.push("Working time creation faild.");
        })
        .finally(() => {
          //Perform action in always
        });
    },
  },
};
</script>
<style>
</style>