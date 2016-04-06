//containers/root.js

import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { Router } from 'react-router';
import invariant from 'invariant';
import routes from '../routes';

export default class Root extends Component {
  render(){
    return (
      <Provider store={this.props.store}>
        { this._renderRouter() }
      </Provider>
    )
  }
  //ensures that there is a router history before trying to render the router
  _renderRouter() {
    //invariant(condition, message)
    invariant(
      this.props.routerHistory,
      '<Root /> needs either a routingContext or routerHistory to render.'
    );

    return (
      <Router history={this.props.routerHistory}>
        { routes }
      </Router>
    );
  }
}
