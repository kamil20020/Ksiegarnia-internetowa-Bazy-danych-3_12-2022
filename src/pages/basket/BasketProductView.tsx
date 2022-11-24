import { Grid, IconButton, Typography } from "@mui/material";
import CustomImage from "../../components/common/CustomImage";
import Book from "../../models/Book";
import AddIcon from '@mui/icons-material/Add';
import RemoveIcon from '@mui/icons-material/Remove';
import DeleteOutlineIcon from '@mui/icons-material/DeleteOutline';
import { BasketProductWithDetails } from "./Basket";
import { useDispatch } from "react-redux";
import { removeProduct, updateProductQuantity } from "../../redux/slices/basketSlice";

const BasketProductView = (props: {book: BasketProductWithDetails, index: number}) => {

    const book = props.book.product

    const dispatch = useDispatch()

    return (
        <Grid item container border="1px solid black" padding={2} marginBottom={4}>
            <Grid item xs={3} container justifyContent="center" marginRight={6}>
                <CustomImage img={book.avatar}/>
            </Grid>
            <Grid item xs={8} container direction="column">
                <Grid item xs={2} container alignItems="center">
                    <Grid item xs={10}>
                        <Typography variant="h5">{book.title}</Typography>
                    </Grid>
                    <Grid item xs={2} container justifyContent="end">
                        <IconButton
                            onClick={() => dispatch(removeProduct(props.index))}
                        >
                            <DeleteOutlineIcon fontSize="large"/>
                        </IconButton>
                    </Grid>
                </Grid>
                <Grid item xs={6} marginTop={1.5}>
                    <Typography variant="h6">{book.authors.join(' ')}</Typography>
                </Grid>
                <Grid item xs={2} container justifyContent="space-between" alignItems="center">
                    <Grid item xs={6} container alignItems="center">
                        <IconButton
                            onClick={() => dispatch(updateProductQuantity({id: props.index, quantity: props.book.quantity+1}))}
                        >
                            <AddIcon />
                        </IconButton>
                        <Grid item>
                            <Typography variant="h5">{props.book.quantity}</Typography>
                        </Grid>
                        <IconButton
                            onClick={() => dispatch(updateProductQuantity({id: props.index, quantity: props.book.quantity-1}))}
                        >
                            <RemoveIcon />
                        </IconButton>
                    </Grid>
                    <Grid item xs={6}>
                        <Typography variant="h5" textAlign="end">{book.price} zł</Typography>
                    </Grid>
                </Grid>
            </Grid>
        </Grid>
    );
}

export default BasketProductView;