import React, { Component } from 'react';
import logo from './logo.svg';

export default class Root extends Component {
  render() {
    return (
      <div className='root'>
        <div className='App-header'>
          <img src={logo} className='App-logo' alt='logo' />
          <h2>Welcome to React</h2>
        </div>

        <p className='App-intro'>
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
      </div>
    );
  }
}
