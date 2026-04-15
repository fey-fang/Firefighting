package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("scenario_personnel")
public class ScenarioPersonnel implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long sceneId;

    private String name;

    private String type;

    private String position;

    private Double longitude;

    private Double latitude;

    private String status;

    private String description;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}