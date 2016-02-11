import React from 'react';
import { Router, Route, IndexRoute } from 'react-router'

// pages
import Home from './pages/Home';
import Login from './pages/Login';


export default function Routes(props) {
  return (
    <Router history={props.history}>
      <Route path="/">
        <IndexRoute component={Home}/>
        <Route path="login" component={Login} />
      </Route>
    </Router>
  );
}
