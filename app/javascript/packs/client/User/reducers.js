import _ from 'lodash';
import { LOGIN_USER, LOGOUT_USER, CREATE_USER } from 'packs/client/types';

export function AuthToken(state = null, action) {
  console.log('Action received: ', action);

  switch (action.type) {
  case LOGIN_USER:
    return action.payload.data.jwt
  case LOGOUT_USER:
    return null
  case CREATE_USER:
    return action.payload.data.data.attributes.token
  default:
    return state
  }
}
