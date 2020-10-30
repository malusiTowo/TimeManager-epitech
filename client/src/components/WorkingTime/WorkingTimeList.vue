<template>
    <b-card no-body>

        <!-- create wt -->
        <b-row class="mt-3 mr-3 mb-3 ml-3" v-if="edit"> 
          <working-time-create v-on:event_child="workingTimeCallback" :userId="userId" />
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
        <v-table :data="items" 
        :currentPage.sync="currentPage"
        :pageSize="7"
        @totalPagesChanged="totalPages = $event"
        :filters="filters"
        class="table">
          <thead slot="head">
            <tr>
              <v-th sortKey="start" defaultSort="desc">Start Time</v-th>
              <th>End Time</th>
              <th v-if="edit">Actions</th>
              <th v-if="edit"></th>
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

  import {getWorkingTimesBetweenDates, formatDateForApi,formatDateFromApi} from '@/api/workingtime';
  import {getUserFromLocalStorage, getUserId} from '@/api/user';

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
        default: getUserId()
      }
    },

    data() {
      return {
        filters: {
          date: { 
            value: { 
              end: moment(moment().add('days', 7).format('YYYY-MM-DD')).format('YYYY-MM-DDTHH:mm:ss'), 
              start: moment(moment().format('YYYY-MM-DD')).format('YYYY-MM-DDTHH:mm:ss')
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
          return formatDateFromApi(date, 'YYYY-MM-DD HH:mm:ss');
      },

      refreshWorkingTimes: async function() {
          this.items = await getWorkingTimesBetweenDates(this.userId, this.filters.date.value.start, this.filters.date.value.end);
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

      'filters.date.value.start': async function (newVal, oldVal) {
        if(newVal != oldVal) this.refreshWorkingTimes();
      },

      'filters.date.value.end': async function (newVal, oldVal) {
        if(newVal != oldVal) this.refreshWorkingTimes();
      },

    }

  };
</script>
<style>

</style>


