import axios from 'axios'
import moment from "moment";

import { buildHeaders } from '../user';
import { formatDateForApi,utcFormatDateForApi, momentLocal } from '../workingtime'

const host = process.env.NODE_ENV === 'production' ? 'https://timemanager-server.herokuapp.com' : 'http://localhost:4000';

const baseUrl = `${host}/api/clocks`;



export const getClockUser = async (userId) => {
  try {
    const response = await axios.get(`${baseUrl}/${userId}`, {
      headers: buildHeaders()
    });
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }
};


export const clock = async (userId) => {
  try {
    const response = await axios.post(`${baseUrl}/${userId}`, null, {
      headers: buildHeaders()
    })
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }

}


export const adminClockUserIn = async (userId, status, time) => {
  try {
    time = moment(time).local().format("YYYY-MM-DD HH:MM:ss");
    const response = await axios.post(`${baseUrl}/admin/${userId}`, {
      clock: {
        status,
        time
      }
    }, {
      headers: buildHeaders()
    })
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }
}

export const deleteClockForUser = async (clockId) => {
  try {
    const response = await axios.delete(`${baseUrl}/${clockId}`, {
      headers: buildHeaders()
    })
    return response.data.data;
  } catch (err) {
    console.log("err", err);
  }

}


export const clockForUser = async (userId, time, status) => {
  //time = utcFormatDateForApi(time);
  //time = moment.utc(time);
  time = utcFormatDateForApi(momentLocal(time))
  try {
    const response = await axios.post(`${baseUrl}/`, {
      "userId": userId,
      "clock": {
        "time": time,
        "status": status
      }
    },
      {
        headers: buildHeaders()
      }
    );
    return response;
  } catch (err) {
    console.log("err", err);
  }
  return {};
}