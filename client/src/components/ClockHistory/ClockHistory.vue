<template>
  <div>
    <b-card no-body>
      <b-row align-v="center" slot="header">
        <b-col cols="8" xl="12" md="12">
          <h1 class="mb-0">Clock History</h1>
        </b-col>
      </b-row>
      <b-row class="mt-3 mr-3 mb-3 ml-3">
        <b-col>
          <clock-create v-if="edit" :userId="userId" v-on:event_child="ClockCallback" />
        </b-col>
        <b-col>
          <clock-delete-all
            v-if="edit"
            v-on:event_child="ClockCallback"
            :selectedRows="this.selectedRows"
          />
        </b-col>
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
      <v-table id="myClocksHistory"
        :data="items"
        :currentPage.sync="currentPage"
        :pageSize="10"
        @totalPagesChanged="totalPages = $event"
        :filters="filters"
        class="table"
        selectionMode="multiple"
        selectedClass="table-info"
        @selectionChanged="selectedRows = $event"
      >
        <thead slot="head">
          <tr>
            <v-th sortKey="time" defaultSort="desc">time</v-th>
            <th>status</th>
            <th></th>
          </tr>
        </thead>
        <tbody slot="body" slot-scope="{ displayData }">
          <v-tr v-for="item in displayData" v-bind:key="item.id" :row="item.id">
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
          </v-tr>
        </tbody>
      </v-table>
      <smart-pagination id="myPagination"
        :currentPage.sync="currentPage"
        :totalPages="totalPages"
      />
    </b-card>
  </div>
</template>
<script>
import { getUserFromLocalStorage } from "../../api/user";
import { clock, getClockUser } from "../../api/clock";
import {
  formatDateForApi,
  formatDateFromApi,
} from "@/api/workingtime";
import { ClockCreate, ClockDelete, ClockDeleteAll } from "@/components";
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

export default {
  name: "clock-history",
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
    ClockDeleteAll,
  },
  props: {
    edit: {
      type: Boolean,
      default: false,
    },
    userId: {
      type: [String, Number],
    }
  },
  data() {
    return {
      myClock: {},
      myLastClock: {},
      userFound: null,
      myDate: null,
      //userId: null,
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
      selectedRows: [],
    };
  },
  methods: {
    timeFilter(filterValue, item) {
      return item.time >= filterValue.min && item.time <= filterValue.max;
    },
    async onClick() {
      try {
        //this.userId = getUserFromLocalStorage().userId;
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
      this.selectedRows = [];
    },
  },
  watch: {
    myClock: async function (val) {
      await this.refreshClock();
    },
  },
  mounted() {
    //this.userId = getUserFromLocalStorage().userId;
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
