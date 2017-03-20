import React, { Component } from 'react';
import { Nav, NavItem } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import LoginCompact from './LoginCompact';
import NavbarDropdownForm from './NavbarDropdownForm';

export default class LoggedOutMenuItems extends Component {
  render() {
    const { eventKey } = this.props;

    return (
      <Nav>
        <NavbarDropdownForm eventKey={eventKey} title='Login'>
          <LoginCompact />
        </NavbarDropdownForm>
        <LinkContainer to="/signup">
          <NavItem eventKey={eventKey + 1}>Sign up</NavItem>
        </LinkContainer>
      </Nav>
    );
  }
}
