import React, { Component } from 'react';
import { Nav, Navbar, NavItem } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
import LoggedInMenuItems from './logged_in_menu_items';
import LoggedOutMenuItems from './logged_out_menu_items';

class Header extends Component {
  renderConditionalMenuItems = (eventKey) => {
    const { token } = this.props;

    if (token) {
      return (<LoggedInMenuItems eventKey={eventKey} />);
    } else {
      return (<LoggedOutMenuItems eventKey={eventKey} />);
    }
  }

  render() {
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
            {this.renderConditionalMenuItems(2)}
          </Nav>
        </Navbar.Collapse>
      </Navbar>
    );
  }
}

function mapStateToProps({ session: { token } }) {
  return { token };
}

export default connect(mapStateToProps)(Header);
