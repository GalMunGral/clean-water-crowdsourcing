import React from 'react';
import { Form } from './Form';
import { Button, Modal } from 'react-bootstrap';

const ModalButton = () => (
  <div className="nav navbar-nav navbar-right"
    style={{marginTop: "7px", marginRight: "10px"}}>
      <Button type="button" className="btn btn-primary" dataToggle="modal" dataTarget="#newReport">New Report</Button>
  </div>
)

export class MyModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = { showModal: false };
    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
  }

  close() { this.setState({ showModal: false }); }
  open() { this.setState({ showModal: true }); }

  render() {
    return (
      <div>
        <div className="nav navbar-nav navbar-right"
          style={{marginTop: "7px", marginRight: "10px"}}>
          <Button bsStyle="primary"onClick={this.open}>
            New Report
          </Button>
        </div>

        <Modal show={this.state.showModal} onHide={this.close}>

          <Modal.Header closeButton>
            <Modal.Title>Edit Water Report</Modal.Title>
          </Modal.Header>

          <Modal.Body>
            <Form />
          </Modal.Body>

          <Modal.Footer>
            <Button onClick={this.close}>Close</Button>
            <Button bsStyle="primary" onClick={this.close}>Save</Button>
          </Modal.Footer>

        </Modal>
      </div>
    )
  }

}
