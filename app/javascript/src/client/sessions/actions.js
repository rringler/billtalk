import axios from 'axios';
import { CREATE_SESSION, DESTROY_SESSION } from 'types';

export function createSession({ email, password }) {
  const url  = '/api/v1/sessions';
  const body = {
    auth: {
      email:    email,
      password: password
    }
  };

  const request = axios.post(url, body)

  return {
    type:    CREATE_SESSION,
    payload: request
  };
}

export function destroySession() {
  return {
    type: DESTROY_SESSION
  };
}
