<template>
  <div class="scenario-container">
    <el-row :gutter="20">
      <el-col :span="18">
        <el-card class="map-card">
          <template #header>
            <div class="card-header">
              <span>沙盘推演</span>
              <div class="header-actions">
                <el-button type="primary" @click="startScenario">
                  <el-icon><VideoPlay /></el-icon>
                  开始推演
                </el-button>
                <el-button @click="pauseScenario" v-if="isPlaying">
                  <el-icon><VideoPause /></el-icon>
                  暂停
                </el-button>
                <el-button type="danger" @click="stopScenario" v-if="isPlaying">
                  <el-icon><Close /></el-icon>
                  停止
                </el-button>
              </div>
            </div>
          </template>
          <div class="map-container">
            <div class="map-placeholder">
              <el-icon><Location /></el-icon>
              <p>三维地图区域</p>
              <p>使用Cesium.js展示三维场景</p>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="control-panel">
          <template #header>
            <span>控制面板</span>
          </template>
          
          <div class="control-section">
            <h4>场景选择</h4>
            <el-select v-model="selectedScenario" placeholder="请选择场景" style="width: 100%">
              <el-option label="商场火灾演练" :value="1" />
              <el-option label="化工泄漏演练" :value="2" />
              <el-option label="地震救援演练" :value="3" />
            </el-select>
          </div>

          <div class="control-section">
            <h4>灾情设置</h4>
            <el-radio-group v-model="disasterType">
              <el-radio :label="1">火灾</el-radio>
              <el-radio :label="2">泄漏</el-radio>
              <el-radio :label="3">地震</el-radio>
            </el-radio-group>
          </div>

          <div class="control-section">
            <h4>力量部署</h4>
            <el-checkbox-group v-model="selectedVehicles">
              <el-checkbox label="消防车" value="fire_truck" />
              <el-checkbox label="云梯车" value="ladder_truck" />
              <el-checkbox label="水罐车" value="water_truck" />
            </el-checkbox-group>
          </div>

          <div class="control-section">
            <h4>时间控制</h4>
            <el-slider v-model="timeSpeed" :min="1" :max="10" />
            <p>时间倍率: {{ timeSpeed }}x</p>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px">
      <el-col :span="24">
        <el-card>
          <template #header>
            <span>推演记录</span>
          </template>
          <el-table :data="scenarioLogs" style="width: 100%">
            <el-table-column prop="time" label="时间" width="180" />
            <el-table-column prop="type" label="类型" width="120">
              <template #default="{ row }">
                <el-tag :type="row.type === 'action' ? 'primary' : 'info'">
                  {{ row.type === 'action' ? '操作' : '事件' }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="content" label="内容" />
          </el-table>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { VideoPlay, VideoPause, Close, Location } from '@element-plus/icons-vue'

const isPlaying = ref(false)
const selectedScenario = ref(null)
const disasterType = ref(1)
const selectedVehicles = ref<string[]>([])
const timeSpeed = ref(5)
const scenarioLogs = ref<any[]>([])

const startScenario = () => {
  if (!selectedScenario.value) {
    ElMessage.warning('请选择场景')
    return
  }
  isPlaying.value = true
  addLog('action', '推演开始')
  ElMessage.success('推演开始')
}

const pauseScenario = () => {
  isPlaying.value = false
  addLog('event', '推演暂停')
  ElMessage.info('推演暂停')
}

const stopScenario = () => {
  isPlaying.value = false
  addLog('event', '推演停止')
  ElMessage.warning('推演停止')
}

const addLog = (type: string, content: string) => {
  const now = new Date()
  scenarioLogs.value.unshift({
    time: now.toLocaleTimeString('zh-CN'),
    type,
    content
  })
  if (scenarioLogs.value.length > 50) {
    scenarioLogs.value.pop()
  }
}
</script>

<style scoped>
.scenario-container {
  padding: 0;
}

.map-card {
  height: 500px;
}

.map-container {
  height: 400px;
  background: #f0f2f5;
  display: flex;
  align-items: center;
  justify-content: center;
}

.map-placeholder {
  text-align: center;
  color: #999;
}

.map-placeholder .el-icon {
  font-size: 64px;
  margin-bottom: 10px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-actions {
  display: flex;
  gap: 10px;
}

.control-panel {
  height: 500px;
}

.control-section {
  margin-bottom: 20px;
}

.control-section h4 {
  margin: 0 0 10px 0;
  font-size: 14px;
  color: #333;
}
</style>
