import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { logoutUser } from './actions';

class Logout extends Component {
  static contextTypes = {
    router: PropTypes.object
  };

  componentWillMount() {
    this.props.logoutUser();
    this.context.router.push('/');
  }

  render() {
    return (
      <div></div>
    );
  }
}

export default connect(null, { logoutUser })(Logout);
