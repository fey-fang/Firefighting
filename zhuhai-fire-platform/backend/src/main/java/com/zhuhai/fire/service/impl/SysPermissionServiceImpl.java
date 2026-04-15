package com.zhuhai.fire.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuhai.fire.entity.SysPermission;
import com.zhuhai.fire.mapper.SysPermissionMapper;
import com.zhuhai.fire.service.SysPermissionService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysPermissionServiceImpl extends ServiceImpl<SysPermissionMapper, SysPermission> implements SysPermissionService {

    @Override
    public List<SysPermission> getPermissionsByUserId(Long userId) {
        // 这里需要联表查询，后续实现
        return null;
    }

    @Override
    public List<SysPermission> getPermissionsByRoleId(Long roleId) {
        // 这里需要联表查询，后续实现
        return null;
    }
}