import React from 'react';
import { Map, Marker, GoogleApiWrapper } from 'google-maps-react';

const Container = function(props) {
  return (
    <div>
      <Map google={props.google}>
        {
          props.reports.map((report, index) => (
            <Marker
              title={report.quality}
              name={'SOMA'}
              position={{lat: report.latitude, lng: report.longitude}} />
          ))
        }
      </Map>
    </div>
  );
};

export const GMap = GoogleApiWrapper({
  apiKey: 'AIzaSyDpD4XZSVVlkJI5PDTtcAtX2SDe3aUHQ_8'
})(Container);
