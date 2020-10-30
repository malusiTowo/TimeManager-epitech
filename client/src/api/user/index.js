import axios from 'axios'
import { userIdIdentifier } from '../../routes/router';

const host = process.env.NODE_ENV === 'production' ? 'https://timemanager-server.herokuapp.com' : 'http://localhost:4000';
const baseUrl = `${host}/api/users`;
const headers = {
  'Content-Type': 'application/json'
}


export const removeUserFromLocalStorage = () => {
  localStorage.removeItem(userIdIdentifier)
  localStorage.removeItem('user')
}

export const setUserToLocalStorage = (user, userId) => {
  localStorage.setItem('user', JSON.stringify(user))
  localStorage.setItem(userIdIdentifier, userId)
}

export const getUserFromLocalStorage = () => {
  const userId = localStorage.getItem(userIdIdentifier)
  let user = null;
  try {
    user = JSON.parse(localStorage.getItem('user'));
  } catch (err) {
    console.log("err", err)
  }
  return {
    userId,
    user,
    userLoggedIn: user !== null
  }
}

export const getUserId = () => {
  
  let id = null;

  if (id = getUserFromLocalStorage()['user']['id'])
    return id;
  else
    return "";

}


export const getUsers = async () => {
  try {
    const response = await axios.get(`${baseUrl}`);
    const users = response.data.data;
    return users;
  } catch (err) {
    console.log("err", err);
  }
  return [];
}

export const getUserByUserNameAndEmail = async (userName, email) => {
  try {
    const response = await axios.get(`${baseUrl}?username=${userName}&email=${email}`, { headers });
    const user = response.data.data;
    setUserToLocalStorage(user, user.id)
    return true;
  } catch (err) {
    console.log("err", err);
    return false;
  }
};

export const getUserById = async (userId) => {

  let localUser = getUserFromLocalStorage()['user'];

  if (localUser['id'] == userId) {
    return localUser;
  }

  try {
    const response = await axios.get(`${baseUrl}/${userId}`, { headers });
    const user = response.data.data;
    return user;
  } catch (err) {
    console.log("err", err);
    return false;
  }
};

export const createUser = async (userName, email) => {
  try {
    const response = await axios.post(`${baseUrl}`, {
      user: {
        username: userName,
        email
      },
    })
    const user = response.data.data;
    setUserToLocalStorage(user, user.id)
    return true
  } catch (err) {
    console.log("err", err);
    return false;
  }

}

export const updateUser = async (userId, userName, email) => {

  try {
    const response = await axios.put(`${baseUrl}/${userId}`, {
      user: {
        username: userName,
        email
      }
    })

    if (getUserFromLocalStorage()['user']['id'] == userId){
      const updatedUser = response.data.data;
      setUserToLocalStorage(updatedUser, updatedUser.id)
    }

    return true;

  } catch (err) {
    console.log("err", err);
    return false;
  }

}

export const deleteUser = userId => {
  axios.delete(`${baseUrl}/${userId}`);
  removeUserFromLocalStorage();
};