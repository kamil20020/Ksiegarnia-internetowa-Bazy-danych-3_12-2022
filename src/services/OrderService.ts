import axios from "axios";
import { stringify } from "querystring";
import { OrderBookDetails } from "../models/OrderBookDetails";
import { OrderStatus } from "../models/OrderStatus";
import { PersonalData } from "../models/PersonalData";
import { BasketProduct } from "../redux/slices/basketSlice";
import { Pagination } from "../models/Pagination";

export interface BasicBasketProduct {
    bookId: number,
    quantity: number
}

export interface CreateOrder {
    clientId: number,
    receiverData?: PersonalData,
    basketItems: BasicBasketProduct[],
}

export interface OrdersSearchCriteria{
    name?: string,
    surname?: string,
    email?: string,
    tel?: string,
    creationDateFrom?: Date,
    creationDateTo?: Date,
    status?: string,
    minPrice?: number,
    maxPrice?: number,
}

class OrderService {

    private apiUrl: string = `${process.env.REACT_APP_API_1 as string}/v1`

    searchOrders = (ordersCriteria: OrdersSearchCriteria, pagination: Pagination) => {
        return axios.get(`${this.apiUrl}/orders`, {
            params: {
                ...ordersCriteria,
                ...pagination
            }
        })
    }

    getById = (orderId: number) => {
        return axios.get(`${this.apiUrl}/order/${orderId}`)
    }

    getOrdersByClientId = (clientId: number) => {
        return axios.get(`${this.apiUrl}/orders/${clientId}`)
    }

    checkOrder = (createOrder: CreateOrder) => {
        return axios.post(`${this.apiUrl}/order/check`, createOrder)
    }

    placeOrder = (createOrder: CreateOrder) => {
        return axios.post(`${this.apiUrl}/order`, createOrder)
    }

    rollbackOrder = (orderId: number) => {
        return axios.put(`${this.apiUrl}/order/${orderId}/rollback`)
    }
}

export default new OrderService();