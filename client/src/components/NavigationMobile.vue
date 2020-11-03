<template>
  <div>
    <!-- Icons to add -->
    <!-- <md-tab id="tab-posts" md-label="Clock" md-icon="/assets/icon-whatshot.svg"></md-tab> -->
    <md-tabs md-alignment="centered">
      <md-tab
        id="tab-home"
        md-label="Home"
        :to="{ path: '/dashboard' }"
      ></md-tab>

      <md-tab
        md-label="Working Time"
        md-icon=""

      ></md-tab>

      <!-- <md-tab
        md-label="Working Time"
        md-icon=""
        :to="{ name: 'workingtime', params: { userId: userId } }"
      ></md-tab> -->
      <md-tab
        md-label="Clock"
        md-icon=""
        :to="{ path: '/clock/:username' }"
      ></md-tab>

      <md-tab
        md-label="Profile"
        md-icon=""

      ></md-tab>

	  <!-- <md-tab
        md-label="Profile"
        md-icon=""
        :to="{ name: 'profile', params: { userId: userId } }"
      ></md-tab> -->
    </md-tabs>
  </div>
</template>

<script>
export default {
  name: "navigationmobile",
  props: {
    userId: null,
  },
};
</script>
<style lang="scss" scoped>
.md-tabs + .md-tabs {
  // margin-top: 24px;
  margin-top: 70px;
}
</style>
