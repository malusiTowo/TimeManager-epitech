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
import {
  getWorkingTimesForUserIdAndWorkingId,
  updateWorkingTime,
} from "../../api/workingtime";

export default {
  name: "working-time-update",
  props: {
    idUser: Number,
    wtId: Number,
  },
  data() {
    return {
      modals: {
        update: false,
      },
      errors: [],
      form: {
        start: null,
        end: null,
      },
    };
  },
  mounted() {
    // axios
    //   .get(
    //     "http://localhost:4000/api/workingtimes/" +
    //       this.idUser +
    //       "/" +
    //       this.wtId
    //   )
    getWorkingTimesForUserIdAndWorkingId(this.idUser, this.wtId).then(
      (response) => (this.form = response)
    );
  },
  methods: {
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
    UpdateWorkingTime() {
      // this.form.start.format('YYYY-MM-DD hh:mm:ss');
      // this.form.end =  this.form.end.format('YYYY-MM-DD hh:mm:ss');

      if (!this.checkForm()) {
        return false;
      }

      let dateFormat = require("dateformat");
      let start = new Date(this.form.start);
      let end = new Date(this.form.end);

      start = dateFormat(start, "yyyy-mm-dd'T'HH:MM:ss");
      end = dateFormat(end, "yyyy-mm-dd'T'HH:MM:ss");

      // axios.put('http://localhost:4000/api/workingtimes/'+this.wtId, {
      //             "workingtimes" : {
      //                 "start": start,
      //                 "end": end
      //             }
      //         })
      updateWorkingTime(this.wtId, start, end)
        .then((res) => {
          this.modals.update = false;
        })
        .catch((error) => {
          // error.response.status Check status code
          this.errors.push("Working time update faild.");
          console.log(error);
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