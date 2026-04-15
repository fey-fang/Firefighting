package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("scenario_disaster")
public class ScenarioDisaster implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long sceneId;

    private String name;

    private Integer type;

    private String location;

    private String severity;

    private String description;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}