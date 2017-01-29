import React             from 'react';
import { Router, Route } from 'react-router';

import App      from './components/App';
import About    from './components/About';
import NotFound from './components/NotFound';
import SignUp   from './components/SignUp';
import SignIn   from './components/SignIn';

const Routes = (props) => (
  <Router {...props}>
    <Route path="/"       component={App} />
    <Route path="/about"  component={About} />
    <Route path="/signup" component={SignUp} />
    <Route path="/signin" component={SignIn} />
    <Route path="*"       component={NotFound} />
  </Router>
);

export default Routes;
