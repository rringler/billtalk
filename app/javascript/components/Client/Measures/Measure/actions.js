import axios from 'axios';
import { FETCH_MEASURE } from 'components/Client/types';

export function fetchMeasure(id) {
  const url     = `/api/v1/measures/${id}`;
  const request = axios.get(url);

  return {
    type:    FETCH_MEASURE,
    payload: request
  };
}
