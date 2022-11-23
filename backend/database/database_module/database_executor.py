import MySQLdb as mc
from database.models import *
from database.serializers import BooksSerializer,BooksSerializer2, BookAuthorshipsSerializer, BookCategoriesSerializer
import json


def get_start_page_data():
    all_entries = Books.objects.filter(is_available = 1)
    list1 = []
    dict1 = {}
    serializer = BooksSerializer(all_entries, many = True)
    res = json.dumps(serializer.data)
    dict1["books"] = res
    list1.append(dict1)
    

    dict2 = {}
    all_categories = BookCategories.objects.all()
    serializer = BookCategoriesSerializer(all_categories, many = True)
    res = json.dumps(serializer.data)
    dict2["categories"] = res
    list1.append(dict2)    
    ret = json.dumps(list1)
    print(ret)
    return ret
    


def find_books(title1: str, genre1: str, author1: str, publisher1: str, release1: str, min1: str, max1: str):
    all_entries = None
    if len(title1)> 0:
        if len(genre1)> 0:
            if len(publisher1)> 0:
                if len(release1)> 0:
                    if len(min1)> 0:
                        min2 = float(min1)
                        if len(max1)> 0:
                            max2 = float(max1)
                            list1 = []
                            all_entries = Books.objects.filter(is_available = 1, title = title1, genre = genre1, publisher = publisher1,
                                release_date= release1, price__ge = min2, price__le = max2).select_related('book_category','publisher','book_cover','language')








    # all_entries = Books.objects.filter(is_available = 1).select_related('book_category','publisher','book_cover','language')
    # list1 = []
    # for i in all_entries:
    #     dict1 = {}
    #     serializer = BooksSerializer(i)
    #     res = json.dumps(serializer.data)
    #     dict1["book"] = res
    #     authors = BookAuthorships.objects.select_related('book_author').filter(book = i.id)
    #     serializer2 = BookAuthorshipsSerializer(authors, many = True)
    #     res2 = json.dumps(serializer2.data)
    #     dict1["authors"] = res2
    #     list1.append(dict1)
    

    # dict1 = {}
    # all_categories = BookCategories.objects.all()
    # serializer = BookCategoriesSerializer(all_categories, many = True)
    # res = json.dumps(serializer.data)
    # dict1["categories"] = res
    # list1.append(dict1)    
    # ret = json.dumps(list1)
    # print(ret)
    # return ret

def get_book(id: int):
    all_entries = Books.objects.filter(is_available = 1, id = id).select_related('book_category','publisher','book_cover','language')
    list1 = []
    if (not(all_entries is None)) and len(all_entries) > 0:
        dict1 = {}
        serializer = BooksSerializer2(all_entries[0])
        res = json.dumps(serializer.data)
        dict1["book"] = res
        authors = BookAuthorships.objects.select_related('book_author').filter(book = all_entries[0].id)
        serializer2 = BookAuthorshipsSerializer(authors, many = True)
        res2 = json.dumps(serializer2.data)
        dict1["authors"] = res2
        list1.append(dict1)

        ret = json.dumps(list1)
        print(ret)
        return ret
    return ""