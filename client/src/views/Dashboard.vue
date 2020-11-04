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
      <b-row class="">
        <b-col lg="4" md="6">
          <h1> idUser:{{userId}} </h1>
        </b-col>
      </b-row>
    </b-container>

  </div>
</template>
<script>
import Clock from "./Clock/Clock";
import ChartManager from "../views/Pages/ChartManager";
import { getUserFromLocalStorage } from "@/api/user";

export default {
  components: {
    Clock,
    ChartManager
  },

  data() {
    return {
      userId: this.getUserId(),
    };
  },
  methods: {
    getUserId() {
      if(this.$route.params.userId){
        return this.$route.params.userId;
      }
      return getUserFromLocalStorage().userId;
    }
  },
  mounted() {
  },
  watch: {
    "$route.params.userId": async function (id) {
      location.reload();
    }
  },
};
</script>
<style>
</style>
