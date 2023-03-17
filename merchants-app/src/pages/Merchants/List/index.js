import React, { useEffect } from "react";
import {
  fetchMerchants,
  deleteMerchant,
} from "../../../store/merchants/merchantsApi";
import { useSelector, useDispatch } from "react-redux";
import Loading from "../../../components/Loading";
import List from "./List";

const Merchants = () => {
  const dispatch = useDispatch();
  const { isLoading, isError, errors, merchants } = useSelector(
    (state) => state.merchants
  );

  useEffect(() => {
    dispatch(fetchMerchants());
  }, [dispatch]);

  const onDelete = (id) => {
    dispatch(deleteMerchant(id)).then(() => {
      // dispatch(fetchMerchants());
    });
  };

  return isLoading ? (
    <Loading />
  ) : (
    <List
      isError={isError}
      errors={errors}
      merchants={merchants}
      onDelete={onDelete}
    />
  );
};

export default Merchants;
