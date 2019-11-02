import Vue from 'vue';
import Vuex from 'vuex';
import { managerService } from '../manager.service';
import  Router  from '../../_services/router';


Vue.use(Vuex);

export const manager_store = {
  namespaced: true,
  state: {
      teamList: [],
      userList: [],
      watchedUser: null,
      watchedUserClockList: [],
      modifiedTeam: null
  },
  mutations: {
    newTeamList(state, list) {
      state.teamList = list;
    },
    newUserList(state, list) {
      state.userList = list;
    },
    newWatchedUser(state, user) {
      state.watchedUser = user;
    },
    newWatchedUserClockList(state, list) {
      state.watchedUserClockList = list;
    },
    addCountToTeam(state, payload) {
      state.teamList[payload.index].count = payload.count
    },
    removeTeam(state, index) {
      state.teamList.splice(index,1);
    },
    pushNewTeam(state, team) {
      state.teamList.push(team)
    },
    newModifiedTeam(state, team) {
      state.modifiedTeam = team;
    },
  },
  actions: {
    getFullTeamList({dispatch, commit}) {
      managerService.getTeamList()
      .then(data => {
        if (data != null) {
          let sortedList = data.data.data.sort((a,b)=>a.id-b.id);
          commit('newTeamList', sortedList);
        }
      });
    },
    getUserFromMyTeam({dispatch, commit}, teamID) {
      managerService.getUsersFromTeam(teamID)
      .then(data => {
        if (data != null) {
            console.log(data)
            commit('newUserList', data.data.data);
        }
      });
    },
    getUserById({dispatch, commit}, userID) {
      managerService.getUserById(userID)
      .then(data => {
        if (data != null) {
            console.log(data)
            commit('newWatchedUser', data.data.data);
        }
      });
    },
    getWatchedUserClockList({dispatch, commit}, userID) {
      managerService.getClocks(userID)
      .then(data => {
        if (data != null) {
          commit('newWatchedUserClockList', data.data.data);
        }
      });
    },
    addCountToTeam({dispatch, commit}, payload) {
      managerService.getNumberOfUserInTeam(payload.id)
      .then(data => {
        if (data != null) {
          let newPayload = {'index': payload.index, 'count': data.data.number[0]}
          commit('addCountToTeam', newPayload);
        }
      });
    },
    postNewTeam({dispatch, commit}, team) {
      console.log(team)
      managerService.postNewTeam(team)
      .then(
      data => {
        commit('pushNewTeam', team);
        return true;
      },
      error => {
        return false;
      })
    },
    deleteTeam({dispatch, commit}, payload) {
      managerService.deleteTeamById(payload.id)
      commit('removeTeam', payload.index);
    },
    getTeamById({dispatch, commit}, id) {
      managerService.getTeamById(id)
      .then(data => {
        if (data != null) {
          commit('newModifiedTeam', data.data.data);
        }
      });
    },
    updateTeam({dispatch, commit}, team) {
      console.log(team)
      managerService.updateTeam(team);
      Vue.notify({
        title: 'Done',
        text: "This team has been edited",
        type: 'success',
        closeOnClick: true
      })
      Router.push('/admin');
    },
  },
  getters: {
    teamList: state => {
      return state.teamList;
    },
    userList: state => {
      return state.userList;
    },
    watchedUser: state => {
      return state.watchedUser;
    },
    watchedUserClockList: state => {
      return state.watchedUserClockList;
    },
    modifiedTeam: state => {
      return state.modifiedTeam;
    },
  }
};
