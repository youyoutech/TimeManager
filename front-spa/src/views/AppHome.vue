<template>
  <div v-if="currentUser">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-8">
          <div id="welcome" class="card">
            <div class="card-body">
              <h4>Hi, welcome back <span>{{ formFields.username }}</span></h4>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div id="current-date" class="card">
            <div class="card-body">
              <div><i class="fa fa-clock-o" aria-hidden="true"></i> {{ currentTime }}</div>
              {{ currentDate }}
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-3">
          <div class="card bg-success" style="background-color: #00c689 !important">
            <div class="card-body">
              <div class="d-flex flex-md-column flex-xl-row flex-wrap  align-items-center justify-content-between">
                <div class="icon-rounded-inverse-success icon-rounded-lg">
                  <i class="fa fa-long-arrow-right color-success" aria-hidden="true"></i>
                </div>
                <div class="text-white">
                  <p class="font-weight-medium mt-md-2 mt-xl-0 text-md-center text-xl-left">Arrival Time</p>
                  <div v-for="(workingTime, index) in workingTimeList" :key="workingTime.id">
                    <div v-if="workingTimeList && index == workingTimeList.length - 1" class="d-flex flex-md-column flex-xl-row flex-wrap align-items-baseline align-items-md-center align-items-xl-baseline">
                      <h3 class="mb-0 mb-md-1 mb-lg-0 mr-1">{{ formatTime(workingTime.start_day) }}</h3>
                      <small class="mb-0">{{ abbvTime(workingTime.start_day) }}</small>
                    </div>
                  </div>
                  <div v-if="workingTimeList && !workingTimeList.length"><h5 class="mb-0 mb-md-1 mb-lg-0 mr-1">No value yet</h5></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card bg-info">
            <div class="card-body">
              <div class="d-flex flex-md-column flex-xl-row flex-wrap  align-items-center justify-content-between">
                <div class="icon-rounded-inverse-success icon-rounded-lg">
                  <i class="fa fa-long-arrow-left color-info" aria-hidden="true"></i>
                </div>
                <div class="text-white">
                  <p class="font-weight-medium mt-md-2 mt-xl-0 text-md-center text-xl-left">Left Time</p>
                  <div v-for="(workingTime, index) in workingTimeList" :key="workingTime.id">
                    <div v-if="workingTimeList && index == workingTimeList.length - 1" class="d-flex flex-md-column flex-xl-row flex-wrap align-items-baseline align-items-md-center align-items-xl-baseline">
                      <h3 class="mb-0 mb-md-1 mb-lg-0 mr-1">{{ formatTime(workingTime.end_day) }}</h3>
                      <small class="mb-0">{{ abbvTime(workingTime.end_day) }}</small>
                    </div>
                  </div>
                  <div v-if="workingTimeList && !workingTimeList.length"><h5 class="mb-0 mb-md-1 mb-lg-0 mr-1">No value yet</h5></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card bg-danger">
            <div class="card-body">
              <div class="d-flex flex-md-column flex-xl-row flex-wrap  align-items-center justify-content-between">
                <div class="icon-rounded-inverse-success icon-rounded-lg">
                  <i class="fa fa-clock-o color-danger" aria-hidden="true"></i>
                </div>
                <div class="text-white">
                  <p class="font-weight-medium mt-md-2 mt-xl-0 text-md-center text-xl-left">Time at work</p>
                  <div v-for="(workingTime, index) in workingTimeList" :key="workingTime.id">
                    <div v-if="workingTimeList && index == workingTimeList.length - 1" class="d-flex flex-md-column flex-xl-row flex-wrap align-items-baseline align-items-md-center align-items-xl-baseline">
                      <h3 class="mb-0 mb-md-1 mb-lg-0 mr-1">{{ calcTimeAtWork(workingTime.end_day, workingTime.start_day) }}</h3>
                    </div>
                  </div>
                  <div v-if="workingTimeList && !workingTimeList.length"><h5 class="mb-0 mb-md-1 mb-lg-0 mr-1">No value yet</h5></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card bg-warning">
            <div class="card-body">
              <div class="d-flex flex-md-column flex-xl-row flex-wrap  align-items-center justify-content-between">
                <div class="icon-rounded-inverse-success icon-rounded-lg">
                  <i class="fa fa-briefcase color-warning" aria-hidden="true"></i>
                </div>
                <div class="text-white">
                  <p class="font-weight-medium mt-md-2 mt-xl-0 text-md-center text-xl-left">Productivity</p>
                  <div v-for="(workingTime, index) in workingTimeList" :key="workingTime.id">
                    <div v-if="workingTimeList && index == workingTimeList.length - 1" class="d-flex flex-md-column flex-xl-row flex-wrap align-items-baseline align-items-md-center align-items-xl-baseline">
                      <h3 class="mb-0 mb-md-1 mb-lg-0 mr-1">{{ calcProductivity(workingTime.end_day, workingTime.start_day) }}</h3>
                      <small class="mb-0">%</small>
                    </div>
                  </div>
                  <div v-if="workingTimeList && !workingTimeList.length"><h5 class="mb-0 mb-md-1 mb-lg-0 mr-1">No value yet</h5></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-xl-8 grid-margin stretch-card">
          <div class="card">
            <div class="card-body">
              <h5>Last added people</h5>
              <div class="table-responsive">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th scope="col">#</th>
                      <th scope="col">Name</th>
                      <th scope="col">Email</th>
                      <th scope="col">Role</th>
                      <th scope="col">Team</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="user in userList.slice().reverse()"
                      :key="user.id" 
                      :class="user.id == currentUser.id ? 'active' : ''">
                      <th>
                        {{ user.id }}
                      </th>
                      <td>{{ user.username }}</td>
                      <td>{{ user.email }}</td>
                      <td v-if="user.role_id == 3 || user.role_id == 2">
                        <span class="badge" :class="user.role_id == 3 ? 'badge-warning' : (user.role_id == 2 ? 'badge-info' : '')">
                          {{ getRoleLabelFromId(user.role_id) }}
                        </span>
                      </td>
                      <td v-else>
                        <span class="badge badge-success">
                          Employee
                        </span>
                      </td>
                      <td>{{ getTeamLabelFromId(user.team_id) }}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
        <div class="col-xl-4 grid-margin">
          <div class="card">
            <div class="card-body">
              <h5>City hall employees</h5>
              <donut-chart 
                id="donut" 
                :data="donutData" 
                colors='[ "rgb(241, 83, 110)", "#36A2EB", "#FFCE56" ]' 
                resize="true">
              </donut-chart>
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
import momentTimezone from 'moment-timezone'
import axios from 'axios'
import { DonutChart } from 'vue-morris'

export default {
  name: 'home',
  components: {
    DonutChart,
  },
  data () {
    return {
      valid:false,
      formFields: {
        username: null,
        email: null,
        password: null,
      },
      currentTime: null,
      donutData: [
        { label: 'Admin', value: 300, labelColor: 'white' },
        { label: 'Manager', value: 50, labelColor: 'white' },
        { label: 'User', value: 100, labelColor: 'yellow' }
      ],
    }
  },
  created() {
    this.getWorkingTime()
    this.getTeamList()
    this.currentTime = moment().format('LTS')
    setInterval(() => this.updateCurrentTime(), 1 * 1000)
    this.formFields = 
      this.currentUser ? 
      this.currentUser : 
      { username: null,
        email: null,
        password: null,
      }
  },
  destroyed() {
    clearInterval(this.interval);
  },
  computed: {
    ...mapGetters('user_store', ['currentUser', 'clockList', 'workingTimeList']),
    ...mapGetters('manager_store', ['teamList']),
    userList() {
      let list = [];
      for(let team of this.teamList) {
        for(let user of team.user) {
          list.push(user);
        }
      }
        return _.sortBy(list, 'id');
    },
    filteredDayArray() {
      return _.filter(this.dayArray, ['filtered', false]);
    },
    currentDate() {
      return moment().format('DD/MM/YYYY');
    },
  },
  methods: {
    ...mapActions('user_store', ['fetchWorkingTimeList']),
    ...mapActions('manager_store', ['getFullTeamList']),
    updateCurrentTime() {
      this.currentTime = moment().format('LTS');
    },
    getWorkingTime() {
      if (this.currentUser) {
        this.fetchWorkingTimeList(this.currentUser.id)
      }
    },
    formatTime(time) {
      return moment(time).tz("Etc/GMT-4").format('hh:mm')
    },
    abbvTime(time) {
      return moment(time).tz("Etc/GMT-4").format('a')
    },
    calcTimeAtWork(start_day, end_day) {
      var timeAtWork = moment.utc(moment(start_day,"YYYY.MM.DD HH:mm").diff(moment(end_day,"YYYY.MM.DD HH:mm"))).format("HH[h]mm")
      return timeAtWork;
    },
    calcProductivity(start_day, end_day) {
      var timeAtWork = moment.utc(moment(start_day,"HH:mm").diff(moment(end_day,"HH:mm"))).format("HH:mm")
      var intString = String(timeAtWork).replace(":", ".")
      return (intString*100/7).toFixed(2)
    },
    getTeamList() {
      this.getFullTeamList();
    },
    getRoleLabelFromId(id) {
      switch(id) {
        case 1: return 'User'; break;
        case 2: return 'Manager'; break;
        case 3: return 'Admin'; break;
      }
    },
    getTeamLabelFromId(id) {
      for(let team of this.teamList) {
        if (team.id == id)
          return team.name;
      }
    },
    getWorkingAndPauseTimes() {
      if (this.currentUser && this.clockList) {
        this.dayArray = [];
        this.sortedList = _.sortBy(this.clockList, 'time');
        for(let clock of this.sortedList) {
          let formattedDay = moment(clock.time, 'YYYY-MM-DD').format('MMMM Do YYYY');
          clock.day = formattedDay;
          if (!this.dayArray.some(e => e.day === formattedDay)) {
            this.dayArray.push(
              {
                'day': formattedDay,
                'work': 0,
                'break': 0,
                'filtered': false
              }
            );
          }
        }

        for(let i = 0; i < this.sortedList.length; i++) {
          if (this.sortedList[i-1] && this.sortedList[i].status == true && this.sortedList[i-1].day == this.sortedList[i].day ) {
            let clockTime = moment(this.sortedList[i].time) - moment(this.sortedList[i-1].time);
            let day = this.sortedList[i].day;
            let index =_.findIndex(this.dayArray, function(o) { return o.day == day; });
            this.dayArray[index].break += clockTime/3600000;
          }
          if (this.sortedList[i].status == false) {
            let clockTime = moment(this.sortedList[i].time) - moment(this.sortedList[i-1].time);
            let day = this.sortedList[i].day;
            let index =_.findIndex(this.dayArray, function(o) { return o.day == day; });
            this.dayArray[index].work += clockTime/3600000;
          }
        }
      } else {
        console.log('non connecté');
      }
    },
  },
};
</script>
