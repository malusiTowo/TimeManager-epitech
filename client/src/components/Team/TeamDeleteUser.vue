<template>
  <div>
    <b-button
      @click="
        modals.delete = true;
        errors = [];
      "
      variant="danger"
      >Delete</b-button
    >

    <b-modal v-model="modals.delete" title="Delete Team">
      <b-alert show variant="danger" v-if="errors.length">
        <p v-for="error in errors" v-bind:key="error">
          <strong>{{ error }}</strong>
        </p>
      </b-alert>
      <b-container fluid>
        <b-col xl="12" md="12">
          <h3>Are you sure do you want to delete this User?</h3>
        </b-col>
      </b-container>  
      <template #modal-footer>
        <b-button
          variant="primary"
          class="float-right"
          @click="modals.delete = false"
        >
          Close
        </b-button>
        <b-button
          variant="danger"
          class="float-right"
          @click="DeleteTeamUser"
        >
          Delete
        </b-button>
      </template>
    </b-modal>
  </div>
</template>
<script>
import axios from "axios";
import Vue from "vue";
import { deleteTeamUser } from "@/api/team";

export default {
  name: "team-user-delete",

  props: {
    id: [Number, String],
  },

  data() {
    return {
      modals: {
        delete: false,
      },
      errors: [],
    };
  },
  methods: {
    async DeleteTeamUser() {
      this.errors = [];

      if (await deleteTeamUser(this.id)) {
        this.$emit("event_child");
        this.modals.delete = false;
      } else {
        this.errors.push("Team user not found.");
      }
    },
  },
};
</script>
<style>
</style>