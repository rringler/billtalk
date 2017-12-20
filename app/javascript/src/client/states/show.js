import _ from 'lodash';
import React, { Component } from 'react';
import { Col } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { connect } from 'react-redux';
import { fetchState } from './actions';


class State extends Component {
  componentDidMount() {
    const { id } = this.props.params;

    this.props.fetchState(id);
  }

  renderElection(election) {
    const { id }   = election;
    const { name } = election.attributes;

    return (
      <li>
        <LinkContainer to={`/elections/${id}`}>
          <p>{name}</p>
        </LinkContainer>
      </li>
    );
  }

  render() {
    const { name, code } = this.props.state.data.attributes;
    const elections      = this.props.state.included;

    return (
      <Col sm={6} smOffset={3}>
        <h2>
          {name} <small>({code})</small>
        </h2>

        <hr />

        <h4>Elections</h4>
        <ul>{_.map(elections, this.renderElection)}</ul>
      </Col>
    );
  }
}

function mapStateToProps({ state }) {
  return { state };
}

export default connect(mapStateToProps, { fetchState })(State);
