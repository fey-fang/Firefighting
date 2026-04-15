package com.zhuhai.fire.service;

import com.zhuhai.fire.entity.AssessmentInfo;
import com.zhuhai.fire.entity.AssessmentResult;

import java.util.List;

public interface AssessmentService {
    List<AssessmentInfo> getAllAssessments();
    AssessmentInfo getAssessmentById(Long id);
    AssessmentInfo createAssessment(AssessmentInfo assessmentInfo);
    AssessmentInfo updateAssessment(AssessmentInfo assessmentInfo);
    void deleteAssessment(Long id);
    List<AssessmentResult> getResultsByAssessmentId(Long assessmentId);
    AssessmentResult saveResult(AssessmentResult result);
}
