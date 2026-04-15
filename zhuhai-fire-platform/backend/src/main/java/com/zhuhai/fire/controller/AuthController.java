package com.zhuhai.fire.controller;

import com.zhuhai.fire.entity.SysUser;
import com.zhuhai.fire.service.SysUserService;
import com.zhuhai.fire.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private SysUserService userService;

    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> params) {
        String username = params.get("username");
        String password = params.get("password");

        SysUser user = userService.login(username, password);
        if (user != null) {
            String token = jwtUtils.generateToken(user.getId());
            Map<String, Object> result = new HashMap<>();
            result.put("token", token);
            result.put("user", user);
            return result;
        } else {
            Map<String, Object> result = new HashMap<>();
            result.put("code", 401);
            result.put("message", "用户名或密码错误");
            return result;
        }
    }

    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody SysUser user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        boolean saved = userService.save(user);
        if (saved) {
            Map<String, Object> result = new HashMap<>();
            result.put("code", 200);
            result.put("message", "注册成功");
            return result;
        } else {
            Map<String, Object> result = new HashMap<>();
            result.put("code", 500);
            result.put("message", "注册失败");
            return result;
        }
    }
}