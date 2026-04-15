package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("performance_point")
public class PerformancePoint implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String userName;

    private Double trainingPoints;

    private Double examPoints;

    private Double totalPoints;

    private Integer year;

    private Integer month;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}