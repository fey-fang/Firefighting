package com.zhuhai.fire.plan.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "fire_personnel")
public class FirePersonnel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, length = 50)
    private String name;

    @Column(name = "id_card", nullable = false, unique = true, length = 18)
    private String idCard;

    @Column(name = "station_id")
    private Long stationId;

    @Column(name = "position", length = 50)
    private String position;

    @Column(name = "rank", length = 50)
    private String rank;

    @Column(name = "phone", nullable = false, length = 20)
    private String phone;

    @Column(name = "entry_date")
    @Temporal(TemporalType.DATE)
    private Date entryDate;

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