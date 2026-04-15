package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("assessment_info")
public class AssessmentInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    private String code;

    private Long jobId;

    private String assessor;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private Integer status;

    private String description;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}