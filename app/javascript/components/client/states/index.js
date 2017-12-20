import _ from 'lodash';
import React, { Component } from 'react';
import { Col } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { connect } from 'react-redux';
import { fetchStates } from './actions';


class StatesIndex extends Component {
  componentDidMount() {
    this.props.fetchStates();
  }

  renderState(state) {
    const { id }   = state;
    const { name } = state.attributes;

    return (
      <li>
        <LinkContainer to={`/states/${id}`}>
          <h4>{name}</h4>
        </LinkContainer>
      </li>
    );
  }

  render() {
    const states = this.props.states.data;

    return (
      <Col sm={8} smOffset={2}>
        <h2>United States:</h2>

        <ul className='list-group'>
          {_.map(states, this.renderState)}
        </ul>
      </Col>
    );
  }
}

function mapStateToProps({ states }) {
  return { states };
}

export default connect(mapStateToProps, { fetchStates })(StatesIndex);
