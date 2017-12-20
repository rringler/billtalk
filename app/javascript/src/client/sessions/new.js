import _ from 'lodash';
import React, { Component } from 'react';
import { Alert, Button, Col, ControlLabel, Form, FormControl, FormGroup, HelpBlock } from 'react-bootstrap';
import { reduxForm, Field, SubmissionError } from 'redux-form';
import ClosableAlert from 'lib/closeable_alert';
import { connect } from 'react-redux';
import { createSession } from './actions';
import { emailRegex } from 'validations';

class SessionsNew extends Component {
  onSubmit = (values) => {
    return this.props.createSession(values)
      .then(this.onSubmitSuccess)
      .catch(this.onSubmitFail);
  }

  onSubmitSuccess = () => {
    this.props.history.push('/');
  }

  onSubmitFail = () => {
    throw new SubmissionError({ _error: 'Login failed.' })
  }

  renderAlert = () => {
    return (
      <ClosableAlert bsStyle='danger'>
        <strong>Login failed.</strong>
        <p>Please double check your email and password.</p>
      </ClosableAlert>
    );
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
    const { error, handleSubmit, pristine, submitting } = this.props;

    return (
      <Col sm={4} smOffset={4}>
        <h1>Log in</h1>

        {error && this.renderAlert()}

        <Form
          id='sessions-new'
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
          </FormGroup>
        </Form>
      </Col>
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
  form: 'SessionsNewForm',
  validate
})(
  connect(null, { createSession })(SessionsNew)
);
