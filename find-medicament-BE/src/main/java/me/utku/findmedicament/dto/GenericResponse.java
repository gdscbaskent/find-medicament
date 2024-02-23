package me.utku.findmedicament.dto;

import lombok.Builder;

@Builder
public record GenericResponse<T> (int statusCode, String message, T data){ }
