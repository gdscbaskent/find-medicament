package me.utku.findmedicament.dto;

import me.utku.findmedicament.enums.Role;

import java.util.Set;

public record CreateUserDTO(String name,
                            String username,
                            String password,
                            Set<Role> authorities
) { }
