import axios from 'axios';
import { FETCH_ELECTION, FETCH_ELECTIONS } from 'types';

export function fetchElection(id) {
  const url     = `/api/v1/elections/${id}`;
  const request = axios.get(url);

  return {
    type:    FETCH_ELECTION,
    payload: request
  };
}

export function fetchElections() {
  const url     = '/api/v1/elections';
  const request = axios.get(url);

  return {
    type:    FETCH_ELECTIONS,
    payload: request
  };
}
