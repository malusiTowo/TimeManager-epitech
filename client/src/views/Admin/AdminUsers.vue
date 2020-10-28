<template>
    <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
    </base-header>

    <b-container fluid class="mt--7">

    <b-card >
        <b-card-body class="px-lg-5 py-lg-5">
            <div class="text-center mb-2">
                <h1>Admin Users</h1>
            </div>
        </b-card-body>

        <b-row class="mt-3 mr-3 ml-3 mb-4" >
            <b-col>
                <!-- Create employee button  -->
                Create employee
            </b-col>
            <b-col>
                <!-- Search bar  -->
                Search bar
            </b-col>
        </b-row>

        <b-row class="mt-3 mr-3 mb-3 ml-3">
          <b-col> 
              
              <table class="table">
                <thead>
                  <tr>
                    <th>Firstname</th>
                    <th>Lastname</th>
                    <th>Mail</th>
                    <th>Role</th>
                    <th></th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                      <!-- <tr v-for="item in items" v-bind:key = item.id> -->
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <!-- Add buttons -->
                    <td>See infos</td>
                    <td>See graphs</td>
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
export default {
    
}
</script>

<style>

</style>