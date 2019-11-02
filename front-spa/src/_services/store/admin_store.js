import Vue from 'vue';
import Vuex from 'vuex';
import { adminService } from '../admin.service';
import  Router  from '../../_services/router';


Vue.use(Vuex);

export const admin_store = {
  namespaced: true,
  state: {
      userList: [],
      modifiedUser: null
  },
  mutations: {
    newUserList(state, list) {
      state.userList = list;
    },
    newModifiedUser(state, user) {
      state.modifiedUser = user;
    },
  },
  actions: {
    getFullUserList({dispatch, commit}) {
      adminService.getFullUserList()
      .then(data => {
        if (data != null) {
            let sortedList = data.data.data.sort((a,b)=>a.id-b.id);
            commit('newUserList', sortedList);
        }
      });
    },
    deleteUser({dispatch, commit}, userID) {
      adminService.deleteUserById(userID);
      Vue.notify({
        title: 'Done',
        text: "This user has been removed",
        type: 'success',
        closeOnClick: true
      })
    },
    editUser({dispatch, commit}, user) {
      adminService.editUser(user);
      Vue.notify({
        title: 'Done',
        text: "This user has been edited",
        type: 'success',
        closeOnClick: true
      })
      Router.push('/admin');
    },
    getUserById({dispatch, commit}, userID) {
      adminService.getUserById(userID)
      .then(data => {
        if (data != null) {
            commit('newModifiedUser', data.data.data);
        }
      });
    },
    fetchAllUserWithWorkingtime({dispatch, commit}) {
      adminService.getAllUsersWithWorkingtime()
      .then(data => {
        if (data != null) {
            commit('newUserList', data.data.data);
        }
      });
    }
  },
  getters: {
    userList: state => {
      return state.userList;
    },
    modifiedUser: state => {
      return state.modifiedUser;
    },
  }
};
