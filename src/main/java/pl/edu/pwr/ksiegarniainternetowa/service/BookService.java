package pl.edu.pwr.ksiegarniainternetowa.service;

import pl.edu.pwr.ksiegarniainternetowa.model.entity.BookEntity;

public interface BookService {

    boolean existsById(Long bookId);
    BookEntity getBookById(Long bookId);

}
