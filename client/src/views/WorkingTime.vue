<template>
  <div>
    <!-- Header -->
    <base-header></base-header>

    <!--Working Time-->
    <b-container fluid class="mt--9">
      <b-row>
        <b-col xl="12" md="12">
          <h1>Working Times</h1>
        </b-col>
      </b-row>

      <b-row>
        <b-col xl="12" md="12">
          <WorkingTimeList v-bind:userId="userId" />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import { WorkingTimeList } from "@/components";
import { getUserId } from "@/api/user";

export default {
  components: {
    WorkingTimeList,
  },
  data() {
    return {
      userId: this.$route.params.userId,
    };
  },
  methods: {},
  mounted() {},
};
</script>
<style>
</style>