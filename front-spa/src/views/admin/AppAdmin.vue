<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-body">
            <h4>Admin management</h4>
            <div class="input-group mb-3 col-6">
              <div class="input-group-prepend">
                <label class="input-group-text" for="inputGroupSelect01">What do you want to manage?</label>
              </div>
              <select v-model="selectedOption" class="custom-select" id="inputGroupSelect01">
                <option value="1">Employees</option>
                <option value="2">Teams</option>
              </select>
            </div>
            <div v-if="selectedOption == 1">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Role</th>
                    <th scope="col">Team</th>
                    <th scope="col">Administrate</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="user in userList"
                    :key="user.id" 
                    :class="user.id == currentUser.id ? 'active' : ''">
                    <th>
                      {{ user.id }}
                    </th>
                    <td>{{ user.username }}</td>
                    <td>{{ user.email }}</td>
                    <td >
                      <span class="badge" :class="user.role_id == 3 ? 'badge-warning' : (user.role_id == 2 ? 'badge-info' : '')">
                        {{ getRoleLabelFromId(user.role_id) }}
                      </span>
                    </td>
                    <td>{{ getTeamLabelFromId(user.team_id) }}</td>
                    <td>
                      <div v-if="user.id != currentUser.id">
                        <router-link class="no-link" :to="{name: 'admin/edit', params:{id: user.id}}">
                          <v-icon style="color:#FFFFFF">edit</v-icon>
                        </router-link>
                        <v-icon style="color:#FFFFFF" @click="deleteUserById(user.id)">delete</v-icon>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div v-else>
              <table class="table table-hover">
                  <thead>
                    <tr>
                      <th scope="col">#</th>
                      <th scope="col">Name</th>
                      <th scope="col">Members</th>
                      <th scope="col">Administrate</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="team in teamList"
                      :key="team.id">
                      <th scope="row">{{ team.id }}</th>
                      <td>{{ team.name }}</td>
                      <td>{{ team.user.length }}</td>
                      <td>
                        <router-link class="no-link" :to="{name: 'admin/team/management', params:{id: team.id}}">
                          <v-icon style="color:#FFFFFF">alarm</v-icon>
                        </router-link>
                        <router-link class="no-link" :to="{name: 'admin/team/edit', params:{id: team.id}}">
                          <v-icon style="color:#FFFFFF">edit</v-icon>
                        </router-link>
                        <v-icon style="color:#FFFFFF" v-if="team.user.length==0" @click="deleteTeamById(team.id)">delete</v-icon>
                      </td>
                    </tr>
                    <tr>
                      <th scope="row">{{ teamList[teamList.length-1].id + 1 }}</th>
                      <td>
                        <input v-model="newTeam.name" type="text" placeholder="Enter name">
                      </td>
                      <td>-</td>
                      <td>
                        <v-icon style="color:#FFFFFF" @click="createNewTeam()">add</v-icon>
                      </td>
                    </tr>
                  </tbody>
                </table>
            </div>
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
import { adminService } from '../../_services';

export default {
  name: 'admin',
  components: {
  },
  created () {
    this.getTeamList();
    this.refreshInterval = setInterval(this.getTeamList,5000);
  },
  destroyed () {
      clearInterval(this.refreshInterval);
  },
  data () {
    return {
      selectedOption: 1,
      refreshInterval: null,
      newTeam: {
        name: ''
      },
    }
  },
  computed: {
    ...mapGetters('user_store', ['currentUser']),
    ...mapGetters('manager_store', ['teamList']),
    userList() {
      let list = [];
      for(let team of this.teamList) {
        for(let user of team.user) {
          list.push(user);
        }
      }
        return _.sortBy(list, 'id');
    }
  },
  methods: {
    ...mapActions('manager_store', ['getFullTeamList', 'deleteTeam', 'postNewTeam']),
    ...mapActions('admin_store', ['deleteUser']),
    getTeamList() {
      this.getFullTeamList();
    },
    deleteUserById(id) {
      let confirmUser = window.confirm("Are you sure you want to delete your account?");
      if (confirmUser) {
        this.deleteUser(id);
        setTimeout(this.getFullUserList, 1000);
      }
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
    createNewTeam() {
      let team = {
        'name': this.newTeam.name,
        'id': this.teamList[this.teamList.length-1].id + 1
      }
      this.postNewTeam(team) 
      this.$notify({
        title: 'Done',
        text: "Team " + this.newTeam.name + 'created',
        type: 'success',
        closeOnClick: true
      })
      this.newTeam.name = '';
    },
    deleteTeamById(teamID) {
      let index = null;
      for (let i=0; i<this.teamList.length; i++) {
        if (this.teamList[i].id == teamID){
          index = i;
          break;
        }
      }
      let payload = {
        'index': index,
        'id': teamID
      }
      this.deleteTeam(payload);
    }
  }
};
</script>
