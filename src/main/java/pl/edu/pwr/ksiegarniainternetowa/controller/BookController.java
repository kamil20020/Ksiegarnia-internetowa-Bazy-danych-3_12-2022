package pl.edu.pwr.ksiegarniainternetowa.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.BookEntity;
import pl.edu.pwr.ksiegarniainternetowa.service.BookService;

@RestController
@RequestMapping(value = "/v1/book")
@RequiredArgsConstructor
public class BookController {

    private final BookService bookService;

    @GetMapping(value = "/{id}")
    public BookEntity getBookById(@PathVariable("id") Integer bookId) {
        return bookService.getBookById(bookId);
    }

}
