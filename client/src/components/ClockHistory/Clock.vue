<template>
  <div>  
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
  </div>
</template>
<script>
import { getUserFromLocalStorage } from "../../api/user";
import { clock, getClockUser } from "../../api/clock";
import moment from "moment";

export default {
  name: "clock",
  data() {
    return {
      myClock: {},
      myLastClock: {},
      userFound: null,
      myDate: null,
      userId: null,
      subTitle:null,
      type: null,
      username: null
    };
  },
  methods: {
    formatDate: function(date) {
            return moment.tz(date, "Europe/Paris").format('YYYY MM DD, h:mm:ss a');
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
        
          response.sort(function (a, b) {
            return (a.time > b.time) ? 1 : -1;
          });
      
          this.myLastClock = response.pop();
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
        
      } catch (error) {
        console.log("error", error);
      }
    }
  },
  mounted(){
    this.userId = getUserFromLocalStorage().userId;
    this.username = getUserFromLocalStorage().username;
    this.updateClockUser();
  }
};
</script>
