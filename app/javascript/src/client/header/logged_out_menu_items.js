import React, { Component } from 'react';
import { Nav, NavItem } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';

import SessionsNewCompact from 'sessions/new_compact';
import NavbarDropdownForm from 'lib/navbar_dropdown';

export default class LoggedOutMenuItems extends Component {
  render() {
    const { eventKey } = this.props;

    return (
      <Nav>
        <NavbarDropdownForm eventKey={eventKey} title='Login'>
          <SessionsNewCompact />
        </NavbarDropdownForm>
        <LinkContainer to="/signup">
          <NavItem eventKey={eventKey + 1}>Sign up</NavItem>
        </LinkContainer>
      </Nav>
    );
  }
}
