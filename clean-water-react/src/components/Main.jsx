import React from 'react';
import { Switch, Route } from 'react-router-dom';
import { GMap } from './Map';
import { List } from './List';
import { MyModal } from './Modal';

export class Main extends React.Component {
  constructor(props) {
    super(props);
    this.GMapWithData = this.GMapWithData.bind(this);
    this.ListWithData = this.ListWithData.bind(this);
  };

  GMapWithData() {
    return <GMap reports={this.props.reports} />
  };

  ListWithData() {
    return <List reports={this.props.reports} />
  };

  render() {
    return (
      <div>
        <Route exact path='/' render={this.GMapWithData} />
        <Route path='/reports' render={this.ListWithData}/>
        <Route path='/test' render={() => (
          <div style={{marginTop: '70px'}} >
            <MyModal />
          </div>
        )}/>
      </div>
    );
  };
}
