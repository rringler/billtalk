import _ from 'lodash';
import React, { Component } from 'react';
import { Col } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { connect } from 'react-redux';
import { fetchElection } from './actions';


class ElectionsShow extends Component {
  componentDidMount() {
    const { id } = this.props.match.params;

    this.props.fetchElection(id);
  }

  render() {
    const { election } = this.props;

    return (
      <Col sm={6} smOffset={3}>
        <h2>{election.name}</h2>
      </Col>
    );
  }
}

function mapStateToProps({ elections }, ownProps) {
  return { election: elections[ownProps.match.params.id] };
}

export default connect(mapStateToProps, { fetchElection })(ElectionsShow);
