package com.zhuhai.fire.auth.controller;

import com.zhuhai.fire.auth.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {
    
    @Autowired
    private JwtUtils jwtUtils;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> loginInfo) {
        String username = loginInfo.get("username");
        String password = loginInfo.get("password");
        
        // 这里应该从数据库查询用户信息，然后进行密码验证
        // 为了演示，这里直接返回token
        Map<String, Object> claims = new HashMap<>();
        claims.put("username", username);
        claims.put("role", "admin");
        
        String token = jwtUtils.generateToken(username, claims);
        
        Map<String, Object> result = new HashMap<>();
        result.put("token", token);
        result.put("expiration", 3600);
        
        return result;
    }
    
    @PostMapping("/refresh")
    public Map<String, Object> refresh(@RequestBody Map<String, String> refreshInfo) {
        String oldToken = refreshInfo.get("token");
        
        // 验证旧token
        if (!jwtUtils.validateToken(oldToken)) {
            Map<String, Object> error = new HashMap<>();
            error.put("code", 401);
            error.put("message", "Invalid token");
            return error;
        }
        
        // 从旧token中获取用户信息
        String username = jwtUtils.parseToken(oldToken).getSubject();
        
        // 生成新token
        Map<String, Object> claims = new HashMap<>();
        claims.put("username", username);
        claims.put("role", "admin");
        
        String newToken = jwtUtils.generateToken(username, claims);
        
        Map<String, Object> result = new HashMap<>();
        result.put("token", newToken);
        result.put("expiration", 3600);
        
        return result;
    }
}