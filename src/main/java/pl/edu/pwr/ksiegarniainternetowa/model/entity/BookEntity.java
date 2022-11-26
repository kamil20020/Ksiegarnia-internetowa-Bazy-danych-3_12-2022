package pl.edu.pwr.ksiegarniainternetowa.model.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

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

    @Column(name = "title", length = 100, nullable = false)
    private String title;

    @Lob
    @Column(name = "description", columnDefinition = "LONGTEXT")
    private String description;

    @Column(name = "isbn", length = 13, unique = true)
    private String isbn;

    @Column(name = "releaseNumber", length = 13)
    private Integer releaseNumber;

    @Column(name = "releaseDate", nullable = false)
    private LocalDateTime releaseDate;

    @Column(name = "size", length = 11)
    private String size;

    @Column(name = "price", nullable = false)
    private BigDecimal price;

    @Column(name = "isAvailable", nullable = false)
    private Boolean isAvailable;

    @Column(name = "numOfBookItems", nullable = false)
    private Integer numOfBookItems;

    @Column(name = "numberOfPages", length = 20)
    private String numOfBookPages;

    @Lob
    @Type(type="org.hibernate.type.ImageType")
    @Column(name = "avatar")
    private byte[] avatar;
}
