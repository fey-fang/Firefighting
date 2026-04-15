package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("unit_personnel")
public class UnitPersonnel implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long unitId;

    private String name;

    private String idCard;

    private String phone;

    private String position;

    private Integer type;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}