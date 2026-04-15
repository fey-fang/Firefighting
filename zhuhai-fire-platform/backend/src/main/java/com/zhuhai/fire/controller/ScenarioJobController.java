package com.zhuhai.fire.controller;

import com.zhuhai.fire.entity.ScenarioJob;
import com.zhuhai.fire.service.ScenarioJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/scenario")
public class ScenarioJobController {

    @Autowired
    private ScenarioJobService scenarioJobService;

    @GetMapping("/list")
    public List<ScenarioJob> list() {
        return scenarioJobService.list();
    }

    @GetMapping("/unit/{unitId}")
    public List<ScenarioJob> getByUnitId(@PathVariable Long unitId) {
        return scenarioJobService.getJobsByUnitId(unitId);
    }

    @GetMapping("/type/{type}")
    public List<ScenarioJob> getByType(@PathVariable Integer type) {
        return scenarioJobService.getJobsByType(type);
    }

    @GetMapping("/detail/{id}")
    public ScenarioJob getDetail(@PathVariable Long id) {
        return scenarioJobService.getJobWithDetails(id);
    }

    @PostMapping("/save")
    public boolean save(@RequestBody ScenarioJob scenarioJob) {
        return scenarioJobService.save(scenarioJob);
    }

    @PutMapping("/update")
    public boolean update(@RequestBody ScenarioJob scenarioJob) {
        return scenarioJobService.updateById(scenarioJob);
    }

    @DeleteMapping("/delete/{id}")
    public boolean delete(@PathVariable Long id) {
        return scenarioJobService.removeById(id);
    }
}