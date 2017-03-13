import axios from 'axios';
import { REGISTER_USER } from './types';

export function registerUser({ email, password, tos }) {
  const URL = '/api/v1/users';
  const request = axios.post(URL, {
    user: {
      email:                 email,
      password:              password,
      password_confirmation: password,
      accepts_tos:           tos
    }
  });

  return {
    type:    REGISTER_USER,
    payload: request
  };
}
