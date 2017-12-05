import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import ReduxPromise from 'redux-promise';

import router from './router';
import reducers from './reducers';

import './style.scss';

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
