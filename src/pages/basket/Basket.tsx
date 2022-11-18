import { Button, Grid, Typography } from "@mui/material";
import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Book } from "../../models/Book";
import { BasketProduct } from "../../redux/slices/basketSlice";
import { RootState } from "../../redux/store";
import { books } from "../shop/Shop";
import BasketProductView from "./BasketProductView";

export interface BasketProductWithDetails {
    product: Book,
    quantity: number
}

const Basket = () => {

    const basketProducts = useSelector((state: RootState) => state.basket).products
    const dispatch = useDispatch()

    const [basketProductsWithDetails, setBasketProductsWithDetails] = useState<BasketProductWithDetails[]>([])
    const [totalPrice, setTotalPrice] = useState<number>(0);

    useEffect(() => {

        let newBasketProductsWithDetails: BasketProductWithDetails[] = []

        let newTotalPrice = 0

        basketProducts.forEach((basketProduct: BasketProduct) => {
            const book = books.filter((book: Book) => book.id == basketProduct.id)[0]
            newBasketProductsWithDetails.push({
                product: book,
                quantity: basketProduct.quantity
            });
            newTotalPrice += book.price * basketProduct.quantity
        })

        setBasketProductsWithDetails(newBasketProductsWithDetails)
        setTotalPrice(+newTotalPrice.toFixed(2))
    }, [basketProducts])

    return (
        <Grid item xs={10} alignSelf="start" container justifyContent="space-between" marginTop={8}>
            <Grid item xs={6} container direction="column">
                <Grid item marginBottom={6}>
                    <Typography variant="h4">
                        Koszyk ({basketProducts.length})
                    </Typography>
                </Grid>
                <Grid item container>
                    {basketProductsWithDetails.map((book: BasketProductWithDetails, index: number) => (
                        <BasketProductView key={book.product.id} book={book} index={index}/>
                    ))}
                </Grid>
            </Grid>
            <Grid item xs={5} container direction="column" marginTop={14} rowSpacing={4}>
                <Grid item container justifyContent="center">
                    <Typography variant="h4" textAlign="end">
                        Łączna kwota: {totalPrice} zł
                    </Typography>
                </Grid>
                <Grid item container justifyContent="center">
                    <Button
                        variant="contained"
                        color="secondary"
                    >
                        Złóż zamówienie
                    </Button>
                </Grid>
            </Grid>
        </Grid>
    );
}

export default Basket