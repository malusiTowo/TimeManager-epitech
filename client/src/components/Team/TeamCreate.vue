<template>
  <div>
    <b-button
      @click="
        modals.create = true;
        errors = [];
      "
      >New Team</b-button
    >

    <b-modal v-model="modals.create" title="Create team">
      <b-container fluid>
        <b-col xl="12" md="12">
          <b-alert show variant="warning" v-if="errors.length">
            <strong>Fields error:</strong>
            <ul>
              <li v-for="error in errors" v-bind:key="error">{{ error }}</li>
            </ul>
          </b-alert>

          <form
            id="CreateNewTeamForm"
            @submit="checkForm"
            v-on:submit.prevent="CreateNewTeam"
          >
            <div class="form-group">
              <label for="name">Team Name</label>
              <input
                type="text"
                class="form-control"
                id="name"
                placeholder="Team Name"
                v-model="form.name"
              />
            </div>
            <div class="form-group">
              <label for="name">Description</label>
              <input
                type="text"
                class="form-control"
                id="description"
                placeholder="Team description ... "
                v-model="form.description"
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
          Create
        </b-button>
      </template>
    </b-modal>
  </div>
</template>

<script>

import { createTeam } from "@/api/team";

export default {
  name: "team-create",

  data() {
    return {
      modals: {
        create: false,
      },
      errors: [],
      form: {
        name: null,
        description: null,
      }
    };
  },

  methods: {

    submitForm(evt) {
      evt.preventDefault();
      document.getElementById("createNewTeamForm").submit();
    },
    
    async checkForm() {
      let checker = true;
      this.errors = [];

      if (!this.form.name) {
        this.errors.push("Name required.");
        checker = false;
      }
      if (!this.form.description) {
        this.errors.push("Description required.");
        checker = false;
      }

      return checker;
    },

    async createNewTeam() {
      this.form.idUser = this.userId;

      if (!(await this.checkForm())) {
        return false;
      }

      try {
        await createTeam(this.form.name, this.form.description);
        //console.log(this.selectedUser + " " + this.form.start + " " + this.form.end);
        this.$emit("event_child");
        this.modals.create = false;
        this.form.name = null;
        this.form.description = null;
      } catch (err) {
        this.errors.push("Team create failed.");
      }
    },
  },
};
</script>
<style>
</style>