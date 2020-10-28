<template>
    <b-card no-body>

        <!-- create wt -->
        <b-row class="mt-3 mr-3 mb-3 ml-3" v-if="edit"> 
          <working-time-create v-on:event_child="workingTimeCallback" />
        </b-row>

        <!-- filters -->
        <b-row class="mt-3 mr-3 mb-3 ml-3"> 
          <b-col>
              <label for="name">Start Date</label>
              <input
                type="datetime-local"
                class="form-control"
                id="dateStart"
                placeholder="Date Start"
                v-model="filters.date.value.start"
              />
          </b-col>
          <b-col>
              <label for="name">End Date</label>
              <input
                type="datetime-local"
                class="form-control"
                id="dateEnd"
                placeholder="Date End"  
                v-model="filters.date.value.end"
              />
          </b-col>
        </b-row>

        <!-- table -->
        <!-- <b-row class="mt-3 mr-3 mb-3 ml-3">
          <b-col>
              <table class="table">
                <thead>
                  <tr>
                    <th>start time</th>
                    <th>end time</th>
                    <th v-if="edit"></th>
                    <th v-if="edit"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in items" v-bind:key = item.id>
                    <td>{{formatDate(item.start)}}</td>
                    <td>{{formatDate(item.end)}}</td>
                    <td v-if="edit">
                      <working-time-update  :idUser="userId" :wtId ="item.id" v-on:event_child="workingTimeCallback" />
                    </td>
                    <td v-if="edit">
                      <working-time-delete :wtId ="item.id" v-on:event_child="workingTimeCallback" />
                    </td>
                  </tr>
                </tbody>
              </table>
          </b-col>
        </b-row> -->
        <v-table :data="items" 
        :currentPage.sync="currentPage"
        :pageSize="5"
        @totalPagesChanged="totalPages = $event"
        :filters="filters"
        class="table">
          <thead slot="head">
            <tr>
              <v-th sortKey="start" defaultSort="desc">Start Time</v-th>
              <th>End Time</th>
              <th>Actions</th>
              <th></th>
            </tr>
          </thead>
          <tbody slot="body" slot-scope="{displayData}">
            <tr v-for="item in displayData" v-bind:key = item.id> 
              <td>{{formatDate(item.start)}}</td>
              <td>{{formatDate(item.end)}}</td>  
              <td v-if="edit">
                <working-time-update  :idUser="userId" :wtId ="item.id" v-on:event_child="workingTimeCallback" />
              </td>
              <td v-if="edit">
                <working-time-delete :wtId ="item.id" v-on:event_child="workingTimeCallback" />
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
  import moment from 'moment';

  import { WorkingTimeCreate, WorkingTimeUpdate, WorkingTimeDelete } from './';
  import axios from 'axios';

  import {getWorkingTimesBetweenDates, formatDateForApi} from '@/api/workingtime';
  import {getUserFromLocalStorage} from '@/api/user';

  import SmartTable from 'vuejs-smart-table';

  export default {
    name: "working-time-list",
    components: {
      SmartTable,
      WorkingTimeCreate,
      WorkingTimeUpdate,
      WorkingTimeDelete
    },
    props: {
      edit: {
        type: Boolean,
        default: false
      },
      userId: {
        type: [String, Number],
        default: getUserFromLocalStorage()['user']['id']
      }
    },
    data() {
      return {
        filterStart: moment(moment().format('YYYY-MM-DD')).format('YYYY-MM-DDTHH:mm:ss'),  
        filterEnd:moment(moment().add(15, 'days').format('YYYY-MM-DD')).format('YYYY-MM-DDTHH:mm:ss'),

        filters: {
          date: { 
            value: { 
              end: moment().add('days', 7).format('YYYY-MM-DDTHH:mm:ss'), 
              start: moment().format('YYYY-MM-DDTHH:mm:ss')
            }, 
            custom: this.dateFilter }
        },
        items: [],
        pageSize:10,
        currentPage:1,
        totalPages: 0
      }
    },

    methods: {
    
      formatDate: function(date) {
            return moment(date).format('YYYY MM DD, hh:mm:ss a'); 
        },

      refreshWorkingTimes: async function() {
          this.items = await getWorkingTimesBetweenDates(this.userId, this.filterStart, this.filterEnd);
      },
      
      workingTimeCallback: function() {
        this.refreshWorkingTimes();
      },
      
      dateFilter (filterValue, row) {
        return (row.start >= filterValue.start && row.start <= filterValue.end)
                || (row.end >= filterValue.start && row.end <= filterValue.end)
      }
    },
  
    async mounted() {
      await this.refreshWorkingTimes();
    },

    watch:{

      filterStart: async function () {
        this.refreshWorkingTimes();
      },
      filterEnd: async function () {
        this.refreshWorkingTimes();
      },
      userId: async function () {
        this.refreshWorkingTimes();
      }
      
    }

  };
</script>
<style>

</style>


