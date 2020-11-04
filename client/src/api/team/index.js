import axios from 'axios'
import moment from 'moment';
import { buildHeaders } from '../user';

const host = process.env.NODE_ENV === 'production' ? 'https://timemanager-server.herokuapp.com' : 'http://localhost:4000';

const baseUrl = `${host}/api/teams`;
const baseUrlUsers = `${host}/api/team_users`;


/* Team */

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
      },
      {headers: buildHeaders()}
      );
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



export const updateTeam = async (form) => {

  if (!(form && form.id)){
    return null;
  }

  console.log(form);
  try {
    const response = await axios.put(`${baseUrl}/${form.id}`, 
      {
        team: {
          name: form.name,
          description: form.description
        }
      },
      {headers: buildHeaders()}
    );
    return response;
  } catch (err) {
    console.log("err", err);
  }

  return {};
}


/****  Team Users  ****/

export const getTeamUsers = async (teamId) => {
  try {
    const response = await axios.get(`${baseUrlUsers}?teamId=${teamId}`, { headers: buildHeaders() });
    const team = response.data.data;
    return team;
  } catch (err) {
    console.log("err", err)
  }
  return null;
}

export const getUserTeams = async (userId) => {
  

  try {
    const response = await axios.get(`${baseUrlUsers}?userId=${userId}`, { headers: buildHeaders() });
    const team = response.data.data;
    return team;
  } catch (err) {
    console.log("err", err)
  }
  return null;
}

export const addTeamUser = async (form) => {
  try {
    await axios.post(`${baseUrlUsers}`, {
      team_user: {
        user: form.user,
        team: form.team,
        role: form.role
      }
    },
    {headers: buildHeaders()});
    return true;
  } catch (err) {
    console.log("err", err);
    return false;
  }
}

export const deleteTeamUser = async (id) => {
  try {
    const response = await axios.delete(`${baseUrlUsers}/${id}`, { headers: buildHeaders() });
    return response;
  } catch (err) {
    console.log("err", err);
  }
  return true;
}


export const updateTeamUser = async (form) => {

  if (!(form && form.id)){
    return null;
  }
  
  try {
    const response = await axios.put(`${baseUrlUsers}/${form.id}`, 
      {
        team_user: {
          role: form.role
        }
      },
      {headers: buildHeaders()}
    );
    return response;
  } catch (err) {
    console.log("err", err);
  }

  return {};
}



