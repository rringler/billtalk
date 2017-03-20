import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import { AuthToken } from './User/reducers';

const rootReducer = combineReducers({
  authToken: AuthToken,
  form:      formReducer
});

export default rootReducer;
