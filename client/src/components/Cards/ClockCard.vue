<template>
  <card class="card-stats" :show-footer-line="true">
    <b-row>

      <b-col>
        <slot>
          <h5 class="card-title text-uppercase text-muted mb-0" v-if="title">{{title}}</h5>
          <span class="h2 font-weight-bold mb-0" v-if="subTitle">{{subTitle}}</span>
        </slot>
      </b-col>

      <b-col cols="auto" v-if="$slots.icon || icon">
        <slot name="icon">

        <b-button @click="onclick" >
          <div class="icon icon-shape text-white rounded-circle shadow"
               :class="[`bg-${typeOff}`, iconClasses]">
            <i :class="icon"></i>
          </div>

        </b-button>
        </slot>
      </b-col>
    </b-row>

    <p class="mt-3 mb-0 text-sm">
      <slot name="footer">

      </slot>
    </p>
  </card>
</template>
<script>
  import Card from './Card.vue';

  export default {
    name: 'clock-card',
    components: {
      Card
    },
    props: {
      typeOff: {
        typeOff: String,
        default: 'primary'
      },
      icon: String,
      title: String,
      subTitle: String,
      iconClasses: [String, Array],
      onclick:Function
    }
  };
</script>
<style></style>
