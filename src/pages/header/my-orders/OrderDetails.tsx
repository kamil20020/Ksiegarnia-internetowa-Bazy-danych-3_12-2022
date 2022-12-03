import { Button, Grid, IconButton, Typography } from "@mui/material";
import moment from "moment";
import React from "react";
import CustomImage from "../../../components/common/CustomImage";
import XCloeasableDialog from "../../../components/common/XCloeasableDialog";
import Book from "../../../models/Book";
import Order from "../../../models/Order";
import { OrderBookDetails } from "../../../models/OrderBookDetails";
import { OrderStatus } from "../../../models/OrderStatus";
import { OrderWithDetails } from "../../../models/OrderWithDetails";
import { removeProduct, updateProductQuantity } from "../../../redux/slices/basketSlice";
import { DataRow } from "../../book-details/BookDetails";
import { mockedData } from "../../order/OrderView";
import OrderProduct from "./OrderProduct";

export interface OrderDetailsProps {
    index: number,
    orderWithDetails: OrderWithDetails
}

const OrderDetails = (props: OrderDetailsProps) => {

    const order = props.orderWithDetails

    const [showAllProducts, setShowAllProducts] = React.useState<boolean>(false)

    console.log(order)

    return (
        <Grid item container xs={10} justifyContent="space-between" marginBottom={4} rowSpacing={2}>
            <Grid item xs={12}>
                <Typography variant="h4">
                    Zamowienie {props.index+1}
                </Typography>
            </Grid>
            <Grid item xs={6}>
                {!showAllProducts ?
                    <OrderProduct book={order.books[0].book} quantity={order.books[0].quantity}/>
                :
                    order.books.map((bookDetails: OrderBookDetails) => (
                        <OrderProduct key={bookDetails.book.id} book={bookDetails.book} quantity={bookDetails.quantity}/>
                    ))
                }
                {order.books.length > 1 && 
                    <Button
                        variant="contained"
                        color="secondary"
                        onClick={() => setShowAllProducts(!showAllProducts)}
                    >
                        {!showAllProducts ? "Pokaż więcej produktów" : "Ukryj produkty"}
                    </Button>
                }
            </Grid>
            <Grid item xs={4} container direction="column" justifyContent="center" rowSpacing={2} marginBottom={10}>
                <DataRow title="Data utworzena:" value={moment(order.creationDate).format("DD.MM.YYYY").toLocaleString()}/>
                {order.fulfillmentDate && <DataRow title="Data realizacji:" value={moment(order.creationDate).format("DD.MM.YYYY").toLocaleString()}/>}
                <DataRow title="Status zamówienia:" value={order.status.name}/>
                <Grid item container justifyContent="center" marginTop={2}>
                    <Grid item xs={6}>
                        <XCloeasableDialog
                            title={`Dane odbiorcy zamówienia ${props.index+1}`}
                            buttonTitle="Dane odbiorcy"
                            showButton={true}
                            form={
                                <Grid item xs={8} container alignSelf="center" justifyContent="center" alignItems="center" rowSpacing={2}>
                                    <DataRow title="Imię:" value={mockedData.name}/>
                                    <DataRow title="Nazwisko:" value={mockedData.surname}/>
                                    <DataRow title="E-mail:" value={mockedData.email}/>
                                    <DataRow title="Telefon:" value={mockedData.telephone}/>
                                </Grid>
                            }
                        />
                    </Grid>
                </Grid>
                {order.status.name === "Utworzone" &&
                    <Grid item container justifyContent="center" marginTop={2}>
                        <Button
                            variant="contained"
                            color="error"
                        >
                            Wycofaj
                        </Button>
                    </Grid>
                }
            </Grid>
        </Grid>
    );
}

export default OrderDetails;

//<DataRow title="Data utworzena:" value={moment(order.creationDate).format("DD.MM.YYYY").toLocaleString()}/>
//{order.creationDate && <DataRow title="Data realizacji:" value={moment(order.creationDate).format("DD.MM.YYYY").toLocaleString()}/>}