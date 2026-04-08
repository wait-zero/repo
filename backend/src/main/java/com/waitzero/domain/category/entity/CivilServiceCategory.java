package com.waitzero.domain.category.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "civil_service_category")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CivilServiceCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(length = 255)
    private String description;

    @Column(columnDefinition = "TEXT")
    private String requiredDocuments;

    private Integer estimatedProcessMinutes;

    @Builder
    public CivilServiceCategory(String name, String description,
                                 String requiredDocuments, Integer estimatedProcessMinutes) {
        this.name = name;
        this.description = description;
        this.requiredDocuments = requiredDocuments;
        this.estimatedProcessMinutes = estimatedProcessMinutes;
    }
}
