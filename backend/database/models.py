from django.db import models


class Languages(models.Model):
    name = models.CharField(max_length=32)


    class Meta:
        db_table = "Languages"


class BookCovers(models.Model):
    name = models.CharField(max_length=20)


    class Meta:
        db_table = "BookCovers"


class Publishers(models.Model):
    name= models.CharField(max_length=50)


    class Meta:
        db_table = "Publishers"

class BookCategories(models.Model):
    name = models.CharField(max_length=22)


    class Meta:
        db_table = "BookCategories"


class Books(models.Model):
    book_category = models.ForeignKey(BookCategories, on_delete=models.CASCADE)
    publisher = models.ForeignKey(Publishers, on_delete=models.CASCADE)
    book_cover = models.ForeignKey(BookCovers, on_delete=models.CASCADE)
    language= models.ForeignKey(Languages, on_delete=models.CASCADE)
    title=models.CharField(max_length=100)
    description= models.TextField()
    isbn= models.CharField(max_length=20)
    release_number = models.IntegerField()
    release_date = models.DateField()
    size = models.CharField(max_length=11)
    price = models.DecimalField(max_digits=6,decimal_places=2)
    is_available = models.BooleanField()
    num_of_book_items = models.IntegerField()
    number_of_pages = models.CharField(max_length = 20)
    avatar = models.BinaryField()


    class Meta:
        db_table = "Books"


class BookAuthors(models.Model):
    firstname = models.CharField(max_length=32)
    surname = models.CharField(max_length=32)


    class Meta:
        db_table = "BookAuthors"


class BookAuthorships(models.Model):
    book = models.ForeignKey(Books, on_delete=models.CASCADE)
    book_author = models.ForeignKey(BookAuthors, on_delete=models.CASCADE)


    class Meta:
        db_table = "BookAuthorships"




    







