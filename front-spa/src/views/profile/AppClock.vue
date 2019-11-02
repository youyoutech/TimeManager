<template>
  <div>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div v-if="!currentUser">
            You should identify first if you want to access clock infos
          </div>
          <div v-else>
            <div class="card">
              <div class="card-body">
                <h4>Daily report</h4>
                <div v-if="clockList.length">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">Status</th>
                        <th scope="col">Time</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="clock in clockList" :key="clock.id">
                        <th scope="row">{{ clock.id }}</th>
                        <td><label class="badge" :class="clock.status ? 'badge-success': 'badge-warning'">{{ clock.status ? "In" : "Out" }}</label></td>
                        <td>{{ formatTime(clock.time) }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div v-else>
                  <div>No value yet. Please start time by clicking on the button above.</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import { mapGetters, mapActions } from 'vuex'
import moment from 'moment'
import axios from 'axios'

export default {
  name: 'clock',
  components: {
  },
  data() {
    return {
      interval : null
    }
  },
  created(){
    this.interval = setInterval(this.getUserClocks, 5000);
  },
  destroyed() {
    clearInterval(this.interval);
  },
  computed: {
    ...mapGetters('user_store', ['currentUser', 'clockList'])
  },
  methods: {
    ...mapActions('user_store', ['newClockList', 'fetchClockList']),
    getUserClocks() {
      if (this.currentUser) {
        this.fetchClockList(this.currentUser.id)
      } else {
        this.$notify({
          title: 'Empty form',
          text: 'Please fill users data first',
          type: 'error',
          closeOnClick: true
        })
        console.log('formfields empty');
      }
    },
    formatTime(time) {
      return moment(time).format('lll');
    }
  }
};
</script>
