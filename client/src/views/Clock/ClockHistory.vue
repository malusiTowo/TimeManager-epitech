<template>
  <div>
    <!-- Header -->
    <base-header></base-header>

    <!-- Card clock -->
    <b-container fluid class="mt--9 mb48">
      <b-row class="">
        <b-col lg="4" md="6">
          <clock-card
            title="Are you there?"
            :typeOff="type"
            :sub-title="subTitle"
            :onclick="onClick"
            icon="ni ni-button-power"
            class="mb-4"
          >
            <template slot="footer">
              <span class="text-success mr-2">{{ myDate }}</span>
            </template>
          </clock-card>
        </b-col>
      </b-row>
      <b-card no-body>
        <b-row align-v="center" slot="header">
          <b-col cols="8" xl="12" md="12">
            <h1 class="mb-0">Clock History</h1>
          </b-col>
        </b-row>

        <b-row class="mt-3 mr-3 mb-3 ml-3 float-right">
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
        <v-table
          :data="items"
          :currentPage.sync="currentPage"
          :pageSize="10"
          @totalPagesChanged="totalPages = $event"
          :filters="filters"
          class="table"
        >
          <thead slot="head">
            <tr>
              <v-th sortKey="time" defaultSort="desc">time</v-th>
              <th>status</th>
              <th></th>
            </tr>
          </thead>
          <tbody slot="body" slot-scope="{ displayData }">
            <tr v-for="item in displayData" v-bind:key="item.id">
              <td>{{ formatDate(item.time) }}</td>
              <td v-if="item.status == true">Clock-In</td>
              <td v-else>Clock-Out</td>
              <td>
                <clock-delete
                  v-if="edit"
                  :clockId="item.id"
                  v-on:event_child="ClockCallback"
                />
              </td>
            </tr>
          </tbody>
        </v-table>
        <smart-pagination
          :currentPage.sync="currentPage"
          :totalPages="totalPages"
        />
        <!-- </b-col> -->
        <!-- </b-row> -->
      </b-card>
    </b-container>
  </div>
</template>
<script>
import { getUserFromLocalStorage } from "../../api/user";
import { clock, getClockUser } from "../../api/clock";
import { ClockCreate, ClockDelete } from "@/components";
import {
  Dropdown,
  DropdownItem,
  DropdownMenu,
  Table,
  TableColumn,
} from "element-ui";
import SmartTable from "vuejs-smart-table";
import axios from "axios";

import moment from "moment";
import {
  formatDateForApi,
  formatDateFromApi,
} from "@/api/workingtime";

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
    ClockDelete,
  },
  props: {
    edit: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      myClock: {},
      myLastClock: {},
      userFound: null,
      myDate: null,
      userId: null,
      subTitle: null,
      type: null,
      username: null,
      items: [],
      users: [],
      selectedUser: "1",
      currentPage: 1,
      totalPages: 0,
      filters: {
        time: {
          value: {
            min: moment()
              .subtract(7, "days")
              .set({ hour: 0, minute: 0, second: 0, millisecond: 0 })
              .format("YYYY-MM-DDTHH:mm:ss"),
            max: moment()
              .add(1, "days")
              .set({ hour: 0, minute: 0, second: 0, millisecond: 0 })
              .format("YYYY-MM-DDTHH:mm:ss"),
          },
          custom: this.timeFilter,
        },
      },
    };
  },
  methods: {
    timeFilter(filterValue, item) {
      return item.time >= filterValue.min && item.time <= filterValue.max;
    },
    async onClick() {
      try {
        this.userId = getUserFromLocalStorage().userId;
        const response = await clock(this.userId);
        this.myClock = response;
        if (this.myClock.status == true) {
          this.subTitle = "Clock-In";
          this.type = "gradient-green";
        } else {
          this.subTitle = "Clock-Out";
          this.type = "gradient-red";
        }
        this.myDate  = this.formatDate(this.myClock.time);
      } catch (error) {
        console.log("error", error);
      }
    },
    async updateClockUser() {
      try {
        const response = await getClockUser(this.userId);
        if (response) {
          response.sort(function (a, b) {
            return a.time > b.time ? 1 : -1;
          });

          this.myLastClock = response.pop();
        }

        if(this.myLastClock != null){
        if (this.myLastClock.status == true) {
          this.subTitle = "Clock-In";
          this.type = "gradient-green";
        } else {
          this.subTitle = "Clock-Out";
          this.type = "gradient-red";
        }

        this.myDate  = this.formatDate(this.myLastClock.time);
        this.refreshClock();
        }
      } catch (error) {
        console.log("error", error);
      }
    },
    formatDate: function (date) {
      return formatDateFromApi(date, "YYYY-MM-DD HH:mm:ss");
    },

    refreshClock: async function () {
      const response = await getClockUser(this.userId);
      this.items = response;
    },

    ClockCallback: function () {
      this.updateClockUser();
      this.refreshClock();
    },
  },
  watch: {
    myClock: async function (val) {
      await this.refreshClock();
    },
  },
  mounted() {
    this.userId = getUserFromLocalStorage().userId;
    this.username = getUserFromLocalStorage().username;
    this.updateClockUser();
  },
};
</script>

<style lang="scss">
.smart-pagination {
  z-index: 0;
}
</style>
