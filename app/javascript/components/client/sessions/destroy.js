import React, { Component } from 'react';
import { connect } from 'react-redux';
import { destroySession } from './actions';

class SessionDestroy extends Component {
  componentWillMount() {
    this.props.destroySession();
    this.props.history.push('/');
  }

  render() {
    return <div></div>;
  }
}

export default connect(null, { destroySession })(SessionDestroy);
