import React, { Component } from 'react';
import Header from '../../containers/Header';
import './style.scss';

export default class App extends Component {
  render() {
    return (
      <div>
        <Header />

        <div className="content">
          {this.props.children}
        </div>
      </div>
    );
  }
}
