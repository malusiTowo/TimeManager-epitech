import axios from 'axios'

const host = process.env.NODE_ENV === 'production' ? 'https://timemanager-server.herokuapp.com' : 'http://localhost:4000';
const baseUrl = `${host}/api/clocks`;

const headers = {
  'Content-Type': 'application/json'
}

export const getClockUser = async (userId) => {
  try {
    const response = await axios.get(`${baseUrl}/${userId}`, { headers });
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }
};


export const clock = async (userId) => {
  try {
    const response = await axios.post(`${baseUrl}/${userId}`, {})
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }

}

export const clockForUser = async (userId, time, status) => {
  try {
    const response = await axios.post(`${baseUrl}/${userId}`, {
      time: time,
      status: status
    })
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }

}

export const deleteClockForUser = async (clockId) => {
  try {
    const response = await axios.delete(`${baseUrl}/${clockId}`, {
    })
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }

}


