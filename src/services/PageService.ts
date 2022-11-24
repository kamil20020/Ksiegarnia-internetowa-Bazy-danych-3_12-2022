import axios from "axios"



export const PageService = {

    getPageData(){

        return axios.get('http://127.0.0.1:8000/books/all');
    }





}