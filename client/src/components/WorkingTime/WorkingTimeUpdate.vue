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

    <b-modal v-model="modals.update" title="Update working time">
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
          @click="modals.update = false"
        >
          Close
        </b-button>
        <b-button
          variant="success"
          class="float-right"
          @click="UpdateWorkingTime"
        >
          update
        </b-button>
      </template>
    </b-modal>
  </div>
</template>


<script>
import axios from "axios";
import moment from "moment";
import { getWorkingTimesForUserIdAndWorkingId, updateWorkingTime, checkValidDate, formatDateFromApi } from "@/api/workingtime";

export default {
  name: "working-time-update",
  props: {
    idUser: [Number, String],
    wtId: [Number, String],
  },
  data() {
    return {
      modals: {
        update: false,
      },
      errors: [],
      form: {
        id: null,
        start: null,
        end: null,
        idUser: null
      },
    };
  },
  async mounted() {
    let response = await getWorkingTimesForUserIdAndWorkingId(
      this.idUser,
      this.wtId
    );

    response.end = formatDateFromApi(response.end, 'YYYY-MM-DDTHH:mm:ss');
    response.start = formatDateFromApi(response.start, 'YYYY-MM-DDTHH:mm:ss');

    this.form = response;
  },
  methods: {
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

      if (checker && !await checkValidDate(this.form)) {
        this.errors.push("Error, date as already been taken.");
        checker = false;
      }

      return checker;
    },
    async UpdateWorkingTime() {

      this.form.idUser = this.idUser;

      if (!await this.checkForm()) {
        return false;
      }
      
      try {
        await updateWorkingTime(this.wtId, this.form.start, this.form.end);
        this.$emit("event_child");
        this.modals.update = false;
      } catch (err) {
        this.errors.push("Working time update faild.");
      }
    },
  },
};
</script>
<style>
</style>