<template>
  <div>
    <!-- Header -->
    <div class="header bg-yellow py-7 py-lg-8 pt-lg-9">
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg
          x="0"
          y="0"
          viewBox="0 0 2560 100"
          preserveAspectRatio="none"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
        >
          <polygon
            class="fill-default"
            points="2560 0 2560 100 0 100"
          ></polygon>
        </svg>
      </div>
    </div>
    <!-- Page content -->
    <b-container class="mt--8 pb-5">
      <b-row class="justify-content-center">
        <b-col lg="12" md="7">
          <div>
            <b-button-group>
              <b-dropdown right :text="menuLabel">
                <b-dropdown-item @click="isWorkingTimesSelected = false"
                  >Clock</b-dropdown-item
                >
                <b-dropdown-item @click="isWorkingTimesSelected = true"
                  >Working times</b-dropdown-item
                >
              </b-dropdown>
            </b-button-group>
          </div>
        </b-col>
      </b-row>
      <b-row class="justify-content-center">
        <b-col lg="12" md="7">
          <b-card no-body class="border-0 mb-0">
            <b-card-body class="px-lg-5 py-lg-5">
              <div class="text-center text-muted mb-4">
                <small>{{ menuLabel }}</small>
              </div>

              <div v-if="isWorkingTimesSelected">
                <working-times :menuLabel="menuLabel"></working-times>
              </div>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import { DonutChart } from "vue-morris";
import { getUserFromLocalStorage } from "../../api/user";
import { getWorkingTimesForUserIdAndWorkingId } from "../../api/workingtime";
import moment from "moment";
import workingTimes from "../../components/graphs/WorkingTimes";

export default {
  data() {
    return {
      isWorkingTimesSelected: true,
    };
  },
  methods: {
    async onSubmit() {},
  },
  computed: {
    menuLabel() {
      return this.isWorkingTimesSelected ? "Working Times" : "Clocks";
    },
  },

  components: {
    DonutChart,

    workingTimes,
  },
};
</script>
