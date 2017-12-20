import axios from 'axios';
import { FETCH_MEASURE, FETCH_MEASURES } from 'types';

export function fetchMeasure(id) {
  const url     = `/api/v1/measures/${id}`;
  const request = axios.get(url);

  return {
    type:    FETCH_MEASURE,
    payload: request
  };
}

export function fetchMeasures() {
  const url     = '/api/v1/measures';
  const request = axios.get(url);

  return {
    type:    FETCH_MEASURES,
    payload: request
  };
}
