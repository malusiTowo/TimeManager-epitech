<template>
  <b-row class="justify-content-center">
    <b-col lg="12" md="7">
      <b-card no-body class="border-0 mb-0">
        <b-card-body class="px-lg-5 py-lg-5">
          <template>
            <div>
              <div>
                <label for="example-datepicker">Start date</label>
                <date-picker
                  v-model="start"
                  :config="optionsStart"
                ></date-picker>
              </div>
              <div>
                <label for="example-datepicker">End date</label>
                <date-picker
                  v-model="end"
                  :config="optionsEnd"
                ></date-picker>
              </div>
            </div>

            <div class="text-center">
              <b-button @click="getClocks" class="my-4" variant="outline-info"
                >Generate {{ menuLabel }} graph</b-button
              >
            </div>
          </template>

          <bar-chart
            v-if="data.length > 0"
            id="bar"
            :data="data"
            xkey="date"
            ykeys='["hours"]'
            colors='[ "#FF6384"]'
            grid="true"
            resize="true"
            grid-text-weight="bold"
          ></bar-chart>
        </b-card-body>
      </b-card>
    </b-col>
  </b-row>
</template>
<script>
import { BarChart, LineChart } from "vue-morris";
import datePicker from "vue-bootstrap-datetimepicker";
import moment from "moment";
// Import date picker css
import "pc-bootstrap4-datetimepicker/build/css/bootstrap-datetimepicker.css";
import {
  getWorkingTimesBetweenDates,
  getDiffHours,
  formatDate,
  getTimesAndClocksForGraph,
  formatDateFromApi,
  formatDateForApi
} from "../../api/workingtime";
import { getClocksBetweenDates } from "../../api/clock";
import { getUserFromLocalStorage } from "../../api/user";

export default {
  name: "clocks",
  props: {
    menuLabel: String,
  },
  data() {
    return {
      start: "",
      end: "",
      hours: null,
      date: "",
      optionsStart: {
        format: "YYYY-MM-DD HH:mm:ss",
        useCurrent: false,
        sideBySide: true,
        // defaultViewDate: this.firstDayOfWeek
      },
      optionsEnd: {
        format: "YYYY-MM-DD HH:mm:ss",
        useCurrent: false,
        sideBySide: true,
        // defaultViewDate: this.lastDayOfWeek
      },
      data: [],
      data_: [],
    };
  },
  methods: {
    formatDates(dates = []) {
      let { begin, finish } = this;
      return dates.map((d) => {
        if (d.status === true) {
          begin = d.time;
        }
        if (d.status === false) {
          finish = d.time;
        }
        if (begin != null && finish != null) {
          let dataClock = {};
          this.date = formatDateFromApi(begin, "YYYY-MM-DD");
          this.hours = getDiffHours(begin, finish);

          dataClock = { date: this.date, hours: this.hours };
          this.data.push(dataClock);
          begin = null;
          finish = null;
        }
      });
    },
    async getClocks() {
      try {
        let { start, end } = this;
        if (!start && !end) {
          let today = moment();
          start = moment().startOf("week").format("YYYY-MM-DDTHH:mm:ss");
          end = moment().endOf("week").format("YYYY-MM-DDTHH:mm:ss");
        }
        if (!start || !end) return alert("Please start and end dates");

        const isEndBeforeStart = moment(end).isBefore(start);
        if (isEndBeforeStart)
          return alert("Please select an end date after the start date");

        const { userId } = getUserFromLocalStorage();
        const clocks = await getClocksBetweenDates(userId, start, end);
        this.data = [];
        this.formatDates(clocks);
      } catch (err) {
        console.log("err", err);
      }
    },
  },
  mounted() {
    this.getClocks();
  },
  components: {
    datePicker,
    BarChart,
    LineChart,
  },
};
</script>
<style>
</style>
