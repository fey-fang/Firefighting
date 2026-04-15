package com.zhuhai.fire.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuhai.fire.entity.SysUser;

import java.util.List;

public interface SysUserService extends IService<SysUser> {
    SysUser login(String username, String password);
    List<SysUser> getUsersByRoleId(Long roleId);
    List<SysUser> getUsersByOrganizationId(Long organizationId);
}