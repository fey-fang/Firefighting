package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("exam_result")
public class ExamResult implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long examId;

    private Long userId;

    private String userName;

    private Double score;

    private String grade;

    private LocalDateTime examTime;

    private String answers;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}