package com.zhuhai.fire.plan.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "unit_building")
public class UnitBuilding {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "building_name", nullable = false, length = 100)
    private String buildingName;

    @Column(name = "unit_id")
    private Long unitId;

    @Column(name = "building_type", nullable = false, length = 50)
    private String buildingType;

    @Column(name = "total_floor")
    private Integer totalFloor;

    @Column(name = "building_area")
    private Double buildingArea;

    @Column(name = "height")
    private Double height;

    @Column(name = "create_time", nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime;

    @Column(name = "update_time", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime;

    @PrePersist
    protected void onCreate() {
        createTime = new Date();
        updateTime = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        updateTime = new Date();
    }
}