<template>
  <footer class="footer px-4">
    <!-- <b-row align-v="center" class="justify-content-lg-between">
      <b-col lg="6">
        <div class="copyright text-center text-lg-left text-muted">
          © {{year}} <a href="#" class="font-weight-bold ml-1">Time Manager</a>
        </div>
      </b-col>
    </b-row> -->
  </footer>
</template>
<script>
export default {
  data() {
    return {
      year: new Date().getFullYear(),
    };
  },
};
</script>
<style></style>
