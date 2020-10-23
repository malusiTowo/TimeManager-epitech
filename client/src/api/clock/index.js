import axios from 'axios'
import { getWorkingTimesBetweenDates } from '../workingtime';

const baseUrl = 'http://localhost:4000/api/clocks';
const headers = {
  'Content-Type': 'application/json'
}

const months = [
  "jan",
  "feb",
  "march",
  "april",
  "may",
  "june",
  "july",
  "aug",
  "sept",
  "oct",
  "nov",
  "dec"
];

export const getClocksAndWorkingTimesComparison = async (userId, start, end) => {
  const base = {};
  const clocks = await getUserClocks(userId);
  const times = await getWorkingTimesBetweenDates(userId, start, end);

  months.map((m) => (base[m] = { clocks: [], times: [] }));

  clocks.map((c) => {
    let a = moment(c.time).month();
    let key = months[a];
    base[key].clocks.push(c);
  });

  times.map((t) => {
    let a = moment(t.start).month();
    let key = months[a];
    base[key].times.push(t);
  });

  Object.keys(base).map((val, key) => {
    const t = base[val]
    if (t.clocks.length === 0 && t.times.length === 0) delete base[val]
  })

  return base;
}


export const getUserClocks = async userId => {
  try {
    const response = await axios.get(`${baseUrl}/${userId}`);
    const clocks = response.data.data;
    return clocks;
  } catch (err) {
    alert('An error occured. try again later.')
    console.log("err", err)
  }
  return [];
}