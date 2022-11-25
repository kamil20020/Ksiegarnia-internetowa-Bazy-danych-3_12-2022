import axios from "axios"

export interface BookSearchCriteria {
    id?: number, 
    title?:string, 
    genres?: string[], 
    author?: string,
    publisher?: string, 
    releaseDate?: Date, 
    minPrice?: number, 
    maxPrice?: number
}

class BookData{

    private apiUrl: string = `${process.env.REACT_APP_API_2 as string}`

    getBookData(id: number){

        return axios.get(`${this.apiUrl}/book/${id}`);
    }

    getFoundBooks(searchCriteria: BookSearchCriteria){

        return axios.get(`${this.apiUrl}/books/find/`, {
            params: {
              ...searchCriteria, genres: searchCriteria.genres?.join(',')
            },
        });
    }

    getAllAvailableBooks(){

        return axios.get(`${this.apiUrl}/books/all`);
    }
}
export default new BookData();