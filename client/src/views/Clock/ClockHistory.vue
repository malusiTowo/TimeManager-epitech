<template>

  <div>
    <!-- Header -->
    <div class="header bg-gradient-success py-7 py-lg-8 pt-lg-9">
      <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
      <!-- Card clock -->
      <b-row>
        <b-col xl="3" md="6">
          <clock-card title="Are you there?"
                      :typeOff="type"
                      :sub-title="subTitle"
                      :onclick=onClick
                      icon="ni ni-button-power"
                      class="mb-4">
            <template slot="footer">
              <span class="text-success mr-2">{{ myDate }}</span>
            </template>
          </clock-card>
        </b-col>
      </b-row>
      </base-header>
    </div>
    <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
    </base-header>

    <b-container fluid class="mt--7">
      
    <b-card no-body>
        <b-row class="mt-3 mr-3 mb-3 ml-3 float-right" > 
          <clock-create v-on:event_child="ClockCallback" />
        </b-row>
        
        <b-row class="mt-3 mr-3 mb-3 ml-3">
          <b-col> 
            <div>
              <td>
              <label>Enter your filter</label></td>
            <label>Min Date:</label>
              <input
              type="datetime-local"
              class="form-control"
              id="dateStart"
              placeholder="Date Start"
              v-model="filters.time.value.min"
              />
            
              <label>Max Date:</label>
              <input
              type="datetime-local"
              class="form-control"
              id="dateEnd"
              placeholder="Date End"
              v-model="filters.time.value.max"
              />
            </div>
              <v-table  :data="items" 
                        :currentPage.sync="currentPage"
                        :pageSize="10"
                        @totalPagesChanged="totalPages = $event" 
                        :filters="filters"
                        class="table">
                <thead slot="head">
                  <tr>
                    <v-th sortKey="time" defaultSort="desc">time</v-th>
                    <th>status</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody slot="body" slot-scope="{displayData}">
                  <tr v-for="item in displayData" v-bind:key = item.id> 
                    <td>{{formatDate(item.time)}}</td>
                    <td v-if="item.status == true">Clock-In</td>
                    <td v-else>Clock-Out</td>
                    <td>
                      <clock-delete :clockId ="item.id" v-on:event_child="ClockCallback" />
                    </td>
                  </tr>
                </tbody>
              </v-table>
            <smart-pagination
              :currentPage.sync="currentPage"
              :totalPages="totalPages"
            />
          </b-col>
        </b-row>
      </b-card>
    </b-container>

  </div>
  </div>
  
</template>
<script>
import { getUserFromLocalStorage } from "../../api/user";
import { clock, getClockUser } from "../../api/clock";
import { ClockCreate, ClockDelete } from '@/components';
import { Dropdown, DropdownItem, DropdownMenu, Table, TableColumn } from 'element-ui';
import SmartTable from 'vuejs-smart-table';
import axios from 'axios';


import moment from "moment";

export default {
  components: {
      //LightTable,
      //DarkTable,
      [Dropdown.name]: Dropdown,
      [DropdownItem.name]: DropdownItem,
      [DropdownMenu.name]: DropdownMenu,
      [Table.name]: Table,
      [TableColumn.name]: TableColumn,
      SmartTable,
      ClockCreate,
      ClockDelete
    },
  data() {
    return {
      myClock: {},
      myLastClock: {},
      userFound: null,
      myDate: null,
      userId: null,
      subTitle:null,
      type: null,
      username: null,
      items: [],
      users: [],
      selectedUser: '1',
      currentPage:1,
      totalPages: 0,
      filters: {
        time: { value: { min: moment().subtract('days', 7).format("YYYY-MM-DDTkk:mm"), max: moment().format("YYYY-MM-DDTkk:mm")}, custom: this.timeFilter }
      }
    };
  },
  methods: {
    timeFilter (filterValue, item) {
      return item.time >= filterValue.min && item.time <= filterValue.max
    },
    async onClick(){
      try {
        this.userId = getUserFromLocalStorage().userId;
        const response = await clock(this.userId);
        this.myClock = response;
        if(this.myClock.status == true)
        {
          this.subTitle = "Clock-In";
          this.type = "gradient-green";
        }
        else{
          this.subTitle = "Clock-Out";
          this.type = "gradient-red";
        }
        const myFormatDate = new Date(this.myClock.time);
        this.myDate = moment(myFormatDate).format('MM-DD-YYYY HH:mm:ss');
      } catch (error) {
        console.log("error", error);
      }
    },
    async updateClockUser(){
      try {
        const response = await getClockUser(this.userId);
        this.myLastClock = response[(response.length -1)];
        if(this.myLastClock.status == true)
        {
          this.subTitle = "Clock-In";
          this.type = "gradient-green";
        }
        else{
          this.subTitle = "Clock-Out";
          this.type = "gradient-red";
        }
        const myFormatDate = new Date(this.myLastClock.time);
        this.myDate = moment(myFormatDate).format('MM-DD-YYYY HH:mm:ss');
        this.refreshClock();
      } catch (error) {
        console.log("error", error);
      }
    },
    formatDate: function(date) {
            return moment(date).format('YYYY MM DD, h:mm:ss a');
        },

      refreshClock: async function() {
          const response = await getClockUser(this.userId);
          this.items = response;
      },
      
      ClockCallback: function() {
        this.updateClockUser();
        this.refreshClock();
		  }
    },
    watch : {
      myClock: async function(val) {
        await this.refreshClock();
      }
    },
    mounted() {
      this.userId = getUserFromLocalStorage().userId;
      this.username = getUserFromLocalStorage().username;
      this.updateClockUser();
    }
};
</script>
