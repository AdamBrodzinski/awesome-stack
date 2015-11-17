import { ReduxRouter } from 'redux-router';
import { Route } from 'react-router';
import React from 'react';
// pages
import Login from './pages/Login';

export default function Routes() {
  return (
    <ReduxRouter>
      <Route path="/" component={Login}/>
    </ReduxRouter>
  );
}
