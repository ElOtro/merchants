import { configureStore } from '@reduxjs/toolkit'

import authReducer from './session/authSlice'
import transactionsReducer from './transactions/transactionsSlice'
import merchantsReducer from './merchants/merchantsSlice'

export default configureStore({
  reducer: {
      auth: authReducer,
      merchants: merchantsReducer,
      transactions: transactionsReducer
  }
})