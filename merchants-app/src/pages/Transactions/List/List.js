import React, { useState } from "react";
import {
  Row,
  Col,
  Table,
  ToggleButton,
  ToggleButtonGroup,
} from "react-bootstrap";
import { statuses } from "../../../utils/HelperFunctions";
import dayjs from "dayjs";

const List = ({ transactions = [] }) => {
  const [value, setValue] = useState([1, 2, 3]);
  const handleChange = (val) => setValue(val);

  return (
    <React.Fragment>
      <Row style={{ paddingBottom: 10 }}>
        <Col>
          <ToggleButtonGroup
            size="sm"
            type="checkbox"
            value={value}
            onChange={handleChange}
          >
            <ToggleButton variant="outline-primary" value={1}>
              Authorize
            </ToggleButton>
            <ToggleButton variant="outline-primary" value={2}>
              Capture
            </ToggleButton>
            <ToggleButton variant="outline-primary" value={3}>
              Refund
            </ToggleButton>
          </ToggleButtonGroup>
        </Col>
      </Row>
      <Row>
        <Col>
          <Table striped bordered hover>
            <thead>
              <tr>
                <th>#</th>
                <th>Status</th>
                <th>Type</th>
                <th>Merchant</th>
                <th>Amount</th>
                <th>Created</th>
              </tr>
            </thead>
            <tbody>
              {transactions.map((transaction) => {
                return (
                  <tr key={transaction.id}>
                    <td>{transaction.id}</td>
                    <td>{statuses(transaction.attributes.status)}</td>
                    <td>{transaction.attributes.type}</td>
                    <td>{transaction.attributes.merchant.name}</td>
                    <td style={{ textAlign: "right" }}>
                      {transaction.attributes.amount}
                    </td>
                    <td>
                      {transaction.attributes.created_at
                        ? dayjs(transaction.attributes.created_at).format(
                            "YYYY.MM.DD HH:ss"
                          )
                        : ""}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </Table>
        </Col>
      </Row>
    </React.Fragment>
  );
};

export default List;
