package com.zhuhai.fire.plan.repository;

import com.zhuhai.fire.plan.entity.SysOrganization;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SysOrganizationRepository extends JpaRepository<SysOrganization, Long> {

    SysOrganization findByOrgCode(String orgCode);

    java.util.List<SysOrganization> findByParentId(Long parentId);
}
