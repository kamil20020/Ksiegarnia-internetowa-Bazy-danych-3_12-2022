import axios from "axios"


class BookData{

    private apiUrl: string = `${process.env.REACT_APP_API_2 as string}`

    getBookData(id: number){

        return axios.get(`${this.apiUrl}/book/${id}`);
    }

    getFoundBooks(id: number, title:string, genre: string, authorFirstname: string, authorSurname: string,
         publisher: string, releaseData: string, min: number, max:number, check: string){

        return axios.get(`${this.apiUrl}/books/find/${title}/${genre}/${authorFirstname}/${authorSurname}/${publisher}/${releaseData}/${min}/${max}/${check}`);
    }

    getAllAvailableBooks(){

        return axios.get(`${this.apiUrl}/books/all`);
    }
}
export default new BookData();