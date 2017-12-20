import React, { Component } from 'react';
import { NavDropdown } from 'react-bootstrap';

export default class NavbarDropdown extends Component {
  constructor(props) {
    super(props);

    this.state = { open: false };
  }

  onDropdownToggle = (newState, _, { source }) => {
    if (!newState && source === 'rootClose') {
      this.setState({ open: false });
    }
    else {
      this.setState({ open: true });
    }
  }

  render() {
    const { eventKey, id, title } = this.props;
    const { open }                = this.state;

    return (
      <NavDropdown
        eventKey={eventKey}
        title={title}
        id={id}
        open={open}
        onToggle={this.onDropdownToggle}
      >
        {this.props.children}
      </NavDropdown>
    );
  }
}
