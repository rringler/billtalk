import axios from 'axios';
import { CREATE_USER } from 'types';

export function createUser({ email, password, tos }) {
  const url  = '/api/v1/users';
  const body = {
    user: {
      email:                 email,
      password:              password,
      password_confirmation: password,
      accepts_tos:           tos
    }
  }

  const request = axios.post(url, body);

  return {
    type:    CREATE_USER,
    payload: request
  };
}
