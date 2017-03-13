import React, { Component } from 'react';
import { NavDropdown } from 'react-bootstrap';

export default class NavbarDropdownForm extends Component {
  constructor(props) {
    super(props);

    this.state = { _open: false };
  }

  onDropdownToggle = (newState, _, { source }) => {
    if (!newState && source === 'rootClose') {
      this.setState({ _open: false });
    }
    else {
      this.setState({ _open: true });
    }
  }

  render() {
    const { eventKey, id, title } = this.props;
    const { _open }               = this.state;

    return (
      <NavDropdown eventKey={eventKey}
                   title={title}
                   id={id}
                   open={_open}
                   onToggle={this.onDropdownToggle}>
        {this.props.children}
      </NavDropdown>
    );
  }
}
