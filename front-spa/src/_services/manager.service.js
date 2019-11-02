import { authHeader, globals } from '../_helpers';
import axios from 'axios'

export const managerService = {
    getTeamList,
    getUsersFromTeam,
    getUserById,
    getClocks,
    getNumberOfUserInTeam,
    deleteTeamById,
    postNewTeam,
    getTeamById,
    updateTeam
};

function getTeamList() {
    let payload = {
        headers: authHeader(),
    }
    return axios.get(globals.baseUrl + '/team', payload)
    .then((response) => {
        return response;
    })
    .catch((e) => {
        return null;
    });
}

function getUsersFromTeam(teamID) {
    let payload = {
        headers: authHeader(),
    }
    return axios.get(globals.baseUrl + '/manager/team/' + teamID, payload)
    .then((response) => {
        return response;
    })
    .catch((e) => {
        return null;
    });
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

function getNumberOfUserInTeam(teamID) {
    let payload = {
        headers: authHeader(),
    }
    return axios.get(globals.baseUrl + '/admin/team/' + teamID + '/count', payload)
    .then((response) => {
        return response;
    })
    .catch((e) => {
        console.log(e)
        return null;
    })
}


function deleteTeamById(teamID) {
    let payload = {
        headers: authHeader(),
    }
    return axios.delete(globals.baseUrl + '/team/' + teamID, payload)
    .then((response) => {
        return response;
    })
    .catch((e) => {
        console.log(e)
        return null;
    })
}

function postNewTeam(team) {
    let payload = {
        headers: authHeader(),
    }
    return axios.post(globals.baseUrl + '/team/', team, payload)
    .then((response) => {
        return response;
    })
    .catch((e) => {
        return null;
    })
}

function getTeamById(teamID) {
    let payload = {
        headers: authHeader(),
    }
    return axios.get(globals.baseUrl + '/team/' + teamID, payload)
    .then((response) => {
        return response;
    })
    .catch((e) => {
        return null;
    })
}

function updateTeam(team) {
    console.log(team);
    let payload = {
        headers: authHeader(),
    }
    return axios.put(globals.baseUrl + '/team/' + team.id, team, payload)
    .then((response) => {
        return response;
    })
    .catch((e) => {
        return null;
    })
}
