package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("fire_personnel")
public class FirePersonnel implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    private String idCard;

    private String phone;

    private Integer gender;

    private Integer age;

    private String position;

    private String rank;

    private Long stationId;

    private Integer status;

    private LocalDateTime entryDate;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}