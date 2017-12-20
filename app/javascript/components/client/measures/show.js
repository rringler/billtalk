import _ from 'lodash';
import React, { Component } from 'react';
import { Col } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { connect } from 'react-redux';
import { fetchMeasure } from './actions';


class MeasuresShow extends Component {
  componentDidMount() {
    const { id } = this.props.match.params;

    this.props.fetchMeasure(id);
  }

  render() {
    const { measure } = this.props;

    return (
      <Col sm={6} smOffset={3}>
        <h2>{measure.name}</h2>
      </Col>
    );
  }
}

function mapStateToProps({ measures }, ownProps) {
  return { measure: measures[ownProps.match.params.id] };
}

export default connect(mapStateToProps, { fetchMeasure })(MeasuresShow);
