import _ from 'lodash';
import { FETCH_STATES } from 'packs/client/types';

const null_states = {
  data: []
};

export function States(state = null_states, action) {
  switch (action.type) {
  case FETCH_STATES:
    return action.payload.data;
  default:
    return state;
  }
}
