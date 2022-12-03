package pl.edu.pwr.ksiegarniainternetowa.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.edu.pwr.ksiegarniainternetowa.exception.EntityNotFoundException;
import pl.edu.pwr.ksiegarniainternetowa.model.api.request.CreateOrder;
import pl.edu.pwr.ksiegarniainternetowa.model.api.response.OrderWithDetails;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.OrderEntity;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.OrderStatusEntity;
import pl.edu.pwr.ksiegarniainternetowa.service.OrderService;
import pl.edu.pwr.ksiegarniainternetowa.service.OrderStatusService;

import java.util.List;

@RestController
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:8000", "https://booksshop-dr.azurewebsites.net"})
@RequestMapping(value = "/v1")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final OrderStatusService orderStatusService;

    @GetMapping("/orders/{clientId}")
    public ResponseEntity getOrdersByClientId(@PathVariable("clientId") String clientIdStr){

        Long clientId;

        try{
            clientId = Long.valueOf(clientIdStr);
        }
        catch(NumberFormatException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Podano nieprawidłowe id klienta");
        }

        List<OrderWithDetails> foundOrders;

        try{
            foundOrders = orderService.getOrdersByClientId(clientId);
        }
        catch(EntityNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }

        return ResponseEntity.ok(foundOrders);
    }

    @PostMapping("/order/check")
    public ResponseEntity checkOrder(@RequestBody CreateOrder createOrderRequest){
        if(createOrderRequest == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Nie podano danych zamówienia");
        }

        if(createOrderRequest.getClientId() == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Nie podano id klienta");
        }

        if(createOrderRequest.getBasketItems() == null || createOrderRequest.getBasketItems().isEmpty()){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Nie podano produktów");
        }

        try{
            orderService.checkOrder(
                createOrderRequest.getClientId(),
                createOrderRequest.getPersonalData(),
                createOrderRequest.getBasketItems()
            );
        }
        catch(EntityNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
        catch(IllegalStateException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
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
                createOrderRequest.getClientId(),
                createOrderRequest.getPersonalData(),
                createOrderRequest.getBasketItems()
            );
        }
        catch(EntityNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
        catch(IllegalStateException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }

        return ResponseEntity.status(HttpStatus.CREATED).body(placedOrderId);
    }

    @PutMapping("/orders/{orderId}/rollback")
    public ResponseEntity rollbackOrder(@PathVariable("orderId") String orderIdStr){

        Long orderId;

        try{
            orderId = Long.valueOf(orderIdStr);
        }
        catch(NumberFormatException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Podano nieprawidłowe id zamówienia");
        }

        OrderStatusEntity newOrderStatus;

        try{
            newOrderStatus = orderService.changeOrderStatus(orderId, orderStatusService.getByName("Utworzone"));
        }
        catch(EntityNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }

        return ResponseEntity.ok(newOrderStatus);
    }

    @PutMapping("/orders/{orderId}")
    public ResponseEntity updateOrderStatus(@PathVariable("orderId") String orderIdStr, OrderStatusEntity newOrderStatus){

        if(newOrderStatus == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Nie podano statusu zamówienia");
        }

        Long orderId;

        try{
            orderId = Long.valueOf(orderIdStr);
        }
        catch(NumberFormatException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Podano nieprawidłowe id zamówienia");
        }

        OrderStatusEntity updatedOrderStatus;

        try{
            updatedOrderStatus = orderService.changeOrderStatus(orderId, newOrderStatus);
        }
        catch(EntityNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }

        return ResponseEntity.ok(updatedOrderStatus);
    }
}
