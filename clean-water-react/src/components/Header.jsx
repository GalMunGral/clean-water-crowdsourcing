import React from 'react';
import ReactDOM from 'react-dom';
import { Route, Link } from 'react-router-dom';
import { MyModal } from './Modal';

export const Header = () => (
  <nav className="navbar navbar-default navbar-fixed-top" role="navigation">
    <div className="container-fluid">

      <div className="navbar-header">
        <Link className="navbar-brand" to="/">
          <span style={{fontWeight: "bold"}}>Clean Water Crowdsourcing</span>
        </Link>
      </div>

      <ul className="nav navbar-nav">
        <li><Link to="/">Map</Link></li>
        <li><Link to="/reports">Recent Reports</Link></li>
      </ul>

      <Route path='/reports' component={MyModal} />
    </div>
  </nav>
)
