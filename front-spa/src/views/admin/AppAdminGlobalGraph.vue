<template>
  <div id="app">
    <div>
      <div class="card">
        <h4>Statistics of teams</h4>
        <div class="card-body row">
          <div class="col-6">
            <bar-chart 
              id="bar"
              :data="filteredDayArray" 
              :bar-colors="arrayColors"
              :ykeys="teamNameList"
              :labels="teamNameList"
              xkey="day"
              resize="true" 
              grid=true
              grid-text-weight="bold">
            </bar-chart>
          </div>
          <div class="col-6">
            <donut-chart 
              id="donut" 
              :data="dataForDonut" 
              :colors='arrayColors'
              resize="true">
            </donut-chart>
          </div>
        </div>
      </div>
      <div class="card mb-3" style="max-width: 18rem;">
        <div class="card-header">Filters</div>
        <div class="card-body">
          <h5 class="card-title">Filter by day</h5>
          <div class="row">
            <div 
              v-for="day of dayArray"
              :key="day.day"
              class="col-6">
              <div>
                <button @click="filterDay(day)" type="button" :class="day.filtered ? 'btn btn-secondary m-1' : 'btn btn-primary m-1'">{{ day.day }}</button>
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
import { BarChart } from 'vue-morris'
import { DonutChart } from 'vue-morris'
import { mapGetters, mapActions } from 'vuex'
import axios from 'axios';
import moment from 'moment'

export default {
  name: 'adminglobalgraph',
  created() {
    this.fetchTeamList();
    this.getAllUserWithTime();
    setTimeout(this.getWorkingTimePerTeam, 500);
  },
  components: {
    BarChart,
    DonutChart
  },
  data () {
    return {
      dayArray: [],
      sortedList: [],
      arrayColors:["#340068","#FF6978","FFFCF9", "B1EDE8", "6D435A"],
      dataForDonut: []
    }
  },
  computed: {
    ...mapGetters('manager_store', ['teamList']),
    ...mapGetters('admin_store', ['userList']),
    filteredDayArray() {
      return _.filter(this.dayArray, ['filtered', false]);
    },
    teamNameList() {
      let teams = []
      for (let team of this.teamList) {
        teams.push(team.name);
      }
      return teams;
    },

  },
  methods: {
    ...mapActions('manager_store', ['getFullTeamList']),
    ...mapActions('admin_store', ['fetchAllUserWithWorkingtime']),
    fetchTeamList() {
      this.getFullTeamList();
    },
    getAllUserWithTime() {
      this.fetchAllUserWithWorkingtime()
    },
    getWorkingTimePerTeam() {
      for (let user of this.userList) {
        let teamIndex = _.findIndex(this.teamList, function(o) { return o.id == user.team_id });
        for (let workingtime of user.workingtime) {
          let formattedDay = moment(workingtime.start_day, 'YYYY-MM-DD').format('MMMM Do YYYY');
          if (!this.dayArray.some(e => e.day === formattedDay)) {
            this.dayArray.push(
              {
                'day': formattedDay,
                'filtered': false
              }
            );
          }
          let workingDuration =  
            ((moment(workingtime.end_day) - moment(workingtime.start_day))/3600000) > 0 ? 
            ((moment(workingtime.end_day) - moment(workingtime.start_day))/3600000) :
            0
          let dayIndex = _.findIndex(this.dayArray, function(o) { return o.day == formattedDay });
          let teamName = this.teamList[teamIndex].name;
          let infoForDonut = {
            'label': teamName,
            'value': workingDuration
          }
          this.dayArray[dayIndex][teamName] ? this.dayArray[dayIndex][teamName] += workingDuration : this.dayArray[dayIndex][teamName] = workingDuration;
          let donutIndex = _.findIndex(this.dataForDonut, function(o) { return o.label == teamName })
          if (donutIndex == -1) {
            this.dataForDonut.push(infoForDonut);
          } else {
            this.dataForDonut[donutIndex].value += workingDuration;
          }
          
        }
      }
    },
    filterDay(day) {
      day.filtered = !day.filtered;
    }
  },
};
</script>
