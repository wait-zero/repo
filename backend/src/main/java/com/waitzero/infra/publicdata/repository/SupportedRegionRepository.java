package com.waitzero.infra.publicdata.repository;

import com.waitzero.infra.publicdata.entity.SupportedRegion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SupportedRegionRepository extends JpaRepository<SupportedRegion, Long> {

    Optional<SupportedRegion> findByStdgCd(String stdgCd);

    List<SupportedRegion> findAllByEnabledTrue();

    boolean existsByStdgCd(String stdgCd);
}
