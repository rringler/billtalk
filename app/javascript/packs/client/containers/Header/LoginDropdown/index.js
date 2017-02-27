import React, { Component } from 'react';
import { Button, FormControl, FormGroup, Navbar, NavDropdown } from 'react-bootstrap';
import { connect } from 'react-redux';
import { loginUser } from '../../../actions/session';

class LoginDropdown extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email:      '',
      password:   '',

      _dropdownOpen: false,
    };
  }

  onDropdownToggle = (newState, _event, { source }) => {
    if (!newState && source === 'rootClose') {
      this.setState({ _dropdownOpen: false });
    }
    else {
      this.setState({ _dropdownOpen: true });
    }
  }

  onEmailChange = (event) => {
    this.setState({ email: event.target.value });
  }

  onPasswordChange = (event) => {
    this.setState({ password: event.target.value });
  }

  onFormSubmit = (event) => {
    event.preventDefault();

    this.props.loginUser(
      this.state.email,
      this.state.password
    );
  }

  render() {
    return (
      <NavDropdown eventKey={2}
                   title="Login"
                   id="nav-login-dropdown"
                   open={this.state._dropdownOpen}
                   onToggle={this.onDropdownToggle}>
        <Navbar.Form onSubmit={this.onFormSubmit}>
          <FormGroup>
            <FormControl type="text" placeholder="email" />
          </FormGroup>
          <FormGroup>
            <FormControl type="password" placeholder="password" />
          </FormGroup>
          <FormGroup>
            <Button type='submit' bsStyle='primary'>
              Submit
            </Button>
          </FormGroup>
        </Navbar.Form>
      </NavDropdown>
    );
  }
}

export default connect(null, { loginUser })(LoginDropdown);
