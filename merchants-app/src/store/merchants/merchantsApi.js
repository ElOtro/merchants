import { createAsyncThunk } from "@reduxjs/toolkit";
import { getToken } from "../../utils/HelperFunctions";
import api, { showErrors, showSuccess } from "../../services/api";

export const fetchMerchants = createAsyncThunk(
  "merchants/fetchMerchants",
  async (_, { rejectWithValue }) => {
    try {
      const accessToken = getToken();
      api.defaults.headers.Authorization = `Bearer ${accessToken}`;
      const response = await api.get("/merchants");
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
      return rejectWithValue(err.response.data);
    }
  }
);

export const fetchMerchant = createAsyncThunk(
  "merchants/fetchMerchant",
  async (id, { rejectWithValue }) => {
    try {
      const accessToken = getToken();
      api.defaults.headers.Authorization = `Bearer ${accessToken}`;
      const response = await api.get(`/merchants/${id}`);
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
      return rejectWithValue(err.response.data);
    }
  }
);

export const updateMerchant = createAsyncThunk(
  "merchants/updateMerchant",
  async ({ id, payload }, { rejectWithValue }) => {
    try {
      const accessToken = getToken();
      api.defaults.headers.Authorization = `Bearer ${accessToken}`;
      const response = await api.patch(`/merchants/${id}`, payload);
      showSuccess("Merchant updated successfully!");
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
      showErrors(err.response.data);
      return rejectWithValue(err.response.data);
    }
  }
);

export const postMerchant = createAsyncThunk(
  "merchants/updateMerchant",
  async ({ payload }, { rejectWithValue }) => {
    try {
      const accessToken = getToken();
      api.defaults.headers.Authorization = `Bearer ${accessToken}`;
      const response = await api.post(`/merchants`, payload);
      showSuccess("Merchant created successfully!");
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
      showErrors(err.response.data);
      return rejectWithValue(err.response.data);
    }
  }
);
