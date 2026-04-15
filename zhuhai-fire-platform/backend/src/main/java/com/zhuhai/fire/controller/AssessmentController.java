package com.zhuhai.fire.controller;

import com.zhuhai.fire.entity.AssessmentInfo;
import com.zhuhai.fire.entity.AssessmentResult;
import com.zhuhai.fire.service.AssessmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/assessment")
public class AssessmentController {

    @Autowired
    private AssessmentService assessmentService;

    @GetMapping("/list")
    public List<AssessmentInfo> getAssessmentList() {
        return assessmentService.getAllAssessments();
    }

    @GetMapping("/{id}")
    public AssessmentInfo getAssessmentById(@PathVariable Long id) {
        return assessmentService.getAssessmentById(id);
    }

    @PostMapping("/create")
    public AssessmentInfo createAssessment(@RequestBody AssessmentInfo assessmentInfo) {
        return assessmentService.createAssessment(assessmentInfo);
    }

    @PutMapping("/update")
    public AssessmentInfo updateAssessment(@RequestBody AssessmentInfo assessmentInfo) {
        return assessmentService.updateAssessment(assessmentInfo);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteAssessment(@PathVariable Long id) {
        assessmentService.deleteAssessment(id);
    }

    @GetMapping("/results/{assessmentId}")
    public List<AssessmentResult> getAssessmentResults(@PathVariable Long assessmentId) {
        return assessmentService.getResultsByAssessmentId(assessmentId);
    }

    @PostMapping("/results/save")
    public AssessmentResult saveAssessmentResult(@RequestBody AssessmentResult result) {
        return assessmentService.saveResult(result);
    }
}
