export default interface Book{
    id: number,
    title: string,
    authors: string[],
    category: string,
    publisher: string,
    cover: string,
    language: string,
    avatar?: string,
    description?: string,
    isbn?: string,
    release_number?: number,
    release_date?: Date,
    size: string,
    number_of_pages: string,
    price: number
}