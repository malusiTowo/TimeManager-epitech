<template>
  <!-- <a href="/img/user-placeholder.jpeg" download="timemanager.apk">Download</a> -->
  <!-- <a :href="link" download="download">PDF</a> -->
  <div></div>
</template>

<script>
export default {
  data() {
    return {
      // link: require("/img/user-placeholder.jpeg"),
    };
  },
  mounted() {
    const link = document.createElement("a");
    link.href = "app-debug.apk";
    link.setAttribute("download", "mobile.apk");
    link.click();
  },
};
</script>

<style>
</style>