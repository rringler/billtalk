import _ from 'lodash';
import React, { Component, PropTypes } from 'react';
import { Button, Col, ControlLabel, Form, FormGroup } from 'react-bootstrap';
import { Field, reduxForm } from 'redux-form';
import { connect } from 'react-redux';
import { loginUser } from '../../actions/session';
import { required, email } from '../validations';

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
  }
};

class Login extends Component {
  static contextTypes = {
    router: PropTypes.object
  };

  onSubmit = (data) => {
    this.props.loginUser(data)
      .then((response) => {
        if (response.status === 200 ) {
          this.context.router.push('/');
        } else {
          this.props.alert = response.body.errors;
        }
      });
  }

  renderField = ({ label, type, validations }, field) => {
    return (
      <Field name={field}
             id={field}
             label={label}
             component={this.renderInput}
             type={type}
             validate={validations} />
    );
  }

  renderInput = ({ input, label, type, meta }) => {
    const validationState = this.validationState(meta);

    return (
      <FormGroup validationState={validationState}>
        <ControlLabel>{label}</ControlLabel>
        <input {...input} className='form-control' type={type} />
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
      <div>
        <h1>Log in</h1>

        <Col sm={4} smOffset={4}>
          <Form id='login'
                onSubmit={handleSubmit(this.onSubmit)}>
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
      </div>
    );
  }
}

const LoginForm = reduxForm({
  form: 'LoginForm'
})(Login);

export default connect(null, { loginUser })(LoginForm);
