import React from "react";
import { Link } from "react-router-dom";
import { Row, Col, Nav, Table, Button, Badge, Alert } from "react-bootstrap";
import Message from "../../../components/Message";

const List = ({
  isError = false,
  errors = [],
  merchants = [],
  onDelete = () => {},
}) => {
  return (
    <Row>
      {isError && (
        <Message messages={errors} variant="danger" />
      )}
      <Col>
        <Row style={{ paddingBottom: 10 }}>
          <Nav className="justify-content-end">
            <Link className="nav-item" to={`/merchants/new`}>
              Create
            </Link>
          </Nav>
        </Row>
        <Row>
          <Table
            striped
            bordered
            hover
            className="table align-middle text-center"
          >
            <thead>
              <tr>
                <th>#</th>
                <th>Status</th>
                <th>Name</th>
                <th>Description</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              {merchants.map((merchant) => {
                return (
                  <tr key={merchant.id}>
                    <td>{merchant.id}</td>
                    <td>
                      {merchant.attributes.status ? (
                        <Badge bg="success">active</Badge>
                      ) : (
                        <Badge bg="danger">inactive</Badge>
                      )}
                    </td>
                    <td>
                      <Link to={`/merchants/${merchant.id}`}>
                        {merchant.attributes.name}
                      </Link>
                    </td>
                    <td>{merchant.attributes.description}</td>
                    <td>
                      <Button
                        variant="danger"
                        size="sm"
                        onClick={onDelete.bind(this, merchant.id)}
                      >
                        Delete
                      </Button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </Table>
        </Row>
      </Col>
    </Row>
  );
};

export default List;
