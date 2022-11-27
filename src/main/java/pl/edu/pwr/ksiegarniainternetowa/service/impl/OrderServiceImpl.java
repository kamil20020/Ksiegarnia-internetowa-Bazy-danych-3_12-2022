package pl.edu.pwr.ksiegarniainternetowa.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import pl.edu.pwr.ksiegarniainternetowa.exception.EntityNotFoundException;
import pl.edu.pwr.ksiegarniainternetowa.model.api.request.CreateOrder;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.*;
import pl.edu.pwr.ksiegarniainternetowa.repository.OrderRepository;
import pl.edu.pwr.ksiegarniainternetowa.service.*;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final ClientService clientService;
    private final BookItemService bookItemService;
    private final BookService bookService;
    private final PersonalDataSerivce personalDataSerivce;
    private final ReceiverDataService receiverDataService;
    private final OrderStatusService orderStatusService;
    private final OrderItemService orderItemService;

    @Override
    public List<OrderEntity> getOrdersByClientId(Long clientId) throws EntityNotFoundException{

        if(!clientService.existsById(clientId)){
            throw new EntityNotFoundException("Nie istnieje klient o takim id");
        }

        return orderRepository.findAllByClientEntityId(clientId);
    }

    @Transactional
    @Override
    public Long placeOrder(Long clientId, PersonalDataEntity personalData, List<CreateOrder.BasketItem> basketItemList)
        throws EntityNotFoundException, IllegalStateException
    {
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

            foundAvailableBookItems.addAll(bookItemService.getAvailableBookItemsByBookId(bookId));

            totalPrice.add(foundBook.getPrice());
        }

        totalPrice = totalPrice.setScale(2, RoundingMode.HALF_EVEN);

        OrderStatusEntity orderStatus = orderStatusService.getByName("Utworzone");
        ClientEntity foundClientEntity = clientService.getById(clientId);

        ReceiverDataEntity receiverDataEntity = null;

        if(personalData != null){
            Long personalDataId = personalDataSerivce.create(personalData);
            receiverDataEntity = receiverDataService.create(personalDataId);
        }

        OrderEntity placedOrder = OrderEntity.builder()
            .orderStatusEntity(orderStatus)
            .clientEntity(foundClientEntity)
            .receiverDataEntity(receiverDataEntity)
            .creationDate(LocalDateTime.now())
            .totalPrice(totalPrice)
        .build();

        foundAvailableBookItems.forEach(bookItemEntity -> {
            bookItemEntity.setIsPurchased(true);

            orderItemService.create(placedOrder, bookItemEntity, bookItemEntity.getBookEntity().getPrice());

            int numOfBookItems = bookItemEntity.getBookEntity().getNumOfBookItems();
            bookItemEntity.getBookEntity().setNumOfBookItems(numOfBookItems - 1);
        });

        return orderRepository.save(placedOrder).getId();
    }
}
