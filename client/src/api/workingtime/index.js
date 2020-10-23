import axios from 'axios'
import moment from 'moment';

const baseUrl = 'http://localhost:4000/api/workingtimes'
const headers = {
  'Content-Type': 'application/json'
}

export const formatDate = (date) => {
  if (date) {
    return moment(date).format('YYYY-MM-DD hh:mm A');
  }
}

export const getDiffHours = (start, end) => {
  const duration = moment.duration(moment(end).diff(moment(start)));
  return duration.asHours();
}


export const getWorkingTimesForUserIdAndWorkingId = async (userId, workingId) => {
  try {
    const response = await axios.get(`${baseUrl}/${userId}/${workingId}`);
    const workingTime = response.data.data;
    return workingTime;
  } catch (err) {
    console.log("err", err)
  }
  return null;
}


export const getWorkingTimesBetweenDates = async (userId, start, end) => {
  try {
    const response = await axios.get(`${baseUrl}/${userId}?start=${start}&end=${end}`);
    const workingTimes = response.data.data;
    return workingTimes;
  } catch (err) {
    console.log("err", err);
  }
  return [];
}