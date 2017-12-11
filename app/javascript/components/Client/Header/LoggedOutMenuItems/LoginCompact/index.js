import _ from 'lodash';
import React, { Component } from 'react';
import { Button, Col, Form, FormControl, FormGroup, HelpBlock } from 'react-bootstrap';
import { reduxForm, Field, SubmissionError } from 'redux-form';
import ClosableAlert from 'components/Client/Lib/ClosableAlert';
import { connect } from 'react-redux';
import { loginUser } from 'components/Client/User/Login/actions';
import { emailRegex } from 'components/Client/validations';
import './style.scss';

class LoginCompact extends Component {
  onSubmit = (values) => {
    return this.props.loginUser(values)
      .catch(this.onSubmitFail);
  }

  onSubmitFail = () => {
    throw new SubmissionError({
      email:    'error',
      password: 'error',
      _error:   'error'
    });
  }

  renderField = (field) => {
    const { meta: { touched, error } } = field;
    const validationState = this.validationState(field);

    return (
      <FormGroup validationState={validationState}>
        <label>{field.label}</label>
        <input
          className='form-control'
          type={field.type}
          placeholder={field.placeholder}
          {...field.input}
        />
        <FormControl.Feedback />
        {touched ? <HelpBlock>{error}</HelpBlock> : ''}
      </FormGroup>
    );
  }

  validationState = ({ meta: { touched, error, warning }}) => {
    if (!touched) { return null; }

    return (error && 'error') || (warning && 'warning') || 'success';
  }

  render() {
    const { handleSubmit, pristine, submitting, error } = this.props;

    return (
      <div className='pull-right'>
        <Form
          id='sessions-new-compact'
          onSubmit={handleSubmit(this.onSubmit)}
        >
          <Field
            label='Email'
            name='email'
            type='text'
            component={this.renderField}
          />

          <Field
            label='Password'
            name='password'
            type='password'
            component={this.renderField}
          />

          <FormGroup>
            <Button
              bsStyle='primary'
              type='submit'
              disabled={pristine || submitting}
            >
              Submit
            </Button>
            {error && <p id='fail-message'>Login failed</p>}
          </FormGroup>
        </Form>
      </div>
    );
  }
}

function validate(values) {
  const errors = {};

  if (!values.email) {
    errors.email = 'Please enter an email address'
  }

  if (values.email && !values.email.match(emailRegex)) {
    errors.email = 'Please enter a valid email address'
  }

  if (!values.password) {
    errors.password = 'Please enter a password'
  }

  return errors;
}

export default reduxForm({
  form: 'SessionsNewCompactForm',
  validate
})(
  connect(null, { loginUser })(LoginCompact)
);
