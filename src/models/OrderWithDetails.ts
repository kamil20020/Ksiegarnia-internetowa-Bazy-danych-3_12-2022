import { OrderBookDetails } from "./OrderBookDetails";
import { OrderStatus } from "./OrderStatus";
import { PersonalData } from './PersonalData'

export interface OrderWithDetails {
    id: number,
    creationDate: Date,
    fulfillmentDate?: Date,
    totalPrice: number,
    status: OrderStatus,
    books: OrderBookDetails[],
    receiverData: PersonalData
}