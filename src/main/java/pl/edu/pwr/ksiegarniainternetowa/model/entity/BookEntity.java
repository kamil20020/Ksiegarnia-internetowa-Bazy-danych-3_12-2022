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
@Table(name = "BOOKS")
public class BookEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title", length = 100)
    private String title;

}
