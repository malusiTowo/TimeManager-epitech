<template>
  <div>
    <b-button
      @click="
        modals.update = true;
        errors = [];
      "
      variant="primary"
      >Update</b-button
    >

    <b-modal v-model="modals.update" title="Update Team User">
      <b-container fluid>
        <b-col xl="12" md="12">
          <b-alert show variant="warning" v-if="errors.length">
            <strong>Fields error:</strong>
            <ul>
              <li v-for="error in errors" v-bind:key="error">{{ error }}</li>
            </ul>
          </b-alert>

          <form>
            <div class="form-group">
                
                <h4>{{this.username}}</h4>
                <h4>{{this.email}}</h4>

                <base-input
                type="text"
                label="Team Role"
                placeholder="..."
                v-model="form.role"
                >
                </base-input>
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
          @click="UpdateTeamUser"
        >
          Update User
        </b-button>
      </template>
    </b-modal>
  </div>
</template>







<script>

import { getTeamById, updateTeamUser } from "@/api/team";

export default {
  name: "team-update",

  props: {
    id: [Number, String],
    username: [String],
    email: [String],
    role: [String]
  },

  data() {
    return {
      modals: {
        update: false,
      },
      errors: [],
      form: {
        id: this.id,
        role: this.role
      }
    };
  },

  async mounted(){
  },

  methods: {

    async checkForm() {
      let checker = true;
      this.errors = [];

      if (!this.form.role) {
        this.errors.push("Team role required.");
        checker = false;
      }

      return checker;
    },

    async UpdateTeamUser() {
          
      if (!(await this.checkForm())) {
        return false;
      }

      try {
        await updateTeamUser(this.form);
        this.modals.update = false;
        this.$emit("event_child");
    
      } catch (err) {
        this.errors.push("User update failed.");
      }
    },
  },
};
</script>
<style>
</style>