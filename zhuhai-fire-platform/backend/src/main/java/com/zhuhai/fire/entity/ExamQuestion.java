package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("exam_question")
public class ExamQuestion implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long examId;

    private String content;

    private Integer type;

    private String options;

    private String answer;

    private Integer score;

    private String analysis;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}