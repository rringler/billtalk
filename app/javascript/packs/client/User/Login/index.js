import _ from 'lodash';
import React, { Component, PropTypes } from 'react';
import { Alert, Button, Col, ControlLabel, Form, FormGroup } from 'react-bootstrap';
import { reduxForm, Field, SubmissionError } from 'redux-form';
import { connect } from 'react-redux';
import { loginUser } from './actions';
import { email, required } from 'packs/client/validations';

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

  constructor(props) {
    super(props);

    this.state = {
      alertDismissed: false
    };
  }

  onSubmit = (data) => {
    return this.props.loginUser(data).then(
      this.onSubmitSuccess,
      this.onSubmitFail
    );
  }

  onSubmitSuccess = () => {
    this.context.router.push('/');
  }

  onSubmitFail = () => {
    throw new SubmissionError({ _error: 'Login failed.' })
  }

  renderAlert = (error) => {
    if (!this.state.alertDismissed) {
      return (
        <Alert bsStyle="danger"
               onDismiss={() => { this.setState({ alertDismissed: true }); }}>
          <strong>Login failed.</strong>
          <p>Please double check your email and password.</p>
        </Alert>
      );
    }
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
    const { error, handleSubmit, submitting } = this.props;

    return (
      <div>
        <h1>Log in</h1>

        <Col sm={4} smOffset={4}>
          {error && this.renderAlert(error)}

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
