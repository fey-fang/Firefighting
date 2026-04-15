package com.zhuhai.fire.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuhai.fire.entity.SysUser;
import com.zhuhai.fire.entity.SysUserRole;
import com.zhuhai.fire.mapper.SysUserMapper;
import com.zhuhai.fire.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    public SysUser login(String username, String password) {
        QueryWrapper<SysUser> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username);
        SysUser user = baseMapper.selectOne(wrapper);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public List<SysUser> getUsersByRoleId(Long roleId) {
        // 这里需要联表查询，后续实现
        return null;
    }

    @Override
    public List<SysUser> getUsersByOrganizationId(Long organizationId) {
        QueryWrapper<SysUser> wrapper = new QueryWrapper<>();
        wrapper.eq("organization_id", organizationId);
        return baseMapper.selectList(wrapper);
    }
}