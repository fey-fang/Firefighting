package com.zhuhai.fire.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuhai.fire.entity.ScenarioJob;
import com.zhuhai.fire.mapper.ScenarioJobMapper;
import com.zhuhai.fire.service.ScenarioJobService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScenarioJobServiceImpl extends ServiceImpl<ScenarioJobMapper, ScenarioJob> implements ScenarioJobService {

    @Override
    public List<ScenarioJob> getJobsByUnitId(Long unitId) {
        QueryWrapper<ScenarioJob> wrapper = new QueryWrapper<>();
        wrapper.eq("unit_id", unitId);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public List<ScenarioJob> getJobsByType(Integer type) {
        QueryWrapper<ScenarioJob> wrapper = new QueryWrapper<>();
        wrapper.eq("type", type);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public ScenarioJob getJobWithDetails(Long id) {
        // 这里需要联表查询，后续实现
        return baseMapper.selectById(id);
    }
}