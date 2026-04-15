package com.zhuhai.fire.plan.repository;

import com.zhuhai.fire.plan.entity.FirePersonnel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FirePersonnelRepository extends JpaRepository<FirePersonnel, Long> {

    FirePersonnel findByIdCard(String idCard);

    java.util.List<FirePersonnel> findByStationId(Long stationId);

    java.util.List<FirePersonnel> findByStatus(Integer status);
}
