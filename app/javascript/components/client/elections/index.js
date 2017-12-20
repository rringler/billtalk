import _ from 'lodash';
import React, { Component } from 'react';
import { Col } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { connect } from 'react-redux';
import { fetchElections } from './actions';

class ElectionsIndex extends Component {
  componentDidMount() {
    this.props.fetchElections();
  }

  renderElection(election) {
    const { id, attributes: { name } } = election;

    return (
      <li>
        <LinkContainer to={`/elections/${id}`}>
          <h4>{name}</h4>
        </LinkContainer>
      </li>
    );
  }

  render() {
    const { elections } = this.props;

    return (
      <Col sm={8} smOffset={2}>
        <h2>Elections:</h2>

        <ul className='list-group'>
          {_.map(elections, this.renderElection)}
        </ul>
      </Col>
    );
  }
}

function mapStateToProps({ elections }) {
  return { elections };
}

export default connect(mapStateToProps, { fetchElections })(ElectionsIndex);
