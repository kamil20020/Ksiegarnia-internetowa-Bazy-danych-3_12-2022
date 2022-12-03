package pl.edu.pwr.ksiegarniainternetowa.service;

import pl.edu.pwr.ksiegarniainternetowa.exception.EntityNotFoundException;
import pl.edu.pwr.ksiegarniainternetowa.model.api.request.CreateOrder;
import pl.edu.pwr.ksiegarniainternetowa.model.api.response.OrderWithDetails;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.OrderEntity;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.OrderStatusEntity;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.PersonalDataEntity;

import javax.transaction.Transactional;
import java.util.List;

public interface OrderService {

    List<OrderWithDetails> getOrdersByClientId(Long clientId);

    void checkOrder(Long clientId, PersonalDataEntity personalData, List<CreateOrder.BasketItem> basketItemList);

    Long placeOrder(Long clientId, PersonalDataEntity personalData, List<CreateOrder.BasketItem> basketItemList);

    OrderStatusEntity changeOrderStatus(Long orderId, OrderStatusEntity orderStatusEntity);
}
