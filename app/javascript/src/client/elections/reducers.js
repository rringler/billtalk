import _ from 'lodash';
import { FETCH_ELECTION, FETCH_ELECTIONS } from '../types';

export default function(state = {}, action) {
  switch (action.type) {
  case FETCH_ELECTION:
    return { ...state, [action.payload.data.id]: action.payload.data };
  case FETCH_ELECTIONS:
    return _.mapKeys(action.payload.data, 'id');
  default:
    return state;
  }
}
