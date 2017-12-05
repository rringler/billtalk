import axios from 'axios';
import { LOGIN_USER } from 'components/Client/types';

export function loginUser({ email, password }) {
  const url  = '/api/v1/sessions';
  const body = {
    auth: {
      email:    email,
      password: password
    }
  };

  const request = axios.post(url, body);

  return {
    type:    LOGIN_USER,
    payload: request
  };
}
