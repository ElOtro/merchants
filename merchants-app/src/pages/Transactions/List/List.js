import React from "react";
import { Table } from "react-bootstrap";
import { statuses } from "../../../utils/HelperFunctions";
import dayjs from "dayjs";

const List = ({ transactions = [] }) => {
  return (
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
  );
};

export default List;
