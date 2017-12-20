import _ from 'lodash';
import { CREATE_SESSION, DESTROY_SESSION, CREATE_USER } from 'types';

export default function(state = {}, action) {
  switch (action.type) {
  case CREATE_SESSION:
    return { ...state, token: action.payload.data.data.attributes.token };
  case DESTROY_SESSION:
    return _.omit(state, 'token')
  case CREATE_USER: // This is weird
    return { ...state, token: action.payload.data.data.attributes.token };
  default:
    return state
  }
}
