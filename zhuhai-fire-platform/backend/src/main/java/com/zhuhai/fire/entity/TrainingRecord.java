package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("training_record")
public class TrainingRecord implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long planId;

    private Long userId;

    private String userName;

    private LocalDateTime trainingDate;

    private String content;

    private Double score;

    private String status;

    private String remarks;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}