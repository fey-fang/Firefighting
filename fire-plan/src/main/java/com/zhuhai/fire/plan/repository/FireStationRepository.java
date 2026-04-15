package com.zhuhai.fire.plan.repository;

import com.zhuhai.fire.plan.entity.FireStation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FireStationRepository extends JpaRepository<FireStation, Long> {

    FireStation findByStationCode(String stationCode);

    java.util.List<FireStation> findByOrganizationId(Long organizationId);
}
