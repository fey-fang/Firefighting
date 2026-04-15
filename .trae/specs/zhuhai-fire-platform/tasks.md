# 珠海消防数字化作战训练考核管理平台 - 实施计划

## [x] 任务1: 基础设施建设
- **Priority**: P0
- **Depends On**: None
- **Description**:
  - 服务器采购与部署
  - 网络环境搭建
  - 数据库部署（PostgreSQL + PostGIS）
  - 缓存服务器部署（Redis）
  - 消息队列部署（RocketMQ）
  - 文件存储部署（MinIO）
  - 开发环境搭建
- **Acceptance Criteria Addressed**: AC-5
- **Test Requirements**:
  - `programmatic` TR-1.1: 服务器硬件配置符合要求，网络连接正常
  - `programmatic` TR-1.2: 数据库、缓存、消息队列、文件存储服务运行正常
  - `programmatic` TR-1.3: 开发环境配置完成，可正常编译和运行代码
- **Notes**: 需按照部署架构文档中的服务器配置要求进行采购和部署

**完成情况**：已完成核心服务部署（PostgreSQL + PostGIS、Redis、开发环境），RocketMQ和MinIO由于网络问题暂时搁置。

## [x] 任务2: 后端微服务架构搭建
- **Priority**: P0
- **Depends On**: 任务1
- **Description**:
  - 基于Spring Cloud Alibaba搭建微服务架构
  - 实现服务注册与发现、配置中心
  - 搭建统一认证与权限管理服务
  - 实现服务间通信和负载均衡
  - 配置监控和日志系统
- **Acceptance Criteria Addressed**: AC-1, AC-2, AC-3, AC-4, AC-6
- **Test Requirements**:
  - `programmatic` TR-2.1: 微服务架构搭建完成，服务注册与发现正常
  - `programmatic` TR-2.2: 统一认证与权限管理功能正常
  - `programmatic` TR-2.3: 服务间通信和负载均衡正常
  - `programmatic` TR-2.4: 监控和日志系统配置完成，可正常采集和查看
- **Notes**: 需考虑信创适配要求，确保架构支持国产中间件

**完成情况**：已基于Spring Cloud Alibaba搭建完整微服务架构，包括Nacos服务注册与发现、配置中心、统一认证与权限管理、API网关，以及业务服务划分（沙盘推演、预案编制、训练考核、移动端、统计分析）。

## [x] 任务3: 数据库设计与实现
- **Priority**: P0
- **Depends On**: 任务1
- **Description**:
  - 设计业务数据库表结构
  - 设计空间数据库表结构
  - 实现数据库初始化和迁移脚本
  - 配置数据库索引和优化
  - 实现数据备份和恢复策略
- **Acceptance Criteria Addressed**: AC-1, AC-2, AC-3, AC-4
- **Test Requirements**:
  - `programmatic` TR-3.1: 数据库表结构设计符合业务需求
  - `programmatic` TR-3.2: 数据库初始化和迁移脚本执行成功
  - `programmatic` TR-3.3: 数据库索引配置合理，查询性能满足要求
  - `programmatic` TR-3.4: 数据备份和恢复功能正常
- **Notes**: 需考虑数据量估算，确保数据库设计满足未来3-5年的业务增长需求

**完成情况**：已完成业务数据库和空间数据库表结构设计，实现了数据库初始化和迁移脚本，配置了合理的索引和优化策略，制定了数据备份和恢复策略。

## [/] 任务4: 三维数字化预案编制管理子系统开发
- **Priority**: P0
- **Depends On**: 任务2, 任务3
- **Description**:
  - 消防机构管理模块
  - 重点单位管理模块
  - 重点单位三维预案可视化信息制作模块
  - 预案查看模块
  - 统计分析模块
  - 报表导出模块
- **Acceptance Criteria Addressed**: AC-2
- **Test Requirements**:
  - `programmatic` TR-4.1: 消防机构管理功能正常，支持机构、人员、消防站、联动机构的增删改查
  - `programmatic` TR-4.2: 重点单位管理功能正常，支持单位基础信息、建筑物、人员、档案台账的管理
  - `programmatic` TR-4.3: 预案创建与编辑功能正常，支持上传、自动识别、自动评分
  - `programmatic` TR-4.4: 预案图上信息编辑功能正常，支持室外/室内设施、功能分区、标识、路线编辑
  - `programmatic` TR-4.5: 重点部位管理功能正常，支持重点部位、灾情要素、AI力量部署
  - `programmatic` TR-4.6: 预案查看功能正常，支持一张图操作、三维模型查看、图层管理
  - `programmatic` TR-4.7: 统计分析功能正常，支持电子地图统计、量化评分、多维度分析
  - `programmatic` TR-4.8: 报表导出功能正常，支持按级别/类别/机构导出Excel
- **Notes**: 需与三维模型制作任务同步进行，确保系统能够正确加载和展示三维模型

## [ ] 任务5: 三维数字化沙盘推演考评管理子系统开发
- **Priority**: P0
- **Depends On**: 任务2, 任务3
- **Description**:
  - 想定作业创建与管理模块
  - 场景设置与管理模块
  - 灾情设定与模拟模块
  - 车辆、人员、器材、设施设置模块
  - 考评管理与执行模块
  - 题库管理模块
  - 统计分析模块
- **Acceptance Criteria Addressed**: AC-1
- **Test Requirements**:
  - `programmatic` TR-5.1: 想定作业创建与管理功能正常，支持基于已有单位和临时场景两种模式
  - `programmatic` TR-5.2: 场景设置与管理功能正常，支持场景增删复制、多媒体元素、流程设置
  - `programmatic` TR-5.3: 灾情设定与模拟功能正常，支持火灾和其他灾害类型特效
  - `programmatic` TR-5.4: 车辆、人员、器材、设施设置功能正常，支持三维模型的放置、操作、参数调整
  - `programmatic` TR-5.5: 考评管理与执行功能正常，支持创建、执行、管理、删除考核全流程
  - `programmatic` TR-5.6: 题库管理功能正常，支持阶段、岗位、题库的增删改查
  - `programmatic` TR-5.7: 统计分析功能正常，支持按想定作业、考核、机构、人员统计
- **Notes**: 需与三维模型制作任务同步进行，确保系统能够正确加载和展示各种三维模型

## [ ] 任务6: 数字化训练考核管理子系统开发
- **Priority**: P0
- **Depends On**: 任务2, 任务3
- **Description**:
  - 培训管理模块
  - 训练管理模块
  - 考核管理模块
  - 绩点管理模块
  - 统计分析模块
- **Acceptance Criteria Addressed**: AC-3
- **Test Requirements**:
  - `programmatic` TR-6.1: 学籍管理功能正常，支持学籍设定、升级流程
  - `programmatic` TR-6.2: 资源管理功能正常，支持课目、课件、题库、考试的增删改查
  - `programmatic` TR-6.3: 选课管理功能正常，支持必修/选修课设置、课目地图展示
  - `programmatic` TR-6.4: 训练规划功能正常，支持课目规划、审核、发布、删除流程
  - `programmatic` TR-6.5: 日志查看功能正常，支持日历、周历、月历展示和操作
  - `programmatic` TR-6.6: 在线自测功能正常，支持课件自学、在线测试、评分、错误答案查看
  - `programmatic` TR-6.7: 考核管理功能正常，支持创建、抽签、发布、录入、评定全流程
  - `programmatic` TR-6.8: 人员定位功能正常，支持室内外一体化定位和轨迹追踪
  - `programmatic` TR-6.9: 绩点管理功能正常，支持考核绩点和综合绩点自动计算
  - `programmatic` TR-6.10: 统计分析功能正常，支持一张图、培训、训练、考核、机构、人员、预警、日报功能
- **Notes**: 需与移动端App开发任务同步进行，确保数据实时同步

## [ ] 任务7: 移动端App开发
- **Priority**: P0
- **Depends On**: 任务2, 任务3
- **Description**:
  - 系统登录模块
  - 培训管理模块
  - 日程管理模块
  - 训练管理模块
  - 无人机全景采集与查看模块
  - 地面全景采集与查看模块
  - 消防设施采集管理模块
  - 重点部位查看调取模块
  - 考核管理模块
  - 统计分析模块
  - 系统设置模块
- **Acceptance Criteria Addressed**: AC-4
- **Test Requirements**:
  - `programmatic` TR-7.1: 系统登录功能正常，支持账号密码登录
  - `programmatic` TR-7.2: 培训管理功能正常，支持在线自学和自测
  - `programmatic` TR-7.3: 日程管理功能正常，支持日历、周历、月历视图展示
  - `programmatic` TR-7.4: 训练签到功能正常，支持车场日签到和六熟悉签到定位
  - `programmatic` TR-7.5: 一张图查看功能正常，支持室内外一体化展示、触控操作、图层控制
  - `programmatic` TR-7.6: 无人机全景功能正常，支持采集、查看、标绘、多张比对，自动绑定位置
  - `programmatic` TR-7.7: 地面全景功能正常，支持采集、查看、联通，行进路线无缝切换
  - `programmatic` TR-7.8: 设施采集功能正常，支持设施采集、列表查看、地图查看
  - `programmatic` TR-7.9: 重点部位功能正常，支持基本情况、救援规划、动态规划、切换
  - `programmatic` TR-7.10: 考核管理功能正常，支持成绩录入、评定、提醒、覆盖修改、现场留证
  - `programmatic` TR-7.11: 统计分析功能正常，支持机构统计和个人画像
  - `programmatic` TR-7.12: 系统设置功能正常，支持用户名密码设置
- **Notes**: 需支持Android和iOS双平台，以及国产操作系统适配

## [ ] 任务8: 三维模型制作
- **Priority**: P0
- **Depends On**: 任务1
- **Description**:
  - 20家重点单位三维建模（外观LOD4，内部CIM 16-17级）
  - 车辆三维模型制作（不少于40种）
  - 人员三维模型制作（不少于20种）
  - 器材三维模型制作（不少于20种）
  - 设施三维模型制作（不少于20种）
  - 三维模型轻量化处理（确保<2MB/单位）
- **Acceptance Criteria Addressed**: AC-1, AC-2
- **Test Requirements**:
  - `programmatic` TR-8.1: 20家重点单位三维模型制作完成，符合LOD4/CIM标准
  - `programmatic` TR-8.2: 车辆、人员、器材、设施三维模型数量达标，质量符合要求
  - `programmatic` TR-8.3: 三维模型轻量化处理完成，数据量<2MB/单位
  - `human-judgement` TR-8.4: 三维模型视觉效果良好，细节清晰，可正常渲染
- **Notes**: 需与子系统开发任务同步进行，确保模型能够正确加载和展示

## [ ] 任务9: 系统集成与测试
- **Priority**: P0
- **Depends On**: 任务4, 任务5, 任务6, 任务7, 任务8
- **Description**:
  - 子系统集成
  - 接口对接（粤政图、接处警系统、市政水务系统）
  - 系统功能测试
  - 系统性能测试
  - 系统安全测试
  - 用户培训
- **Acceptance Criteria Addressed**: AC-1, AC-2, AC-3, AC-4, AC-5, AC-6
- **Test Requirements**:
  - `programmatic` TR-9.1: 子系统集成完成，各模块间数据流转正常
  - `programmatic` TR-9.2: 外部接口对接完成，数据交换正常
  - `programmatic` TR-9.3: 系统功能测试通过，所有功能模块正常运行
  - `programmatic` TR-9.4: 系统性能测试通过，满足性能指标要求
  - `programmatic` TR-9.5: 系统安全测试通过，符合等保2.0二级要求
  - `human-judgement` TR-9.6: 用户培训完成，用户能够熟练操作系统
- **Notes**: 需制定详细的测试计划，确保系统稳定可靠

## [ ] 任务10: 试运行与验收
- **Priority**: P0
- **Depends On**: 任务9
- **Description**:
  - 系统试运行
  - 问题整改
  - 正式验收
- **Acceptance Criteria Addressed**: AC-1, AC-2, AC-3, AC-4, AC-5, AC-6
- **Test Requirements**:
  - `programmatic` TR-10.1: 系统试运行期间稳定运行，无重大故障
  - `programmatic` TR-10.2: 试运行期间发现的问题已整改完成
  - `human-judgement` TR-10.3: 系统通过正式验收，满足所有验收标准
- **Notes**: 需制定详细的试运行计划和验收方案