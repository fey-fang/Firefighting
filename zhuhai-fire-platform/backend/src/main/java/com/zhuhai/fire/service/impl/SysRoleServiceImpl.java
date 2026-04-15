package com.zhuhai.fire.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuhai.fire.entity.SysRole;
import com.zhuhai.fire.mapper.SysRoleMapper;
import com.zhuhai.fire.service.SysRoleService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements SysRoleService {

    @Override
    public List<SysRole> getRolesByUserId(Long userId) {
        // 这里需要联表查询，后续实现
        return null;
    }

    @Override
    public List<SysRole> getRolesByPermissionId(Long permissionId) {
        // 这里需要联表查询，后续实现
        return null;
    }
}