import React, { useEffect } from "react";
import { fetchTransactions } from "../../../store/transactions/transactionsApi";
import { useSelector, useDispatch } from "react-redux";
import Loading from "../../../components/Loading";
import List from "./List";

const Transactions = () => {
  const dispatch = useDispatch();
  const { isLoading, transactions } = useSelector(
    (state) => state.transactions
  );

  useEffect(() => {
    dispatch(fetchTransactions());
  }, [dispatch]);

  return isLoading ? <Loading /> : <List transactions={transactions} />;
};

export default Transactions;
