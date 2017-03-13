import _ from 'lodash';
import {
  LOGIN_USER,
  LOGOUT_USER,
  REGISTER_USER
} from '../actions/types';

export default function(state = null, action) {
  console.log('Action received: ', action);

  switch (action.type) {
  case LOGIN_USER:
    return { ...state, auth_token: action.payload.token }
  case LOGOUT_USER:
    return _.omit(state, 'auth_token')
  case REGISTER_USER:
    return { ...state, auth_token: action.payload.data.data.attributes.token }
  default:
    return state
  }
}
