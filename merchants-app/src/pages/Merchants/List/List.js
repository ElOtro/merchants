import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { Row, Col, Nav, Table, Button, Badge } from "react-bootstrap";

const List = ({ merchants = [] }) => {
  const navigate = useNavigate();

  const onCreate = () => {
    navigate.push("/merchants/new");
  };

  const onDelete = (values) => {
    // console.log(values);
  };

  return (
    <Row>
      <Col>
        <Row style={{paddingBottom: 10}}>
          <Nav className="justify-content-end">
            <Link className="nav-item" to={`/merchants/new`}>
              Create
            </Link>
          </Nav>
        </Row>
        <Row>
          <Table striped bordered hover>
            <thead>
              <tr>
                <th>#</th>
                <th>Status</th>
                <th>Name</th>
                <th>Description</th>
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
