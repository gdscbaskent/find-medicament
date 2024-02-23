package me.utku.findmedicament.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "medicament")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Medicament {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private Long dosage;
}
