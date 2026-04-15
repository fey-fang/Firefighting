package com.zhuhai.fire.plan.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "unit_facility")
public class UnitFacility {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "facility_name", nullable = false, length = 100)
    private String facilityName;

    @Column(name = "unit_id")
    private Long unitId;

    @Column(name = "building_id")
    private Long buildingId;

    @Column(name = "facility_type", nullable = false, length = 50)
    private String facilityType;

    @Column(name = "location", length = 200)
    private String location;

    @Column(name = "status", nullable = false, columnDefinition = "int default 1")
    private Integer status;

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
        if (status == null) {
            status = 1;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updateTime = new Date();
    }
}