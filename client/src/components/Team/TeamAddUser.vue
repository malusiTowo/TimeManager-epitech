<template>
  <div>
    <b-button
      @click="
        modals.create = true;
        errors = [];
      "
      variant="outline-info"
      >Add User</b-button
    >

    <b-modal v-model="modals.create" title="Add user">
      <b-container fluid>
        <b-col xl="12" md="12">
          <b-alert show variant="warning" v-if="errors.length">
            <strong>Fields error:</strong>
            <ul>
              <li v-for="error in errors" v-bind:key="error">{{ error }}</li>
            </ul>
          </b-alert>

          <form
            id="AddNewTeamUser"
            @submit="checkForm"
            v-on:submit.prevent="AddNewTeamUser"
          >
            <div class="form-group">
              <label for="name">User</label>
                <base-input>
                    <b-form-select
                    class="form-control"
                    v-model="form.user"
                    :options="users"
                    prepend-icon="ni ni-key-25"
                    >
                    </b-form-select>
                </base-input>
            </div>

            <div class="form-group">
              <label for="name">Team function</label>
              <input
                type="text"
                class="form-control"
                id="description"
                placeholder="ex: developper ... "
                v-model="form.role"
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
          @click="createNewTeam"
        >
          Add
        </b-button>
      </template>
    </b-modal>
  </div>
</template>

<script>

import { addTeamUser } from "@/api/team";
import { getUsers } from "@/api/user";

export default {
  name: "team-member-add",

  props: {
    teamId: [Number, String]
  },
  
  data() {
    return {
      modals: {
        create: false,
      },
      errors: [],
      form: {
        team: null,
        user: null,
        role: null,
      },
      users: [
        { value: null, text: "Please select a User", disabled: true }
      ]
    };
  },

  async mounted(){

    const userList = await getUsers();

    for (let user of userList) {
        this.users.push({
            value: user.id,
            text: user.username
        });
    }

  },

  methods: {
    
    async checkForm() {
      let checker = true;
      this.errors = [];
      
      if (!this.form.team) {
        this.errors.push("Team required.");
        checker = false;
      }

      if (!this.form.user) {
        this.errors.push("User required.");
        checker = false;
      }
      if (!this.form.role) {
        this.errors.push("role required.");
        checker = false;
      }

      return checker;
    },

    async createNewTeam() {

      this.form.team = this.teamId;

      if (!(await this.checkForm())) {
        return false;
      }

      try {
        await addTeamUser(this.form);
       
        this.$emit("event_child");
        this.modals.create = false;
        this.form.role = null;
      } catch (err) {
        this.errors.push("Team create failed.");
      }
    },
  },
};
</script>
<style>
</style>