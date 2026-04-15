package com.zhuhai.fire.controller;

import com.zhuhai.fire.entity.PlanInfo;
import com.zhuhai.fire.service.PlanInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/plan")
public class PlanInfoController {

    @Autowired
    private PlanInfoService planInfoService;

    @GetMapping("/list")
    public List<PlanInfo> list() {
        return planInfoService.list();
    }

    @GetMapping("/unit/{unitId}")
    public List<PlanInfo> getByUnitId(@PathVariable Long unitId) {
        return planInfoService.getPlansByUnitId(unitId);
    }

    @GetMapping("/type/{type}")
    public List<PlanInfo> getByType(@PathVariable Integer type) {
        return planInfoService.getPlansByType(type);
    }

    @GetMapping("/detail/{id}")
    public PlanInfo getDetail(@PathVariable Long id) {
        return planInfoService.getPlanWithDetails(id);
    }

    @PostMapping("/save")
    public boolean save(@RequestBody PlanInfo planInfo) {
        return planInfoService.save(planInfo);
    }

    @PutMapping("/update")
    public boolean update(@RequestBody PlanInfo planInfo) {
        return planInfoService.updateById(planInfo);
    }

    @DeleteMapping("/delete/{id}")
    public boolean delete(@PathVariable Long id) {
        return planInfoService.removeById(id);
    }
}