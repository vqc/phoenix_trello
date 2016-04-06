//store/index.js

import { createStore, applyMiddleware } from 'redux';
import { routerMiddleware } from 'react-router-redux';
import createLogger from 'redux-logger';
import thunkMiddleware from 'redux-thunk';
import reducers from '../reducers';

//logger middleware for redux
const loggerMiddleware = createLogger({
  //level sets what level in the console the information is displayed
  //e.g. 'console', 'warn', 'error'
  level: 'info',
  //true if the log group should be collapsed
  collapsed: true,
});

export default function configureStore(browserHistory){
  const reduxRouterMiddleware = routerMiddleware(browserHistory);
                                                    //dispatch router actions
                                                    //to the store
  const createStoreWithMiddleware = applyMiddleware(reduxRouterMiddleware,
                                                    //thunk can be used for async
                                                    thunkMiddleware,
                                                    //logger to log action and state changes
                                                    //in the browswer console
                                                    loggerMiddleware)(createStore);
  return createStoreWithMiddleware(reducers);
}
