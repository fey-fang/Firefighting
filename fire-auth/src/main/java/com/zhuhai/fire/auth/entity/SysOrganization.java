package com.zhuhai.fire.auth.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
@TableName("sys_organization")
public class SysOrganization implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String orgName;
    private String orgCode;
    private Long parentId;
    private Integer level;
    private Integer orderNum;
    private Integer status;
    private Date createTime;
    private Date updateTime;
}