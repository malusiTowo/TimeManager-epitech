<template>
  <div>
    <!-- Header -->
    <base-header></base-header>
    <!-- Page content -->
    <!-- Select graph to show -->
    <b-container fluid class="mt--7">
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

      <b-card no-body>
      <b-row align-v="center" slot="header">
          <b-col cols="8" xl="12" md="12">
            <h1 class="mb-0">Chart Manager</h1>
          </b-col>
          <b-col cols="8" xl="12" md="12">
            <h2 class="mb-0">{{ menuLabel }}</h2>
          </b-col>
        </b-row>
      <b-row class="justify-content-center">
        <b-col lg="12" md="7">
          <b-card no-body class="border-0 mb-0">
            <b-card-body class="px-lg-5 py-lg-5">
              <!-- <div class="text-center text-muted mb-4">
                <small>{{ menuLabel }}</small>
              </div> -->
              <div v-if="isWorkingTimesSelected">
                <working-times :menuLabel="menuLabel"></working-times>
              </div>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
      </b-card>
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

<style>

.btn-outline-info {
    color: #0b8fa7;
    background-color: transparent;
    background-image: none;
    border-color: #0b8fa7;
}
.btn-outline-info:hover {
    color:  white;
    background-color: #0b8fa7;
    border-color: #0b8fa7;
}

</style>