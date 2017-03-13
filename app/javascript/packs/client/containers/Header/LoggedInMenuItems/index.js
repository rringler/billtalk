import React, { Component } from 'react';
import { Nav, NavItem } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';

export default class LoggedInMenuItem extends Component {
  render() {
    const { eventKey } = this.props;

    return (
      <Nav>
        <LinkContainer to="/logout">
          <NavItem eventKey={eventKey}>Logout</NavItem>
        </LinkContainer>
      </Nav>
    );
  }
}
