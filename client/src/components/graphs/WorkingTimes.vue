<template>
  <b-row class="justify-content-center">
    <b-col lg="12" md="7">
      <b-card no-body class="border-0 mb-0">
        <b-card-body class="px-lg-5 py-lg-5">
          <div>
            <div>
              <label for="example-datepicker">Start date</label>
              <date-picker v-model="start" :config="optionsStart"></date-picker>
            </div>
            <div>
              <label for="example-datepicker">End date</label>
              <date-picker v-model="end" :config="optionsEnd"></date-picker>
            </div>
          </div>

          <div class="text-center">
            <b-button @click="getWorkingTimes" class="my-4" variant="outline-info"
              >Generate {{ menuLabel }} graph</b-button
            >
          </div>
          <bar-chart
            v-if="data.length > 0"
            id="bar"
            :data="data"
            xkey="start"
            ykeys='["hours"]'
            colors='[ "#36A2EB"]'
            grid="true"
            resize="true"
            grid-text-weight="bold"
          ></bar-chart>
          <hr />
          <div class="mt-7"></div>
          <line-chart
            v-if="data_.length > 0"
            id="area"
            :data="data_"
            xkey="month"
            ykeys='["timesHour","clocksHour"]'
            labels='[ "timesHour", "clocksHour" ]'
            line-colors='[ "#36A2EB","#FF6384"]'
          ></line-chart>
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
} from "../../api/workingtime";
import { getUserFromLocalStorage } from "../../api/user";

export default {
  name: "working-times",
  props: {
    menuLabel: String,
  },
  data() {
    return {
      start: "",
      end: "",
      optionsStart: {
        format: "YYYY-MM-DD HH:mm:ss",
        useCurrent: false,
        sideBySide: true,
      },
      optionsEnd: {
        format: "YYYY-MM-DD HH:mm:ss",
        useCurrent: false,
        sideBySide: true,
      },
      data: [],
      data_: [],
    };
  },
  methods: {
    formatDates(dates = []) {
      return dates.map((d) => {
        const hours = getDiffHours(d.start, d.end);
        return {
          ...d,
          start: moment(d.start).format('L'),
          hours: hours > 12 ? 12 : hours,
        };
      });
    },
    async getWorkingTimes() {
      try {
        const { start, end } = this;
        if (!start || !end) return alert("Please select start and end dates");

        const isEndBeforeStart = moment(end).isBefore(start);
        if (isEndBeforeStart)
          return alert("Please select an end date after the start date");

        const { userId } = getUserFromLocalStorage();
        const times = await getWorkingTimesBetweenDates(userId, start, end);
        const clocks = await getWorkingTimesBetweenDates(userId, start, end);
        const data = getTimesAndClocksForGraph([], times);
        this.data_ = data;
        console.log("data", this.data_);
        this.data = this.formatDates(times);
      } catch (err) {
        console.log("err", err);
      }
    },
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
