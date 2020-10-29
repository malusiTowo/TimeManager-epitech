<template>
  <div>
    <b-button @click="modalShow = !modalShow">Create Employee</b-button>

    <b-modal class="text-center" v-model="modalShow" title="Create Employee">
      <template>
        <div class="text-center mb-4">
          <p>Please fill all the information below to create a new employee</p>
        </div>
        <b-form role="form">
          <!-- Rajouter les controles -->
          <base-input
            alternative
            type="text"
            placeholder="Firstname"
            prepend-icon="ni ni-badge"
          >
          </base-input>
          <base-input
            alternative
            type="text"
            placeholder="Lastname"
            prepend-icon="ni ni-badge"
          >
          </base-input>
          <base-input
            alternative
            class="mb-3"
            placeholder="Email"
            prepend-icon="ni ni-email-83"
          >
          </base-input>
          <!-- <base-input alternative
                                    
                                    type="password"
                                    placeholder="Password"
                                    prepend-icon="ni ni-lock-circle-open">
                        </base-input> -->
        </b-form>
      </template>
    </b-modal>
  </div>
</template>

<script>
export default {
  name: "create-employee",
  data() {
    return {
      modalShow: false,
    };
  },
};
</script>

<style>
</style>