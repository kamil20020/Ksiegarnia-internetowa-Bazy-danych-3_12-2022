import { Button, Checkbox, FormControl, FormControlLabel, FormGroup, FormLabel, Grid, OutlinedInput, Paper, TextField, Typography } from "@mui/material";
import { useState, useEffect } from "react";
import Book from "../../models/Book";
import { book1 } from "../../assets/books";
import BookHeader from "./BookHeader";
import BookCategory from "../../models/BookCategory";
import FormElement from "../../components/common/FormElement";
import DatePickerForm from "../../components/common/DatePickerForm";
import { privateDecrypt } from "crypto";
import BookService from "../../services/BookService"

export const books: Book[] = [
    {
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
    },
    {
        id: 2,
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
    },
    {
        id: 3,
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
    },
    {
        id: 4,
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
    },
    {
        id: 5,
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
    },
    {
        id: 6,
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
    },
    {
        id: 7,
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
    },
    {
        id: 8,
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
    },
    {
        id: 9,
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
]

const mockBookCategories: BookCategory[] = [
    {
        id: 1,
        name: 'Przygodowe'
    },
    {
        id: 2,
        name: 'Kryminalne'
    },
    {
        id: 3,
        name: 'Fantastyka'
    },
    {
        id: 4,
        name: 'Sci-fi'
    },
    {
        id: 5,
        name: 'Nauka'
    }
]

interface BookCategorySelect{
    id: number,
    name: string,
    checked: boolean
}

interface Form {
    author?: string,
    publisher?: string,
    releaseDate?: Date,
    priceFrom?: number,
    priceTo?: number
}

const Shop = () => {

    const [bookTitle, setBookTitle] = useState<string>('')
    const [bookCategories, setBookCategories] = useState<BookCategorySelect[]>(
        mockBookCategories.map((category: BookCategory) => (
            {
                id: category.id,
                name: category.name,
                checked: false
            }
        )
    ))

    const [form, setForm] = useState<Form>({})

    const [books, setBooks] = useState<Book[]>([])

    useEffect(() => {
        BookService.getAllAvailableBooks()
        .then((response) => {
            const newBooks = response.data
            setBooks(newBooks)
            console.log(newBooks)
        })
        .catch((error) => {
            console.log(error)
        })
    }, [])

    const handleChangeBookCategory = (event: React.ChangeEvent<HTMLInputElement>, checked: boolean) => {

        const bookCategoryId: number = +event.target.id

        let newBookCategories: BookCategorySelect[] = [...bookCategories]

        const changedBookCategoryIndex = newBookCategories.map((category: BookCategorySelect) => category.id)
        .indexOf(bookCategoryId)

        newBookCategories[changedBookCategoryIndex].checked = checked

        setBookCategories(newBookCategories)
    }

    const getBooksByCriterias = () => {





    }



    return (
        <Grid container justifyContent="center" marginTop={8}>
            <Grid item xs={11} container justifyContent="end">
                <Grid item xs={9} container spacing={3} alignItems="center">
                    <Grid item xs={10}>
                        <TextField
                            fullWidth   
                            placeholder="Podaj tytuł książki..."
                            value={bookTitle}
                            onChange={(event) => setBookTitle(event.target.value)}
                        />
                    </Grid>
                    <Grid item xs={2}>
                        <Button
                            fullWidth
                            variant="contained"
                            color="secondary"
                            sx={{padding: '14px 0px'}}
                            
                        >
                            Szukaj
                        </Button>
                    </Grid>
                </Grid>
            </Grid>
            <Grid item xs={11} container justifyContent="space-between" marginTop={8} columnSpacing={8}>
                <Grid item xs={3} container justifyContent="center" alignSelf="start">
                    <Paper sx={{padding: '10px 20px'}}>
                        <Typography component="h5" textAlign="left">
                            Gatunek
                        </Typography>
                        <FormControl component="fieldset" variant="standard">
                            <FormGroup>
                                {bookCategories.map((category: BookCategorySelect) => (
                                    <FormControlLabel
                                        key={category.id}
                                        label={category.name}
                                        control={
                                            <Checkbox
                                                id={category.id.toString()}
                                                checked={category.checked}
                                                onChange={handleChangeBookCategory}
                                            />
                                        }
                                    />
                                ))}
                            </FormGroup>
                        </FormControl>
                    </Paper>
                    <Grid item container rowSpacing={2} marginTop={4}>
                        <FormElement
                            fieldName="Autor:"
                            placeholder="Wpisz autora..."
                            value={form.author ? form.author : ''}
                            onChange={(event) => setForm({...form, author: event.target.value})}
                        />
                        <FormElement
                            fieldName="Wydawca:"
                            placeholder="Wpisz wydawcę..."
                            value={form.publisher ? form.publisher : ''}
                            onChange={(event) => setForm({...form, publisher: event.target.value})}
                        />
                        <DatePickerForm
                            fieldName="Data wydania"
                            placeholder="Wpisz datę..."
                            maxDate={new Date()}
                            value={form.releaseDate}
                            onChange={(newValue) => setForm({...form, releaseDate: newValue != null ? newValue : undefined})}
                        />
                        <Grid item container alignItems="center">
                            <Grid item xs={6}>
                                <Typography 
                                    textAlign="start" 
                                    variant="h6"
                                >
                                    Cena
                                </Typography>
                            </Grid>
                            <Grid item xs={6} container justifyContent="space-between" alignItems="center">
                                <Grid item xs={5}>
                                    <OutlinedInput
                                        fullWidth
                                        placeholder="Od"
                                        type="number"
                                        color="secondary"
                                        inputProps={{min: 0, max: form.priceTo}}
                                        value={form.priceFrom}
                                        onChange={(event) => setForm({...form, priceFrom: +event.target.value})}
                                    />
                                </Grid>
                                <Typography 
                                    textAlign="start"
                                    variant="h6"
                                >
                                    -
                                </Typography>
                                <Grid item xs={5}>
                                    <OutlinedInput
                                        fullWidth
                                        placeholder="Do"
                                        type="number"
                                        color="secondary"
                                        inputProps={{min: form.priceFrom}}
                                        value={form.priceTo}
                                        onChange={(event) => setForm({...form, priceTo: +event.target.value})}
                                    />
                                </Grid>
                            </Grid>
                        </Grid> 
                    </Grid>
                </Grid>
                <Grid item xs={9} container justifyContent="start" alignItems="center" rowSpacing={6}>
                    {books.map((b: Book) => (
                        <BookHeader key={b.id} book={b}/>
                    ))}
                </Grid>
            </Grid>
        </Grid>
    )
}

export default Shop;