import axios from 'axios'
import { userIdIdentifier } from '../../routes/router';


const host = process.env.VUE_APP_BACKEND_URL;
const baseUrl = `${host}/api/users`;


export const buildHeaders = () => {
  const token = localStorage.getItem('user_token');
  return {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}`
  }
}


export const removeUserFromLocalStorage = () => {
  localStorage.removeItem(userIdIdentifier)
  localStorage.removeItem('user')
}

export const setUserToLocalStorage = (user, userId, token = null) => {
  localStorage.setItem('user', JSON.stringify(user))
  if (token)
    localStorage.setItem('user_token', token)
  localStorage.setItem(userIdIdentifier, userId)
}

export const getUserFromLocalStorage = () => {
  const userId = localStorage.getItem(userIdIdentifier)
  const token = localStorage.getItem('user_token')
  let user = null;
  try {
    user = JSON.parse(localStorage.getItem('user'));
  } catch (err) {
    console.log("err", err)
  }
  return {
    userId,
    user,
    token,
    userLoggedIn: user !== null
  }
}


export const getUsers = async () => {
  try {
    const response = await axios.get(`${baseUrl}`, { headers: buildHeaders() });
    const users = response.data.data;
    return users;
  } catch (err) {
    console.log("err", err);
  }
  return [];
}

export const login = async (email, password) => {
  try {
    const response = await axios.post(`${host}/api/sign_in`, {
      session: {
        email,
        password
      }
    });
    const user = response.data.data;
    setUserToLocalStorage(user, user.id, user.token)
    return true;
  } catch (err) {
    console.log("err", err);
    return false;
  }
}

export const signup = async (username, email, password) => {
  try {
    await axios.post(`${host}/api/sign_up`, {
      user: {
        username,
        email,
        password
      }
    });
    return true;
  } catch (err) {
    console.log("err", err);
    return false;
  }
}

export const updateUser = async (userId, username, email) => {
  try {
    const response = await axios.put(`${baseUrl}/${userId}`, {
      user: {
        username,
        email
      }
    },
      {
        headers: buildHeaders(),
      }
    )

    if (getUserFromLocalStorage()['user']['id'] == userId) {
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
  axios.delete(`${baseUrl}/${userId}`, { headers: buildHeaders() });
  removeUserFromLocalStorage();
};

export const getUserById = id => { }