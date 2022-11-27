package pl.edu.pwr.ksiegarniainternetowa.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.edu.pwr.ksiegarniainternetowa.exception.EntityNotFoundException;
import pl.edu.pwr.ksiegarniainternetowa.model.api.request.CreateOrder;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.BookEntity;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.OrderEntity;
import pl.edu.pwr.ksiegarniainternetowa.service.OrderService;

import java.util.List;

@RestController
@RequestMapping(value = "/v1")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @GetMapping("/orders/{clientId}")
    public ResponseEntity getOrdersByClientId(@PathVariable("clientId") String clientIdStr){

        Long clientId;

        try{
            clientId = Long.valueOf(clientIdStr);
        }
        catch(NumberFormatException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Podano nieprawidłowe id klienta");
        }

        List<OrderEntity> foundOrders;

        try{
            foundOrders = orderService.getOrdersByClientId(clientId);
        }
        catch(EntityNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }

        return ResponseEntity.ok(foundOrders);
    }

    @PostMapping("/order")
    public ResponseEntity placeOrder(@RequestBody CreateOrder createOrderRequest){

        if(createOrderRequest == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Nie podano danych zamówienia");
        }

        if(createOrderRequest.getClientId() == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Nie podano id klienta");
        }

        if(createOrderRequest.getBasketItems() == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Nie podano produktów");
        }

        Long placedOrderId;

        try{
            placedOrderId = orderService.placeOrder(
                createOrderRequest.getClientId(), createOrderRequest.getBasketItems()
            );
        }
        catch(EntityNotFoundException e){

        }

        return ResponseEntity.status(HttpStatus.CREATED).body(placedOrderId);
    }
}
