import { OrderBookDetails } from "./OrderBookDetails";
import { OrderStatus } from "./OrderStatus";

export interface OrderWithDetails {
    id: number,
    creationDate: Date,
    fulfillmentDate?: Date,
    totalPrice: number,
    status: OrderStatus,
    books: OrderBookDetails[]
}