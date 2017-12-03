import axios from 'axios';
import { FETCH_ELECTION } from 'packs/client/types';

export function fetchElection(id) {
  const url     = `/api/v1/elections/${id}`;
  const request = axios.get(url);

  return {
    type:    FETCH_ELECTION,
    payload: request
  };
}