package me.utku.findmedicament.repository;

import me.utku.findmedicament.model.Medicament;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MedicamentRepository extends JpaRepository<Medicament,Long> {
}
