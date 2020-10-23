<template>
  <div>
    <b-container fluid class="mt--6">
      <b-row>
        <b-col xl="8" class="order-xl-1 mt-7">
          <edit-profile-form></edit-profile-form>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import EditProfileForm from "./UserProfile/EditProfileForm.vue";
import UserCard from "./UserProfile/UserCard.vue";

export default {
  components: {
    EditProfileForm,
    UserCard,
  },
};
</script>
<style>
</style>
