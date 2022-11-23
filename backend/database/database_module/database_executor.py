import MySQLdb as mc
from database.models import *
from database.serializers import BooksSerializer, BookAuthorshipsSerializer
import json


def get_all_books():
    print("Getting books")
    all_entries = Books.objects.filter(is_available = 1).select_related('book_category','publisher','book_cover','language')
    list1 = []
    for i in all_entries:
        dict1 = {}
        serializer = BooksSerializer(i)
        res = json.dumps(serializer.data)
        dict1["book"] = res
        authors = BookAuthorships.objects.select_related('book_author').filter(book = i.id)
        serializer2 = BookAuthorshipsSerializer(authors, many = True)
        res2 = json.dumps(serializer2.data)
        dict1["authors"] = res2
        list1.append(dict1)
    
    ret = json.dumps(list1)

    return ret
    




