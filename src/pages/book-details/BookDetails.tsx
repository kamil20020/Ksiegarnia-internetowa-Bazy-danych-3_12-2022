import { Button, Grid, Paper, Typography } from "@mui/material";
import { makeStyles } from "@mui/styles";
import { useState } from "react";
import { useParams } from "react-router-dom";
import { book1 } from "../../assets/books";
import CustomImage from "../../components/common/CustomImage";
import { Book } from "../../models/Book";
import BottomNavigation from "../../components/common/BottomNavigation";
import { useDispatch, useSelector } from "react-redux";
import { addProduct, BasketProduct } from "../../redux/slices/basketSlice";
import { RootState } from "../../redux/store";
import NotFound from "../errors/NotFound";

const book: Book = {
    id: 1,
    title: 'Ostatnie życzenie. Wiedźmin. Tom 1',
    authors: ['Sapkowski Andrzej'],
    category: 'Przygodowe',
    publisher: 'SUPERNOWA',
    cover: 'okładka miękka',
    language: 'polski',
    avatar: book1,
    description: 'Ostatnie życzenie. Wiedźmin, Tom 1',
    isbn: '978-83-01-00000-1',
    release_number: 1,
    release_date: new Date('2014-10-06'),
    size: '195 x 24 x 125',
    number_of_pages: '332',
    price: 39.92
}

const BookDetails = () => {

    const bookId = useParams().bookId

    const basketItems = useSelector((state: RootState) => state.basket).products

    const dispatch = useDispatch()

    const [isShowingDetails, setIsShowingDetails] = useState<boolean>(false)

    if(!bookId){
        return <NotFound />
    }

    const DataRow = (props: {title: string, value: string}) => {
        return (
            <Grid item container>
                <Grid item xs={6}>
                    <Typography variant="h6">{props.title}</Typography>
                </Grid>
                <Grid item xs={6}>
                    <Typography variant="h6">{props.value}</Typography>
                </Grid>
            </Grid>
        )
    }

    const doBasketHave = (): boolean => {
        return basketItems.map((p: BasketProduct) => p.id).includes(+bookId)
    }
    
    const handleAddToBasket = () => {
        if(!doBasketHave()){
            dispatch(addProduct(+bookId))
        }
    }

    return (
        <Grid item xs={11} container justifyContent="center" alignSelf="start" justifySelf="center" marginTop={10} paddingBottom={20}>
            <Grid item xs={5} container justifyContent="center" marginRight={20}>
                <CustomImage img={book.avatar} width={260} height={444}/>
            </Grid>
            <Grid item xs={5} container justifyContent="center" direction="column" rowSpacing={4}>
                <Grid item>
                    <Typography variant="h4">{book.title}</Typography>
                </Grid>
                <DataRow title={"Autorzy"} value={book.authors.toString()}/>
                <DataRow title={"Wydawnictwo"} value={book.publisher}/>
                <DataRow title={"Data wydania"} value={book.release_date?.toLocaleDateString() as string}/>
                <DataRow title={"Liczba stron"} value={book.number_of_pages}/>
                <Grid item container marginTop={2} justifyContent="space-between">
                    <Grid item xs={5}>
                        <Button
                            fullWidth
                            variant="contained"
                            color={!doBasketHave() ? "primary" : "info"}
                            onClick={handleAddToBasket}
                        >
                            {!doBasketHave() ? "Dodaj do koszyka" : "Dodany do koszyka"}
                        </Button>
                    </Grid>
                    <Grid item xs={6}>
                        <Typography variant="h5">{book.price} zł</Typography>
                    </Grid>
                </Grid>
            </Grid>
            <Grid item xs={10} container justifyContent="center" marginTop={8}>
                <Paper sx={{width: '100%', padding: 5}}>
                    {book.description}
                </Paper>
                <Grid item xs={11} marginTop={2}>
                    <Button variant="text" color="secondary" sx={{ color: "#2E9BFF" }} onClick={() => setIsShowingDetails(!isShowingDetails)}>
                        {!isShowingDetails ? "Więcej szczegółów" : "Mniej szczegółów"}
                    </Button>
                </Grid>
                {isShowingDetails && 
                    <Grid item xs={5} container justifyContent="center" justifySelf="center" direction="column" rowSpacing={4} marginTop={4}>
                         <DataRow title={"ISBN"} value={book.isbn as string}/>
                         <DataRow title={"Numer wydania"} value={book.release_number ? book.release_number.toString() : ''}/>
                         <DataRow title={"Język"} value={book.language}/>
                         <DataRow title={"Oprawa"} value={book.cover}/>
                         <DataRow title={"Wymiary"} value={book.size}/>
                    </Grid>
                }
            </Grid>
            <BottomNavigation text={"Wróć do wyszukiwarki"} path="../"/>
        </Grid>
    );
}

export default BookDetails;