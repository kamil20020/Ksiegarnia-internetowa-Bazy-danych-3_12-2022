import { Grid } from "@mui/material";
import Order from "../../../models/Order";
import { OrderStatus } from "../../../models/OrderStatus";
import { books } from "../../shop/Shop";
import OrderDetails from "./OrderDetails";

const orders: Order[] = [
    {
        id: 1,
        status: OrderStatus.ACCEPTED,
        books: books,
        totalPrice: 20.11,
        creationDate: new Date(),
    },
    {
        id: 2,
        status: OrderStatus.COMPLETED,
        books: books,
        totalPrice: 32.31,
        creationDate: new Date(),
        fulfillmentDate: new Date(),
    },
    {
        id: 3,
        status: OrderStatus.CREATED,
        books: books,
        totalPrice: 42.65,
        creationDate: new Date(),
        fulfillmentDate: new Date(),
    },
    {
        id: 4,
        status: OrderStatus.PROCESSED,
        books: books,
        totalPrice: 121.89,
        creationDate: new Date(),
        fulfillmentDate: new Date(),
    },
]

const MyOrders = () => {
    return (
        <Grid item xs={10} container justifyContent="center" marginTop={10}>
            {orders.map((order: Order, index: number) => (
                <OrderDetails key={order.id} index={index} order={order}/>
            ))}
        </Grid>
    );
}

export default MyOrders;