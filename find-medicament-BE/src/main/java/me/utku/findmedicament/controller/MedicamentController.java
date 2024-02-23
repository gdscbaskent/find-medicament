package me.utku.findmedicament.controller;

import lombok.RequiredArgsConstructor;
import me.utku.findmedicament.dto.CreateMedicamentDTO;
import me.utku.findmedicament.dto.GenericResponse;
import me.utku.findmedicament.model.Medicament;
import me.utku.findmedicament.service.MedicamentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/medicament")
@RequiredArgsConstructor
public class MedicamentController {
    private final MedicamentService medicamentService;

    @GetMapping
    public ResponseEntity<GenericResponse<List<Medicament>>> getAll(){
        List<Medicament> medicament = medicamentService.getAllMedicament();
        GenericResponse<List<Medicament>> response = GenericResponse.<List<Medicament>>builder().data(medicament)
                .message("Medicament get successfully")
                .statusCode(200)
                .build();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<GenericResponse<Medicament>> getById(@PathVariable Long id){
        Medicament medicament = medicamentService.getMedicamentById(id);
        GenericResponse<Medicament> response = GenericResponse.<Medicament>builder().data(medicament)
                .message("Medicament get successfully")
                .statusCode(200)
                .build();
        return ResponseEntity.ok(response);
    }

    @PostMapping
    public ResponseEntity<GenericResponse<Medicament>> save(@RequestBody CreateMedicamentDTO medicament){
        Medicament savedMedicament = medicamentService.createMedicament(medicament);
        GenericResponse<Medicament> response = GenericResponse.<Medicament>builder().data(savedMedicament)
                .message("Medicament created")
                .statusCode(201)
                .build();
        return ResponseEntity.ok(response);
    }

    @PutMapping
    public ResponseEntity<GenericResponse<Medicament>> update(@RequestBody Medicament medicament){
        Medicament updatedMedicament = medicamentService.updateMedicament(medicament);
        GenericResponse<Medicament> response = GenericResponse.<Medicament>builder().data(updatedMedicament)
                .message("Medicament updated successfully")
                .statusCode(200)
                .build();
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<GenericResponse<String>> delete(@PathVariable Long id){
        medicamentService.deleteMedicament(id);
        GenericResponse<String> response = GenericResponse.<String>builder().data("Deleted")
                .message("Medicament deleted successfully")
                .statusCode(200)
                .build();
        return ResponseEntity.ok(response);
    }
}
