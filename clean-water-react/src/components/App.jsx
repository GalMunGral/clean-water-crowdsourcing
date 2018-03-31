import React from 'react';
import { Header } from './Header';
import { Main } from './Main';
import * as firebase from 'firebase';

export class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {reports: []};
  }

  componentDidMount() {
    firebase.initializeApp({
      apiKey: "AIzaSyCrooB7pc-GBZuHh8Og-OZUSrlMBUl_WUw",
      authDomain: "cs2340-ios-1499489229862.firebaseapp.com",
      databaseURL: "https://cs2340-ios-1499489229862.firebaseio.com",
      projectId: "cs2340-ios-1499489229862",
      storageBucket: "cs2340-ios-1499489229862.appspot.com",
      messagingSenderId: "1067220737955"
    });

    firebase.database().ref('/reports').on('value', (snapshot) => {
      this.setState({
        reports: snapshot.val().reverse()
      })
    });
  }

  render() {
    return (
      <div>
        <Header />
        <Main reports={this.state.reports} />
      </div>
    )
  }

}
