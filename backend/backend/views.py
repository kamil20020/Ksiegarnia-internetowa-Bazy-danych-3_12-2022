from django.shortcuts import render
from database.database_module import database_executor as db
from django.http import HttpResponse

def get_books_list(request):
    books =db.get_all_books()
    if len(books) != 0:
        return HttpResponse(books, status=200)
    else:
        return HttpResponse(status=204)

    




def return_page(request):

    return render(request, "index.html")






