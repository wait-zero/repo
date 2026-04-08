package com.waitzero.domain.registration.repository;

import com.waitzero.domain.registration.entity.PreRegistration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PreRegistrationRepository extends JpaRepository<PreRegistration, Long> {

    @Query("SELECT r FROM PreRegistration r JOIN FETCH r.office JOIN FETCH r.category WHERE r.user.id = :userId ORDER BY r.createdAt DESC")
    List<PreRegistration> findByUserIdWithDetails(@Param("userId") Long userId);

    @Query("SELECT r FROM PreRegistration r JOIN FETCH r.office JOIN FETCH r.category JOIN FETCH r.user WHERE r.id = :id")
    Optional<PreRegistration> findByIdWithDetails(@Param("id") Long id);
}
