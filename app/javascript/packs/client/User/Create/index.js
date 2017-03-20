import _ from 'lodash';
import React, { Component, PropTypes } from 'react';
import { Button, Col, ControlLabel, Form, FormGroup } from 'react-bootstrap';
import { Field, reduxForm } from 'redux-form';
import { connect } from 'react-redux';
import { createUser } from './actions';
import { checked, email, required } from 'packs/client/validations';

const FIELDS = {
  email: {
    label:       'Email',
    type:        'email',
    validations: [ required, email ]
  },
  password: {
    label:       'Password',
    type:        'password',
    validations: [ required ]
  },
  tos: {
    label:       "I agree to Bill Talk's terms of service.",
    type:        'checkbox',
    validations: [ checked ]
  }
};

class SignUp extends Component {
  static contextTypes = {
    router: PropTypes.object
  };

  onSubmit = (data) => {
    this.props.createUser(data)
      .then(() => { this.context.router.push('/'); });
  }

  renderField = ({ label, type, validations }, field) => {
    const component = (type === 'checkbox' ? this.renderCheckbox : this.renderInput);

    return (
      <Field name={field}
             id={field}
             label={label}
             component={component}
             type={type}
             validate={validations} />
    );
  }

  renderInput = ({ input, label, type, meta }) => {
    const validationState = this.validationState(meta);

    return(
      <FormGroup validationState={validationState}>
        <ControlLabel>{label}</ControlLabel>
        <input {...input} className='form-control' type={type} />
      </FormGroup>
    );
  }

  renderCheckbox = ({ input, label, type, meta }) => {
    const validationState = this.validationState(meta);

    return(
      <FormGroup validationState={validationState}>
        <div className='checkbox'>
          <label>
            <input {...input} type={type} />
            {label}
          </label>
        </div>
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
      <Col sm={6} smOffset={3}>
        <h1>Sign up</h1>

        <Form className='create-user-form'
              onSubmit={handleSubmit(data => this.onSubmit(data))}>

          {_.map(FIELDS, this.renderField)}

          <FormGroup>
            <Button bsStyle="primary"
                    type="submit"
                    disabled={submitting}>
              Submit
            </Button>
          </FormGroup>
        </Form>
      </Col>
    );
  }
}

const SignUpForm = reduxForm({
  form: 'SignUpForm'
})(SignUp);

export default connect(null, { createUser })(SignUpForm);

