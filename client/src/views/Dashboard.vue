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
    </b-container>


    <!-- <b-container fluid class="">
      <b-row class="">
        <b-col lg="4" md="6"> -->
     
        <!-- </b-col>
      </b-row>
    </b-container> -->

  </div>
</template>
<script>
import Clock from "./Clock/Clock";
import clocks from "./../components/graphs/Clocks";

export default {
  components: {
    Clock,
    clocks
  },
};
</script>
<style>
</style>
