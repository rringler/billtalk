import React, { Component } from 'react';
import Header from './Header';
import './style.scss';

export default class App extends Component {
  render() {
    return (
      <div className='app'>
        <Header />

        <div className='content'>
          {this.props.children}
        </div>
      </div>
    );
  }
}
