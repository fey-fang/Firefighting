package com.zhuhai.fire.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuhai.fire.entity.TrainingPlan;

import java.util.List;

public interface TrainingPlanService extends IService<TrainingPlan> {
    List<TrainingPlan> getPlansByType(Integer type);
    List<TrainingPlan> getPlansByStatus(Integer status);
    TrainingPlan getPlanWithDetails(Long id);
}