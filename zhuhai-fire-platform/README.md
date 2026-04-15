# 珠海消防数字化作战训练考核管理平台

## 项目概述

本项目是珠海消防数字化作战训练考核管理平台，基于现代Web技术栈构建，实现了预案管理、沙盘推演、训练考核、统计分析等功能。

## 技术栈

### 后端技术栈
- **语言**: Java 17
- **框架**: Spring Boot 2.7.x
- **微服务**: Spring Cloud Alibaba
- **数据库**: PostgreSQL + PostGIS
- **缓存**: Redis
- **消息队列**: RocketMQ
- **文件存储**: MinIO
- **安全**: Spring Security + JWT

### 前端技术栈
- **框架**: Vue 3
- **语言**: TypeScript
- **UI组件库**: Element Plus
- **路由**: Vue Router 4
- **HTTP客户端**: Axios
- **三维可视化**: Cesium.js

### 移动端技术栈
- **框架**: React Native
- **语言**: TypeScript

## 项目结构

```
zhuhai-fire-platform/
├── backend/                 # 后端服务
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/zhuhai/fire/
│   │   │   │   ├── config/      # 配置类
│   │   │   │   ├── controller/  # 控制器
│   │   │   │   ├── entity/      # 实体类
│   │   │   │   ├── mapper/      # 数据访问层
│   │   │   │   ├── service/     # 服务层
│   │   │   │   └── utils/       # 工具类
│   │   │   └── resources/       # 配置文件
│   └── pom.xml
├── frontend/                # 前端应用
│   ├── src/
│   │   ├── api/             # API接口
│   │   ├── assets/          # 静态资源
│   │   ├── components/      # 组件
│   │   ├── router/          # 路由配置
│   │   ├── views/           # 页面
│   │   ├── App.vue
│   │   └── main.ts
│   ├── index.html
│   ├── package.json
│   └── vite.config.ts
├── mobile/                  # 移动端App
├── config/                  # 配置文件
├── docs/                    # 文档
└── README.md
```

## 功能模块

### 1. 统一用户认证与权限管理
- 用户登录/登出
- 用户管理
- 角色管理
- 权限管理
- 基于RBAC的细粒度权限控制

### 2. 三维数字化预案编制管理
- 消防机构管理
- 重点单位管理
- 预案创建与编辑
- 预案查看与导出
- 统计分析

### 3. 三维数字化沙盘推演考评
- 想定作业创建
- 场景设置
- 灾情设定
- 力量部署
- 推演控制
- 考核管理

### 4. 数字化训练考核管理
- 训练计划管理
- 培训管理
- 考核管理
- 绩点管理
- 统计分析

### 5. 统计分析
- 数据可视化
- 报表生成
- 趋势分析
- 排名统计

## 快速开始

### 环境要求
- JDK 17+
- Node.js 16+
- PostgreSQL 13+
- Redis 6+

### 后端启动

1. 配置数据库连接
   ```yaml
   # backend/src/main/resources/application.yml
   spring:
     datasource:
       url: jdbc:postgresql://localhost:5432/zhuhai_fire
       username: your_username
       password: your_password
   ```

2. 启动后端服务
   ```bash
   cd backend
   mvn spring-boot:run
   ```

### 前端启动

1. 安装依赖
   ```bash
   cd frontend
   npm install
   ```

2. 启动开发服务器
   ```bash
   npm run dev
   ```

3. 访问应用
   打开浏览器访问: http://localhost:5173

## 默认账号

- 用户名: admin
- 密码: admin123

## 开发规范

### 代码规范
- 后端遵循阿里巴巴Java开发规范
- 前端遵循Vue 3风格指南
- 使用ESLint和Prettier进行代码格式化

### Git提交规范
```
<type>(<scope>): <subject>

类型:
- feat: 新功能
- fix: 修复bug
- docs: 文档更新
- style: 代码格式调整
- refactor: 重构
- test: 测试相关
- chore: 构建/工具相关
```

## 系统特性

1. **信创适配**: 支持国产操作系统、数据库、中间件和浏览器
2. **数据安全**: 采用国密SM2算法，HTTPS/TLS加密传输
3. **三维可视化**: 基于Cesium.js实现三维场景和模型展示
4. **移动端支持**: React Native跨平台移动端应用
5. **微服务架构**: 基于Spring Cloud Alibaba的微服务架构

## 文档

- [产品需求文档 (PRD)](.trae/specs/zhuhai-fire-platform/spec.md)
- [实施计划](.trae/specs/zhuhai-fire-platform/tasks.md)
- [验证清单](.trae/specs/zhuhai-fire-platform/checklist.md)
- [试运行计划](docs/试运行计划.md)
- [验收文档](docs/验收文档.md)
- [运维制度](docs/运维制度.md)

## 许可证

本项目为内部项目，版权归珠海市消防救援支队所有。

## 联系方式

如有问题，请联系项目开发团队。
