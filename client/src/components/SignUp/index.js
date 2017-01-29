import React, { PropTypes, Component } from 'react';
import classnames from 'classnames';

import './style.css';

export default class SignUp extends Component {
  // static propTypes = {}
  // static defaultProps = {}
  // state = {}

  render() {
    const { className, ...props } = this.props;

    return (
      <div className={classnames('SignUp', className)} {...props}>
        <h1>Sign up</h1>

        // Form
      </div>
    );
  }
}
