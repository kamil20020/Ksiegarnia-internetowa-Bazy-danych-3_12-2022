import Book from "./Book";
import { OrderStatus } from "./OrderStatus";

export default interface Order{
    id: number,
    status: OrderStatus,
    books: Book[],
    totalPrice: number,
    creationDate: Date,
    fulfillmentDate?: Date
}