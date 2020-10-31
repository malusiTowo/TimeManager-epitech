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
            <create-employee />
          </b-col>
          <b-col>
            <!-- <label>Search...</label> -->
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
                     variant="outline-warning"
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
                     :to="{ name: 'dashboard', params: { userId: user.id } }"
                     size="sm"
                     variant="outline-dark"
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

export default {
  data() {
    return {
      users: [],
      filters: {
        name: { value: "", keys: ["username", "email", "role"] },
      },
    };
  },
  async mounted() {
    this.users = await getUsers();
  },
  components: {
    CreateEmployee,
  },
};
</script>

<style>
</style>