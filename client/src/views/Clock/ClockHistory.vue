<template>
  <div>
    <!-- Header -->
    <div class="header bg-yellow py-7 py-lg-8 pt-lg-9">
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg
          x="0"
          y="0"
          viewBox="0 0 2560 100"
          preserveAspectRatio="none"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
        >
          <polygon
            class="fill-default"
            points="2560 0 2560 100 0 100"
          ></polygon>
        </svg>
      </div>
    </div>
      <!-- Card clock -->

      <b-container fluid class="mt--9">
      <b-row class="">
        <b-col lg="4" md="6">
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
    <b-card no-body>
        <b-row class="mt-3 mr-3 mb-3 ml-3 float-right" > 
          <clock-create v-if="edit" v-on:event_child="ClockCallback" />
        </b-row>
        
        <b-row class="mt-3 mr-3 mb-3 ml-3">
          <b-col> 
              <label for="name">Start Date</label>
              <input
                type="datetime-local"
                class="form-control"
                id="dateStart"
                placeholder="Date Start"
                v-model="filters.time.value.min"
              />
          </b-col>
          <b-col>
              <label for="name">End Date</label>
              <input
                  type="datetime-local"
                  class="form-control"
                  id="dateEnd"
                  placeholder="Date End"
                  v-model="filters.time.value.max"
                  width="auto"
              />
          </b-col>
        </b-row>
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
                      <clock-delete v-if="edit" :clockId ="item.id" v-on:event_child="ClockCallback" />
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
  props: {
      edit: {
        type: Boolean,
        default: false
      }
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
        time: { value: { min: moment().subtract(7, 'days').set({hour:0,minute:0,second:0,millisecond:0}).format("YYYY-MM-DDTHH:mm:ss"), max: moment().add(1, 'days').set({hour:0,minute:0,second:0,millisecond:0}).format("YYYY-MM-DDTHH:mm:ss")}, custom: this.timeFilter }
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
        const myUTCdate = moment.utc(this.myClock.time);
        this.myDate = myUTCdate.local().format('YYYY MM DD, h:mm:ss a');
      } catch (error) {
        console.log("error", error);
      }
    },
    async updateClockUser(){
      try {
        const response = await getClockUser(this.userId);
        if(response){
          console.log("je suis la")
          response.sort(function (a, b) {
            return (a.time > b.time) ? 1 : -1;
          });
      
          this.myLastClock = response.pop();
          console.log(this.myLastClock)
        }
        //this.myLastClock = response[(response.length -1)];
        if(this.myLastClock.status == true)
        {
          this.subTitle = "Clock-In";
          this.type = "gradient-green";
        }
        else{
          this.subTitle = "Clock-Out";
          this.type = "gradient-red";
        }
        const myUTCdate = moment.utc(this.myLastClock.time);
        this.myDate = myUTCdate.local().format('YYYY MM DD, h:mm:ss a');
        this.refreshClock();
      } catch (error) {
        console.log("error", error);
      }
    },
    formatDate: function(date) {
            const myUTCdate = moment.utc(date);
            const myLocaldate = myUTCdate.local().format('YYYY MM DD, h:mm:ss a');
             return myLocaldate;
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
