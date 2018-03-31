import React from 'react';

export const Form = () => (
  <form className="modal-body">
    <div className="form-group">
      <label>Latitude</label>
      <input type="text" className="form-control" id="latitudeInput" name="latitude" placeholder="Enter Latitude" />
    </div>

    <div className="form-group">
      <label>Longitude</label>
      <input type="text" className="form-control" id="longitudeInput"
      name="longitude" placeholder="Enter Longitude" />
    </div>

    <div className="form-group">
      <label>Water Quality</label>
      <select className="form-control" id="waterQualitySelect" name
        ="quality">
        <option>Safe</option>
        <option>Treatable</option>
        <option>Unsafe</option>
      </select>
    </div>

  </form>
)
