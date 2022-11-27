package pl.edu.pwr.ksiegarniainternetowa.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import pl.edu.pwr.ksiegarniainternetowa.exception.EntityNotFoundException;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.PersonalDataEntity;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.ReceiverDataEntity;
import pl.edu.pwr.ksiegarniainternetowa.repository.ReceiverDataRepository;
import pl.edu.pwr.ksiegarniainternetowa.service.PersonalDataSerivce;
import pl.edu.pwr.ksiegarniainternetowa.service.ReceiverDataService;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReceiverDateServiceImpl implements ReceiverDataService {

    private final ReceiverDataRepository receiverDataRepository;
    private final PersonalDataSerivce personalDataSerivce;

    @Override
    public ReceiverDataEntity create(Long personalDataId) throws EntityNotFoundException {

        PersonalDataEntity personalDataEntity = personalDataSerivce.getById(personalDataId);

        ReceiverDataEntity receiverDataEntity = ReceiverDataEntity.builder()
            .personalDataEntity(personalDataEntity)
        .build();

        return receiverDataRepository.save(receiverDataEntity);
    }
}
