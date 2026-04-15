package com.zhuhai.fire.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuhai.fire.entity.TrainingPlan;
import com.zhuhai.fire.mapper.TrainingPlanMapper;
import com.zhuhai.fire.service.TrainingPlanService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainingPlanServiceImpl extends ServiceImpl<TrainingPlanMapper, TrainingPlan> implements TrainingPlanService {

    @Override
    public List<TrainingPlan> getPlansByType(Integer type) {
        QueryWrapper<TrainingPlan> wrapper = new QueryWrapper<>();
        wrapper.eq("type", type);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public List<TrainingPlan> getPlansByStatus(Integer status) {
        QueryWrapper<TrainingPlan> wrapper = new QueryWrapper<>();
        wrapper.eq("status", status);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public TrainingPlan getPlanWithDetails(Long id) {
        // 这里需要联表查询，后续实现
        return baseMapper.selectById(id);
    }
}