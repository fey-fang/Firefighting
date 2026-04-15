package com.zhuhai.fire.plan.repository;

import com.zhuhai.fire.plan.entity.LinkageUnit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LinkageUnitRepository extends JpaRepository<LinkageUnit, Long> {

    LinkageUnit findByUnitCode(String unitCode);

    java.util.List<LinkageUnit> findByUnitType(String unitType);
}
