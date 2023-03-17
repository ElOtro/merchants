import { createAsyncThunk } from "@reduxjs/toolkit";
import { getToken } from "../../utils/HelperFunctions";
import api from "../../services/api";

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
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
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
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
      return rejectWithValue(err.response.data);
    }
  }
);

export const deleteMerchant = createAsyncThunk(
  "merchants/deleteMerchant",
  async (id, { rejectWithValue }) => {
    try {
      const accessToken = getToken();
      api.defaults.headers.Authorization = `Bearer ${accessToken}`;
      const response = await api.delete(`/merchants/${id}`);
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
      return rejectWithValue(err.response.data);
    }
  }
);
