import Vue from 'vue';
import Vuex from 'vuex';
import { userService } from '../user.service';
import  Router  from '../../_services/router';

Vue.use(Vuex);

const user = JSON.parse(localStorage.getItem('user'));
const initialState = user ? 
  {
    currentUser: user,
    userConnected: true,
    clockList: null,
    workingTimeList: null,
    nextClockStatus: true,
    teamMates: null,
  } : {
    currentUser: null,
    userConnected: false,
    workingTimeList: null,
    clockList: null,
    nextClockStatus: true,
    teamMates: null
  }
export const user_store = {
  namespaced: true,
  state: initialState,
  mutations: {
    newUser(state, user) {
      state.currentUser = user;
      state.userConnected = true;
    },
    deleteUser(state) {
      state.currentUser = null;
      state.userConnected = false;
      state.clockList = null;
    },
    newClockList(state, clock) {
      state.clockList = clock;
    },
    newWorkingTimeList(state, list) {
      state.workingTimeList = list;
    },
    nextClockStatus(state, status) {
      state.nextClockStatus = status
    },
    newTeamMates(state, list) {
      state.teamMates = list;
    },
  },
  actions: {
    register({dispatch, commit}, form) {
      userService.register(form)
        .then(data => {
        if (data != null) {
          Vue.notify({
            title: 'Register succes',
            text: "User created",
            type: 'success',
            closeOnClick: true
          })
          Router.push('/login');
        }
      },
      error => {
        Vue.notify({
          title: 'Register failed',
          text: "Might be a network issue?",
          type: 'error',
          closeOnClick: true
        })
      })
    },
    login({dispatch, commit}, user) {
      userService.login(user)
      .then(data => {
        if (data != null) {
          commit('newUser', data.data.data);
          Vue.notify({
            title: 'Connected',
            text: "Connected as " + data.data.data.username,
            type: 'success',
            closeOnClick: true
          })
          userService.getClocks(data.data.data.id)
          .then(data => {
            if (data != null) {
              commit('newClockList', data.data.data);
              commit('nextClockStatus', data.data.data.length ? (!data.data.data[data.data.data.length-1].status) : true);
            }
          })
          Router.push('/');
        } else {
          Vue.notify({
            title: 'Wrong Email/Password',
            text: "Something went wrong",
            type: 'error',
            closeOnClick: true
          })
        }
      })
    },
    deleteUser({dispatch, commit}, userID) {
      userService.deleteUser(userID);
      commit('deleteUser');
      Vue.notify({
        title: 'Account removed',
        text: "You will be redirect to menu",
        type: 'success',
        closeOnClick: true
      })
      Router.push('/');
    },
    disconnectUser({dispatch, commit}) {
      userService.disconnectUser();
      commit('deleteUser');
      Vue.notify({
        title: 'Disconnected',
        text: "You will be redirect to menu",
        type: 'success',
        closeOnClick: true
      })
      Router.push('/');
    },
    fetchClockListAtReload({dispatch, commit}, userID) {
      userService.getClocks(userID)
      .then(data => {
        if (data != null) {
          commit('newClockList', data.data.data);
          commit('nextClockStatus', data.data.data.length ? (!data.data.data[data.data.data.length-1].status) : true );
        }
      });
    },
    fetchClockList({dispatch, commit}, userID) {
      userService.getClocks(userID)
      .then(data => {
        if (data != null) {
          commit('newClockList', data.data.data);
        }
      });
    },
    fetchWorkingTimeList({dispatch, commit}, userID) {
      userService.getWorkingTimes(userID)
      .then(data => {
        if (data != null) {
          commit('newWorkingTimeList', data.data.data);
        }
      });
    },
    updateUser({dispatch, commit}, newUser) {
      userService.updateUser(newUser.id, newUser)
      .then(data => {
        if (data != null) {
          commit('newUser', data.data.data);
          Vue.notify({
            title: 'Success',
            text: "Account updated",
            type: 'success',
            closeOnClick: true
          })
        }
      })
    },
    fetchTeamMates({dispatch, commit}, userID) {
      userService.getTeamMates(userID)
      .then(data => {
        if (data != null) {
          commit('newTeamMates', data.data.data);
        }
      });
    },
    postNewClock({dispatch, commit}, clock) {
      userService.postClock(clock);
    },
    newClockList({dispatch, commit}, clock) {
      commit('newClockList', clock);
    },
    setNextClockStatus({dispatch, commit}, status) {
      commit('nextClockStatus', status);
    }
  },
  getters: {
    currentUser: state => {
      return state.currentUser;
    },
    clockList: state => {
      return state.clockList;
    },
    workingTimeList: state => {
      return state.workingTimeList;
    },
    nextClockStatus: state => {
      return state.nextClockStatus;
    },
    teamMates: state => {
      return state.teamMates;
    }
  }
};
