<template>
  <div>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div class="card">
            <div class="card-body">
              <h4>Your chart</h4>
              <div v-if="currentUser" class="input-group mb-4">
                <div class="input-group-prepend">
                  <label class="input-group-text" for="inputGroupSelect01">Choose your chart</label>
                </div>
                <select v-model="selectedGraph" class="custom-select" id="inputGroupSelect01">
                  <option value="1">Bar graphic</option>
                  <option value="2">Line graphic</option>
                </select>
              </div>
              <bar-chart-component v-if="selectedGraph==1"></bar-chart-component>
              <line-chart-component v-if="selectedGraph==2"></line-chart-component>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import BarChartComponent from "../../components/BarChartComponent"
import LineChartComponent from "../../components/LineChartComponent"
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'chart',
  components: {
    BarChartComponent,
    LineChartComponent
  },
  created() {
    setTimeout(this.getClockList, 500);
  },
  data() {
    return {
      selectedGraph: 1
    }
  },
  computed: {
    ...mapGetters('user_store', ['currentUser']),
  },
  method: {
    ...mapActions('user_store', ['fetchClockList']),
    getClockList() {
      if (this.currentUser) {
        this.fetchClockList(currentUser.id)
      }
    }
  }
};
</script>
