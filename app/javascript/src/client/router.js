import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import Header          from './header';
import AboutPage       from './pages/about';
import NotFoundPage    from './pages/not_found';
import RootPage        from './pages/root';
import SessionsNew     from './sessions/new';
import SessionsDestroy from './sessions/destroy';
import UsersNew        from './users/new';
import StatesIndex     from './states/index';
import StatesShow      from './states/show';
import ElectionsIndex  from './elections/index';
import ElectionsShow   from './elections/show';
import MeasuresIndex   from './measures/index';
import MeasuresShow    from './measures/show';

export default (
  <BrowserRouter>
    <div className='body'>
      <Header />
      <Switch>
        // Static Pages
        <Route path='/about' component={AboutPage} />

        // Sessions
        <Route path='/login'  component={SessionsNew} />
        <Route path='/logout' component={SessionsDestroy} />

        // Users
        <Route path='/signup' component={UsersNew} />

        // States
        <Route path='/states'     component={StatesIndex} />
        <Route path='/states/:id' component={StatesShow} />

        // Elections
        <Route path='/elections'     component={ElectionsIndex} />
        <Route path='/elections/:id' component={ElectionsShow} />

        // Measures
        <Route path='/measures'     component={MeasuresIndex} />
        <Route path='/measures/:id' component={MeasuresShow} />

        // Root
        <Route path='/' component={RootPage} />
      </Switch>
    </div>
  </BrowserRouter>
);
