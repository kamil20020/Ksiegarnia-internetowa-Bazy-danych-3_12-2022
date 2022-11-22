import MySQLdb as mc
from database.models import *
from database.serializers import BooksSerializer, BookAuthorshipsSerializer
def get_all_books():
    print("Getting books")
    all_entries = Books.objects.select_related('book_category','publisher','book_cover','language')
    list1 =[]
    for a in all_entries:
        list1.append(a.id)
    all_authors = BookAuthorships.objects.select_related('book_author').filter(book__in= list1)
    serializer = BookAuthorshipsSerializer('json',all_authors, many = True)
    print("-----------")
    print(serializer.data)
    print("-----------")
        # list1 =[]
        # for a in all_entries:
        #     list1.append(a.id)
        # all_authors = BookAuthorships.objects.select_related('book_author').filter(id= list1)



    # print(type(all_entries))
    # print(all_entries.query)
    # book_category_entries = all_entries.get(id=1).book_category
    # print(book_category_entries.name)
    # result_string = ""
    # for a in len(all_entries):
    #     temp = all_entries[a].id
    #     result_strin



    
    serializer = BooksSerializer(all_entries, many = True)
    return serializer.data
    




