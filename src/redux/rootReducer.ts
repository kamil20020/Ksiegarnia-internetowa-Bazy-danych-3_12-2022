import { combineReducers } from "@reduxjs/toolkit";
import notificationReducer from './slices/notificationSlice'
import basketReducer from './slices/basketSlice'

export const rootReducer = combineReducers({
    notification: notificationReducer,
    basket: basketReducer
})