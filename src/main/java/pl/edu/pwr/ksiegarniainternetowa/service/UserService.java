package pl.edu.pwr.ksiegarniainternetowa.service;

import pl.edu.pwr.ksiegarniainternetowa.model.entity.UserEntity;

public interface UserService {
    UserEntity save(UserEntity userEntity);
}