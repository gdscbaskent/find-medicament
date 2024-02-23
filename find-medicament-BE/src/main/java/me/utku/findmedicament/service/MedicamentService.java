package me.utku.findmedicament.service;

import lombok.RequiredArgsConstructor;
import me.utku.findmedicament.dto.CreateMedicamentDTO;
import me.utku.findmedicament.model.Medicament;
import me.utku.findmedicament.repository.MedicamentRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MedicamentService {
    private final MedicamentRepository medicamentRepository;

    public List<Medicament> getAllMedicament() {
        return medicamentRepository.findAll();
    }

    public Medicament getMedicamentById(Long id) {
        return medicamentRepository.findById(id).orElse(null);
    }

    public Medicament createMedicament(CreateMedicamentDTO medicament) {
        Medicament newMedicament = new Medicament();
        newMedicament.setName(medicament.name());
        newMedicament.setDosage(medicament.dosage());
        return medicamentRepository.save(newMedicament);
    }

    public Medicament updateMedicament(Medicament medicament) {
        return medicamentRepository.save(medicament);
    }

    public void deleteMedicament(Long id) {
        medicamentRepository.deleteById(id);
    }
}
