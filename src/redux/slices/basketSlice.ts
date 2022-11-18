import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { Book } from "../../models/Book";

export interface BasketProduct {
    id: number,
    quantity: number
}

export interface BasketState {
    products: BasketProduct[]
}

const initialState: BasketState = {
    products: []
}

export const basketSlice = createSlice({
    name: 'basket',
    initialState,
    reducers: {
        addProduct(state, action: PayloadAction<number>){
            const newProductId = action.payload

            if(!state.products.map((p: BasketProduct) => p.id).includes(newProductId)){
                state.products = [...state.products, {id: newProductId, quantity: 1}]
            }
        },
        updateProductQuantity(state, action: PayloadAction<BasketProduct>){
            const data = action.payload
            if(data.quantity <= 0){
                return
            }
            let newProducts = [...state.products]
            newProducts[data.id].quantity = data.quantity
            state.products = newProducts
        },
        removeProduct(state, action: PayloadAction<number>){
            state.products.splice(action.payload)
        },
        clear(state){
            state.products = []
        }
    }
})

export const { addProduct, removeProduct, updateProductQuantity, clear } = basketSlice.actions
export default basketSlice.reducer