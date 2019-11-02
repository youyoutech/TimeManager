import { authHeader, globals } from '../_helpers';
import axios from 'axios'

export const userService = {
  register,
  login,
  deleteUser,
  getClocks,
  postClock,
  disconnectUser,
  updateUser,
  getWorkingTimes,
  getTeamMates
};

function register(form) {
  return axios.post(globals.baseUrl + '/register', form)
    .then((response) => {
      if (response.data.meta.token) {
        window.location = "/login";
      }
      return response;
    }).catch((e) => {
    return null;
  });
}

function login(form) {
  return axios.post(globals.baseUrl + '/login', form)
  .then((response) => {
    if (response.data.meta.token) {
      localStorage.setItem('userToken', JSON.stringify(response.data.meta.token));
      localStorage.setItem('user', JSON.stringify(response.data.data));
      window.location = "/";
    }
    return response;
  }).catch((e) => {
    return null;
  })
}

function deleteUser(userID) {
  let payload = {
    headers: authHeader(),
  }
  return axios.delete(globals.baseUrl + '/users/' + userID, payload)
  .then((response) => {
    localStorage.removeItem('userToken');
    localStorage.removeItem('user');
    return response;
  }).catch((e) => {
    return null;
  })
}

function disconnectUser() {
  localStorage.removeItem('userToken');
  localStorage.removeItem('user');
}

function updateUser(userID, newUser) {
  let payload = {
    headers: authHeader(),
  }
  return axios.put(globals.baseUrl + '/users/' + userID, newUser, payload)
  .then((response) => {
    localStorage.setItem('user', JSON.stringify(response.data.data));
    return response;
  })
  .catch((e) => {
    console.log(e)
    return null;
  })
}

function getClocks(userID) {
  let payload = {
    headers: authHeader(),
  }
  return axios.get(globals.baseUrl + '/clock/' + userID, payload)
  .then((response) => {
    return response;
  })
  .catch((e) => {
    return null;
  });
}

function postClock(clock) {
  let payload = {
    headers: authHeader(),
  }
  return axios.post(globals.baseUrl + '/clock/', clock ,payload)
  .then((response) => {
    return response;
  })
  .catch((e) => {
    return null;
  });
}

function getWorkingTimes(userID) {
  let payload = {
    headers: authHeader(),
  }
  return axios.get(globals.baseUrl + '/workingtime/' + userID + '/all', payload)
  .then((response) => {
    return response;
  })
  .catch((e) => {
    return null;
  });
}

function getTeamMates(userID) {
  let payload = {
    headers: authHeader(),
  }
  return axios.get(globals.baseUrl + '/users/' + userID + '/team', payload)
  .then((response) => {
    return response;
  })
  .catch((e) => {
    return null;
  });
}