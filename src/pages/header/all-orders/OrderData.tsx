import { Grid, Typography, Button, FormControl, MenuItem, Select } from "@mui/material"
import moment from "moment"
import React, { useEffect, useState } from "react"
import { useDispatch } from "react-redux"
import { useParams } from "react-router-dom"
import XCloeasableDialog from "../../../components/common/XCloeasableDialog"
import { OrderBookDetails } from "../../../models/OrderBookDetails"
import { OrderWithDetails } from "../../../models/OrderWithDetails"
import { setNotificationMessage, setNotificationType, setNotificationStatus } from "../../../redux/slices/notificationSlice"
import OrderService from "../../../services/OrderService"
import { DataRow } from "../../book-details/BookDetails"
import OrderProduct from "../my-orders/OrderProduct"
import { OrderStatus } from "../../../models/OrderStatus"
import { SelectChangeEvent } from "@mui/material"

const OrderData = () => {

    let orderId: any = useParams().orderId
    const [order, setOrder] = useState<OrderWithDetails>()
    const [orderStatuses, setOrderStatuses] = useState<OrderStatus[]>([])

    const [showAllProducts, setShowAllProducts] = React.useState<boolean>(false)

    const dispatch = useDispatch()

    useEffect(() => {
        OrderService.getById(+orderId)
        .then((response) => {
            setOrder(response.data)
        })
        .catch((error) => {
            dispatch(setNotificationMessage(error.message.data));
            dispatch(setNotificationType("error"));
            dispatch(setNotificationStatus(true));
        })
    }, [])

    if(!order){
        return <div>Ładowanie...</div>
    }

    const handleUpdateOrder = (event: SelectChangeEvent) => {
        const orderStatusId: number = +event.target.value
        setOrder({
            ...order, 
            status:  orderStatuses.filter((status: OrderStatus) => status.id == orderStatusId)[0]
        });
    }

    return (
        <Grid item container xs={10} justifyContent="space-between" alignSelf="start" marginBottom={4}  marginTop={8} rowSpacing={2}>
            <Grid item xs={12} marginBottom={4}>
                <Typography variant="h3">
                    Zamówienie {order.id}
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
                <Typography variant="h4" textAlign="center" marginTop={5} marginBottom={2}>
                    Dane zamówienia
                </Typography>
                <DataRow title="Data utworzenia:" value={moment(order.creationDate).format("DD.MM.YYYY").toLocaleString()}/>
                {order.fulfillmentDate && <DataRow title="Data realizacji:" value={moment(order.creationDate).format("DD.MM.YYYY").toLocaleString()}/>}
                <DataRow title="Łączna kwota:" value={`${order.totalPrice} zł`}/>
                <Grid container>
                    <Grid item xs={6}>
                        <Typography variant="h4">
                            Dane zamówienia
                        </Typography>
                    </Grid>
                    <Grid item xs={6}>
                        <FormControl fullWidth>
                            <Select
                                value={order.status.id.toString()}
                                label="Status"
                                onChange={handleUpdateOrder}
                            >
                                {orderStatuses.map((status: OrderStatus) => (
                                    <MenuItem key={status.id} value={status.id}>{status.name}</MenuItem>
                                ))}
                            </Select>
                        </FormControl>
                    </Grid>
                </Grid>
                <DataRow title="Status zamówienia:" value={order.status.name}/>
                <Typography variant="h4" textAlign="center" marginTop={5} marginBottom={2}>
                    Dane odbiorcy
                </Typography>
                <DataRow title="Imię:" value={order.receiverData.name}/>
                <DataRow title="Nazwisko:" value={order.receiverData.surname}/>
                <DataRow title="E-mail:" value={order.receiverData.email}/>
                <DataRow title="Telefon:" value={order.receiverData.tel ? order.receiverData.tel : ''}/>
            </Grid>
        </Grid>
    );
}

export default OrderData;