import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import { composeWithDevTools } from 'redux-devtools-extension';
import ReduxPromise from 'redux-promise';

import router from './router';
import reducers from './reducers';

import './style.scss';

const store = createStore(
  reducers,
  composeWithDevTools(
    applyMiddleware(ReduxPromise)
  )
);

export default class Client extends Component {
  render() {
    return (
      <Provider store={store}>
        {router}
      </Provider>
    );
  }
}
