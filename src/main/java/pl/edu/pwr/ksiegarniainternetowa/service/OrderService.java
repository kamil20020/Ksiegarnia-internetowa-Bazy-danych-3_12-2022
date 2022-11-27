package pl.edu.pwr.ksiegarniainternetowa.service;

import pl.edu.pwr.ksiegarniainternetowa.model.api.request.CreateOrder;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.OrderEntity;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.PersonalDataEntity;

import java.util.List;

public interface OrderService {

    List<OrderEntity> getOrdersByClientId(Long clientId);
    Long placeOrder(Long clientId, PersonalDataEntity personalData, List<CreateOrder.BasketItem> basketItemList);
}
