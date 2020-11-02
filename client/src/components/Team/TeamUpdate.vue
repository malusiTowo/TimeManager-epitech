<template>
  <div>
    <b-button
      @click="
        modals.update = true;
        errors = [];
      "
      variant="success"
      >Update</b-button
    >

    <b-modal v-model="modals.update" title="Update team">
      <b-container fluid>
        <b-col xl="12" md="12">
          <b-alert show variant="warning" v-if="errors.length">
            <strong>Fields error:</strong>
            <ul>
              <li v-for="error in errors" v-bind:key="error">{{ error }}</li>
            </ul>
          </b-alert>

          <form
            id="UpdateNewTeamForm"
            @submit="checkForm"
            v-on:submit.prevent="UpdateNewTeam"
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
          @click="modals.update = false"
        >
          Close
        </b-button>
        <b-button
          variant="success"
          class="float-right"
          @click="updateNewTeam"
        >
          Update
        </b-button>
      </template>
    </b-modal>
  </div>
</template>

<script>

import { updateTeam, getTeamById } from "@/api/team";

export default {
  name: "team-update",

  props: {
    teamId: [Number, String]
  },

  data() {
    return {
      modals: {
        update: false,
      },
      errors: [],
      form: {
        name: null,
        description: null,
      }
    };
  },
  async mounted(){
    this.form = await getTeamById(this.teamId);
  },

  methods: {

    submitForm(evt) {
      evt.preventDefault();
      document.getElementById("updateNewTeamForm").submit();
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

    async updateNewTeam() {
      this.form.idUser = this.userId;

      if (!(await this.checkForm())) {
        return false;
      }

      try {
        await updateTeam(this.form.name, this.form.description);
        this.$emit("event_child");
        this.modals.update = false;
      } catch (err) {
        this.errors.push("Team update failed.");
      }
    },
  },
};
</script>
<style>
</style>