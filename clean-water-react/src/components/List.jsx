import React from 'react';

export const List = (props) => (
  <div className="container" style={{marginTop: "70px"}}>
    {
      props.reports.map((report, index) => (
        <div className="panel panel-default" key={index}>

          <div className="panel-heading">
            <h3 className="panel-title">Water Report</h3>
          </div>

          <ul className="panel-body list-group">
            <li className="list-group-item">
              <strong>Latitude: </strong> {report.latitude}
            </li>
            <li className="list-group-item">
              <strong>Longitude: </strong> {report.longitude}
            </li>
            <li className="list-group-item">
              <strong>Quality: </strong> {report.quality}
            </li>
          </ul>

        </div>
      ))
    }
  </div>
);
