import axios from 'axios';
import { FETCH_MEASURE } from 'packs/client/types';

export function fetchMeasure(id) {
  const url     = `/api/v1/measures/${id}`;
  const request = axios.get(url);

  return {
    type:    FETCH_MEASURE,
    payload: request
  };
}
