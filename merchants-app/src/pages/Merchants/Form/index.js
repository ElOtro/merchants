import React, { useEffect } from "react";
import { useParams } from "react-router-dom";
import { fetchMerchant } from "../../../store/merchants/merchantsApi";
import { useSelector, useDispatch } from "react-redux";
import Loading from "../../../components/Loading";
import FormEdit from "./FormEdit";
import FormCreate from "./FormCreate";

const Merchant = () => {
  const params = useParams();
  const dispatch = useDispatch();
  const { isLoading, merchant } = useSelector((state) => state.merchants);

  useEffect(() => {
    if (params.id !== "new") {
      dispatch(fetchMerchant(params.id));
    }
  }, [dispatch]);

  return isLoading ? (
    <Loading />
  ) : params.id === "new" ? (
    <FormCreate />
  ) : (
    <FormEdit merchantID={params.id} merchant={merchant} />
  );
};

export default Merchant;
