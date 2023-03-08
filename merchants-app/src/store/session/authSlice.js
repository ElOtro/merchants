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
        [signOut.pending]: (state) => {
            state.isLoading = true;
        },
        [signOut.fulfilled]: (state) => {
            state.isAuthenticated = false;
            state.isAuthorized = false;
            state.isLoading = false;
            state.user = null;
        },
        [signOut.rejected]: (state) => {
            state.isLoading = false;
        },
        // login
        [login.pending]: (state) => {
            state.isLoading = true;
        },
        [login.fulfilled]: (state, action) => {
            const {user} = action.payload;
            state.isAuthenticated = true;
            state.isAuthorized = true;
            state.isLoading = false;
            state.user = user;
        },
        [login.rejected]: (state) => {
            state.isLoading = false;
        },
    },
})


export default authSlice.reducer;