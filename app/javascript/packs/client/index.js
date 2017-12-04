import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import ReduxPromise from 'redux-promise';

import router from './router';
import reducers from './reducers';

const createStoreWithMiddleware = applyMiddleware(ReduxPromise)(createStore);

export default class Client extends Component {
  render() {
    return (
      <Provider store={createStoreWithMiddleware(reducers)}>
        {router}
      </Provider>
    );
  }
}
