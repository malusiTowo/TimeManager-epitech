import axios from 'axios'
import moment from "moment-timezone";

import { buildHeaders } from '../user';

const host = process.env.VUE_APP_BACKEND_URL;
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
    time = moment(time).format("YYYY-MM-DD HH:MM:ss");
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

