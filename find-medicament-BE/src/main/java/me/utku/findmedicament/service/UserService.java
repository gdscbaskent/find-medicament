package me.utku.findmedicament.service;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import me.utku.findmedicament.dto.CreateUserDTO;
import me.utku.findmedicament.model.User;
import me.utku.findmedicament.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Data
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public Optional<User> getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public User create(CreateUserDTO request){
        User newUser = User.builder()
                .name(request.name())
                .username(request.username())
                .password(bCryptPasswordEncoder.encode(request.password()))
                .authorities(request.authorities())
                .accountNonExpired(true)
                .credentialsNonExpired(true)
                .isEnabled(true)
                .accountNonLocked(true)
                .build();
        return userRepository.save(newUser);
    }
}
