package com.zhuhai.fire.auth.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
@TableName("sys_permission")
public class SysPermission implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String permissionName;
    private String permissionCode;
    private String url;
    private String method;
    private Long parentId;
    private Integer orderNum;
    private Integer status;
    private Date createTime;
    private Date updateTime;
}