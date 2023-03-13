import { createSlice } from '@reduxjs/toolkit'
import {fetchUser, login, signOut} from './actions';

const initialState = {
    isLoading: false,
    isAuthenticated: false,
    isAuthorized: false,
    user: null
};

export const authSlice = createSlice({
    name: 'auth',
    initialState,
    reducers: null,
    extraReducers: {
        [signOut.fulfilled]: (state) => {
            state.isLoading = false;
            state.user = null;
        },
        // login
        [login.pending]: (state) => {
            state.isLoading = true;
        },
        [login.fulfilled]: (state) => {
            state.isAuthenticated = true;
            state.isLoading = false;
        },
        [login.rejected]: (state) => {
            state.isLoading = false;
        },
        // fetchUser
        [fetchUser.pending]: (state) => {
            state.isLoading = true;
            state.isAuthorized = false;
        },
        [fetchUser.fulfilled]: (state, action) => {
            const {data} = action.payload;
            state.user = data;
            state.isLoading = false;
            state.isAuthorized = true;
        },
        [fetchUser.rejected]: (state) => {
            state.isLoading = false;
            state.user = null;
            state.isAuthorized = false;
        }
    },
})


export default authSlice.reducer;