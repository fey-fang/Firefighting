package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("key_position")
public class KeyPosition implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long unitId;

    private String name;

    private String code;

    private String location;

    private Integer type;

    private String riskLevel;

    private String description;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}