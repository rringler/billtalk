import axios from 'axios';
import { FETCH_STATE } from 'components/Client/types';

export function fetchState(id) {
  const url     = `/api/v1/states/${id}`;
  const request = axios.get(url);

  return {
    type:    FETCH_STATE,
    payload: request
  };
}
