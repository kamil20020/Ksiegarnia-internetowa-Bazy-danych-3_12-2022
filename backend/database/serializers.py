from rest_framework import serializers
from database.models import *
from database.class_attributes import ClassAttributes

class BooksSerializer(serializers.ModelSerializer):
    book_category = serializers.CharField(source='book_category.name')
    publisher = serializers.CharField(source='publisher.name')
    book_cover = serializers.CharField(source='book_cover.name')
    language = serializers.CharField(source='language.name')


    class Meta:
        model=Books
        fields = ['title', 'description', 'isbn', 'release_number', 'release_date', 'size', 'price', 'is_available', 'num_of_book_items', 
        'number_of_pages', 'avatar','book_category','publisher','book_cover','language']


class BookAuthorshipsSerializer(serializers.ModelSerializer):
    author_name = serializers.CharField(source='book_author.firstname')
    author_surname = serializers.CharField(source='book_author.surname')


    class Meta:
        model= BookAuthorships
        fields = ['book', 'author_name', 'author_surname']








