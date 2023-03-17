import { createSlice } from "@reduxjs/toolkit";
import {
  fetchMerchants,
  fetchMerchant,
  updateMerchant,
  deleteMerchant
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
  errors: [],
  isLoading: false
};

export const merchantsSlice = createSlice({
  name: "merchants",
  initialState,
  extraReducers: {
    // fetch all #####################
    [fetchMerchants.pending]: (state) => {
      state.isLoading = true;
      state.isError = false;
    },
    [fetchMerchants.fulfilled]: (state, action) => {
      const { data, meta } = action.payload;
      state.merchants = data;
      state.isLoading = false;
    },
    [fetchMerchants.rejected]: (state, action) => {
      const { errors } = action.payload;
      state.isLoading = false;
      state.isError = true;
      state.errors = errors;
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
    [fetchMerchant.rejected]: (state, action) => {
      const { errors } = action.payload;
      state.isLoading = false;
      state.isError = true;
      state.errors = errors;
    },
    // patch #########################
    [updateMerchant.pending]: (state) => {
      state.isLoading = true;
      state.isError = false;
      state.errors = [];
    },
    [updateMerchant.fulfilled]: (state, action) => {
      const { data } = action.payload;
      state.merchant = data;
      state.isLoading = false;
    },
    [updateMerchant.rejected]: (state, action) => {
      const { errors } = action.payload;
      state.isLoading = false;
      state.isError = true;
      state.errors = errors;
    },
    // delete #########################
    [deleteMerchant.pending]: (state) => {
      state.isLoading = true;
      state.isError = false;
      state.errors = [];
    },
    [deleteMerchant.fulfilled]: (state) => {
      state.isLoading = false;
    },
    [deleteMerchant.rejected]: (state, action) => {
      const { errors } = action.payload;
      state.isLoading = false;
      state.isError = true;
      state.errors = errors;
    },
    // ##############################
  },
});

export const { merchantAdded } = merchantsSlice.actions;
export default merchantsSlice.reducer;
