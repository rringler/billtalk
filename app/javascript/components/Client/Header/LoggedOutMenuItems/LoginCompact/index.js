import _ from 'lodash';
import React, { Component } from 'react';
import { Button, Col, Form, FormControl, FormGroup } from 'react-bootstrap';
import { reduxForm, Field, SubmissionError } from 'redux-form';
import ClosableAlert from 'components/Client/Lib/ClosableAlert';
import { connect } from 'react-redux';
import { loginUser } from 'components/Client/User/Login/actions';
import { email, required } from 'components/Client/validations';
import './style.scss';

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
  onSubmit = (data) => {
    return this.props.loginUser(data).then(
      null,
      this.onSubmitFail
    );
  }

  onSubmitFail = () => {
    throw new SubmissionError({
      email:    'error',
      password: 'error',
      _error:   'error'
    })
  }

  renderAlert = () => {
    return (
      <ClosableAlert bsStyle='danger'>
        <p>Login failed.</p>
      </ClosableAlert>
    );
  }

  renderField = ({ placeholder, type, validations }, field) => {
    return (
      <Field name={field}
             id={field}
             key={field}
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
        <FormControl.Feedback />
      </FormGroup>
    );
  }

  validationState = ({ touched, error, warning }) => {
    if (!touched) { return null; }

    return (error && 'error') || (warning && 'warning') || 'success';
  }

  render() {
    const { error, handleSubmit, submitting } = this.props;

    return (
      <Form id='login-compact'
            className='pull-right'
            onSubmit={handleSubmit(this.onSubmit)}>

        {_.map(FIELDS, this.renderField)}

        <FormGroup>
          <Button bsStyle='primary'
                  type='submit'
                  disabled={submitting}>
            Submit
          </Button>
          {error && <p id='fail-message'>Login failed</p>}
        </FormGroup>
      </Form>
    );
  }
}

const LoginCompactForm = reduxForm({
  form: 'LoginCompactForm'
})(LoginCompact);

export default connect(null, { loginUser })(LoginCompactForm);
