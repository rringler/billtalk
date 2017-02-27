import _ from 'lodash';
import React, { Component, PropTypes } from 'react';
import { Button, Col, ControlLabel, Form, FormGroup } from 'react-bootstrap';
import { Field, reduxForm } from 'redux-form';
import { connect } from 'react-redux';
import { loginUser } from '../../actions/session';

const required = (value) => {
  return value ? undefined : 'Required';
}

const email = (value) => {
  const email_regex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;

  return (
    value && (!email_regex.test(value) ? 'Invalid email address' : undefined)
  );
}

const FIELDS = {
  email: {
    component:   'input',
    label:       'Email',
    type:        'text',
    validations: [ required, email ]

  },
  password: {
    component:   'input',
    label:       'Password',
    type:        'password',
    validations: [ required ]
  }
};

class LogIn extends Component {
  static contextTypes = {
    router: PropTypes.object
  };

  onSubmit = (data) => {
    this.props.loginUser(data)
      .then(() => { this.context.router.push('/'); });
  }

  renderField = (fieldConfig, field) => {
    return (
      <Field className="form-control"
             component={this.renderFormGroup}
             label={fieldConfig.label}
             name={field}
             type={fieldConfig.type}
             validate={fieldConfig.validations} />
    );
  }

  renderFormGroup = ({ input, label, meta, name, placeholder, type }) => {
    const validationClass = this.validationClass(meta);
    const feedbackClass   = this.feedbackClass(meta);

    return (
      <FormGroup className={`${validationClass}`}
                 controlId={`formHorizontal${name}`}>
        <Col componentClass={ControlLabel}
             smOffset={2}
             sm={3}>
          {label}
        </Col>
        <Col sm={4}>
          <input {...input} className="form-control"
                            placeholder={placeholder}
                            type={type}
                            describedby={`input${name}Status`} />
          <span className={`glyphicon ${feedbackClass} form-control-feedback`}
                aria-hidden="true">
          </span>
        </Col>
      </FormGroup>
    );
  }

  validationClass = ({ touched, error, warning }) => {
    const errorClass   = 'has-error   has-feedback',
          warningClass = 'has-warning has-feedback',
          successClass = 'has-success has-feedback';

    if (!touched) { return undefined; }

    return (error && errorClass) || (warning && warningClass) || successClass;
  }

  feedbackClass = ({ touched, error, warning }) => {
    const errorClass   = 'glyphicon-remove',
          warningClass = 'glyphicon-warning-sign',
          successClass = 'glyphicon-ok';

    if (!touched) { return undefined; }

    return (error && errorClass) || (warning && warningClass) || successClass;
  }

  render() {
    const { handleSubmit, submitting } = this.props;

    return (
      <div>
        <h1>Log in</h1>

        <Form horizontal onSubmit={handleSubmit(data => this.onSubmit(data))}>
          {_.map(FIELDS, this.renderField)}

          <FormGroup>
            <Col smOffset={5} sm={5}>
              <Button bsStyle="primary"
                      type="submit"
                      disabled={submitting}>
                Submit
              </Button>
            </Col>
          </FormGroup>
        </Form>
      </div>
    );
  }
}

const LogInForm = reduxForm({
  form: 'LogInForm'
})(LogIn);

export default connect(null, { loginUser })(LogInForm);
