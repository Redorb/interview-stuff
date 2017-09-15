import React from 'react'
import { Link } from 'react-router-dom'

const NavigationBar = props => {
  return (
    <nav className="navbar">
      <div className="navbar-brand">
        <Link to='/'>
          <p className="navbar-item is-size-3">WOOF</p>
        </Link>
      </div>
      <div className="navbar-menu">
        <div className="navbar-start">
          <Link className="navbar-item" to='/sitters'>Sitters</Link>
        </div>
      </div>
    </nav>
  );
};

export default NavigationBar;