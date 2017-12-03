import React from 'react';
import { IndexRoute, Route } from 'react-router';

import App          from './App';
import AboutPage    from './Pages/About';
import NotFoundPage from './Pages/NotFound';
import RootPage     from './Pages/Root';
import CreateUser   from './User/Create';
import LoginUser    from './User/Login';
import LogoutUser   from './User/Logout';
import States       from './States/States';
import State        from './States/State';
import Election     from './Elections/Election';

export default (
  <Route path='/'                component={App}>
    <IndexRoute                  component={RootPage} />
    <Route path='/about'         component={AboutPage} />
    <Route path='/login'         component={LoginUser} />
    <Route path='/logout'        component={LogoutUser} />
    <Route path='/signup'        component={CreateUser} />
    <Route path='/states'        component={States} />
    <Route path='/states/:id'    component={State} />
    <Route path='/elections/:id' component={Election} />
    <Route path='*'              component={NotFoundPage} />
  </Route>
);
