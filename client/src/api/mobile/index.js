

import axios from 'axios';
import {getUsers, buildHeaders} from '../user';

const host = process.env.VUE_APP_BACKEND_URL;
const baseUrl = `${host}/api/users`;

export const isMobile = () => {
    return (typeof device !== 'undefined' && device.available === true)
};

export const LocalStorageData = () => {
    return localStorage;
}

//isUpdate = true si bdd; false si local 
export function setLocalStorageData() {
    
    let isUpdate = false;
    let table = "users";
    let data = null;

    try {
        const response = axios.get(`${baseUrl}`, { headers: buildHeaders() });
        data = response;
      } catch (err) {
        console.log("err", err);
      }

    console.log(baseUrl);
    
    localStorage.setItem(table, JSON.stringify(data));

}

