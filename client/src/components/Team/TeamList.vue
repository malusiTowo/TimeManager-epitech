<template>
  <b-card no-body>
    <b-row align-v="center" slot="header">
      <b-col cols="8" xl="12" md="12">
        <h1 class="mb-0" v-if="!userId">Teams List</h1>
        <h1 class="mb-0" v-if="userId">User Teams</h1>
      </b-col>
    </b-row>

    <!-- create Team + filters-->
    <b-row class="mt-3 mr-3 ml-3 mb-4">
      <b-col v-if="!userId">
        <TeamCreate v-on:event_child="TeamCallback" />
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
          <v-th sortKey="name" defaultSort="desc">Team name</v-th>
          <th>Description</th>
          <th v-if="!userId">Actions</th>
          <th v-if="!userId"></th>
        </tr>
      </thead>
      <tbody slot="body" slot-scope="{ displayData }">
        <tr v-for="item in displayData" v-bind:key="item.id">
          <td>{{ item.name }}</td>
          <td>{{ item.description }}</td>
          <td v-if="!userId">
            <b-button
              :to="{ name: 'Team', params: { teamId: item.id } }"
              size="sm"
              icon
              variant="outline-primary"
            >
              <span class="btn-inner--text">See infos</span>
            </b-button>
          </td>
          <td v-if="!userId">
            <TeamDelete :teamId="item.id" v-on:event_child="TeamCallback" />
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

import { TeamCreate, TeamUpdate, TeamDelete } from "./";
import axios from "axios";

import { getTeams, getUserTeams } from "@/api/team";

import SmartTable from "vuejs-smart-table";

export default {
  name: "team-list",
  components: {
    SmartTable,
    TeamCreate,
    TeamUpdate,
    TeamDelete
  },

  props: {
    userId: {
      type: [String, Number],
      default: null,
    },
  },

  data() {
    return {
      filters: {
          name: { value: "", keys: ["name", "description"] },
      },
      items: [],
      pageSize: 10,
      currentPage: 1,
      totalPages: 0,
    };
  },

  methods: {
    refreshTeams: async function () {

      const teams = await getTeams();
      
      if(this.userId)
      {
        const tempItems = await getUserTeams(this.userId);
        this.items = [];

        for(let item in tempItems){
            for(let team of teams){
                if(team.id == tempItems[item].team){
                    this.items.push(team);
                }
            }
        }
      }
      else{
        this.items = teams;
      }


    },

    TeamCallback: function () {
      this.refreshTeams();
    },

  },

  async mounted() {
    await this.refreshTeams();
  },

  watch: {

  },
};
</script>
<style>
</style>


