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

    <b-container fluid class="">
      <b-row class="">
        <b-col lg="4" md="6">
          <h1> {{debug}} </h1>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import Clock from "./Clock/Clock";

export default {
  components: {
    Clock,
  },
  data() {
    return {
      debug : ""
    };
  },
  methods: {},
  mounted() {
  },
};
</script>
<style>
</style>
