import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';

import electionsReducer from './elections/reducers';
import measuresReducer  from './measures/reducers';
import sessionReducer   from './sessions/reducers';
import statesReducer    from './states/reducers';

export default combineReducers({
  form:      formReducer,
  session:   sessionReducer,
  elections: electionsReducer,
  measures:  measuresReducer,
  states:    statesReducer,
});
