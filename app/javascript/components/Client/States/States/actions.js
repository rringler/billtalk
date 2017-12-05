import axios from 'axios';
import { FETCH_STATES } from 'components/Client/types';

export function fetchStates() {
  const url     = '/api/v1/states';
  const request = axios.get(url);

  return {
    type:    FETCH_STATES,
    payload: request
  };
}
