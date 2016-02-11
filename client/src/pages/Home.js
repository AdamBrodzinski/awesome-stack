import React from  'react';
import {Link} from 'react-router';


const Home = React.createClass({
  render() {
    return (
      <div className='Home'>
        Home page
        <Link to="/login" text="foo">Go to Login</Link>
      </div>
    );
  }
});
export default Home
