import { authHeader, globals } from '../_helpers';
import axios from 'axios'

export const adminService = {
    getFullUserList,
    deleteUserById,
    getUserById,
    editUser,
    getAllUsersWithWorkingtime
};

function getFullUserList() {
  let payload = {
    headers: authHeader(),
  }
  return axios.get(globals.baseUrl + '/admin/users', payload)
  .then((response) => {
    return response;
  })
  .catch((e) => {
    return null;
  });
}

function deleteUserById(user) {
  let payload = {
    headers: authHeader(),
  }
  return axios.delete(globals.baseUrl + '/users/' + user.id, payload)
  .then((response) => {
    return response;
  }).catch((e) => {
    return null;
  })
}

function getUserById(userID) {
  let payload = {
    headers: authHeader(),
  }
  return axios.get(globals.baseUrl + '/users/' + userID, payload)
  .then((response) => {
    return response;
  }).catch((e) => {
    return null;
  })
}

function editUser(newUser) {
  let payload = {
    headers: authHeader(),
  }
  return axios.put(globals.baseUrl + '/users/' + newUser.id, newUser, payload)
  .then((response) => {
    return response;
  })
  .catch((e) => {
    console.log(e)
    return null;
  })
}

function getAllUsersWithWorkingtime() {
  let payload = {
    headers: authHeader(),
  }
  return axios.get(globals.baseUrl + '/admin/users/clocks', payload)
  .then((response) => {
    return response;
  })
  .catch((e) => {
    console.log(e)
    return null;
  })
}