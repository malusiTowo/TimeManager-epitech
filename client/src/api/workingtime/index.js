import axios from 'axios'
import moment from 'moment';
import { buildHeaders } from '../user';

const host = process.env.VUE_APP_BACKEND_URL;
const baseUrl = `${host}/api/workingtimes`;

export const formatDate = (date) => {
  if (date) {
    return moment(date).format('YYYY-MM-DD hh:mm A');
  }
}

export const formatDateForApi = (date) => {
  if (date) {
    return moment(date).format('YYYY-MM-DD HH:mm:ss');
  }
}

export const utcFormatDateForApi = (date) => {
  if (date) {
    return date.utc().format('YYYY-MM-DD HH:mm:ss');
  }
}

export const localFormatDateForApi = (date, formatDate) => {
  if (date) {
    return date.local().format(formatDate);
  }
}

export const momentLocal = (date) => {
  if (date) {
    return moment(date);
  }
}

export const momentUtc = (date) => {
  if (date) {
    return moment.utc(date);
  }
}

export const formatDateFromApi = (date, formatDate) => {
  return localFormatDateForApi(momentUtc(date), formatDate);
}

export const getDiffHours = (start, end) => {
  const duration = moment.duration(moment(end).diff(moment(start)));
  return duration.asHours();
}


export const getWorkingTimesForUserIdAndWorkingId = async (userId, workingId) => {
  try {
    const response = await axios.get(`${baseUrl}/${userId}/${workingId}`, { headers: buildHeaders() });
    const workingTime = response.data.data;
    return workingTime;
  } catch (err) {
    console.log("err", err)
  }
  return null;
}


export const getWorkingTimesBetweenDates = async (userId, start, end) => {


  start = utcFormatDateForApi(momentLocal(start));
  end = utcFormatDateForApi(momentLocal(end));


  let workingTimes = null;
  try {
    const response = await axios.get(`${baseUrl}/${userId}?start=${start}&end=${end}`, { headers: buildHeaders() });
    workingTimes = response.data.data;
  } catch (err) {
    console.log("err", err);
  }

  if (workingTimes) {

    workingTimes.sort(function (a, b) {
      return (a.start > b.start) ? 1 : -1;
    });

    return workingTimes;
  }

  return [];
}


export const deleteWorkingTime = async (workingId) => {
  try {
    const response = await axios.delete(`${baseUrl}/${workingId}`, { headers: buildHeaders() });
    return response;
  } catch (err) {
    console.log("err", err);
  }
  return true;
}

export const updateWorkingTime = async (workingId, start, end) => {

  start = utcFormatDateForApi(momentLocal(start));
  end = utcFormatDateForApi(momentLocal(end));

  try {
    const response = await axios.put(`${baseUrl}/${workingId}`, {
      workingtimes: {
        start,
        end
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

export const createWorkingTimeForUser = async (userId, start, end) => {

  start = utcFormatDateForApi(momentLocal(start));
  end = utcFormatDateForApi(momentLocal(end));

  try {
    const response = await axios.post(`${baseUrl}/${userId}`, {
      workingtime: {
        start,
        end
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

export const checkValidDate = async (newDate) => {

  const newStart = utcFormatDateForApi(momentLocal(newDate.start));
  const newEnd = utcFormatDateForApi(momentLocal(newDate.end));

  const dateApiEnd = utcFormatDateForApi(momentUtc(newEnd).add(2, 'days'));
  const dateApiStart = utcFormatDateForApi(momentUtc(newStart).subtract(2, 'days'));


  let dates = await getWorkingTimesBetweenDates(newDate.idUser, dateApiStart, dateApiEnd);

  //si c'est un update l'id est présent
  if ('id' in newDate) {
    const oldWorkingTime = dates.find(x => x.id == newDate.id);

    if (oldWorkingTime) {
      const index = dates.map(y => {
        return y.Id;
      }).indexOf(oldWorkingTime.id);

      dates.splice(index, 1);
    }
  }

  for (const date of dates) {
    const start = utcFormatDateForApi(momentUtc(date.start));
    const end = utcFormatDateForApi(momentUtc(date.end));

    //check start date
    if (moment(newStart).isAfter(start) && moment(newStart).isBefore(end)) {
      return false;
    }

    //check end date
    if (moment(newEnd).isAfter(start) && moment(newEnd).isBefore(end)) {
      return false;
    }

  }
  return true;
}