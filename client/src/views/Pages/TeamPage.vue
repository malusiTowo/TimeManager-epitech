<template>
  <div>
    <!-- Header -->
    <base-header></base-header>

    <!--User Info-->
    <b-container fluid class="mt--9">
        <b-row>
            <b-col xl="12" md="12">
                <TeamUpdate v-bind:teamId="teamId"/>
            </b-col>
        </b-row>
    </b-container>

    <b-container fluid class="mt-4">
        <b-row>
            <b-col xl="12" md="12">
                <TeamUsersList v-bind:teamId="teamId"/>
            </b-col>
        </b-row>
    </b-container>
  </div>
</template>
<script>

import { TeamUpdate, TeamUsersList } from "@/components/Team";

export default {
  components: {
    TeamUpdate, 
    TeamUsersList
  },
  data() {
    return {
      teamId: this.$route.params.teamId
    };
  },
  methods: {

  },
  async mounted() {

  },
  mounted() {
      
  }
};
</script>
<style>
</style>

