<template>
  <div>
    <!-- Header -->
    <base-header></base-header>

    <!-- Teams -->
    <b-container fluid class="mt--9">
      <b-row>
        <b-col xl="12" md="12">
          <TeamList />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>

import { TeamList } from "@/components";

export default {
  components: {
    TeamList,
  },
  data() {
    return {
    };
  },
  methods: {},
  mounted() {},
};
</script>
<style>
</style>