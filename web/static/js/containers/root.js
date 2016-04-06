//containers/root.js

import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { Router, Route } from 'react-router';
import invariant from 'invariant';
//import configRoutes from '../routes';
import MainLayout from '../layouts/main';
import RegistrationsNew from '../views/registrations/new';

class Root extends Component {
  render(){
    return (
      <Provider store={this.props.store}>
        { this._renderRouter() }
      </Provider>
    )
  }
  //ensures that there is a router history before trying to render the router
  _renderRouter = () => {
    //invariant(condition, message)
    invariant(
      this.props.routerHistory,
      '<Root /> needs either a routingContext or routerHistory to render.'
    );

    return (
      <Router history={this.props.routerHistory}>
        <Route component={MainLayout}>
          <Route path='/' component={RegistrationsNew} />
        </Route>
      </Router>
    );
  }
}

export default Root;
