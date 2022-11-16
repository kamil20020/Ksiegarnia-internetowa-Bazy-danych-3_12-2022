import { combineReducers } from "@reduxjs/toolkit";
import notificationReducer from './slices/notificationSlice'

export const rootReducer = combineReducers({
    notification: notificationReducer
})