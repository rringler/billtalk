import _ from 'lodash';
import { FETCH_MEASURE } from 'components/Client/types';

export function Measure(state = {}, action) {
  switch (action.type) {
  case FETCH_MEASURE:
    return action.payload.data.data;
  default:
    return state;
  }
}
