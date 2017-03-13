import axios from 'axios';
import { LOGIN_USER, LOGOUT_USER } from './types';

export function loginUser({ email, password }) {
  const URL = '/api/v1/sessions';
  const request = axios.post(URL, {
    auth: {
      email:    email,
      password: password
    }
  });

  return {
    type:    LOGIN_USER,
    payload: request
  };
}

export function logoutUser() {
  return { type: LOGOUT_USER };
}
