<template>
  <div>
    <b-button
      @click="
        modals.delete = true;
        errors = [];
      "
      size="sm"
      variant="outline-warning"
      >Delete</b-button
    >

    <b-modal v-model="modals.delete" title="Delete working time">
      <b-alert show variant="danger" v-if="errors.length">
        <p v-for="error in errors" v-bind:key="error">
          <strong>{{ error }}</strong>
        </p>
      </b-alert>
      <b-container fluid>
        <b-col xl="12" md="12">
          <h3>Are you sure do you want to delete this working time?</h3>
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
          @click="DeleteWorkingTime"
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
import { deleteWorkingTime } from "../../api/workingtime";

export default {
  name: "working-time-delete",
  props: {
    wtId: [Number, String],
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
    async DeleteWorkingTime() {
      this.errors = [];

      if (await deleteWorkingTime(this.wtId)) {
        this.$emit("event_child");
        this.modals.delete = false;
      } else {
        this.errors.push("Working time not found.");
      }
    },
  },
};
</script>
<style>
</style>