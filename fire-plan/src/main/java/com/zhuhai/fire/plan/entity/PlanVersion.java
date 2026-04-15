package com.zhuhai.fire.plan.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "plan_version")
public class PlanVersion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "plan_id")
    private Long planId;

    @Column(name = "version", nullable = false, length = 20)
    private String version;

    @Column(name = "update_content", columnDefinition = "text")
    private String updateContent;

    @Column(name = "update_person", length = 50)
    private String updatePerson;

    @Column(name = "update_time", nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime;

    @PrePersist
    protected void onCreate() {
        updateTime = new Date();
    }
}