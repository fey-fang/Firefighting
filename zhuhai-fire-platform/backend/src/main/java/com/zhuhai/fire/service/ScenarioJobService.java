package com.zhuhai.fire.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuhai.fire.entity.ScenarioJob;

import java.util.List;

public interface ScenarioJobService extends IService<ScenarioJob> {
    List<ScenarioJob> getJobsByUnitId(Long unitId);
    List<ScenarioJob> getJobsByType(Integer type);
    ScenarioJob getJobWithDetails(Long id);
}