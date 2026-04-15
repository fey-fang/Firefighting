package com.zhuhai.fire.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("fire_vehicle")
public class FireVehicle implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private String licensePlate;

    private String vehicleType;

    private String model;

    private Integer capacity;

    private Integer status;

    private Long stationId;

    private LocalDateTime purchaseDate;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}