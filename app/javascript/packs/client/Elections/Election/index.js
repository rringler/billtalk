import _ from 'lodash';
import React, { Component } from 'react';
import { Col } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { connect } from 'react-redux';
import { fetchElection } from './actions';


class Election extends Component {
  componentDidMount() {
    this.props.fetchElection(this.props.params.id);
  }

  renderMeasure = (measure) => {
    const { id }    = measure;
    const { title } = measure.attributes;

    return (
      <li>
        <LinkContainer to={`/measures/${id}`}>
          <p>{title}</p>
        </LinkContainer>
      </li>
    );
  }

  render() {
    const { name } = this.props.election.data.attributes;
    const measures = this.props.election.included;

    return (
      <Col sm={6} smOffset={3}>
        <h2>{name}</h2>

        <hr />

        <h4>Measures</h4>
        <ul>{_.map(measures, this.renderMeasure)}</ul>
      </Col>
    );
  }
}

function mapStateToProps({ election }) {
  return { election };
}

export default connect(mapStateToProps, { fetchElection })(Election);
