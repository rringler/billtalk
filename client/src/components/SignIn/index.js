import React, { PropTypes, Component } from 'react';
import classnames from 'classnames';

import './style.css';

export default class SignIn extends Component {
  // static propTypes = {}
  // static defaultProps = {}
  // state = {}

  render() {
    const { className, ...props } = this.props;

    return (
      <div className={classnames('SignIn', className)} {...props}>
        <h1>Sign in</h1>
      </div>
    );
  }
}
