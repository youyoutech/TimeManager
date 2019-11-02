export function authHeader() {
    // return authorization header with jwt token
    let userToken = JSON.parse(localStorage.getItem('userToken'));
  
    //If the user is autent return the token, else return empty
    if (userToken) {
      return { 'Authorization': 'Bearer ' + userToken };
    } else {
      return {};
    }
  }
  