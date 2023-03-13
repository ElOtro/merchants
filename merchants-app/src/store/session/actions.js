import { createAsyncThunk } from "@reduxjs/toolkit";
import { getToken, removeToken, setToken } from "../../utils/HelperFunctions";
import api, { showErrors, showSuccess } from "../../services/api";

export const fetchUser = createAsyncThunk('auth/fetchUser', async (_, {rejectWithValue}) => {
  try{
      const accessToken = getToken();
      api.defaults.headers.Authorization = `Bearer ${accessToken}`;
      const response = await api.get('/auth/user');
      // console.log("fetchUser", response.data)
      return response.data;
  }catch(e){
      removeToken();
      return rejectWithValue('');
  }
});

export const login = createAsyncThunk(
  "auth/login",
  async (payload, { rejectWithValue }) => {
    try {
      api.defaults.headers.Authorization = '';
      const response = await api.post("/auth",payload);
      setToken(response.data.token);
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
      const response = await api.delete("/auth");
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
