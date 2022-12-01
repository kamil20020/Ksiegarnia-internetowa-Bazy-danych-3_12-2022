package pl.edu.pwr.ksiegarniainternetowa.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import pl.edu.pwr.ksiegarniainternetowa.exception.EntityNotFoundException;
import pl.edu.pwr.ksiegarniainternetowa.mapper.DateTimeMapper;
import pl.edu.pwr.ksiegarniainternetowa.model.api.request.CreateOrder;
import pl.edu.pwr.ksiegarniainternetowa.model.api.response.OrderWithDetails;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.*;
import pl.edu.pwr.ksiegarniainternetowa.repository.OrderRepository;
import pl.edu.pwr.ksiegarniainternetowa.service.*;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final ClientService clientService;
    private final BookItemService bookItemService;
    private final BookService bookService;
    private final PersonalDataService personalDataService;
    private final ReceiverDataService receiverDataService;
    private final OrderStatusService orderStatusService;
    private final OrderItemService orderItemService;

    private final DateTimeMapper dateTimeMapper = DateTimeMapper.INSTANCE;

    @Override
    public List<OrderWithDetails> getOrdersByClientId(Long clientId) throws EntityNotFoundException{

        if(!clientService.existsById(clientId)){
            throw new EntityNotFoundException("Nie istnieje klient o takim id");
        }

        List<OrderEntity> foundOrders = orderRepository.findAllByClientEntityId(clientId);

        return foundOrders.stream().map(orderEntity -> {

           OffsetDateTime offsetCreationDateTime = dateTimeMapper.localDateTimeToOffsetDateTime(
               orderEntity.getCreationDate()
           );

           OffsetDateTime fullfillmentDate = null;

           if(orderEntity.getFullfillmentDate() != null){
               fullfillmentDate = dateTimeMapper.localDateTimeToOffsetDateTime(
                   orderEntity.getFullfillmentDate()
               );
           }

           Map<Long, OrderWithDetails.OrderBookDetails> booksQuantities = new HashMap();

           BigDecimal totalPrice = BigDecimal.valueOf(0);

           orderEntity.getOrderItemEntityList().stream().forEach(orderItemEntity -> {
               Long bookId = orderItemEntity.getBookItemEntity().getBookEntity().getId();

               if(booksQuantities.containsKey(bookId)) {
                    OrderWithDetails.OrderBookDetails orderBookEntity = booksQuantities.get(bookId);
                    orderBookEntity.setQuantity(orderBookEntity.getQuantity());
               }
               else {
                   booksQuantities.put(
                       bookId,
                       new OrderWithDetails.OrderBookDetails(
                          orderItemEntity.getBookItemEntity().getBookEntity(),
                          1
                       )
                   );
               }

               totalPrice.add(orderItemEntity.getPrice());
           });

           return OrderWithDetails.builder()
               .id(orderEntity.getId())
               .creationDate(offsetCreationDateTime)
               .fullfillmentDate(fullfillmentDate)
               .totalPrice(totalPrice)
               .status(orderEntity.getOrderStatusEntity())
               .books(new ArrayList<OrderWithDetails.OrderBookDetails>(booksQuantities.values()))
           .build();
       }).collect(Collectors.toList());
    }

    @Override
    public void checkOrder(
        Long clientId,  PersonalDataEntity personalData, List<CreateOrder.BasketItem> basketItemList
    ){
        if(basketItemList == null || basketItemList.isEmpty()){
            throw new IllegalStateException("Koszyk jest pusty");
        }

        for(CreateOrder.BasketItem basketItem : basketItemList) {

            Long bookId = basketItem.getBookId();
            Integer quantity = basketItem.getQuantity();

            BookEntity foundBook = bookService.getBookById(bookId);

            if (!foundBook.getIsAvailable()) {
                throw new IllegalStateException(
                        "Książka o tytule " + foundBook.getTitle() + " jest niedostępna"
                );
            }

            int quantityDiff = quantity - foundBook.getNumOfBookItems();

            if (quantityDiff > 0) {
                throw new IllegalStateException(
                        "Nie ma na stanie odpowiedniej liczby książek dla tytułu " + foundBook.getTitle() +
                                " brakuje " + quantityDiff + " sztuk"
                );
            }
        }
    }

    @Transactional
    @Override
    public Long placeOrder(Long clientId, PersonalDataEntity personalData, List<CreateOrder.BasketItem> basketItemList)
        throws EntityNotFoundException, IllegalStateException
    {
        if(basketItemList == null || basketItemList.isEmpty()){
            throw new IllegalStateException("Koszyk jest pusty");
        }

        BigDecimal totalPrice = BigDecimal.valueOf(0);

        List<BookItemEntity> foundAvailableBookItems = new ArrayList<>();

        for(CreateOrder.BasketItem basketItem : basketItemList){

            Long bookId = basketItem.getBookId();
            Integer quantity = basketItem.getQuantity();

            BookEntity foundBook = bookService.getBookById(bookId);

            if(!foundBook.getIsAvailable()){
                throw new IllegalStateException(
                    "Książka o tytule " + foundBook.getTitle() + " jest niedostępna"
                );
            }

            int quantityDiff = quantity - foundBook.getNumOfBookItems();

            if(quantityDiff > 0){
                throw new IllegalStateException(
                    "Nie ma na stanie odpowiedniej liczby książek dla tytułu " + foundBook.getTitle() +
                    " brakuje " + quantityDiff + " sztuk"
                );
            }

            foundAvailableBookItems.addAll(
                bookItemService.getAvailableBookItemsByBookId(bookId).stream()
                    .limit(quantity)
                .collect(Collectors.toList())
            );

            totalPrice.add(foundBook.getPrice());
        }

        totalPrice = totalPrice.setScale(2, RoundingMode.HALF_EVEN);

        OrderStatusEntity orderStatus = orderStatusService.getByName("Utworzone");
        ClientEntity foundClientEntity = clientService.getById(clientId);

        ReceiverDataEntity receiverDataEntity = null;

        if(personalData != null){
            Long personalDataId = personalDataService.create(personalData);
            receiverDataEntity = receiverDataService.create(personalDataId);
        }

        OrderEntity placedOrder = OrderEntity.builder()
            .orderStatusEntity(orderStatus)
            .clientEntity(foundClientEntity)
            .receiverDataEntity(receiverDataEntity)
            .creationDate(LocalDateTime.now())
            .totalPrice(totalPrice)
        .build();

        OrderEntity createdOrder = orderRepository.save(placedOrder);

        foundAvailableBookItems.forEach(bookItemEntity -> {
            bookItemEntity.setIsPurchased(true);

            orderItemService.create(createdOrder, bookItemEntity, bookItemEntity.getBookEntity().getPrice());

            int numOfBookItems = bookItemEntity.getBookEntity().getNumOfBookItems();
            bookItemEntity.getBookEntity().setNumOfBookItems(numOfBookItems - 1);
        });

        return orderRepository.save(placedOrder).getId();
    }
}
