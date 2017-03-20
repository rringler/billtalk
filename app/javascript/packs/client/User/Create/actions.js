import axios from 'axios';
import { CREATE_USER } from 'packs/client/types';

export function createUser({ email, password, tos }) {
  const url = '/api/v1/users';
  const request = axios.post(url, {
    user: {
      email:                 email,
      password:              password,
      password_confirmation: password,
      accepts_tos:           tos
    }
  });

  return {
    type:    CREATE_USER,
    payload: request
  };
}
