package com.zhuhai.fire.service.impl;

import com.zhuhai.fire.entity.AssessmentInfo;
import com.zhuhai.fire.entity.AssessmentResult;
import com.zhuhai.fire.mapper.AssessmentMapper;
import com.zhuhai.fire.service.AssessmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AssessmentServiceImpl implements AssessmentService {

    @Autowired
    private AssessmentMapper assessmentMapper;

    @Override
    public List<AssessmentInfo> getAllAssessments() {
        List<AssessmentInfo> list = new ArrayList<>();
        AssessmentInfo info1 = new AssessmentInfo();
        info1.setId(1L);
        info1.setExamName("消防基础知识考核");
        info1.setExamType("理论考核");
        info1.setExamTime("2024-01-20 09:00:00");
        info1.setParticipants(150);
        info1.setPassRate("92%");
        list.add(info1);

        AssessmentInfo info2 = new AssessmentInfo();
        info2.setId(2L);
        info2.setExamName("灭火技能实操考核");
        info2.setExamType("实操考核");
        info2.setExamTime("2024-02-25 08:00:00");
        info2.setParticipants(120);
        info2.setPassRate("88%");
        list.add(info2);

        return list;
    }

    @Override
    public AssessmentInfo getAssessmentById(Long id) {
        AssessmentInfo info = new AssessmentInfo();
        info.setId(id);
        info.setExamName("消防基础知识考核");
        info.setExamType("理论考核");
        return info;
    }

    @Override
    public AssessmentInfo createAssessment(AssessmentInfo assessmentInfo) {
        assessmentInfo.setId(System.currentTimeMillis());
        return assessmentInfo;
    }

    @Override
    public AssessmentInfo updateAssessment(AssessmentInfo assessmentInfo) {
        return assessmentInfo;
    }

    @Override
    public void deleteAssessment(Long id) {
    }

    @Override
    public List<AssessmentResult> getResultsByAssessmentId(Long assessmentId) {
        return new ArrayList<>();
    }

    @Override
    public AssessmentResult saveResult(AssessmentResult result) {
        result.setId(System.currentTimeMillis());
        return result;
    }
}
