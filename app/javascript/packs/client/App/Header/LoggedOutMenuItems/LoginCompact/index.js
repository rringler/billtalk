import _ from 'lodash';
import React, { Component, PropTypes } from 'react';
import { Button, FormControl, FormGroup, Navbar } from 'react-bootstrap';
import { Field, reduxForm } from 'redux-form';
import { connect } from 'react-redux';
import { loginUser } from 'packs/client/User/Login/actions';
import { email, required } from 'packs/client/validations';

const FIELDS = {
  email: {
    placeholder: 'Email',
    type:        'email',
    validations: [ required, email ]

  },
  password: {
    placeholder: 'Password',
    type:        'password',
    validations: [ required ]
  }
};

class LoginCompact extends Component {
  static contextTypes = {
    router: PropTypes.object
  };

  onSubmit = (data) => {
    this.props.loginUser(data);
  }

  renderField = ({ placeholder, type, validations }, field) => {
    return (
      <Field name={field}
             id={field}
             placeholder={placeholder}
             component={this.renderInput}
             type={type}
             validate={validations} />
    );
  }

  renderInput = ({ input, placeholder, type, meta }) => {
    const validationState = this.validationState(meta);

    return (
      <FormGroup validationState={validationState}>
        <input {...input} className='form-control'
                          placeholder={placeholder}
                          type={type} />
      </FormGroup>
    );
  }

  validationState = ({ touched, error, warning }) => {
    if (!touched) { return null; }

    return (error && 'error') || (warning && 'warning') || 'success';
  }

  render() {
    const { handleSubmit, submitting } = this.props;

    return (
      <Navbar.Form id='login-compact' onSubmit={this.onFormSubmit}>
        {_.map(FIELDS, this.renderField)}

        <FormGroup>
          <Button type='submit'
                  bsStyle='primary'
                  disabled={submitting}>
            Submit
          </Button>
        </FormGroup>
      </Navbar.Form>
    );
  }
}

const LoginCompactForm = reduxForm({
  form: 'LoginCompactForm'
})(LoginCompact);

export default connect(null, { loginUser })(LoginCompactForm);
