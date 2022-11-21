from django.shortcuts import render
from backend.database import database_connection as db

def get_books_list():
    return None




def render_react(request):
    books = get_books_list()
    db.connect()

    return render(request, "index.html")






