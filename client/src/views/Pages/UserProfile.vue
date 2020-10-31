<template>
  <div>
    <!-- Header -->
    <div class="header bg-yellow py-7 py-lg-8 pt-lg-9">
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg
          x="0"
          y="0"
          viewBox="0 0 2560 100"
          preserveAspectRatio="none"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
        >
          <polygon
            class="fill-default"
            points="2560 0 2560 100 0 100"
          ></polygon>
        </svg>
      </div>
    </div>

    <!--User Info-->
    <b-container fluid class="mt--9">
      <b-row>
        <b-col xl="12" md="12">
          <h1> {{user.username}} </h1>
        </b-col>
      </b-row>

      <b-row>
        <b-col xl="12" md="12">
          <EditProfileForm v-bind:userId="userId" @user_emit="updateUser" />
        </b-col>
      </b-row>

      <b-row class ="mt-4" v-if="role">
        <b-col xl="12" md="12">
          <h1> Working Times </h1>
        </b-col>

        <b-col xl="12" md="12">
          <WorkingTimeList edit v-bind:userId="userId" />
        </b-col>
      </b-row> 

      <b-row class ="mt-4" >
        <b-col xl="12" md="12" v-if="role">
          <h1> Comming soon... { clock Times } </h1>
        </b-col>
      </b-row>  

    </b-container>

  </div>
</template>
<script>

  import EditProfileForm from "./UserProfile/EditProfileForm.vue";
  import {WorkingTimeList} from '@/components';
  import {getUsers, getUserFromLocalStorage, getUserById, getUserId} from '@/api/user';

  export default {
    components: { 
      EditProfileForm,
      WorkingTimeList
    },
    data() {
      return {
        userId : this.$route.params.userId,
        role : true,
        user: {
          username: null,
          id: null,
          email: null
        }
      };
    },
    methods: {
      updateUser(user) {
        this.user = user;
      }
    },
    async mounted() {
      this.user = await getUserById(this.userId);
    }
  };
</script>
<style>
</style>
