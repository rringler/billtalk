import React, { Component } from 'react';
import { connect } from 'react-redux';
import { logoutUser } from './actions';

class Logout extends Component {
  componentWillMount() {
    this.props.logoutUser();
    this.props.history.push('/');
  }

  render() {
    return (
      <div></div>
    );
  }
}

export default connect(null, { logoutUser })(Logout);
