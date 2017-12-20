import _ from 'lodash';
import React, { Component } from 'react';
import { Col } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { connect } from 'react-redux';
import { fetchMeasures } from './actions';

class MeasuresIndex extends Component {
  componentDidMount() {
    this.props.fetchElections();
  }

  renderMeasure(measure) {
    const { id, attributes: { name } } = measure;

    return (
      <li>
        <LinkContainer to={`/measures/${id}`}>
          <h4>{name}</h4>
        </LinkContainer>
      </li>
    );
  }

  render() {
    const { measures } = this.props;

    return (
      <Col sm={8} smOffset={2}>
        <h2>Measures:</h2>

        <ul className='list-group'>
          {_.map(measures, this.renderMeasure)}
        </ul>
      </Col>
    );
  }
}

function mapStateToProps({ measures }) {
  return { measures };
}

export default connect(mapStateToProps, { fetchMeasures })(MeasuresIndex);
