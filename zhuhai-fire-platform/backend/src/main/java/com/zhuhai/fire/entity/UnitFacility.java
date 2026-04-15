package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("unit_facility")
public class UnitFacility implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long unitId;

    private String name;

    private String code;

    private Integer type;

    private String location;

    private String status;

    private Double longitude;

    private Double latitude;

    private String description;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}