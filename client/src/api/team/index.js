import axios from 'axios'
import moment from 'moment';
import { buildHeaders } from '../user';

const host = process.env.NODE_ENV === 'production' ? 'https://timemanager-server.herokuapp.com' : 'http://localhost:4000';
const baseUrl = `${host}/api/teams`;


export const getTeams = async () => {
  try {
    const response = await axios.get(`${baseUrl}`, { headers: buildHeaders() });
    const teams = response.data.data;
    return teams;
  } catch (err) {
    console.log("err", err)
  }
  return null;
}

export const getTeamById = async (teamId) => {
  try {
    const response = await axios.get(`${baseUrl}/${teamId}`, { headers: buildHeaders() });
    const team = response.data.data;
    return team;
  } catch (err) {
    console.log("err", err)
  }
  return null;
}


export const createTeam = async (name, description) => {
    try {
      await axios.post(`${baseUrl}`, {
        team: {
          name,
          description
        }
      });
      return true;
    } catch (err) {
      console.log("err", err);
      return false;
    }
}

export const deleteTeam = async (teamId) => {
  try {
    const response = await axios.delete(`${baseUrl}/${teamId}`, { headers: buildHeaders() });
    return response;
  } catch (err) {
    console.log("err", err);
  }
  return true;
}