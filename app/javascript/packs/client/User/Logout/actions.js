import { LOGOUT_USER } from 'packs/client/types';

export function logoutUser() {
  return {
    type: LOGOUT_USER
  };
}
