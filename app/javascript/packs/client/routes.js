import React from 'react';
import { IndexRoute, Route } from 'react-router';

import About    from './components/About';
import Layout   from './components/Layout';
import LogIn    from './components/LogIn';
import NotFound from './components/NotFound';
import Register from './components/Register';
import Root     from './components/Root';

export default (
  <Route path="/"           component={Layout}>
    <IndexRoute             component={Root} />
    <Route path="/about"    component={About} />
    <Route path="/login"    component={LogIn} />
    <Route path="/register" component={Register} />
    <Route path="*"         component={NotFound} />
  </Route>
);
