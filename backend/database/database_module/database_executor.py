import MySQLdb as mc
from database.models import *
from database.serializers import BooksSerializer
def get_all_books():
    print("Getting books")
    all_entries = Books.objects.select_related('book_category','publisher','book_cover','language')
    all_entries = Books.objects.prefetch_related('book_category').values('name')
    print(all_entries)
    for a in all_entries:
        print(a)

    #all_entries = Books.objects.all()
    serializer = BooksSerializer(all_entries, many = True)
    return serializer.data
    




