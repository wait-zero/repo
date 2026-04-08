package com.waitzero.domain.category.repository;

import com.waitzero.domain.category.entity.CivilServiceCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<CivilServiceCategory, Long> {
}
