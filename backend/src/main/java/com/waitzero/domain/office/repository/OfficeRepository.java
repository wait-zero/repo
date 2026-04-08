package com.waitzero.domain.office.repository;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OfficeRepository extends JpaRepository<CivilServiceOffice, Long> {

    List<CivilServiceOffice> findByNameContainingOrAddressContaining(String name, String address);

    List<CivilServiceOffice> findByRegionCode(String regionCode);

    @Query("SELECT o FROM CivilServiceOffice o WHERE " +
            "(:keyword IS NULL OR o.name LIKE %:keyword% OR o.address LIKE %:keyword%) AND " +
            "(:region IS NULL OR o.regionCode = :region)")
    List<CivilServiceOffice> searchOffices(@Param("keyword") String keyword, @Param("region") String region);

    @Query(value = "SELECT *, " +
            "(6371 * acos(cos(radians(:lat)) * cos(radians(latitude)) * " +
            "cos(radians(longitude) - radians(:lng)) + sin(radians(:lat)) * sin(radians(latitude)))) AS distance " +
            "FROM civil_service_office " +
            "HAVING distance <= :radius " +
            "ORDER BY distance", nativeQuery = true)
    List<CivilServiceOffice> findNearbyOffices(@Param("lat") double lat,
                                                @Param("lng") double lng,
                                                @Param("radius") double radius);
}
