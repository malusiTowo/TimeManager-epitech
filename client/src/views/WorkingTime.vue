<template>
  <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
    </base-header>

    <b-container fluid class="mt--7">
      
    <b-card no-body>
        <b-row class="mt-3 mr-3 mb-3 ml-3 float-right" > 
          <working-time-create  />
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
                      <working-time-update  :idUser="1" :wtId ="item.id" />
                    </td>
                    <td>
                      <working-time-delete :wtId ="item.id" />
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
  import projects from './Tables/projects';
  import users from './Tables/users';
  import moment from 'moment';
  //import LightTable from "./Tables/RegularTables/LightTable";
  //import DarkTable from "./Tables/RegularTables/DarkTable";
  //import WorkingTime from "./WorkingTime"

  import { WorkingTimeCreate, WorkingTimeUpdate, WorkingTimeDelete } from '@/components';
  import axios from 'axios';

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
        items: []
      };
    },
    mounted() {
        axios
            .get(
                'http://localhost:4000/api/workingtimes/1?start=2019-10-19 23:58:52&end=2050-10-19 23:00:00'
            )
            .then(
                response => this.items = response.data.data
            )
            .catch(
                error => console.error("Something is going wrong ! " + error)
            );
    },
    methods: {
      formatDate: function(date) {
            return moment(date).format('YYYY MM DD, h:mm:ss a');
        }
    }
  };
</script>
<style>

</style>






