package com.zhuhai.fire.controller;

import com.zhuhai.fire.entity.TrainingPlan;
import com.zhuhai.fire.service.TrainingPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/training")
public class TrainingPlanController {

    @Autowired
    private TrainingPlanService trainingPlanService;

    @GetMapping("/list")
    public List<TrainingPlan> list() {
        return trainingPlanService.list();
    }

    @GetMapping("/type/{type}")
    public List<TrainingPlan> getByType(@PathVariable Integer type) {
        return trainingPlanService.getPlansByType(type);
    }

    @GetMapping("/status/{status}")
    public List<TrainingPlan> getByStatus(@PathVariable Integer status) {
        return trainingPlanService.getPlansByStatus(status);
    }

    @GetMapping("/detail/{id}")
    public TrainingPlan getDetail(@PathVariable Long id) {
        return trainingPlanService.getPlanWithDetails(id);
    }

    @PostMapping("/save")
    public boolean save(@RequestBody TrainingPlan trainingPlan) {
        return trainingPlanService.save(trainingPlan);
    }

    @PutMapping("/update")
    public boolean update(@RequestBody TrainingPlan trainingPlan) {
        return trainingPlanService.updateById(trainingPlan);
    }

    @DeleteMapping("/delete/{id}")
    public boolean delete(@PathVariable Long id) {
        return trainingPlanService.removeById(id);
    }
}