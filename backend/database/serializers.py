from rest_framework import serializers
from database.models import *
from database.class_attributes import ClassAttributes

class BooksSerializer(serializers.ModelSerializer):
    

    class Meta:
        model=Books
        fields = ClassAttributes.get_class_attributes(Books)










