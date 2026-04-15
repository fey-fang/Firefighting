<template>
  <div class="dashboard-container">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon" style="background: #409EFF">
              <el-icon><Document /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.plans }}</div>
              <div class="stat-label">预案数量</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon" style="background: #67C23A">
              <el-icon><Monitor /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.scenarios }}</div>
              <div class="stat-label">推演作业</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon" style="background: #E6A23C">
              <el-icon><School /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.trainings }}</div>
              <div class="stat-label">训练计划</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon" style="background: #F56C6C">
              <el-icon><User /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.users }}</div>
              <div class="stat-label">用户数量</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px">
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>最近预案</span>
            </div>
          </template>
          <el-table :data="recentPlans" style="width: 100%">
            <el-table-column prop="name" label="预案名称" />
            <el-table-column prop="unitName" label="所属单位" />
            <el-table-column prop="createTime" label="创建时间" />
          </el-table>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>最近推演</span>
            </div>
          </template>
          <el-table :data="recentScenarios" style="width: 100%">
            <el-table-column prop="name" label="作业名称" />
            <el-table-column prop="type" label="类型" />
            <el-table-column prop="status" label="状态" />
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px">
      <el-col :span="24">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>快速操作</span>
            </div>
          </template>
          <div class="quick-actions">
            <el-button type="primary" size="large" @click="goToPlan">
              <el-icon><Document /></el-icon>
              创建预案
            </el-button>
            <el-button type="success" size="large" @click="goToScenario">
              <el-icon><Monitor /></el-icon>
              开始推演
            </el-button>
            <el-button type="warning" size="large" @click="goToTraining">
              <el-icon><School /></el-icon>
              训练计划
            </el-button>
            <el-button type="danger" size="large" @click="goToStatistics">
              <el-icon><DataAnalysis /></el-icon>
              统计分析
            </el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Document, Monitor, School, User, DataAnalysis } from '@element-plus/icons-vue'
import api from '../api'

const router = useRouter()

const stats = ref({
  plans: 0,
  scenarios: 0,
  trainings: 0,
  users: 0
})

const recentPlans = ref<any[]>([])
const recentScenarios = ref<any[]>([])

const fetchData = async () => {
  try {
    // 模拟数据，实际应该从API获取
    stats.value = {
      plans: 128,
      scenarios: 45,
      trainings: 89,
      users: 256
    }
    
    recentPlans.value = [
      { name: '重点单位火灾预案', unitName: '珠海XX商场', createTime: '2026-04-15' },
      { name: '化工企业泄漏预案', unitName: '珠海XX化工厂', createTime: '2026-04-14' },
      { name: '高层建筑救援预案', unitName: '珠海XX大厦', createTime: '2026-04-13' }
    ]
    
    recentScenarios.value = [
      { name: '商场火灾演练', type: '综合演练', status: '进行中' },
      { name: '化学品泄漏处置', type: '专项演练', status: '已完成' },
      { name: '地震救援演练', type: '综合演练', status: '已完成' }
    ]
  } catch (error) {
    console.error('获取数据失败', error)
  }
}

const goToPlan = () => router.push('/main/plan')
const goToScenario = () => router.push('/main/scenario')
const goToTraining = () => router.push('/main/training')
const goToStatistics = () => router.push('/main/statistics')

onMounted(() => {
  fetchData()
})
</script>

<style scoped>
.dashboard-container {
  padding: 0;
}

.stat-card {
  margin-bottom: 0;
}

.stat-content {
  display: flex;
  align-items: center;
  gap: 20px;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 28px;
}

.stat-info {
  flex: 1;
}

.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #333;
}

.stat-label {
  font-size: 14px;
  color: #999;
  margin-top: 5px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.quick-actions {
  display: flex;
  gap: 20px;
  justify-content: center;
  padding: 20px 0;
}
</style>
