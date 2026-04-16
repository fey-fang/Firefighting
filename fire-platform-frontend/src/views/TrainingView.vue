<template>
  <div class="training">
    <el-container>
      <el-header height="60px" class="header">
        <div class="logo">珠海消防数字化作战训练考核管理平台</div>
        <el-menu
          :default-active="activeIndex"
          class="el-menu-demo"
          mode="horizontal"
          @select="handleSelect"
        >
          <el-menu-item index="home">首页</el-menu-item>
          <el-menu-item index="plan">预案编制</el-menu-item>
          <el-menu-item index="scene">沙盘推演</el-menu-item>
          <el-menu-item index="training">训练考核</el-menu-item>
        </el-menu>
      </el-header>
      <el-main>
        <h2>数字化训练考核管理</h2>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-card shadow="hover">
              <template #header>
                <div class="card-header">
                  <el-icon><el-icon-book /></el-icon>
                  <span>培训管理</span>
                </div>
              </template>
              <el-table :data="trainingData" style="width: 100%">
                <el-table-column prop="name" label="培训名称" width="180" />
                <el-table-column prop="type" label="培训类型" width="180" />
                <el-table-column prop="startTime" label="开始时间" width="180" />
                <el-table-column prop="endTime" label="结束时间" width="180" />
                <el-table-column label="操作">
                  <template #default="scope">
                    <el-button size="small" type="primary">查看</el-button>
                    <el-button size="small" type="success">报名</el-button>
                  </template>
                </el-table-column>
              </el-table>
            </el-card>
          </el-col>
          <el-col :span="12">
            <el-card shadow="hover">
              <template #header>
                <div class="card-header">
                  <el-icon><el-icon-trophy /></el-icon>
                  <span>考核管理</span>
                </div>
              </template>
              <el-table :data="examData" style="width: 100%">
                <el-table-column prop="name" label="考核名称" width="180" />
                <el-table-column prop="type" label="考核类型" width="180" />
                <el-table-column prop="startTime" label="开始时间" width="180" />
                <el-table-column prop="endTime" label="结束时间" width="180" />
                <el-table-column label="操作">
                  <template #default="scope">
                    <el-button size="small" type="primary">查看</el-button>
                    <el-button size="small" type="success">参加</el-button>
                  </template>
                </el-table-column>
              </el-table>
            </el-card>
          </el-col>
        </el-row>
        <el-row :gutter="20" style="margin-top: 20px;">
          <el-col :span="24">
            <el-card shadow="hover">
              <template #header>
                <div class="card-header">
                  <el-icon><el-icon-data-analysis /></el-icon>
                  <span>统计分析</span>
                </div>
              </template>
              <div class="stats-container">
                <el-row :gutter="20">
                  <el-col :span="6">
                    <el-card shadow="hover" class="stat-card">
                      <div class="stat-value">120</div>
                      <div class="stat-label">总培训次数</div>
                    </el-card>
                  </el-col>
                  <el-col :span="6">
                    <el-card shadow="hover" class="stat-card">
                      <div class="stat-value">85</div>
                      <div class="stat-label">总考核次数</div>
                    </el-card>
                  </el-col>
                  <el-col :span="6">
                    <el-card shadow="hover" class="stat-card">
                      <div class="stat-value">92%</div>
                      <div class="stat-label">考核通过率</div>
                    </el-card>
                  </el-col>
                  <el-col :span="6">
                    <el-card shadow="hover" class="stat-card">
                      <div class="stat-value">88</div>
                      <div class="stat-label">平均绩点</div>
                    </el-card>
                  </el-col>
                </el-row>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </el-main>
      <el-footer height="80px" class="footer">
        <p>© 2026 珠海市消防救援支队 版权所有</p>
      </el-footer>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const activeIndex = ref('training')

const handleSelect = (key: string) => {
  activeIndex.value = key
  router.push(`/${key}`)
}

// 模拟数据
const trainingData = [
  { name: '消防安全知识培训', type: '理论培训', startTime: '2026-04-01', endTime: '2026-04-02' },
  { name: '灭火救援技能培训', type: '实操培训', startTime: '2026-04-10', endTime: '2026-04-15' },
  { name: '应急处置预案培训', type: '理论培训', startTime: '2026-04-20', endTime: '2026-04-21' }
]

const examData = [
  { name: '第一季度理论考核', type: '理论考核', startTime: '2026-04-05', endTime: '2026-04-05' },
  { name: '第一季度实操考核', type: '实操考核', startTime: '2026-04-16', endTime: '2026-04-18' },
  { name: '年度综合考核', type: '综合考核', startTime: '2026-12-20', endTime: '2026-12-25' }
]
</script>

<style scoped>
.training {
  height: 100vh;
  background-color: #f5f7fa;
}

.header {
  background-color: #1890ff;
  color: white;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

.logo {
  font-size: 20px;
  font-weight: bold;
}

.el-menu-demo {
  background-color: transparent;
  border-bottom: none;
}

.el-menu-item {
  color: white;
}

.el-menu-item.is-active {
  background-color: rgba(255, 255, 255, 0.2);
}

.el-main h2 {
  margin-bottom: 20px;
  color: #333;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 10px;
}

.stats-container {
  margin-top: 20px;
}

.stat-card {
  text-align: center;
  padding: 20px;
}

.stat-value {
  font-size: 32px;
  font-weight: bold;
  color: #1890ff;
  margin-bottom: 10px;
}

.stat-label {
  font-size: 16px;
  color: #666;
}

.footer {
  background-color: #333;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
