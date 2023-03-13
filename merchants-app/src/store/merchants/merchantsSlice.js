import { createSlice } from "@reduxjs/toolkit";
import {
  fetchMerchants,
  fetchMerchant,
  updateMerchant,
} from "./merchantsApi";

const initialState = {
  merchants: [],
  merchant: {
    status: false,
    email: "",
    name: "",
    description: "",
  },
  meta: {
    total_pages: 1,
    current_page: 1,
    total_count: 1,
  },
  fetchParams: {
    search: null,
    sort: null,
    direction: null,
    page: 1,
    limit: 15,
  },
  isError: false,
  error: {},
  isLoading: false,
  isUploadingLogo: false,
};

const emptyMerchant = {
  name: null,
  full_name: null,
  ceo: null,
  ceo_title: null,
  cfo: null,
  cfo_title: null,
  is_vat_payer: false,
  details: {},
  bank_accounts: [],
};

export const merchantsSlice = createSlice({
  name: "merchants",
  initialState,
  reducers: {
    merchantAdded(state) {
      state.merchant = emptyMerchant;
    },
  },
  extraReducers: {
    // fetch all #####################
    [fetchMerchants.pending]: (state) => {
      state.isLoading = true;
    },
    [fetchMerchants.fulfilled]: (state, action) => {
      const { data, meta } = action.payload;
      state.merchants = data;
      state.isLoading = false;
    },
    [fetchMerchants.rejected]: (state) => {
      state.isLoading = false;
    },
    // fetch one #####################
    [fetchMerchant.pending]: (state) => {
      state.isLoading = true;
    },
    [fetchMerchant.fulfilled]: (state, action) => {
      const { data } = action.payload;
      state.merchant = data.attributes;
      state.isLoading = false;
    },
    [fetchMerchant.rejected]: (state) => {
      state.isLoading = false;
    },
    // patch #########################
    [updateMerchant.pending]: (state) => {
      state.isLoading = true;
      state.isError = false;
      state.error = {};
    },
    [updateMerchant.fulfilled]: (state, action) => {
      const { data } = action.payload;
      state.merchant = data;
      state.isLoading = false;
    },
    [updateMerchant.rejected]: (state, action) => {
      const { error } = action.payload;
      state.isLoading = false;
      state.isError = true;
      state.error = error;
    },
    // ##############################
  },
});

export const { merchantAdded } = merchantsSlice.actions;
export default merchantsSlice.reducer;
