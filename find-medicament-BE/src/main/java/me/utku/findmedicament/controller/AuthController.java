package me.utku.findmedicament.controller;

import me.utku.findmedicament.dto.GenericResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @PostMapping("/login")
    ResponseEntity<GenericResponse<Boolean>> confirmAuthentication(){
        return ResponseEntity.ok(new GenericResponse<>(200, "Logged in successfully!", true));
    }
}
