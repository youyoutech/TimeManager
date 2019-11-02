<template>
  <div v-if="currentUser" class="row">
      <div class="status-container">
        <p class="status-title">Status: </p>
        <div class="status-clock"
          :style="nextClockStatus ?'color:#f1536e' : 'color:#00c689'">
          <span :style="nextClockStatus ?'background:#f1536e' : 'background:#00c689'"></span>
          {{ nextClockStatus ? "Break" : "Work" }}
        </div>
        <div class="clock-timer">
          {{ lastClockTime }}
        </div>
      </div>
      <button type="button" class="btn btn-primary" @click="clock()">
        {{ nextClockStatus ? "Start time" : "Stop time" }}
      </button>
  </div>
</template>

<script>
// @ is an alias to /src
import axios from 'axios';
import { mapGetters, mapActions } from 'vuex'
import moment, { now } from 'moment'
export default {
  name: 'ClockButton',
  components: {
  },
  data () {
    return {
      clockList: null,
      lastClockTime: null,
    }
  },
  created () {
    if (this.currentUser) {
      this.fetchClockListAtReload(this.currentUser.id);
    }
  },
  computed: {
    ...mapGetters('user_store', ['currentUser', 'nextClockStatus']),
    newClock() {
      return {
          status: this.nextClockStatus,
          time: moment(),
          users_id: this.currentUser.id
        };
    },
    timer() {
      return moment()-this.lastClockTime;
    }
  },
  methods: {
    ...mapActions('user_store', ['setNextClockStatus','fetchClockList', 'fetchClockListAtReload', 'postNewClock']),
    clock() {
      if(!this.currentUser) {
        this.$notify({
          title: 'Clock failed',
          text: 'You must connect first',
          type: 'error',
          closeOnClick: true
        })
      } else {
        this.postNewClock(this.newClock)
        this.setNextClockStatus(!this.nextClockStatus)
        this.fetchClockList(this.currentUser.id)
        this.$notify({
          title: 'CLOCK',
          text: !this.newClock.status ? 'You clocked in, have a good day' : 'You clocked out, goodbye',
          type: 'success',
          closeOnClick: true
        }),
        this.lastClockTime = moment()
      }
    },
  }
};
</script>
