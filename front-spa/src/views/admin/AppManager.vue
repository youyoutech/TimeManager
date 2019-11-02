<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-body">
            <h4>Team management</h4>
            <table class="table table-hover m">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Role</th>
                    <th scope="col">Team</th>
                    <th scope="col">Time</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="user in userList"
                    :key="user.id" :class="user.id == currentUser.id ? 'active' : ''">
                    <th scope="row">{{ user.id }}
                    </th>
                    <td>{{ user.username }}</td>
                    <td>{{ user.email }}</td>
                    <td>
                      <span class="badge" :class="user.role_id == 3 ? 'badge-warning' : (user.role_id == 2 ? 'badge-primary' : '')">
                        {{ getRoleLabelFromId(user.role_id) }}
                      </span>
                    </td>
                    <td>{{ getTeamLabelFromId(user.team_id) }}</td>
                    <td>
                      <div v-if="user.id != currentUser.id">
                        <router-link class="no-link" :to="{name: 'manager/chart', params:{id: user.id}}">
                          <v-icon style="color:#FFFFFF">alarm</v-icon>
                        </router-link>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import axios from 'axios';
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'manager',
  components: {
  },
  created() {
    this.getTeamList();
    this.getUserList();
    this.refreshInterval = setInterval(this.getUserList, 10000);
  },
  destroyed() {
    clearInterval(this.refreshInterval);
  },
  data () {
    return {
      refreshInterval: null
    }
  },
  computed: {
    ...mapGetters('user_store', ['currentUser']),
    ...mapGetters('manager_store', ['userList', 'teamList'])
  },
  methods: {
    ...mapActions('manager_store', ['getFullTeamList', 'getUserFromMyTeam']),
    getUserList() {
      this.getUserFromMyTeam(this.currentUser.team_id);
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
    }
  }
};
</script>
