-- 创建数据库
CREATE DATABASE fire_platform;

-- 启用PostGIS扩展
CREATE EXTENSION IF NOT EXISTS postgis;

-- 创建用户并授权
CREATE USER postgres WITH PASSWORD '123456';
GRANT ALL PRIVILEGES ON DATABASE fire_platform TO postgres;

-- 连接到数据库
\c fire_platform;

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

-- 创建索引
-- 用户与权限管理
CREATE UNIQUE INDEX idx_sys_user_username ON sys_user(username);
CREATE INDEX idx_sys_user_organization_id ON sys_user(organization_id);
CREATE UNIQUE INDEX idx_sys_role_role_code ON sys_role(role_code);
CREATE UNIQUE INDEX idx_sys_permission_permission_code ON sys_permission(permission_code);
CREATE UNIQUE INDEX idx_sys_organization_org_code ON sys_organization(org_code);
CREATE INDEX idx_sys_organization_parent_id ON sys_organization(parent_id);

-- 消防机构管理
CREATE UNIQUE INDEX idx_fire_station_station_code ON fire_station(station_code);
CREATE INDEX idx_fire_station_organization_id ON fire_station(organization_id);
CREATE UNIQUE INDEX idx_fire_vehicle_vehicle_code ON fire_vehicle(vehicle_code);
CREATE INDEX idx_fire_vehicle_station_id ON fire_vehicle(station_id);
CREATE UNIQUE INDEX idx_fire_personnel_id_card ON fire_personnel(id_card);
CREATE INDEX idx_fire_personnel_station_id ON fire_personnel(station_id);
CREATE UNIQUE INDEX idx_linkage_unit_unit_code ON linkage_unit(unit_code);
CREATE UNIQUE INDEX idx_fire_expert_id_card ON fire_expert(id_card);

-- 重点单位管理
CREATE UNIQUE INDEX idx_key_unit_unit_code ON key_unit(unit_code);
CREATE INDEX idx_key_unit_organization_id ON key_unit(organization_id);
CREATE INDEX idx_key_unit_longitude_latitude ON key_unit(longitude, latitude);
CREATE INDEX idx_unit_building_unit_id ON unit_building(unit_id);
CREATE INDEX idx_unit_personnel_unit_id ON unit_personnel(unit_id);
CREATE INDEX idx_unit_archive_unit_id ON unit_archive(unit_id);
CREATE INDEX idx_unit_facility_unit_id ON unit_facility(unit_id);
CREATE INDEX idx_unit_facility_building_id ON unit_facility(building_id);
CREATE INDEX idx_key_position_unit_id ON key_position(unit_id);
CREATE INDEX idx_key_position_building_id ON key_position(building_id);

-- 预案管理
CREATE INDEX idx_plan_info_unit_id ON plan_info(unit_id);
CREATE INDEX idx_plan_drawing_plan_id ON plan_drawing(plan_id);
CREATE INDEX idx_plan_attachment_plan_id ON plan_attachment(plan_id);
CREATE INDEX idx_plan_version_plan_id ON plan_version(plan_id);

-- 训练考核管理
CREATE INDEX idx_training_plan_organization_id ON training_plan(organization_id);
CREATE INDEX idx_training_record_training_plan_id ON training_record(training_plan_id);
CREATE INDEX idx_training_record_personnel_id ON training_record(personnel_id);
CREATE INDEX idx_exam_info_organization_id ON exam_info(organization_id);
CREATE INDEX idx_exam_question_exam_id ON exam_question(exam_id);
CREATE INDEX idx_exam_result_exam_id ON exam_result(exam_id);
CREATE INDEX idx_exam_result_personnel_id ON exam_result(personnel_id);
CREATE INDEX idx_performance_point_personnel_id ON performance_point(personnel_id);
CREATE INDEX idx_performance_point_year_month ON performance_point(year, month);

-- 沙盘推演管理
CREATE INDEX idx_scenario_job_unit_id ON scenario_job(unit_id);
CREATE INDEX idx_scenario_scene_scenario_job_id ON scenario_scene(scenario_job_id);
CREATE INDEX idx_scenario_disaster_scenario_scene_id ON scenario_disaster(scenario_scene_id);
CREATE INDEX idx_scenario_vehicle_scenario_scene_id ON scenario_vehicle(scenario_scene_id);
CREATE INDEX idx_scenario_personnel_scenario_scene_id ON scenario_personnel(scenario_scene_id);
CREATE INDEX idx_assessment_info_scenario_job_id ON assessment_info(scenario_job_id);
CREATE INDEX idx_assessment_result_assessment_id ON assessment_result(assessment_id);
CREATE INDEX idx_assessment_result_personnel_id ON assessment_result(personnel_id);

-- 空间数据库
CREATE INDEX idx_spatial_unit_geometry ON spatial_unit USING GIST (geometry);
CREATE INDEX idx_spatial_facility_geometry ON spatial_facility USING GIST (geometry);
CREATE INDEX idx_spatial_route_geometry ON spatial_route USING GIST (geometry);
CREATE INDEX idx_spatial_water_source_geometry ON spatial_water_source USING GIST (geometry);

-- 数据初始化
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
