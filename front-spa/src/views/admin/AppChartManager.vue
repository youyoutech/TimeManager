<template>
  <div id="app">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div v-if="watchedUser && sortedList.length">
            <div class="card">
              <div class="card-body">
                <h4>Work and breaks of: {{ watchedUser.username }}</h4>
                <bar-chart 
                  id="bar"
                  :data="filteredDayArray" 
                  :bar-colors="arrayColors"
                  :ykeys="categories"
                  :labels="categoriesUpper"
                  xkey="day"
                  resize="true" 
                  grid=true
                  grid-text-weight="bold">
                </bar-chart>
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
          <div v-else-if="!watchedUser">
            <div class="card">
              <div class="card-body">
                <div class="mb-2">This user does not exist.</div>
                <router-link class="btn btn-primary" :to="{name: 'manager'}">Go back</router-link>
              </div>
            </div>
          </div>
          <div v-else>
            <div class="card">
              <div class="card-body">
                <div class="mb-2">This user has no clock.</div>
                <router-link class="btn btn-primary" :to="{name: 'manager'}">Go back</router-link>
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
import { mapGetters, mapActions } from 'vuex'
import axios from 'axios';
import moment from 'moment'

export default {
  name: 'chartmanager',
  created() {
    this.getUserAtCreate(this.$route.params.id);
    this.getWatchedUserClockList(this.$route.params.id);
    setTimeout(this.getWorkingAndPauseTimes,1000);
  },
  components: {
    BarChart
  },
  data () {
    return {
      dayArray: [],
      sortedList: [],
      categories:["work", "break"],
      categoriesUpper:["Work", "Break"],
      arrayColors:["#73c000","#FFB233"],
    }
  },
  computed: {
    ...mapGetters('manager_store', ['teamList', 'watchedUser', 'watchedUserClockList']),
    filteredDayArray() {
      return _.filter(this.dayArray, ['filtered', false]);
    }
  },
  methods: {
    ...mapActions('manager_store', ['getFullTeamList', 'getUserById', 'getWatchedUserClockList']),
    getUserAtCreate(userId) {
      this.getUserById(userId);
    },
    getWorkingAndPauseTimes() {
      if (this.watchedUser && this.watchedUserClockList) {
        this.dayArray = [];
        this.sortedList = _.sortBy(this.watchedUserClockList, 'time');
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
    filterDay(day) {
      day.filtered = !day.filtered;
    }
  },
};
</script>
