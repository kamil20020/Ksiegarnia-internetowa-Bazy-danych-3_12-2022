package pl.edu.pwr.ksiegarniainternetowa.service;

import pl.edu.pwr.ksiegarniainternetowa.model.entity.PersonalDataEntity;

import java.util.Optional;

public interface PersonalDataSerivce {

    PersonalDataEntity getById(Long id);
    Long create(PersonalDataEntity personalDataEntity);
}
