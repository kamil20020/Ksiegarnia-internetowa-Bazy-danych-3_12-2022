package pl.edu.pwr.ksiegarniainternetowa.service;

import pl.edu.pwr.ksiegarniainternetowa.model.entity.OrderStatusEntity;

public interface OrderStatusService {

    boolean existsById(Long id);
    OrderStatusEntity getByName(String name);
}
