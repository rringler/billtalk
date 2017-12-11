import _ from 'lodash';
import React, { Component } from 'react';
import { Button, Col, ControlLabel, Form, FormControl, FormGroup, HelpBlock } from 'react-bootstrap';
import { Field, reduxForm } from 'redux-form';
import { connect } from 'react-redux';
import { createUser } from './actions';
import { emailRegex } from 'components/Client/validations';

class SignUp extends Component {
  onSubmit = (values) => {
    this.props.createUser(values)
      .then(this.onSuccess);
  }

  onSuccess = () => {
    this.props.history.push('/');
  }

  renderInputField = (field) => {
    const validationState = this.validationState(field);
    const helpBlock       = this.renderHelpBlock(field);

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
        {helpBlock}
      </FormGroup>
    );
  }

  renderCheckboxField = (field) => {
    const validationState = this.validationState(field);
    const helpBlock       = this.renderHelpBlock(field);

    return(
      <FormGroup validationState={validationState}>
        <div className='checkbox'>
          <label>
            <input
              type='checkbox'
              {...field.input}
            />
            {field.label}
          </label>
          {helpBlock}
        </div>
      </FormGroup>
    );
  }

  renderHelpBlock = (field) => {
    const { meta: { touched, error } } = field;

    if (!touched) { return null; }

    return(
      <HelpBlock>
        {error}
      </HelpBlock>
    );
  }

  validationState = ({ meta: { touched, error, warning }}) => {
    if (!touched) { return null; }

    return (error && 'error') || (warning && 'warning') || 'success';
  }

  render() {
    const { handleSubmit, pristine, submitting } = this.props;

    return (
      <Col sm={6} smOffset={3}>
        <h1>Join the conversation</h1>

        <Form
          className='create-user-form'
          onSubmit={handleSubmit(this.onSubmit)}
        >

          <Field
            label='Email'
            name='email'
            type='text'
            component={this.renderInputField}
          />

          <Field
            label='Password'
            name='password'
            type='password'
            component={this.renderInputField}
          />

          <Field
            label="I agree to Bill Talk's terms of service"
            name='tos'
            component={this.renderCheckboxField}
          />

          <FormGroup>
            <Button
              bsStyle="primary"
              type="submit"
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

  if (!values.tos) {
    errors.tos = 'Please accept the Terms of Service'
  }

  return errors;
}

export default reduxForm({
  form: 'UsersNewForm',
  validate
})(
  connect(null, { createUser })(SignUp)
);
