#!/bin/bash

# 数据库备份脚本
# 执行频率：每天凌晨2点全量备份，每小时增量备份

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

# 创建备份目录
mkdir -p $FULL_BACKUP_DIR
mkdir -p $INCREMENTAL_BACKUP_DIR
mkdir -p $WAL_BACKUP_DIR

# 导出环境变量
export PGPASSWORD=$DB_PASSWORD

# 函数：执行全量备份
full_backup() {
    echo "开始执行全量备份..."
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="$FULL_BACKUP_DIR/full_${TIMESTAMP}.backup"
    
    pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -F c -f $BACKUP_FILE
    
    if [ $? -eq 0 ]; then
        echo "全量备份成功：$BACKUP_FILE"
        # 删除7天前的全量备份
        find $FULL_BACKUP_DIR -name "full_*.backup" -mtime +7 -delete
    else
        echo "全量备份失败"
    fi
}

# 函数：执行增量备份
incremental_backup() {
    echo "开始执行增量备份..."
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="$INCREMENTAL_BACKUP_DIR/incremental_${TIMESTAMP}.backup"
    
    # 获取最新的全量备份
    LATEST_FULL_BACKUP=$(ls -t $FULL_BACKUP_DIR/full_*.backup | head -1)
    
    if [ -z "$LATEST_FULL_BACKUP" ]; then
        echo "没有找到全量备份，执行全量备份..."
        full_backup
        return
    fi
    
    pg_basebackup -h $DB_HOST -p $DB_PORT -U $DB_USER -D $BACKUP_FILE -F t -x
    
    if [ $? -eq 0 ]; then
        echo "增量备份成功：$BACKUP_FILE"
        # 删除24小时前的增量备份
        find $INCREMENTAL_BACKUP_DIR -name "incremental_*.backup" -mtime +1 -delete
    else
        echo "增量备份失败"
    fi
}

# 函数：备份WAL日志
backup_wal() {
    echo "开始备份WAL日志..."
    
    # 确保WAL日志目录存在
    mkdir -p $WAL_BACKUP_DIR
    
    # 使用pg_receivewal备份WAL日志
    pg_receivewal -h $DB_HOST -p $DB_PORT -U $DB_USER -D $WAL_BACKUP_DIR -w
    
    if [ $? -eq 0 ]; then
        echo "WAL日志备份成功"
    else
        echo "WAL日志备份失败"
    fi
}

# 函数：验证备份
verify_backup() {
    echo "开始验证备份..."
    
    # 获取最新的全量备份
    LATEST_FULL_BACKUP=$(ls -t $FULL_BACKUP_DIR/full_*.backup | head -1)
    
    if [ -z "$LATEST_FULL_BACKUP" ]; then
        echo "没有找到全量备份，无法验证"
        return
    fi
    
    # 验证备份文件
    pg_restore -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME --list $LATEST_FULL_BACKUP
    
    if [ $? -eq 0 ]; then
        echo "备份验证成功"
    else
        echo "备份验证失败"
    fi
}

# 主函数
main() {
    case "$1" in
        "full")
            full_backup
            ;;
        "incremental")
            incremental_backup
            ;;
        "wal")
            backup_wal
            ;;
        "verify")
            verify_backup
            ;;
        *)
            echo "用法：$0 {full|incremental|wal|verify}"
            exit 1
            ;;
    esac
}

# 执行主函数
main "$1"
