package me.utku.findmedicament.controller;

import lombok.RequiredArgsConstructor;
import me.utku.findmedicament.dto.CreateUserDTO;
import me.utku.findmedicament.dto.GenericResponse;
import me.utku.findmedicament.model.User;
import me.utku.findmedicament.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/me")
    public ResponseEntity<GenericResponse<User>> getMe(@AuthenticationPrincipal User user){
        return ResponseEntity.ok(new GenericResponse<>(200,"User found", user));
    }

    @PostMapping("/signup")
    public ResponseEntity<GenericResponse<User>> createUser(@RequestBody CreateUserDTO user){
        User newUser = userService.create(user);
        return ResponseEntity.ok(new GenericResponse<>(201,"User created", newUser));
    }
}
