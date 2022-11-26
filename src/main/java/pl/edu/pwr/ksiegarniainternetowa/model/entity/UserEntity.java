package pl.edu.pwr.ksiegarniainternetowa.model.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Builder
@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "USERS")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username", length = 30, unique = true, nullable = false)
    private String username;

    @Column(name = "password", length = 256, nullable = false)
    private char[] password;

    @Column(name = "is_employee", nullable = false)
    private Boolean isEmployee;
}
