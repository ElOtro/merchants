import { configureStore } from '@reduxjs/toolkit'

import authReducer from './session/authSlice'

export default configureStore({
  reducer: {
      auth: authReducer
  }
})