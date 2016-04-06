//reducers/index.js
import { combineReducers } from 'redux';
import { routeReducer } from 'react-router-redux';
import session from './session';

export default combineReducers({
  //routeReduer will set routing changes to the state
  routing: routeReducer,
  //current session keeps track of user
  session: session,
})
