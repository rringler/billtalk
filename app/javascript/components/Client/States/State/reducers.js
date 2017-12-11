import _ from 'lodash';
import { FETCH_STATE } from 'components/Client/types';

const null_state = {
  data: {
    attributes: {}
  },
  included: []
};

export function State(state = {}, action) {
  switch (action.type) {
  case FETCH_STATE:
    return action.payload.data;
  default:
    return state;
  }
}
