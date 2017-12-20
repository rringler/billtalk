import axios from 'axios';
import { FETCH_STATE, FETCH_STATES } from 'types';

export function fetchState(id) {
  const url     = `/api/v1/states/${id}`;
  const request = axios.get(url);

  return {
    type:    FETCH_STATE,
    payload: request
  };
}

export function fetchStates() {
  const url     = '/api/v1/states';
  const request = axios.get(url);

  return {
    type:    FETCH_STATES,
    payload: request
  };
}
