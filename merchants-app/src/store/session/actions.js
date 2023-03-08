import { createAsyncThunk } from "@reduxjs/toolkit";
import { getToken, removeToken, setToken } from "../../utils/HelperFunctions";
import api, { showErrors, showSuccess } from "../../services/api";

export const login = createAsyncThunk(
  "auth/login",
  async (user, { rejectWithValue }) => {
    try {
      api.defaults.headers.Authorization = '';
      const response = await api.post("/users/sign_in", { user });
      setToken(response.headers.authorization);
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
      showErrors(err.response);
      return rejectWithValue(err.response);
    }
  }
);

export const signOut = createAsyncThunk(
  "auth/signOut",
  async (_, { rejectWithValue }) => {
    try {
      const accessToken = getToken();
      api.defaults.headers.Authorization = `Bearer ${accessToken}`;
      const response = await api.delete("/users/sign_out");
      removeToken();
      return response.data;
    } catch (err) {
      if (!err.response) {
        throw err;
      }
      showErrors(err.response);
      return rejectWithValue(err.response);
    }
  }
);
