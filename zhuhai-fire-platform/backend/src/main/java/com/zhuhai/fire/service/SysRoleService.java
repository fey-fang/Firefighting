package com.zhuhai.fire.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuhai.fire.entity.SysRole;

import java.util.List;

public interface SysRoleService extends IService<SysRole> {
    List<SysRole> getRolesByUserId(Long userId);
    List<SysRole> getRolesByPermissionId(Long permissionId);
}