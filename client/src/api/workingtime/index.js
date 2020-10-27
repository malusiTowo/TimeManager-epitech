import axios from 'axios'
import moment from 'moment';

const host = process.env.NODE_ENV === 'production' ? 'https://timemanager-server.herokuapp.com' : 'http://localhost:4000';
const baseUrl = `${host}/api/workingtimes`;

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


export const deleteWorkingTime = async (workingId) => {
  try {
    const response = await axios.delete(`${baseUrl}/${workingId}`);
    return response;
  } catch (err) {
    console.log("err", err);
  }
  return true;
}

export const updateWorkingTime = async (workingId, start, end) => {
  start = moment(start).format("YYYY-MM-DD hh:mm:ss");
  end = moment(end).format("YYYY-MM-DD hh:mm:ss");
  try {
    const response = await axios.put(`${baseUrl}/${workingId}`, {
      workingtimes: {
        start,
        end
      }
    });
    return response;
  } catch (err) {
    console.log("err", err);
  }
  return {};
}
  
export const createWorkingTimeForUser = async (userId, start, end) => {
  start = moment(start).format("YYYY-MM-DD hh:mm:ss");
  end = moment(end).format("YYYY-MM-DD hh:mm:ss");

  try {
    const response = await axios.post(`${baseUrl}/${userId}`, {
      workingtime: {
        start,
        end
      }
    });
    return response;
  } catch (err) {
    console.log("err", err);
  }
  return {};
}


export const getTimesAndClocksForGraph = (clocks = [], times = []) => {
  const months = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    "december"
  ];

  const base = {};

  months.map((m) => (base[m] = { month: m, clocks: [], times: [] }));

  const seperateClocksAndTimes = (identifier, item) => {
    let a = identifier === 'clocks' ? item.time : item.start;
    a = moment(a).month();
    let key = months[a];
    base[key][identifier].push(item);
  }

  clocks.map((c) => seperateClocksAndTimes('clocks', c));

  times.map((t) => seperateClocksAndTimes('times', t));

  Object.keys(base).map((val) => {
    const t = base[val]
    if (t.clocks.length === 0 && t.times.length === 0) delete base[val]
  })

  Object.keys(base).map((val) => {
    const t = base[val]
    const timesHour = t.times.reduce((acc, { start, end }) => acc + getDiffHours(start, end), 0)
    t.timesHour = timesHour;
  })

  return Object.values(base);
}