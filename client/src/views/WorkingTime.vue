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

    <!--Working Time-->
    <b-container fluid class="mt--9">
      <b-row>
        <b-col xl="12" md="12">
          <h1>Working Times</h1>
        </b-col>
      </b-row>

      <b-row>
        <b-col xl="12" md="12">
          <WorkingTimeList />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import { WorkingTimeList } from "@/components";

export default {
  components: {
    WorkingTimeList,
  },
  data() {
    return {};
  },
  methods: {},
  mounted() {},
};
</script>
<style>
</style>







