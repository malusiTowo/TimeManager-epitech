<template>
  <div>
    <!-- Header -->
    <base-header></base-header>

    <b-container fluid class="mt--7">
      <b-card no-body>
        <b-row align-v="center" slot="header">
          <b-col cols="8" xl="12" md="12">
            <h1 class="mb-0">Admin Users</h1>
          </b-col>
        </b-row>

        <b-row class="mt-3 mr-3 ml-3 mb-4">
          <b-col>
            <create-employee
              v-on:event_child="usersCallback"
              v-bind:isAdmin="isAdmin"
            />
          </b-col>
          <b-col>
            <input
              class="form-control"
              v-model="filters.name.value"
              placeholder="Search employee"
              aria-label="Search"
            />
            <!-- <i class="fas fa-search"></i> -->
          </b-col>
        </b-row>
        <b-row>
          <!-- <b-row class="mt-3 mr-3 mb-3 ml-3"> -->
          <b-col>
            <v-table class="table" :data="users" :filters="filters">
              <thead slot="head">
                <!-- <tr> -->
                <v-th sortKey="username" defaultSort="asc">Username</v-th>
                <!-- <v-th sortKey="firstname">Firstname</v-th>
                <v-th sortKey="lastname">Lastname</v-th> -->
                <v-th sortKey="email">Email</v-th>
                <v-th sortKey="role">Role</v-th>
                <th></th>
                <th></th>
                <!-- </tr> -->
              </thead>
              <!-- displayData is a copy of the users array pass in v-table :data -->
              <tbody slot="body" slot-scope="{ displayData }">
                <tr v-for="user in displayData" v-bind:key="user.id">
                  <td>{{ user.username }}</td>
                  <!-- <td>{{ user.firstname }}</td>
									<td>{{ user.lastname }}</td> -->
                  <td>{{ user.email }}</td>
                  <td>{{ user.role }}</td>
                  <td>
                    <b-button
                     :to="{ name: 'profile', params: { userId: user.id } }"
                     size="sm"
                     icon
                    >
                      <span class="btn-inner--icon"
                        ><i class="ni ni-single-02"></i
                      ></span>
                      <span class="btn-inner--text">See infos</span>
                    </b-button>
                  </td>
                  <td>
                    <b-button
                     :to="{ name: 'userDashboard', params: { userId: user.id } }"
                     size="sm"
                     icon
                    >
                      <span class="btn-inner--icon"
                        ><i class="ni ni-chart-bar-32"></i
                      ></span>
                      <span class="btn-inner--text">See graphs</span>
                    </b-button>
                  </td>
                </tr>
              </tbody>
            </v-table>
          </b-col>
        </b-row>
      </b-card>
    </b-container>
  </div>
</template>

<script>
import CreateEmployee from "@/components/Admin/CreateEmployee";
import { getUsers } from "@/api/user";
import { getUserFromLocalStorage } from "@/api/user";

export default {
  data() {
    return {
      users: [],
      filters: {
        name: { value: "", keys: ["username", "email", "role"] },
      },
      isAdmin: null
    };
  },
  methods: {
    getEmployee: async function () {
      return this.users = await getUsers();
    },
    usersCallback: function () {
      this.getEmployee();
    },
    isItAdmin: async function () {
      const roleGet = await getUserFromLocalStorage().user.role;
      if (roleGet === "admin" ) {
        return this.isAdmin = true;
      }
    },
  },
  async mounted() {
    await this.getEmployee();

    await this.isItAdmin();
  },
  components: {
    CreateEmployee,
  },
};
</script>

<style>
</style>