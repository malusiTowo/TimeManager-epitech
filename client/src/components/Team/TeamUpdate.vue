<template>
  <card>
    <b-row align-v="center" slot="header">
      <b-col cols="8">
        <h1 class="mb-0">Edit Team</h1>
      </b-col>
    </b-row>
    <b-form @submit.prevent="updateNewTeam">
      <h6 class="heading-small text-muted mb-4">Team information</h6>

      <div class="pl-lg-4">
        <b-row>
          <b-col lg="6">
            <base-input
              type="text"
              label="Team Name"
              placeholder="Team Name"
              v-model="form.name"
            >
            </base-input>
          </b-col>
          <b-col lg="6">
            <base-input
              type="text"
              label="Description"
              placeholder="..."
              v-model="form.description"
            >
            </base-input>
          </b-col>
        </b-row>
        <b-row>
          <b-col lg="6">
            <base-button type="primary" native-type="submit" class="my-4">
              Update profile
            </base-button>
          </b-col>
        </b-row>
      </div>
    </b-form>
  </card>
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
          
      console.log('oui');

      if (!(await this.checkForm())) {
        return false;
      }

      try {
        await updateTeam(this.form);
        this.$emit("event_child");
    
      } catch (err) {
        this.errors.push("Team update failed.");
      }
    },
  },
};
</script>
<style>
</style>