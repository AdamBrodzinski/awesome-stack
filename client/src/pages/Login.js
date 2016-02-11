import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router';

import {dispatch} from '../store'
import { routeActions } from 'react-router-redux'

function handleClick(e) {
  dispatch(routeActions.push('/'));
}

const Login = React.createClass({
  render(props=this.props) {
    return (
      <div className='Login'>
        <br/>
        Login Page
        <button onClick={handleClick}>Go to home page</button>
      </div>
    );
  }
});
export default Login;
