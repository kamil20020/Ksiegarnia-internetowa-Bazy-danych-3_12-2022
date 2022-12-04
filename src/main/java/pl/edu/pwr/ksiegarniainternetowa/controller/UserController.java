package pl.edu.pwr.ksiegarniainternetowa.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.edu.pwr.ksiegarniainternetowa.model.api.request.RegistrationData;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.ClientEntity;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.PersonalDataEntity;
import pl.edu.pwr.ksiegarniainternetowa.model.entity.UserEntity;
import pl.edu.pwr.ksiegarniainternetowa.service.ClientService;
import pl.edu.pwr.ksiegarniainternetowa.service.PersonalDataService;
import pl.edu.pwr.ksiegarniainternetowa.service.UserService;

@RestController
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:8000", "https://booksshop-dr.azurewebsites.net"})
@RequestMapping(value = "/v1/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final PersonalDataService personalDataService;
    private final ClientService clientService;

    @PostMapping(value = "/register")
    public ResponseEntity<String> registerUser(@RequestBody RegistrationData registrationData) {

        UserEntity userEntity = UserEntity.builder()
                .username(registrationData.getUsername())
                .password(registrationData.getPassword())
                .isEmployee(false)
                .build();
        userEntity = userService.save(userEntity);
        PersonalDataEntity personalDataEntity = PersonalDataEntity.builder()
                .name(registrationData.getName())
                .surname(registrationData.getSurname())
                .email(registrationData.getEmail())
                .tel(registrationData.getTel())
                .build();
        personalDataEntity = personalDataService.save(personalDataEntity);
        ClientEntity clientEntity = ClientEntity.builder()
                .userEntity(userEntity)
                .personalDataEntity(personalDataEntity)
                .build();
        clientService.save(clientEntity);
        return new ResponseEntity<>("Registration completed successfully", HttpStatus.OK);
    }
}