import React, { useEffect } from "react";
import { fetchMerchants } from "../../../store/merchants/merchantsApi";
import { useSelector, useDispatch } from "react-redux";
import Loading from "../../../components/Loading";
import List from "./List";

const Merchants = () => {
  const dispatch = useDispatch();
  const { isLoading, merchants } = useSelector((state) => state.merchants);

  useEffect(() => {
    dispatch(fetchMerchants());
  }, [dispatch]);
  

  return isLoading ? (
    <Loading />
  ) : (
    <List merchants={merchants} />
  );
};

export default Merchants;
