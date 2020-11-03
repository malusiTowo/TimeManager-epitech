<template>
  <b-card no-body>
    <b-row align-v="center" slot="header">
      <b-col cols="8" xl="12" md="12">
        <h1 class="mb-0">Members</h1>
      </b-col>
    </b-row>

    <!-- create Team User + filters-->
    <b-row class="mt-3 mr-3 ml-3 mb-4">
      <b-col>
        <TeamAddUser v-bind:teamId="teamId" v-on:event_child="TeamUsersCallback" />
      </b-col>
      <b-col>
        <input
          class="form-control"
          v-model="filters.name.value"
          placeholder="Search Team"
          aria-label="Search"
        />
        <!-- <i class="fas fa-search"></i> -->
      </b-col>
    </b-row>
    <!-- table -->
    <v-table
      :data="items"
      :currentPage.sync="currentPage"
      :pageSize="7"
      @totalPagesChanged="totalPages = $event"
      :filters="filters"
      class="table"
    >
      <thead slot="head">
        <tr>
            <v-th sortKey="username" defaultSort="asc">Username</v-th>
            <v-th sortKey="email">Email</v-th>
            <v-th sortKey="role">Team Role</v-th>
            <th></th>
        </tr>
      </thead>
      <tbody slot="body" slot-scope="{ displayData }">
        <tr v-for="item in displayData" v-bind:key="item.id">
          <td>{{ item.user.username }}</td>
          <td>{{ item.user.email }}</td>
          
          <td>{{ item.role }}</td>
          <td>
            <TeamUserUpdate
                v-bind:id="item.id" 
                v-bind:username="item.user.username" 
                v-bind:email="item.user.email" 
                v-bind:role="item.role"
                v-on:event_child="TeamUsersCallback" />
          <td>
            <TeamDeleteUser v-bind:id="item.id" v-on:event_child="TeamUsersCallback" />
          </td>
        </tr>
      </tbody>
    </v-table>

    <smart-pagination
      :currentPage.sync="currentPage"
      :totalPages="totalPages"
    />
  </b-card>
</template>

<script>
import moment from "moment";

//import { TeamCreate, TeamUpdate, TeamDelete } from "./";
import axios from "axios";

import { getTeamUsers } from "@/api/team";
import { getUsers } from "@/api/user";

import TeamAddUser from "./TeamAddUser";
import TeamDeleteUser from "./TeamDeleteUser";
import TeamUserUpdate from "./TeamUserUpdate";

import SmartTable from "vuejs-smart-table";

export default {
  name: "team-list",
  components: {
    SmartTable,
    TeamAddUser,
    TeamDeleteUser,
    TeamUserUpdate
  },

  props: {
    teamId: [Number, String],
  },

  data() {
    return {
      filters: {
          name: { value: "", keys: ["role", "user.username","user.email"] },
      },
      items: [],
      pageSize: 10,
      currentPage: 1,
      totalPages: 0,
      users: [],
    };
  },

  methods: {
    refresh: async function () {

        this.items = await getTeamUsers(this.teamId);

        for(let item in this.items){
            for(let user of this.users){
                if(user.id == this.items[item].user){
                    this.items[item].user = user;
                }
            }
        }

    },

    TeamUsersCallback: function () {
      this.refresh();
    },

  },
  async mounted(){
    this.users = await getUsers();
    await this.refresh();
  },

  watch: {

  },
};
</script>
<style>
</style>


