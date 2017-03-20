import React, { Component } from 'react';
import { Alert } from 'react-bootstrap';

export default class ClosableAlert extends Component {
  constructor(props) {
    super(props);

    this.state = {
      dismissed: false
    };
  }

  dismiss = () => {
    this.setState({ dismissed: true });
  }

  render() {
    if (this.state.dismissed) { return null; }

    return (
      <Alert bsStyle={this.props.bsStyle || 'warning'}
             onDismiss={this.dismiss}>
        {this.props.children}
      </Alert>
    );
  }
}
