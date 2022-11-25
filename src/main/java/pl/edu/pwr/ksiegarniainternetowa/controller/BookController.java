package pl.edu.pwr.ksiegarniainternetowa.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.pwr.ksiegarniainternetowa.exception.EntityNotFoundException;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.BookEntity;
import pl.edu.pwr.ksiegarniainternetowa.service.BookService;

@RestController
@RequestMapping(value = "/v1/book")
@RequiredArgsConstructor
public class BookController {

    private final BookService bookService;

    @GetMapping(value = "/{id}")
    public ResponseEntity getBookById(@PathVariable("id") String bookIdStr) {

        Long bookId;

        try{
            bookId = Long.valueOf(bookIdStr);
        }
        catch(NumberFormatException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Podano nieprawidłowe id książki");
        }

        BookEntity bookEntity;

        try{
            bookEntity = bookService.getBookById(bookId);
        }
        catch(EntityNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }

        return ResponseEntity.ok(bookEntity);
    }
}
