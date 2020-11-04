<template>
  <div>
    <b-card no-body>
    <!-- Page content -->
    <!-- Select graph to show -->
      <b-row class="justify-content-center">
        <b-col lg="12" md="7">
          <div>
              <md-tabs>
                <md-tab
                id="tab-Clock"
                md-label="Clock"
                @click="isWorkingTimesSelected = false; isClockSelected = true; isOffSetSelected = false"
              ></md-tab>
                <md-tab
                id="tab-wt"
                md-label="Working Times"
                @click="isWorkingTimesSelected = true; isClockSelected = false; isOffSetSelected = false"
              ></md-tab>
                <md-tab
                id="tab-offset"
                md-label="Off-set"
                @click="isWorkingTimesSelected = false; isClockSelected = false; isOffSetSelected = true"
              ></md-tab>
              </md-tabs>
          </div>
        </b-col>
      </b-row>
      
      <b-row class="justify-content-center">
        <b-col lg="12" md="7">
          <b-card no-body class="border-0 mb-0">
            <b-card-body class="px-lg-5 py-lg-5">
              <!-- <div class="text-center text-muted mb-4">
                <small>{{ menuLabel }}</small>
              </div> -->
              <div v-if="isClockSelected">
                <clocks :menuLabel="menuLabel"></clocks>
              </div>
              <div v-if="isWorkingTimesSelected">
                <working-times :menuLabel="menuLabel"></working-times>
              </div>
              <div v-if="isOffSetSelected">
                <off-set :menuLabel="menuLabel"></off-set>
              </div>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
      </b-card>

  </div>
</template>
<script>
import { DonutChart } from "vue-morris";
import { getUserFromLocalStorage } from "../../api/user";
import { getWorkingTimesForUserIdAndWorkingId } from "../../api/workingtime";
import moment from "moment";
import workingTimes from "../../components/graphs/WorkingTimes";
import clocks from "../../components/graphs/Clocks";
import offSet from "../../components/graphs/OffSet";

export default {
  name: "chart-manager",
  data() {
    return {
      isWorkingTimesSelected: false,
      isClockSelected: true,
      isOffSetSelected: false
    };
  },
  methods: {
    async onSubmit() {},
  },
  computed: {
    menuLabel() {
      if(this.isWorkingTimesSelected)
      {
        return "Working Times";
      }
      else if(this.isClockSelected)
      {
        return "Clocks";
      }
      else (this.isOffSetSelected)
      {
        return "Off-set";
      }
    },
  },

  components: {
    DonutChart,
    workingTimes,
    clocks,
    offSet
  },
};
</script>
<style lang="scss">
.md-button-content {
  font-weight: bold;
}
.md-tabs-navigation {
 z-index: 0 !important;
}
</style>
