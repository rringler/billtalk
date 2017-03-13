import React, { Component } from 'react';
import { Nav, Navbar, NavItem } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { Link } from 'react-router';
import { connect } from 'react-redux';
import LoggedInMenuItems from './LoggedInMenuItems';
import LoggedOutMenuItems from './LoggedOutMenuItems';

class Header extends Component {
  render() {
    const { authToken } = this.props;

    return (
      <Navbar inverse collapseOnSelect fixedTop>
        <Navbar.Header>
          <Navbar.Brand>
            <Link to="/">Bill Talk</Link>
          </Navbar.Brand>
          <Navbar.Toggle />
        </Navbar.Header>
        <Navbar.Collapse>
          <Nav pullRight>
            <LinkContainer to="/about">
              <NavItem eventKey={1}>About</NavItem>
            </LinkContainer>
            {authToken ? <LoggedInMenuItems eventKey={2} /> : <LoggedOutMenuItems eventKey={2}/>}
          </Nav>
        </Navbar.Collapse>
      </Navbar>
    );
  }
}

function mapStateToProps({ authToken }) {
  return { authToken };
}

export default connect(mapStateToProps)(Header);
