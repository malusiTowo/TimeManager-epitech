import axios from 'axios'
import moment from "moment-timezone";

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
    const response = await axios.post(`${baseUrl}/${userId}`, {
    })
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }

}

export const formatDateForApi = (date) => {
  if (date) {
    return moment.tz(date, "Europe/Paris");
  }
}

export const clockForUser = async (userId, time, status) => {
  time = formatDateForApi(time).utc().format();
  try {
    const response = await axios.post(`${baseUrl}/`, { "userId" : userId,
      "clock" :{
        "time": time,
        "status": status
      }
    });
    return response;
  } catch (err) {
    console.log("err", err);
  }
  return {};
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


