#!/bin/bash

# 数据库恢复脚本
# 用于从备份文件恢复数据库

# 配置参数
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="fire_platform"
DB_USER="postgres"
DB_PASSWORD="123456"

# 备份目录
BACKUP_DIR="/backup/fire_platform"
FULL_BACKUP_DIR="$BACKUP_DIR/full"
INCREMENTAL_BACKUP_DIR="$BACKUP_DIR/incremental"
WAL_BACKUP_DIR="$BACKUP_DIR/wal"

# 导出环境变量
export PGPASSWORD=$DB_PASSWORD

# 函数：从全量备份恢复
restore_from_full() {
    echo "开始从全量备份恢复..."
    
    # 获取最新的全量备份
    LATEST_FULL_BACKUP=$(ls -t $FULL_BACKUP_DIR/full_*.backup | head -1)
    
    if [ -z "$LATEST_FULL_BACKUP" ]; then
        echo "没有找到全量备份文件"
        exit 1
    fi
    
    echo "使用备份文件：$LATEST_FULL_BACKUP"
    
    # 停止数据库服务
    echo "停止数据库服务..."
    systemctl stop postgresql
    
    # 清理数据目录
    echo "清理数据目录..."
    rm -rf /var/lib/postgresql/13/main/*
    
    # 从备份恢复
    echo "从全量备份恢复..."
    pg_restore -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -F c $LATEST_FULL_BACKUP
    
    if [ $? -eq 0 ]; then
        echo "全量备份恢复成功"
    else
        echo "全量备份恢复失败"
        exit 1
    fi
    
    # 启动数据库服务
    echo "启动数据库服务..."
    systemctl start postgresql
    
    echo "数据库恢复完成"
}

# 函数：从增量备份恢复
restore_from_incremental() {
    echo "开始从增量备份恢复..."
    
    # 获取最新的全量备份
    LATEST_FULL_BACKUP=$(ls -t $FULL_BACKUP_DIR/full_*.backup | head -1)
    
    if [ -z "$LATEST_FULL_BACKUP" ]; then
        echo "没有找到全量备份文件"
        exit 1
    fi
    
    # 获取最新的增量备份
    LATEST_INCREMENTAL_BACKUP=$(ls -t $INCREMENTAL_BACKUP_DIR/incremental_*.backup | head -1)
    
    if [ -z "$LATEST_INCREMENTAL_BACKUP" ]; then
        echo "没有找到增量备份文件，使用全量备份恢复..."
        restore_from_full
        return
    fi
    
    echo "使用全量备份：$LATEST_FULL_BACKUP"
    echo "使用增量备份：$LATEST_INCREMENTAL_BACKUP"
    
    # 停止数据库服务
    echo "停止数据库服务..."
    systemctl stop postgresql
    
    # 清理数据目录
    echo "清理数据目录..."
    rm -rf /var/lib/postgresql/13/main/*
    
    # 从全量备份恢复
    echo "从全量备份恢复..."
    pg_restore -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -F c $LATEST_FULL_BACKUP
    
    if [ $? -ne 0 ]; then
        echo "全量备份恢复失败"
        exit 1
    fi
    
    # 从增量备份恢复
    echo "从增量备份恢复..."
    tar -xf $LATEST_INCREMENTAL_BACKUP -C /var/lib/postgresql/13/main/
    
    if [ $? -eq 0 ]; then
        echo "增量备份恢复成功"
    else
        echo "增量备份恢复失败"
        exit 1
    fi
    
    # 启动数据库服务
    echo "启动数据库服务..."
    systemctl start postgresql
    
    echo "数据库恢复完成"
}

# 函数：时间点恢复
point_in_time_restore() {
    echo "开始时间点恢复..."
    
    # 获取最新的全量备份
    LATEST_FULL_BACKUP=$(ls -t $FULL_BACKUP_DIR/full_*.backup | head -1)
    
    if [ -z "$LATEST_FULL_BACKUP" ]; then
        echo "没有找到全量备份文件"
        exit 1
    fi
    
    # 检查WAL日志目录
    if [ ! -d "$WAL_BACKUP_DIR" ] || [ -z "$(ls -A $WAL_BACKUP_DIR)" ]; then
        echo "没有找到WAL日志文件"
        exit 1
    fi
    
    echo "使用全量备份：$LATEST_FULL_BACKUP"
    echo "使用WAL日志目录：$WAL_BACKUP_DIR"
    
    # 停止数据库服务
    echo "停止数据库服务..."
    systemctl stop postgresql
    
    # 清理数据目录
    echo "清理数据目录..."
    rm -rf /var/lib/postgresql/13/main/*
    
    # 从全量备份恢复
    echo "从全量备份恢复..."
    pg_restore -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -F c $LATEST_FULL_BACKUP
    
    if [ $? -ne 0 ]; then
        echo "全量备份恢复失败"
        exit 1
    fi
    
    # 复制WAL日志
    echo "复制WAL日志..."
    cp -r $WAL_BACKUP_DIR/* /var/lib/postgresql/13/main/pg_wal/
    
    # 启动数据库服务
    echo "启动数据库服务..."
    systemctl start postgresql
    
    echo "时间点恢复完成"
}

# 函数：表级恢复
restore_table() {
    if [ -z "$2" ]; then
        echo "用法：$0 table <表名>"
        exit 1
    fi
    
    TABLE_NAME="$2"
    echo "开始表级恢复：$TABLE_NAME"
    
    # 获取最新的全量备份
    LATEST_FULL_BACKUP=$(ls -t $FULL_BACKUP_DIR/full_*.backup | head -1)
    
    if [ -z "$LATEST_FULL_BACKUP" ]; then
        echo "没有找到全量备份文件"
        exit 1
    fi
    
    echo "使用备份文件：$LATEST_FULL_BACKUP"
    
    # 从备份中恢复指定表
    echo "从备份中恢复表：$TABLE_NAME"
    pg_restore -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -F c -t $TABLE_NAME $LATEST_FULL_BACKUP
    
    if [ $? -eq 0 ]; then
        echo "表级恢复成功：$TABLE_NAME"
    else
        echo "表级恢复失败：$TABLE_NAME"
        exit 1
    fi
    
    echo "表级恢复完成"
}

# 主函数
main() {
    case "$1" in
        "full")
            restore_from_full
            ;;
        "incremental")
            restore_from_incremental
            ;;
        "point-in-time")
            point_in_time_restore
            ;;
        "table")
            restore_table "$@"
            ;;
        *)
            echo "用法：$0 {full|incremental|point-in-time|table <表名>}"
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"
