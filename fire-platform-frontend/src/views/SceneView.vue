<template>
  <div class="scene">
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
        <h2>三维数字化沙盘推演考评管理</h2>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-card shadow="hover">
              <template #header>
                <div class="card-header">
                  <el-icon><el-icon-document /></el-icon>
                  <span>想定作业管理</span>
                </div>
              </template>
              <el-table :data="scenarioData" style="width: 100%">
                <el-table-column prop="name" label="想定名称" width="180" />
                <el-table-column prop="type" label="想定类型" width="180" />
                <el-table-column prop="createTime" label="创建时间" width="180" />
                <el-table-column prop="status" label="状态" width="180" />
                <el-table-column label="操作">
                  <template #default="scope">
                    <el-button size="small" type="primary">编辑</el-button>
                    <el-button size="small" type="success">执行</el-button>
                    <el-button size="small" type="danger">删除</el-button>
                  </template>
                </el-table-column>
              </el-table>
            </el-card>
          </el-col>
          <el-col :span="12">
            <el-card shadow="hover">
              <template #header>
                <div class="card-header">
                  <el-icon><el-icon-medal /></el-icon>
                  <span>考评管理</span>
                </div>
              </template>
              <el-table :data="assessmentData" style="width: 100%">
                <el-table-column prop="name" label="考核名称" width="180" />
                <el-table-column prop="startTime" label="开始时间" width="180" />
                <el-table-column prop="endTime" label="结束时间" width="180" />
                <el-table-column prop="status" label="状态" width="180" />
                <el-table-column label="操作">
                  <template #default="scope">
                    <el-button size="small" type="primary">查看</el-button>
                    <el-button size="small" type="success">评分</el-button>
                    <el-button size="small" type="danger">删除</el-button>
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
                  <el-icon><el-icon-map /></el-icon>
                  <span>三维场景</span>
                </div>
              </template>
              <div id="cesiumContainer" class="cesium-container"></div>
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
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const activeIndex = ref('scene')

const handleSelect = (key: string) => {
  activeIndex.value = key
  router.push(`/${key}`)
}

// 模拟数据
const scenarioData = [
  { name: '高层火灾想定', type: '火灾', createTime: '2026-04-10', status: '已发布' },
  { name: '化工爆炸想定', type: '爆炸', createTime: '2026-04-08', status: '已发布' },
  { name: '地下建筑火灾想定', type: '火灾', createTime: '2026-04-05', status: '草稿' },
  { name: '大型商场火灾想定', type: '火灾', createTime: '2026-04-01', status: '已发布' }
]

const assessmentData = [
  { name: '第一季度考核', startTime: '2026-04-01', endTime: '2026-04-05', status: '已完成' },
  { name: '第二季度考核', startTime: '2026-07-01', endTime: '2026-07-05', status: '未开始' },
  { name: '年度考核', startTime: '2026-12-01', endTime: '2026-12-10', status: '未开始' }
]

// 初始化Cesium
onMounted(() => {
  // 这里将在后续集成Cesium.js时实现
  console.log('Cesium container initialized')
})
</script>

<style scoped>
.scene {
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

.cesium-container {
  width: 100%;
  height: 500px;
  background-color: #e6f7ff;
  display: flex;
  align-items: center;
  justify-content: center;
}

.footer {
  background-color: #333;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
