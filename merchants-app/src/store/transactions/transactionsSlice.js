import { createSlice } from "@reduxjs/toolkit";
import {
  fetchTransactions,
  fetchTransaction,
  updateTransaction,
} from "./transactionsApi";

const initialState = {
  transactions: [],
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

export const transactionsSlice = createSlice({
  name: "transactions",
  initialState,
  extraReducers: {
    // fetch all #####################
    [fetchTransactions.pending]: (state) => {
      state.isLoading = true;
    },
    [fetchTransactions.fulfilled]: (state, action) => {
      const { data, meta } = action.payload;
      state.transactions = data;
      state.isLoading = false;
    },
    [fetchTransactions.rejected]: (state) => {
      state.isLoading = false;
    },
  },
});

export const { transactionAdded } = transactionsSlice.actions;
export default transactionsSlice.reducer;
