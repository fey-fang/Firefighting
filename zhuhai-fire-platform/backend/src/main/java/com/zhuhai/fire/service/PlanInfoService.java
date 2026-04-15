package com.zhuhai.fire.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuhai.fire.entity.PlanInfo;

import java.util.List;

public interface PlanInfoService extends IService<PlanInfo> {
    List<PlanInfo> getPlansByUnitId(Long unitId);
    List<PlanInfo> getPlansByType(Integer type);
    PlanInfo getPlanWithDetails(Long id);
}