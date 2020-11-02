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
          <h1> {{infos}} </h1>
          <h1> {{infos2}} </h1>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import Clock from "./Clock/Clock";
import { isMobile ,LocalStorageData , setLocalStorageData} from "@/api/mobile";

export default {
  components: {
    Clock,
  },
  data() {
    return {
      infos : "",
      infos2 : ""
    };
  },
  methods: {},
  mounted() {
    setLocalStorageData();
    console.log(LocalStorageData());
    this.infos = isMobile();
  },
};
</script>
<style>
</style>
