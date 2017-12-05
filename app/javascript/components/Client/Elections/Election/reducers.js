import _ from 'lodash';
import { FETCH_ELECTION } from 'components/Client/types';

const null_election = {
  data: {
    attributes: {}
  },
  included: []
};

export function Election(state = null_election, action) {
  switch (action.type) {
  case FETCH_ELECTION:
    return action.payload.data;
  default:
    return state;
  }
}
