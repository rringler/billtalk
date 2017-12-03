import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import { AuthToken } from './User/reducers';
import { Election } from './Elections/Election/reducers';
import { Measure } from './Measures/Measure/reducers';
import { States } from './States/States/reducers';
import { State } from './States/State/reducers';

const rootReducer = combineReducers({
  form:      formReducer,
  authToken: AuthToken,
  election:  Election,
  measure:   Measure,
  states:    States,
  state:     State
});

export default rootReducer;
