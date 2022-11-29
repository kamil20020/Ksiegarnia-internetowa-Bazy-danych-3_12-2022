import axios from "axios";
import { OrderBookDetails } from "../models/OrderBookDetails";
import { OrderStatus } from "../models/OrderStatus";
import { PersonalData } from "../models/PersonalData";
import { BasketProduct } from "../redux/slices/basketSlice";

export interface BasicBasketProduct {
    bookId: number,
    quantity: number
}

export interface CreateOrder {
    clientId: number,
    personalData?: PersonalData,
    basketItems: BasicBasketProduct[],
}

class OrderService {

    private apiUrl: string = `${process.env.REACT_APP_API_1 as string}/v1`

    getOrdersByClientId = (clientId: number) => {
        return axios.get(`${this.apiUrl}/orders/${clientId}`)
    }

    checkOrder = (createOrder: CreateOrder) => {
        return axios.post(`${this.apiUrl}/order/check`, createOrder)
    }

    placeOrder = (createOrder: CreateOrder) => {
        return axios.post(`${this.apiUrl}/order`, createOrder)
    }
}

export default new OrderService();