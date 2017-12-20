import _ from 'lodash';
import { FETCH_STATE, FETCH_STATES } from '../types';

export default function(state = {}, action) {
  switch (action.type) {
  case FETCH_STATE:
    return { ...state, [action.payload.data.id]: action.payload.data };
  case FETCH_STATES:
    return _.mapKeys(action.payload.data, 'id');
  default:
    return state;
  }
}
