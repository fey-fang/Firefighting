<template>
  <div class="statistics-view">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon training">
              <el-icon><TrendCharts /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">156</div>
              <div class="stat-label">训练计划总数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon exam">
              <el-icon><Document /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">89</div>
              <div class="stat-label">考核总数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon personnel">
              <el-icon><User /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">2,345</div>
              <div class="stat-label">参训人员</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon pass">
              <el-icon><CircleCheck /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-value">91.5%</div>
              <div class="stat-label">平均通过率</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>训练计划统计</span>
              <el-radio-group v-model="planChartType" size="small">
                <el-radio-button label="month">月度</el-radio-button>
                <el-radio-button label="quarter">季度</el-radio-button>
                <el-radio-button label="year">年度</el-radio-button>
              </el-radio-group>
            </div>
          </template>
          <div class="chart-container">
            <div class="chart-placeholder">
              <el-icon><DataLine /></el-icon>
              <p>训练计划趋势图</p>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>训练类型分布</span>
            </div>
          </template>
          <div class="chart-container">
            <div class="chart-placeholder">
              <el-icon><PieChart /></el-icon>
              <p>训练类型饼图</p>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>考核成绩统计</span>
              <el-radio-group v-model="examChartType" size="small">
                <el-radio-button label="theory">理论</el-radio-button>
                <el-radio-button label="practical">实操</el-radio-button>
                <el-radio-button label="comprehensive">综合</el-radio-button>
              </el-radio-group>
            </div>
          </template>
          <div class="chart-container">
            <div class="chart-placeholder">
              <el-icon><DataAnalysis /></el-icon>
              <p>考核成绩分布图</p>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>各单位绩点排名</span>
            </div>
          </template>
          <el-table :data="rankData" style="width: 100%">
            <el-table-column type="index" label="排名" width="80">
              <template #default="scope">
                <span v-if="scope.$index === 0" class="rank-badge gold">1</span>
                <span v-else-if="scope.$index === 1" class="rank-badge silver">2</span>
                <span v-else-if="scope.$index === 2" class="rank-badge bronze">3</span>
                <span v-else>{{ scope.$index + 1 }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="organization" label="单位名称"></el-table-column>
            <el-table-column prop="totalPoints" label="总绩点" width="120"></el-table-column>
            <el-table-column prop="avgPoints" label="人均绩点" width="120"></el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <el-row style="margin-top: 20px;">
      <el-col :span="24">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>数据报表</span>
              <div>
                <el-button type="primary" @click="exportReport">导出报表</el-button>
              </div>
            </div>
          </template>
          <el-tabs v-model="reportTab">
            <el-tab-pane label="训练报表" name="training">
              <el-table :data="trainingReportData" stripe style="width: 100%">
                <el-table-column prop="month" label="月份" width="120"></el-table-column>
                <el-table-column prop="planCount" label="计划数" width="100"></el-table-column>
                <el-table-column prop="completedCount" label="完成数" width="100"></el-table-column>
                <el-table-column prop="completionRate" label="完成率" width="120"></el-table-column>
                <el-table-column prop="participants" label="参训人数" width="120"></el-table-column>
                <el-table-column prop="trainingHours" label="训练时长(小时)" width="150"></el-table-column>
              </el-table>
            </el-tab-pane>
            <el-tab-pane label="考核报表" name="exam">
              <el-table :data="examReportData" stripe style="width: 100%">
                <el-table-column prop="month" label="月份" width="120"></el-table-column>
                <el-table-column prop="examCount" label="考核数" width="100"></el-table-column>
                <el-table-column prop="participants" label="参考人数" width="120"></el-table-column>
                <el-table-column prop="passCount" label="通过人数" width="120"></el-table-column>
                <el-table-column prop="passRate" label="通过率" width="100"></el-table-column>
                <el-table-column prop="avgScore" label="平均分数" width="120"></el-table-column>
              </el-table>
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { TrendCharts, Document, User, CircleCheck, DataLine, PieChart, DataAnalysis } from '@element-plus/icons-vue'

const planChartType = ref('month')
const examChartType = ref('theory')
const reportTab = ref('training')

const rankData = ref([
  { organization: '珠海市消防救援支队', totalPoints: 15680, avgPoints: 125 },
  { organization: '香洲区消防救援大队', totalPoints: 12450, avgPoints: 118 },
  { organization: '斗门区消防救援大队', totalPoints: 11230, avgPoints: 112 },
  { organization: '金湾区消防救援大队', totalPoints: 9870, avgPoints: 105 },
  { organization: '高新区消防救援大队', totalPoints: 8650, avgPoints: 98 }
])

const trainingReportData = ref([
  { month: '2024-01', planCount: 12, completedCount: 11, completionRate: '91.7%', participants: 450, trainingHours: 360 },
  { month: '2024-02', planCount: 15, completedCount: 14, completionRate: '93.3%', participants: 520, trainingHours: 420 },
  { month: '2024-03', planCount: 18, completedCount: 17, completionRate: '94.4%', participants: 610, trainingHours: 510 }
])

const examReportData = ref([
  { month: '2024-01', examCount: 8, participants: 320, passCount: 295, passRate: '92.2%', avgScore: 85.6 },
  { month: '2024-02', examCount: 10, participants: 380, passCount: 350, passRate: '92.1%', avgScore: 86.2 },
  { month: '2024-03', examCount: 12, participants: 450, passCount: 418, passRate: '92.9%', avgScore: 87.1 }
])

const exportReport = () => {
  ElMessage.success('报表导出成功')
}
</script>

<style scoped>
.statistics-view {
  padding: 20px;
}

.stat-card {
  margin-bottom: 20px;
}

.stat-content {
  display: flex;
  align-items: center;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 20px;
}

.stat-icon.training {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.stat-icon.exam {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.stat-icon.personnel {
  background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

.stat-icon.pass {
  background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
}

.stat-icon .el-icon {
  font-size: 30px;
  color: white;
}

.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #303133;
}

.stat-label {
  font-size: 14px;
  color: #909399;
  margin-top: 5px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.chart-container {
  height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.chart-placeholder {
  text-align: center;
  color: #909399;
}

.chart-placeholder .el-icon {
  font-size: 60px;
  margin-bottom: 10px;
}

.rank-badge {
  display: inline-block;
  width: 24px;
  height: 24px;
  line-height: 24px;
  text-align: center;
  border-radius: 50%;
  color: white;
  font-weight: bold;
}

.rank-badge.gold {
  background: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
}

.rank-badge.silver {
  background: linear-gradient(135deg, #c0c0c0 0%, #a8a8a8 100%);
}

.rank-badge.bronze {
  background: linear-gradient(135deg, #cd7f32 0%, #b87333 100%);
}
</style>
