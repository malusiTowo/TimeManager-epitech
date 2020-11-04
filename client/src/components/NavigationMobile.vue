<template>
  <div id="navbarMobile">
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
        :to="{ path: '/workingtime/' + userId }"
      >
      </md-tab>

      <md-tab
        md-label="Clock"
        md-icon=""
        :to="{ path: '/clock/' + username }"
      ></md-tab>

    </md-tabs>
  </div>
</template>

<script>
export default {
  name: "navigationmobile",
  props: {
    userId: null,
    username: null
  },
  
};

</script>
<style>
/* .md-tabs + .md-tabs {
  margin-top: 24px;
} */
#navbarMobile {
  position: fixed;
  left: 0;
  bottom: 0;
  z-index: 1 !important;
  width: 100%;
  color: black;
  text-align: center;
}
.md-tabs-navigation {
  background-color: #ffd600 !important;
  z-index: 1 !important ;
}
.mb48 {
  margin-bottom: 48px;
}
</style>
