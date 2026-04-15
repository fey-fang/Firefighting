package com.zhuhai.fire.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuhai.fire.entity.PlanInfo;
import com.zhuhai.fire.mapper.PlanInfoMapper;
import com.zhuhai.fire.service.PlanInfoService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlanInfoServiceImpl extends ServiceImpl<PlanInfoMapper, PlanInfo> implements PlanInfoService {

    @Override
    public List<PlanInfo> getPlansByUnitId(Long unitId) {
        QueryWrapper<PlanInfo> wrapper = new QueryWrapper<>();
        wrapper.eq("unit_id", unitId);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public List<PlanInfo> getPlansByType(Integer type) {
        QueryWrapper<PlanInfo> wrapper = new QueryWrapper<>();
        wrapper.eq("type", type);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public PlanInfo getPlanWithDetails(Long id) {
        // 这里需要联表查询，后续实现
        return baseMapper.selectById(id);
    }
}