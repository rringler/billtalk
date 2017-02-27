import React from 'react';
import { IndexRoute, Route } from 'react-router';

import App      from './components/App';
import About    from './components/About';
import Home     from './components/Home';
import LogIn    from './components/LogIn';
import NotFound from './components/NotFound';
import Register from './components/Register';

export default (
  <Route path="/" component={App}>
    <IndexRoute             component={Home} />
    <Route path="/about"    component={About} />
    <Route path="/login"    component={LogIn} />
    <Route path="/register" component={Register} />
    <Route path="*"         component={NotFound} />
  </Route>
);
