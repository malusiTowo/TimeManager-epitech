<template>
  <div>
    <!-- Header -->
    <base-header></base-header>

    <b-container fluid class="mt--9">
      <b-row class="">
        <b-col lg="4" md="6">
          <Clock />
        </b-col>
      </b-row>
      <b-row class="">
        <b-col lg="12" md="6">
          <ChartManager />
        </b-col>
      </b-row>
    </b-container>


    <b-container fluid class="">
      
    </b-container>

  </div>
</template>
<script>
import Clock from "./Clock/Clock";
import clocks from "./../components/graphs/Clocks";
import ChartManager from "../views/Pages/ChartManager";

export default {
  components: {
    Clock,
    clocks,
    ChartManager
  },
};
</script>
<style>
</style>
