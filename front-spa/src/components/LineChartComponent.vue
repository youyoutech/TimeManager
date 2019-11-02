<template>
  <div id="app">
    <div v-if="currentUser && clockList.length">
      <div class="card">
        <div class="card-body">
          <h4>Work and breaks of: {{ currentUser.username }}</h4>
          <button @click="getWorkingAndPauseTimes()">Refresh</button>
          <line-chart 
            id="line"
            :data="filteredDayArray" 
            :line-colors="arrayColors"
            :ykeys="categories"
            :labels="categoriesUpper"
            xLabels="day"
            xkey="day"
            resize="true" 
            grid=true
            grid-text-weight="bold">
          </line-chart>
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
    <div v-else-if="!currentUser">
      <h1>You are not connected</h1>
    </div>
    <div v-else>
      <div class="text-white">No line graphic for the moment as you don't have any clocks.</div>
    </div>
  </div>
</template>
<script>
import { LineChart } from 'vue-morris'
import { mapGetters, mapActions } from 'vuex'
import moment from 'moment'
export default {
    name: 'LineChartComponent',
  data(){
    return{
      dayArray: [],
      sortedList: [],
      categories:["work", "break"],
      categoriesUpper:["Work", "Break"],
      arrayColors:["rgb(0, 198, 137)","rgb(241, 83, 110)"],
    }
  },
  created(){
    setTimeout(this.getWorkingAndPauseTimes,500)
  },
  components:{
    LineChart
  },
  computed: {
    ...mapGetters('user_store', ['currentUser', 'clockList']),
    filteredDayArray() {
      return _.filter(this.dayArray, ['filtered', false]);
    }
  },
  methods: {
    getWorkingAndPauseTimes() {
      if (this.currentUser && this.clockList) {
        this.dayArray = [];
        this.sortedList = _.sortBy(this.clockList, 'time');
        for(let clock of this.sortedList) {
          let formattedDay = moment(clock.time).format().substr(0,10);
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
            let clockTime =
            moment(this.sortedList[i].time) - moment(this.sortedList[i-1].time) > 0 ?
            moment(this.sortedList[i].time) - moment(this.sortedList[i-1].time) :
            0
            let day = this.sortedList[i].day;
            let index =_.findIndex(this.dayArray, function(o) { return o.day == day; });
            this.dayArray[index].break += clockTime/3600000;
          }
          if (this.sortedList[i].status == false) {
            let clockTime =
            moment(this.sortedList[i].time) - moment(this.sortedList[i-1].time) > 0 ?
            moment(this.sortedList[i].time) - moment(this.sortedList[i-1].time) :
            0
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
  }
}
</script>
<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>