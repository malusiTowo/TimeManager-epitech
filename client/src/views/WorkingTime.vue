<template>
  <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
    </base-header>

    <b-container fluid class="mt--7">
      
    <b-card no-body>
        <b-row class="mt-3 mr-3 mb-3 ml-3 float-right" > 
          <working-time-create v-on:event_child="workingTimeCallback" />
        </b-row>
        
        <b-row class="mt-3 mr-3 mb-3 ml-3 float-right" > 
          <select class="form-control" v-model="selectedUser">
              <option v-for="user in users" v-bind:key = user.id v-bind:value ="user.id">
                  {{ user.username }}
              </option>
          </select>
        </b-row>

        <b-row class="mt-3 mr-3 mb-3 ml-3">
          <b-col> 
              
              <table class="table">
                <thead>
                  <tr>
                    <th>id</th>
                    <th>start time</th>
                    <th>end time</th>
                    <th></th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in items" v-bind:key = item.id>
                    <td>{{item.id}}</td>
                    <td>{{formatDate(item.start)}}</td>
                    <td>{{formatDate(item.end)}}</td>
                    <td>
                      <working-time-update  :idUser="selectedUser" :wtId ="item.id" v-on:event_child="workingTimeCallback" />
                    </td>
                    <td>
                      <working-time-delete :wtId ="item.id" v-on:event_child="workingTimeCallback" />
                    </td>
                  </tr>
                </tbody>
              </table>
          </b-col>
        </b-row>
      </b-card>
    </b-container>

  </div>
</template>

<script>
  import { Dropdown, DropdownItem, DropdownMenu, Table, TableColumn } from 'element-ui';

  import moment from 'moment';
  //import LightTable from "./Tables/RegularTables/LightTable";
  //import DarkTable from "./Tables/RegularTables/DarkTable";
  //import WorkingTime from "./WorkingTime"

  import { WorkingTimeCreate, WorkingTimeUpdate, WorkingTimeDelete } from '@/components';
  import axios from 'axios';

  import { getWorkingTimesBetweenDates } from '@/api/workingtime';
  import { getUsers } from '@/api/user';

  export default {
    components: {
      //LightTable,
      //DarkTable,
      [Dropdown.name]: Dropdown,
      [DropdownItem.name]: DropdownItem,
      [DropdownMenu.name]: DropdownMenu,
      [Table.name]: Table,
      [TableColumn.name]: TableColumn,
      WorkingTimeCreate,
      WorkingTimeUpdate,
      WorkingTimeDelete
    },
    data() {
      return {
        items: [],
        users: [],
        selectedUser: '1'
      };
    },
    methods: {
      formatDate: function(date) {
            return moment(date).format('YYYY MM DD, h:mm:ss a');
        },

      refreshWorkingTimes: async function() {
          this.items = await getWorkingTimesBetweenDates(this.selectedUser, "2019-10-19T23:58:52", "2050-10-19T23:00:00");
      },
      
      workingTimeCallback: function() {
        this.refreshWorkingTimes();
		  }
    },
    watch : {
      selectedUser: async function(val) {
        await this.refreshWorkingTimes();
      }
    },
    async mounted() {
      await this.refreshWorkingTimes();
      this.users = await getUsers();
    },
  };
</script>
<style>

</style>






