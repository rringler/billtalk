import _ from 'lodash';
import { FETCH_MEASURE, FETCH_MEASURES } from 'types';

export default function(state = {}, action) {
  switch (action.type) {
  case FETCH_MEASURE:
    return { ...state, [action.payload.data.id]: action.payload.data };
  case FETCH_MEASURES:
    return _.mapKeys(action.payload.data, 'id');
  default:
    return state;
  }
}
