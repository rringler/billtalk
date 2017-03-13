import React, { Component } from 'react';
import Header from '../Header';
import './style.scss';

export default class Layout extends Component {
  render() {
    return (
      <div>
        <Header />

        <div className='layout'>
          {this.props.children}
        </div>
      </div>
    );
  }
}
