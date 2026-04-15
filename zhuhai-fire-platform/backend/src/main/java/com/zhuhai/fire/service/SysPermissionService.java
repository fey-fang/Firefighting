package com.zhuhai.fire.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuhai.fire.entity.SysPermission;

import java.util.List;

public interface SysPermissionService extends IService<SysPermission> {
    List<SysPermission> getPermissionsByUserId(Long userId);
    List<SysPermission> getPermissionsByRoleId(Long roleId);
}