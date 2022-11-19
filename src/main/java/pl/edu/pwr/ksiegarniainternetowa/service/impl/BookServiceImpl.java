package pl.edu.pwr.ksiegarniainternetowa.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.BookEntity;
import pl.edu.pwr.ksiegarniainternetowa.repository.BookRepository;
import pl.edu.pwr.ksiegarniainternetowa.service.BookService;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {
    private final BookRepository bookRepository;

    @Override
    public BookEntity getBookById(Long bookId) {
        Optional<BookEntity> bookEntity = bookRepository.findById(bookId);
        // Optional, zeby mozna bylo ewentualnie wyrzucac wyjatki
        return bookEntity.get();
    }

}
