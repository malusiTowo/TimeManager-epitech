<template>
  <button
    class="navbar-toggler text-yellow"
    type="button"
    data-toggle="collapse"
    :data-target="target"
    :aria-controls="target"
    :aria-expanded="toggled"
    aria-label="Toggle navigation"
  >
    <!-- <span class="navbar-toggler-icon"></span> -->
    <span class="fas fa-bars"></span>
    <slot>
      <span></span>
    </slot>
  </button>
</template>
<script>
export default {
  props: {
    target: {
      type: [String, Number],
      description: 'Button target element'
    },
    toggled: {
      type: Boolean,
      default: false,
      description: 'Whether button is toggled'
    }
  }
};
</script>
<style></style>
