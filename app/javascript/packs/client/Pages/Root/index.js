import React, { Component } from 'react';
import { LinkContainer } from 'react-router-bootstrap';
import logo from './logo.svg';
import './style.scss';

export default class Root extends Component {
  render() {
    return (
      <div className='root'>
        <div className='header'>
          <img src={logo} className='logo' alt='logo' />
          <h2>Welcome to React</h2>
        </div>

        <p className='intro'>
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>

        <LinkContainer to='/states'>
          <h4>Browse States</h4>
        </LinkContainer>
      </div>
    );
  }
}
