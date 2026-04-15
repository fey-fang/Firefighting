# 珠海消防数字化作战训练考核管理平台 - 数据库设计方案

## 1. 业务数据库表结构

### 1.1 用户与权限管理

#### sys_user（用户表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 用户ID |
| username | VARCHAR(50) | UNIQUE, NOT NULL | 用户名 |
| password | VARCHAR(100) | NOT NULL | 密码（加密存储） |
| name | VARCHAR(50) | NOT NULL | 真实姓名 |
| phone | VARCHAR(20) | | 手机号码 |
| email | VARCHAR(100) | | 邮箱 |
| organization_id | BIGINT | REFERENCES sys_organization(id) | 所属组织机构ID |
| status | INTEGER | DEFAULT 1 | 状态（1-启用，0-禁用） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### sys_role（角色表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 角色ID |
| role_name | VARCHAR(50) | NOT NULL | 角色名称 |
| role_code | VARCHAR(50) | UNIQUE, NOT NULL | 角色编码 |
| description | VARCHAR(200) | | 角色描述 |
| status | INTEGER | DEFAULT 1 | 状态（1-启用，0-禁用） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### sys_permission（权限表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 权限ID |
| permission_name | VARCHAR(50) | NOT NULL | 权限名称 |
| permission_code | VARCHAR(50) | UNIQUE, NOT NULL | 权限编码 |
| parent_id | BIGINT | REFERENCES sys_permission(id) | 父权限ID |
| url | VARCHAR(200) | | 权限URL |
| type | INTEGER | NOT NULL | 权限类型（1-菜单，2-按钮） |
| sort | INTEGER | DEFAULT 0 | 排序 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### sys_user_role（用户角色关联表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | ID |
| user_id | BIGINT | REFERENCES sys_user(id) | 用户ID |
| role_id | BIGINT | REFERENCES sys_role(id) | 角色ID |

#### sys_role_permission（角色权限关联表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | ID |
| role_id | BIGINT | REFERENCES sys_role(id) | 角色ID |
| permission_id | BIGINT | REFERENCES sys_permission(id) | 权限ID |

#### sys_organization（组织机构表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 组织机构ID |
| org_name | VARCHAR(100) | NOT NULL | 组织机构名称 |
| org_code | VARCHAR(50) | UNIQUE, NOT NULL | 组织机构编码 |
| parent_id | BIGINT | REFERENCES sys_organization(id) | 父组织机构ID |
| level | INTEGER | NOT NULL | 组织机构级别 |
| address | VARCHAR(200) | | 地址 |
| phone | VARCHAR(20) | | 联系电话 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

### 1.2 消防机构管理

#### fire_station（消防站表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 消防站ID |
| station_name | VARCHAR(100) | NOT NULL | 消防站名称 |
| station_code | VARCHAR(50) | UNIQUE, NOT NULL | 消防站编码 |
| organization_id | BIGINT | REFERENCES sys_organization(id) | 所属组织机构ID |
| address | VARCHAR(200) | NOT NULL | 地址 |
| phone | VARCHAR(20) | NOT NULL | 联系电话 |
| longitude | DOUBLE | | 经度 |
| latitude | DOUBLE | | 纬度 |
| capacity | INTEGER | | 容量 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### fire_vehicle（消防车辆表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 车辆ID |
| vehicle_name | VARCHAR(100) | NOT NULL | 车辆名称 |
| vehicle_code | VARCHAR(50) | UNIQUE, NOT NULL | 车辆编码 |
| station_id | BIGINT | REFERENCES fire_station(id) | 所属消防站ID |
| vehicle_type | VARCHAR(50) | NOT NULL | 车辆类型 |
| brand | VARCHAR(50) | | 品牌 |
| model | VARCHAR(50) | | 型号 |
| purchase_date | DATE | | 购买日期 |
| status | INTEGER | DEFAULT 1 | 状态（1-正常，0-维修，2-报废） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### fire_personnel（消防人员表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 人员ID |
| name | VARCHAR(50) | NOT NULL | 姓名 |
| id_card | VARCHAR(18) | UNIQUE, NOT NULL | 身份证号 |
| station_id | BIGINT | REFERENCES fire_station(id) | 所属消防站ID |
| position | VARCHAR(50) | | 职位 |
| rank | VARCHAR(50) | | 军衔/职级 |
| phone | VARCHAR(20) | NOT NULL | 联系电话 |
| entry_date | DATE | | 入职日期 |
| status | INTEGER | DEFAULT 1 | 状态（1-在职，0-离职） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### linkage_unit（联动单位表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 联动单位ID |
| unit_name | VARCHAR(100) | NOT NULL | 单位名称 |
| unit_code | VARCHAR(50) | UNIQUE, NOT NULL | 单位编码 |
| unit_type | VARCHAR(50) | NOT NULL | 单位类型（社会联动单位、联勤保障单位） |
| address | VARCHAR(200) | NOT NULL | 地址 |
| contact_person | VARCHAR(50) | | 联系人 |
| phone | VARCHAR(20) | NOT NULL | 联系电话 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### fire_expert（消防专家表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 专家ID |
| name | VARCHAR(50) | NOT NULL | 姓名 |
| id_card | VARCHAR(18) | UNIQUE, NOT NULL | 身份证号 |
| expertise | VARCHAR(100) | NOT NULL | 专业领域 |
| affiliation | VARCHAR(100) | | 所属单位 |
| phone | VARCHAR(20) | NOT NULL | 联系电话 |
| email | VARCHAR(100) | | 邮箱 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

### 1.3 重点单位管理

#### key_unit（重点单位表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 单位ID |
| unit_name | VARCHAR(100) | NOT NULL | 单位名称 |
| unit_code | VARCHAR(50) | UNIQUE, NOT NULL | 单位编码 |
| organization_id | BIGINT | REFERENCES sys_organization(id) | 所属组织机构ID |
| address | VARCHAR(200) | NOT NULL | 地址 |
| longitude | DOUBLE | | 经度 |
| latitude | DOUBLE | | 纬度 |
| unit_type | VARCHAR(50) | NOT NULL | 单位类型 |
| risk_level | VARCHAR(20) | NOT NULL | 风险等级 |
| contact_person | VARCHAR(50) | | 联系人 |
| phone | VARCHAR(20) | NOT NULL | 联系电话 |
| total_floor | INTEGER | | 总楼层 |
| building_area | DOUBLE | | 建筑面积 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### unit_building（单位建筑表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 建筑ID |
| building_name | VARCHAR(100) | NOT NULL | 建筑名称 |
| unit_id | BIGINT | REFERENCES key_unit(id) | 所属单位ID |
| building_type | VARCHAR(50) | NOT NULL | 建筑类型 |
| total_floor | INTEGER | | 总楼层 |
| building_area | DOUBLE | | 建筑面积 |
| height | DOUBLE | | 建筑高度 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### unit_personnel（单位人员表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 人员ID |
| name | VARCHAR(50) | NOT NULL | 姓名 |
| unit_id | BIGINT | REFERENCES key_unit(id) | 所属单位ID |
| position | VARCHAR(50) | | 职位 |
| phone | VARCHAR(20) | NOT NULL | 联系电话 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### unit_archive（单位档案表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 档案ID |
| unit_id | BIGINT | REFERENCES key_unit(id) | 所属单位ID |
| archive_name | VARCHAR(100) | NOT NULL | 档案名称 |
| archive_type | VARCHAR(50) | NOT NULL | 档案类型 |
| file_path | VARCHAR(200) | NOT NULL | 文件路径 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### unit_facility（单位设施表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 设施ID |
| facility_name | VARCHAR(100) | NOT NULL | 设施名称 |
| unit_id | BIGINT | REFERENCES key_unit(id) | 所属单位ID |
| building_id | BIGINT | REFERENCES unit_building(id) | 所属建筑ID |
| facility_type | VARCHAR(50) | NOT NULL | 设施类型 |
| location | VARCHAR(200) | | 位置 |
| status | INTEGER | DEFAULT 1 | 状态（1-正常，0-故障） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### key_position（重点部位表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 重点部位ID |
| position_name | VARCHAR(100) | NOT NULL | 部位名称 |
| unit_id | BIGINT | REFERENCES key_unit(id) | 所属单位ID |
| building_id | BIGINT | REFERENCES unit_building(id) | 所属建筑ID |
| location | VARCHAR(200) | NOT NULL | 位置 |
| risk_level | VARCHAR(20) | NOT NULL | 风险等级 |
| area | DOUBLE | | 面积 |
| description | TEXT | | 描述 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

### 1.4 预案管理

#### plan_info（预案信息表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 预案ID |
| plan_name | VARCHAR(100) | NOT NULL | 预案名称 |
| unit_id | BIGINT | REFERENCES key_unit(id) | 所属单位ID |
| plan_type | VARCHAR(50) | NOT NULL | 预案类型 |
| version | VARCHAR(20) | NOT NULL | 版本号 |
| status | INTEGER | DEFAULT 1 | 状态（1-启用，0-禁用） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### plan_drawing（预案图纸表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 图纸ID |
| plan_id | BIGINT | REFERENCES plan_info(id) | 所属预案ID |
| drawing_name | VARCHAR(100) | NOT NULL | 图纸名称 |
| drawing_type | VARCHAR(50) | NOT NULL | 图纸类型 |
| file_path | VARCHAR(200) | NOT NULL | 文件路径 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### plan_attachment（预案附件表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 附件ID |
| plan_id | BIGINT | REFERENCES plan_info(id) | 所属预案ID |
| attachment_name | VARCHAR(100) | NOT NULL | 附件名称 |
| file_path | VARCHAR(200) | NOT NULL | 文件路径 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### plan_version（预案版本表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 版本ID |
| plan_id | BIGINT | REFERENCES plan_info(id) | 所属预案ID |
| version | VARCHAR(20) | NOT NULL | 版本号 |
| update_content | TEXT | | 更新内容 |
| update_person | VARCHAR(50) | | 更新人 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 1.5 训练考核管理

#### training_plan（训练计划表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 训练计划ID |
| plan_name | VARCHAR(100) | NOT NULL | 计划名称 |
| organization_id | BIGINT | REFERENCES sys_organization(id) | 所属组织机构ID |
| start_date | DATE | NOT NULL | 开始日期 |
| end_date | DATE | NOT NULL | 结束日期 |
| content | TEXT | | 训练内容 |
| status | INTEGER | DEFAULT 1 | 状态（1-进行中，0-已结束） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### training_record（训练记录表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 训练记录ID |
| training_plan_id | BIGINT | REFERENCES training_plan(id) | 所属训练计划ID |
| personnel_id | BIGINT | REFERENCES fire_personnel(id) | 参训人员ID |
| training_date | DATE | NOT NULL | 训练日期 |
| training_content | TEXT | | 训练内容 |
| score | INTEGER | | 得分 |
| status | INTEGER | DEFAULT 1 | 状态（1-已完成，0-未完成） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### exam_info（考试信息表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 考试ID |
| exam_name | VARCHAR(100) | NOT NULL | 考试名称 |
| organization_id | BIGINT | REFERENCES sys_organization(id) | 所属组织机构ID |
| start_time | TIMESTAMP | NOT NULL | 开始时间 |
| end_time | TIMESTAMP | NOT NULL | 结束时间 |
| status | INTEGER | DEFAULT 1 | 状态（1-进行中，0-已结束） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### exam_question（考试题目表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 题目ID |
| exam_id | BIGINT | REFERENCES exam_info(id) | 所属考试ID |
| question_type | VARCHAR(20) | NOT NULL | 题目类型（单选、多选、判断、简答） |
| question_content | TEXT | NOT NULL | 题目内容 |
| option_a | VARCHAR(200) | | 选项A |
| option_b | VARCHAR(200) | | 选项B |
| option_c | VARCHAR(200) | | 选项C |
| option_d | VARCHAR(200) | | 选项D |
| correct_answer | VARCHAR(100) | NOT NULL | 正确答案 |
| score | INTEGER | NOT NULL | 分值 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### exam_result（考试成绩表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 成绩ID |
| exam_id | BIGINT | REFERENCES exam_info(id) | 所属考试ID |
| personnel_id | BIGINT | REFERENCES fire_personnel(id) | 参考人员ID |
| score | INTEGER | NOT NULL | 得分 |
| rank | INTEGER | | 排名 |
| status | VARCHAR(20) | | 状态（合格、不合格） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### performance_point（绩点表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 绩点ID |
| personnel_id | BIGINT | REFERENCES fire_personnel(id) | 人员ID |
| year | INTEGER | NOT NULL | 年份 |
| month | INTEGER | NOT NULL | 月份 |
| performance_point | DOUBLE | NOT NULL | 绩点 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

### 1.6 沙盘推演管理

#### scenario_job（想定作业表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 想定作业ID |
| job_name | VARCHAR(100) | NOT NULL | 作业名称 |
| unit_id | BIGINT | REFERENCES key_unit(id) | 所属单位ID |
| create_person | VARCHAR(50) | | 创建人 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### scenario_scene（场景表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 场景ID |
| scene_name | VARCHAR(100) | NOT NULL | 场景名称 |
| scenario_job_id | BIGINT | REFERENCES scenario_job(id) | 所属想定作业ID |
| scene_type | VARCHAR(50) | NOT NULL | 场景类型 |
| description | TEXT | | 场景描述 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### scenario_disaster（灾情表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 灾情ID |
| disaster_name | VARCHAR(100) | NOT NULL | 灾情名称 |
| scenario_scene_id | BIGINT | REFERENCES scenario_scene(id) | 所属场景ID |
| disaster_type | VARCHAR(50) | NOT NULL | 灾情类型（火灾、其他灾害） |
| severity | VARCHAR(20) | NOT NULL | 严重程度 |
| description | TEXT | | 灾情描述 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### scenario_vehicle（场景车辆表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 车辆ID |
| scenario_scene_id | BIGINT | REFERENCES scenario_scene(id) | 所属场景ID |
| vehicle_type | VARCHAR(50) | NOT NULL | 车辆类型 |
| vehicle_model | VARCHAR(50) | | 车辆模型 |
| quantity | INTEGER | DEFAULT 1 | 数量 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### scenario_personnel（场景人员表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 人员ID |
| scenario_scene_id | BIGINT | REFERENCES scenario_scene(id) | 所属场景ID |
| personnel_type | VARCHAR(50) | NOT NULL | 人员类型 |
| quantity | INTEGER | DEFAULT 1 | 数量 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### assessment_info（考核信息表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 考核ID |
| assessment_name | VARCHAR(100) | NOT NULL | 考核名称 |
| scenario_job_id | BIGINT | REFERENCES scenario_job(id) | 所属想定作业ID |
| start_time | TIMESTAMP | NOT NULL | 开始时间 |
| end_time | TIMESTAMP | NOT NULL | 结束时间 |
| status | INTEGER | DEFAULT 1 | 状态（1-进行中，0-已结束） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

#### assessment_result（考核结果表）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 结果ID |
| assessment_id | BIGINT | REFERENCES assessment_info(id) | 所属考核ID |
| personnel_id | BIGINT | REFERENCES fire_personnel(id) | 考核人员ID |
| score | INTEGER | NOT NULL | 得分 |
| rank | INTEGER | | 排名 |
| status | VARCHAR(20) | | 状态（合格、不合格） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

## 2. 空间数据库表结构

### 2.1 spatial_unit（单位空间数据）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 空间数据ID |
| unit_id | BIGINT | REFERENCES key_unit(id) | 所属单位ID |
| geometry | GEOMETRY | NOT NULL | 空间几何数据 |
| spatial_type | VARCHAR(50) | NOT NULL | 空间类型（点、线、面） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

### 2.2 spatial_facility（设施空间数据）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 空间数据ID |
| facility_id | BIGINT | REFERENCES unit_facility(id) | 所属设施ID |
| geometry | GEOMETRY | NOT NULL | 空间几何数据 |
| spatial_type | VARCHAR(50) | NOT NULL | 空间类型（点、线、面） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

### 2.3 spatial_route（路线空间数据）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 空间数据ID |
| route_name | VARCHAR(100) | NOT NULL | 路线名称 |
| start_point | GEOMETRY | NOT NULL | 起点 |
| end_point | GEOMETRY | NOT NULL | 终点 |
| geometry | GEOMETRY | NOT NULL | 路线几何数据 |
| length | DOUBLE | | 路线长度 |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

### 2.4 spatial_water_source（水源空间数据）
| 字段名 | 数据类型 | 约束 | 描述 |
| :--- | :--- | :--- | :--- |
| id | BIGINT | PRIMARY KEY, AUTO_INCREMENT | 空间数据ID |
| water_source_name | VARCHAR(100) | NOT NULL | 水源名称 |
| water_source_type | VARCHAR(50) | NOT NULL | 水源类型（消火栓、水池、湖泊等） |
| geometry | GEOMETRY | NOT NULL | 空间几何数据 |
| capacity | DOUBLE | | 容量 |
| status | INTEGER | DEFAULT 1 | 状态（1-可用，0-不可用） |
| create_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| update_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

## 3. 数据库初始化和迁移脚本

### 3.1 初始化脚本

```sql
-- 创建数据库
CREATE DATABASE fire_platform;

-- 启用PostGIS扩展
CREATE EXTENSION IF NOT EXISTS postgis;

-- 创建用户并授权
CREATE USER postgres WITH PASSWORD '123456';
GRANT ALL PRIVILEGES ON DATABASE fire_platform TO postgres;
```

### 3.2 表结构创建脚本

```sql
-- 用户与权限管理
CREATE TABLE sys_organization (
    id BIGSERIAL PRIMARY KEY,
    org_name VARCHAR(100) NOT NULL,
    org_code VARCHAR(50) UNIQUE NOT NULL,
    parent_id BIGINT REFERENCES sys_organization(id),
    level INTEGER NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sys_user (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    organization_id BIGINT REFERENCES sys_organization(id),
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sys_role (
    id BIGSERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    role_code VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(200),
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sys_permission (
    id BIGSERIAL PRIMARY KEY,
    permission_name VARCHAR(50) NOT NULL,
    permission_code VARCHAR(50) UNIQUE NOT NULL,
    parent_id BIGINT REFERENCES sys_permission(id),
    url VARCHAR(200),
    type INTEGER NOT NULL,
    sort INTEGER DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sys_user_role (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES sys_user(id),
    role_id BIGINT REFERENCES sys_role(id)
);

CREATE TABLE sys_role_permission (
    id BIGSERIAL PRIMARY KEY,
    role_id BIGINT REFERENCES sys_role(id),
    permission_id BIGINT REFERENCES sys_permission(id)
);

-- 消防机构管理
CREATE TABLE fire_station (
    id BIGSERIAL PRIMARY KEY,
    station_name VARCHAR(100) NOT NULL,
    station_code VARCHAR(50) UNIQUE NOT NULL,
    organization_id BIGINT REFERENCES sys_organization(id),
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    longitude DOUBLE PRECISION,
    latitude DOUBLE PRECISION,
    capacity INTEGER,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fire_vehicle (
    id BIGSERIAL PRIMARY KEY,
    vehicle_name VARCHAR(100) NOT NULL,
    vehicle_code VARCHAR(50) UNIQUE NOT NULL,
    station_id BIGINT REFERENCES fire_station(id),
    vehicle_type VARCHAR(50) NOT NULL,
    brand VARCHAR(50),
    model VARCHAR(50),
    purchase_date DATE,
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fire_personnel (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    id_card VARCHAR(18) UNIQUE NOT NULL,
    station_id BIGINT REFERENCES fire_station(id),
    position VARCHAR(50),
    rank VARCHAR(50),
    phone VARCHAR(20) NOT NULL,
    entry_date DATE,
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE linkage_unit (
    id BIGSERIAL PRIMARY KEY,
    unit_name VARCHAR(100) NOT NULL,
    unit_code VARCHAR(50) UNIQUE NOT NULL,
    unit_type VARCHAR(50) NOT NULL,
    address VARCHAR(200) NOT NULL,
    contact_person VARCHAR(50),
    phone VARCHAR(20) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fire_expert (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    id_card VARCHAR(18) UNIQUE NOT NULL,
    expertise VARCHAR(100) NOT NULL,
    affiliation VARCHAR(100),
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 重点单位管理
CREATE TABLE key_unit (
    id BIGSERIAL PRIMARY KEY,
    unit_name VARCHAR(100) NOT NULL,
    unit_code VARCHAR(50) UNIQUE NOT NULL,
    organization_id BIGINT REFERENCES sys_organization(id),
    address VARCHAR(200) NOT NULL,
    longitude DOUBLE PRECISION,
    latitude DOUBLE PRECISION,
    unit_type VARCHAR(50) NOT NULL,
    risk_level VARCHAR(20) NOT NULL,
    contact_person VARCHAR(50),
    phone VARCHAR(20) NOT NULL,
    total_floor INTEGER,
    building_area DOUBLE PRECISION,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE unit_building (
    id BIGSERIAL PRIMARY KEY,
    building_name VARCHAR(100) NOT NULL,
    unit_id BIGINT REFERENCES key_unit(id),
    building_type VARCHAR(50) NOT NULL,
    total_floor INTEGER,
    building_area DOUBLE PRECISION,
    height DOUBLE PRECISION,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE unit_personnel (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    unit_id BIGINT REFERENCES key_unit(id),
    position VARCHAR(50),
    phone VARCHAR(20) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE unit_archive (
    id BIGSERIAL PRIMARY KEY,
    unit_id BIGINT REFERENCES key_unit(id),
    archive_name VARCHAR(100) NOT NULL,
    archive_type VARCHAR(50) NOT NULL,
    file_path VARCHAR(200) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE unit_facility (
    id BIGSERIAL PRIMARY KEY,
    facility_name VARCHAR(100) NOT NULL,
    unit_id BIGINT REFERENCES key_unit(id),
    building_id BIGINT REFERENCES unit_building(id),
    facility_type VARCHAR(50) NOT NULL,
    location VARCHAR(200),
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE key_position (
    id BIGSERIAL PRIMARY KEY,
    position_name VARCHAR(100) NOT NULL,
    unit_id BIGINT REFERENCES key_unit(id),
    building_id BIGINT REFERENCES unit_building(id),
    location VARCHAR(200) NOT NULL,
    risk_level VARCHAR(20) NOT NULL,
    area DOUBLE PRECISION,
    description TEXT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 预案管理
CREATE TABLE plan_info (
    id BIGSERIAL PRIMARY KEY,
    plan_name VARCHAR(100) NOT NULL,
    unit_id BIGINT REFERENCES key_unit(id),
    plan_type VARCHAR(50) NOT NULL,
    version VARCHAR(20) NOT NULL,
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE plan_drawing (
    id BIGSERIAL PRIMARY KEY,
    plan_id BIGINT REFERENCES plan_info(id),
    drawing_name VARCHAR(100) NOT NULL,
    drawing_type VARCHAR(50) NOT NULL,
    file_path VARCHAR(200) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE plan_attachment (
    id BIGSERIAL PRIMARY KEY,
    plan_id BIGINT REFERENCES plan_info(id),
    attachment_name VARCHAR(100) NOT NULL,
    file_path VARCHAR(200) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE plan_version (
    id BIGSERIAL PRIMARY KEY,
    plan_id BIGINT REFERENCES plan_info(id),
    version VARCHAR(20) NOT NULL,
    update_content TEXT,
    update_person VARCHAR(50),
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 训练考核管理
CREATE TABLE training_plan (
    id BIGSERIAL PRIMARY KEY,
    plan_name VARCHAR(100) NOT NULL,
    organization_id BIGINT REFERENCES sys_organization(id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    content TEXT,
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE training_record (
    id BIGSERIAL PRIMARY KEY,
    training_plan_id BIGINT REFERENCES training_plan(id),
    personnel_id BIGINT REFERENCES fire_personnel(id),
    training_date DATE NOT NULL,
    training_content TEXT,
    score INTEGER,
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE exam_info (
    id BIGSERIAL PRIMARY KEY,
    exam_name VARCHAR(100) NOT NULL,
    organization_id BIGINT REFERENCES sys_organization(id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE exam_question (
    id BIGSERIAL PRIMARY KEY,
    exam_id BIGINT REFERENCES exam_info(id),
    question_type VARCHAR(20) NOT NULL,
    question_content TEXT NOT NULL,
    option_a VARCHAR(200),
    option_b VARCHAR(200),
    option_c VARCHAR(200),
    option_d VARCHAR(200),
    correct_answer VARCHAR(100) NOT NULL,
    score INTEGER NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE exam_result (
    id BIGSERIAL PRIMARY KEY,
    exam_id BIGINT REFERENCES exam_info(id),
    personnel_id BIGINT REFERENCES fire_personnel(id),
    score INTEGER NOT NULL,
    rank INTEGER,
    status VARCHAR(20),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE performance_point (
    id BIGSERIAL PRIMARY KEY,
    personnel_id BIGINT REFERENCES fire_personnel(id),
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    performance_point DOUBLE PRECISION NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 沙盘推演管理
CREATE TABLE scenario_job (
    id BIGSERIAL PRIMARY KEY,
    job_name VARCHAR(100) NOT NULL,
    unit_id BIGINT REFERENCES key_unit(id),
    create_person VARCHAR(50),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE scenario_scene (
    id BIGSERIAL PRIMARY KEY,
    scene_name VARCHAR(100) NOT NULL,
    scenario_job_id BIGINT REFERENCES scenario_job(id),
    scene_type VARCHAR(50) NOT NULL,
    description TEXT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE scenario_disaster (
    id BIGSERIAL PRIMARY KEY,
    disaster_name VARCHAR(100) NOT NULL,
    scenario_scene_id BIGINT REFERENCES scenario_scene(id),
    disaster_type VARCHAR(50) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    description TEXT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE scenario_vehicle (
    id BIGSERIAL PRIMARY KEY,
    scenario_scene_id BIGINT REFERENCES scenario_scene(id),
    vehicle_type VARCHAR(50) NOT NULL,
    vehicle_model VARCHAR(50),
    quantity INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE scenario_personnel (
    id BIGSERIAL PRIMARY KEY,
    scenario_scene_id BIGINT REFERENCES scenario_scene(id),
    personnel_type VARCHAR(50) NOT NULL,
    quantity INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE assessment_info (
    id BIGSERIAL PRIMARY KEY,
    assessment_name VARCHAR(100) NOT NULL,
    scenario_job_id BIGINT REFERENCES scenario_job(id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE assessment_result (
    id BIGSERIAL PRIMARY KEY,
    assessment_id BIGINT REFERENCES assessment_info(id),
    personnel_id BIGINT REFERENCES fire_personnel(id),
    score INTEGER NOT NULL,
    rank INTEGER,
    status VARCHAR(20),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 空间数据库
CREATE TABLE spatial_unit (
    id BIGSERIAL PRIMARY KEY,
    unit_id BIGINT REFERENCES key_unit(id),
    geometry GEOMETRY NOT NULL,
    spatial_type VARCHAR(50) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE spatial_facility (
    id BIGSERIAL PRIMARY KEY,
    facility_id BIGINT REFERENCES unit_facility(id),
    geometry GEOMETRY NOT NULL,
    spatial_type VARCHAR(50) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE spatial_route (
    id BIGSERIAL PRIMARY KEY,
    route_name VARCHAR(100) NOT NULL,
    start_point GEOMETRY NOT NULL,
    end_point GEOMETRY NOT NULL,
    geometry GEOMETRY NOT NULL,
    length DOUBLE PRECISION,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE spatial_water_source (
    id BIGSERIAL PRIMARY KEY,
    water_source_name VARCHAR(100) NOT NULL,
    water_source_type VARCHAR(50) NOT NULL,
    geometry GEOMETRY NOT NULL,
    capacity DOUBLE PRECISION,
    status INTEGER DEFAULT 1,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建空间索引
CREATE INDEX idx_spatial_unit_geometry ON spatial_unit USING GIST (geometry);
CREATE INDEX idx_spatial_facility_geometry ON spatial_facility USING GIST (geometry);
CREATE INDEX idx_spatial_route_geometry ON spatial_route USING GIST (geometry);
CREATE INDEX idx_spatial_water_source_geometry ON spatial_water_source USING GIST (geometry);
```

### 3.3 数据初始化脚本

```sql
-- 初始化组织机构
INSERT INTO sys_organization (org_name, org_code, parent_id, level, address, phone) VALUES
('珠海市消防救援支队', 'ZHXF', NULL, 1, '珠海市香洲区梅华东路301号', '0756-119'),
('香洲区消防救援大队', 'XZXF', 1, 2, '珠海市香洲区香洲街道', '0756-2222222'),
('金湾区消防救援大队', 'JWXF', 1, 2, '珠海市金湾区三灶镇', '0756-3333333'),
('斗门区消防救援大队', 'DMXF', 1, 2, '珠海市斗门区井岸镇', '0756-4444444');

-- 初始化角色
INSERT INTO sys_role (role_name, role_code, description, status) VALUES
('超级管理员', 'super_admin', '系统超级管理员', 1),
('支队管理员', 'team_admin', '支队管理员', 1),
('大队管理员', 'brigade_admin', '大队管理员', 1),
('消防站管理员', 'station_admin', '消防站管理员', 1),
('普通用户', 'normal_user', '普通用户', 1);

-- 初始化权限
INSERT INTO sys_permission (permission_name, permission_code, parent_id, url, type, sort) VALUES
('系统管理', 'system_manage', NULL, '/system', 1, 1),
('用户管理', 'user_manage', 1, '/system/user', 1, 2),
('角色管理', 'role_manage', 1, '/system/role', 1, 3),
('权限管理', 'permission_manage', 1, '/system/permission', 1, 4),
('组织机构管理', 'org_manage', 1, '/system/org', 1, 5),
('消防机构管理', 'fire_org_manage', NULL, '/fire/org', 1, 6),
('消防站管理', 'station_manage', 6, '/fire/station', 1, 7),
('消防车辆管理', 'vehicle_manage', 6, '/fire/vehicle', 1, 8),
('消防人员管理', 'personnel_manage', 6, '/fire/personnel', 1, 9),
('联动单位管理', 'linkage_manage', 6, '/fire/linkage', 1, 10),
('消防专家管理', 'expert_manage', 6, '/fire/expert', 1, 11),
('重点单位管理', 'key_unit_manage', NULL, '/key/unit', 1, 12),
('单位基础信息', 'unit_base', 12, '/key/unit/base', 1, 13),
('单位建筑管理', 'unit_building', 12, '/key/unit/building', 1, 14),
('单位人员管理', 'unit_personnel', 12, '/key/unit/personnel', 1, 15),
('单位档案管理', 'unit_archive', 12, '/key/unit/archive', 1, 16),
('单位设施管理', 'unit_facility', 12, '/key/unit/facility', 1, 17),
('重点部位管理', 'key_position', 12, '/key/position', 1, 18),
('预案管理', 'plan_manage', NULL, '/plan', 1, 19),
('预案信息管理', 'plan_info', 19, '/plan/info', 1, 20),
('预案图纸管理', 'plan_drawing', 19, '/plan/drawing', 1, 21),
('预案附件管理', 'plan_attachment', 19, '/plan/attachment', 1, 22),
('预案版本管理', 'plan_version', 19, '/plan/version', 1, 23),
('训练考核管理', 'training_manage', NULL, '/training', 1, 24),
('训练计划管理', 'training_plan', 24, '/training/plan', 1, 25),
('训练记录管理', 'training_record', 24, '/training/record', 1, 26),
('考试信息管理', 'exam_info', 24, '/training/exam', 1, 27),
('考试题目管理', 'exam_question', 24, '/training/question', 1, 28),
('考试成绩管理', 'exam_result', 24, '/training/result', 1, 29),
('绩点管理', 'performance_point', 24, '/training/performance', 1, 30),
('沙盘推演管理', 'scenario_manage', NULL, '/scenario', 1, 31),
('想定作业管理', 'scenario_job', 31, '/scenario/job', 1, 32),
('场景管理', 'scenario_scene', 31, '/scenario/scene', 1, 33),
('灾情管理', 'scenario_disaster', 31, '/scenario/disaster', 1, 34),
('场景车辆管理', 'scenario_vehicle', 31, '/scenario/vehicle', 1, 35),
('场景人员管理', 'scenario_personnel', 31, '/scenario/personnel', 1, 36),
('考核信息管理', 'assessment_info', 31, '/scenario/assessment', 1, 37),
('考核结果管理', 'assessment_result', 31, '/scenario/result', 1, 38),
('空间数据管理', 'spatial_manage', NULL, '/spatial', 1, 39),
('单位空间数据', 'spatial_unit', 39, '/spatial/unit', 1, 40),
('设施空间数据', 'spatial_facility', 39, '/spatial/facility', 1, 41),
('路线空间数据', 'spatial_route', 39, '/spatial/route', 1, 42),
('水源空间数据', 'spatial_water_source', 39, '/spatial/water', 1, 43);

-- 初始化角色权限关联
INSERT INTO sys_role_permission (role_id, permission_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(1, 6), (1, 7), (1, 8), (1, 9), (1, 10), (1, 11),
(1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18),
(1, 19), (1, 20), (1, 21), (1, 22), (1, 23),
(1, 24), (1, 25), (1, 26), (1, 27), (1, 28), (1, 29), (1, 30),
(1, 31), (1, 32), (1, 33), (1, 34), (1, 35), (1, 36), (1, 37), (1, 38),
(1, 39), (1, 40), (1, 41), (1, 42), (1, 43);

-- 初始化用户
INSERT INTO sys_user (username, password, name, phone, email, organization_id, status) VALUES
('admin', '$2a$10$e1d7L3Qr7Y4Fp7w8e7z9uO7U6V5N4M3L2K1J0H9G8F7E6D5C4B3A2', '管理员', '13800138000', 'admin@example.com', 1, 1);

-- 初始化用户角色关联
INSERT INTO sys_user_role (user_id, role_id) VALUES
(1, 1);
```

## 4. 数据库索引配置和优化

### 4.1 索引配置

| 表名 | 索引名 | 索引类型 | 索引字段 | 用途 |
| :--- | :--- | :--- | :--- | :--- |
| sys_user | idx_sys_user_username | 唯一索引 | username | 加速用户登录和查询 |
| sys_user | idx_sys_user_organization_id | 普通索引 | organization_id | 加速按组织机构查询用户 |
| sys_role | idx_sys_role_role_code | 唯一索引 | role_code | 加速角色查询 |
| sys_permission | idx_sys_permission_permission_code | 唯一索引 | permission_code | 加速权限查询 |
| sys_organization | idx_sys_organization_org_code | 唯一索引 | org_code | 加速组织机构查询 |
| sys_organization | idx_sys_organization_parent_id | 普通索引 | parent_id | 加速查询子组织机构 |
| fire_station | idx_fire_station_station_code | 唯一索引 | station_code | 加速消防站查询 |
| fire_station | idx_fire_station_organization_id | 普通索引 | organization_id | 加速按组织机构查询消防站 |
| fire_vehicle | idx_fire_vehicle_vehicle_code | 唯一索引 | vehicle_code | 加速车辆查询 |
| fire_vehicle | idx_fire_vehicle_station_id | 普通索引 | station_id | 加速按消防站查询车辆 |
| fire_personnel | idx_fire_personnel_id_card | 唯一索引 | id_card | 加速人员查询 |
| fire_personnel | idx_fire_personnel_station_id | 普通索引 | station_id | 加速按消防站查询人员 |
| key_unit | idx_key_unit_unit_code | 唯一索引 | unit_code | 加速重点单位查询 |
| key_unit | idx_key_unit_organization_id | 普通索引 | organization_id | 加速按组织机构查询重点单位 |
| key_unit | idx_key_unit_longitude_latitude | 空间索引 | (longitude, latitude) | 加速地理位置查询 |
| unit_building | idx_unit_building_unit_id | 普通索引 | unit_id | 加速按单位查询建筑 |
| unit_facility | idx_unit_facility_unit_id | 普通索引 | unit_id | 加速按单位查询设施 |
| unit_facility | idx_unit_facility_building_id | 普通索引 | building_id | 加速按建筑查询设施 |
| key_position | idx_key_position_unit_id | 普通索引 | unit_id | 加速按单位查询重点部位 |
| key_position | idx_key_position_building_id | 普通索引 | building_id | 加速按建筑查询重点部位 |
| plan_info | idx_plan_info_unit_id | 普通索引 | unit_id | 加速按单位查询预案 |
| training_plan | idx_training_plan_organization_id | 普通索引 | organization_id | 加速按组织机构查询训练计划 |
| training_record | idx_training_record_training_plan_id | 普通索引 | training_plan_id | 加速按训练计划查询记录 |
| training_record | idx_training_record_personnel_id | 普通索引 | personnel_id | 加速按人员查询训练记录 |
| exam_info | idx_exam_info_organization_id | 普通索引 | organization_id | 加速按组织机构查询考试 |
| exam_result | idx_exam_result_exam_id | 普通索引 | exam_id | 加速按考试查询成绩 |
| exam_result | idx_exam_result_personnel_id | 普通索引 | personnel_id | 加速按人员查询考试成绩 |
| scenario_job | idx_scenario_job_unit_id | 普通索引 | unit_id | 加速按单位查询想定作业 |
| scenario_scene | idx_scenario_scene_scenario_job_id | 普通索引 | scenario_job_id | 加速按想定作业查询场景 |
| scenario_disaster | idx_scenario_disaster_scenario_scene_id | 普通索引 | scenario_scene_id | 加速按场景查询灾情 |
| scenario_vehicle | idx_scenario_vehicle_scenario_scene_id | 普通索引 | scenario_scene_id | 加速按场景查询车辆 |
| scenario_personnel | idx_scenario_personnel_scenario_scene_id | 普通索引 | scenario_scene_id | 加速按场景查询人员 |
| assessment_info | idx_assessment_info_scenario_job_id | 普通索引 | scenario_job_id | 加速按想定作业查询考核 |
| assessment_result | idx_assessment_result_assessment_id | 普通索引 | assessment_id | 加速按考核查询结果 |
| assessment_result | idx_assessment_result_personnel_id | 普通索引 | personnel_id | 加速按人员查询考核结果 |
| spatial_unit | idx_spatial_unit_geometry | 空间索引 | geometry | 加速空间查询 |
| spatial_facility | idx_spatial_facility_geometry | 空间索引 | geometry | 加速空间查询 |
| spatial_route | idx_spatial_route_geometry | 空间索引 | geometry | 加速空间查询 |
| spatial_water_source | idx_spatial_water_source_geometry | 空间索引 | geometry | 加速空间查询 |

### 4.2 性能优化

1. **分区表**：对于数据量较大的表，如训练记录、考试成绩等，可以考虑使用分区表来提高查询性能。

2. **物化视图**：对于频繁查询的统计数据，可以创建物化视图来预计算结果，提高查询速度。

3. **连接池优化**：配置合理的数据库连接池大小，避免连接过多或过少。

4. **查询优化**：
   - 避免使用SELECT *，只查询需要的字段
   - 使用JOIN代替子查询
   - 合理使用索引
   - 避免在WHERE子句中使用函数

5. **缓存策略**：对于频繁访问的数据，可以使用Redis等缓存工具来缓存结果，减少数据库访问。

6. **硬件优化**：使用SSD存储、增加内存、优化服务器配置等。

7. **数据库参数调优**：根据实际情况调整PostgreSQL的参数，如shared_buffers、work_mem等。

## 5. 数据备份和恢复策略

### 5.1 备份策略

1. **全量备份**：
   - 每天凌晨2点执行一次全量备份
   - 使用pg_dump工具进行备份
   - 备份文件存储在备份服务器上，保留最近7天的备份

2. **增量备份**：
   - 每小时执行一次增量备份
   - 使用pg_basebackup工具进行备份
   - 备份文件存储在备份服务器上，保留最近24小时的备份

3. **日志备份**：
   - 实时备份WAL日志
   - 确保可以通过WAL日志进行时间点恢复

### 5.2 恢复策略

1. **完全恢复**：
   - 使用最近的全量备份和增量备份进行恢复
   - 适用于数据库完全损坏的情况

2. **时间点恢复**：
   - 使用全量备份、增量备份和WAL日志进行时间点恢复
   - 适用于数据库在某个时间点出现错误的情况

3. **表级恢复**：
   - 对于误删除的表，可以从备份中恢复单个表
   - 适用于单个表数据丢失的情况

### 5.3 备份验证

1. **定期验证**：
   - 每周执行一次备份验证，确保备份文件可以正常恢复
   - 验证过程包括恢复备份到测试环境，并检查数据完整性

2. **监控**：
   - 监控备份任务的执行状态
   - 当备份失败时，及时发送告警通知

### 5.4 灾难恢复

1. **灾备方案**：
   - 建立异地灾备中心
   - 定期将备份文件同步到灾备中心
   - 当主数据中心发生灾难时，可以从灾备中心恢复数据

2. **恢复演练**：
   - 每季度执行一次灾难恢复演练
   - 测试从灾备中心恢复数据的流程和时间
   - 确保在灾难发生时能够快速恢复系统运行

## 6. 总结

本数据库设计方案基于系统设计文档的需求，设计了完整的业务数据库和空间数据库表结构，包括用户与权限管理、消防机构管理、重点单位管理、预案管理、训练考核管理、沙盘推演管理等模块。同时，设计了数据库初始化和迁移脚本、索引配置和优化策略，以及数据备份和恢复策略，确保数据库设计满足业务需求和性能要求。

通过合理的数据库设计和优化，可以提高系统的性能和可靠性，为珠海消防数字化作战训练考核管理平台的稳定运行提供有力支持。