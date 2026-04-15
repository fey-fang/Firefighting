<template>
  <div class="training-view">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>训练考核管理</span>
          <el-button type="primary" @click="showCreateDialog">新建训练计划</el-button>
        </div>
      </template>
      
      <el-tabs v-model="activeTab">
        <el-tab-pane label="训练计划" name="plan">
          <el-table :data="trainingPlans" stripe style="width: 100%">
            <el-table-column prop="planName" label="计划名称" width="200"></el-table-column>
            <el-table-column prop="trainingType" label="训练类型" width="150"></el-table-column>
            <el-table-column prop="startTime" label="开始时间" width="180"></el-table-column>
            <el-table-column prop="endTime" label="结束时间" width="180"></el-table-column>
            <el-table-column prop="status" label="状态" width="120">
              <template #default="scope">
                <el-tag :type="getStatusType(scope.row.status)">{{ scope.row.status }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="200">
              <template #default="scope">
                <el-button size="small" @click="viewPlan(scope.row)">查看</el-button>
                <el-button size="small" type="primary" @click="editPlan(scope.row)">编辑</el-button>
                <el-button size="small" type="danger" @click="deletePlan(scope.row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>
        
        <el-tab-pane label="考核管理" name="exam">
          <el-table :data="exams" stripe style="width: 100%">
            <el-table-column prop="examName" label="考核名称" width="200"></el-table-column>
            <el-table-column prop="examType" label="考核类型" width="150"></el-table-column>
            <el-table-column prop="examTime" label="考核时间" width="180"></el-table-column>
            <el-table-column prop="participants" label="参与人数" width="120"></el-table-column>
            <el-table-column prop="passRate" label="通过率" width="120"></el-table-column>
            <el-table-column label="操作" width="200">
              <template #default="scope">
                <el-button size="small" @click="viewExam(scope.row)">查看</el-button>
                <el-button size="small" type="primary" @click="startExam(scope.row)">开始考核</el-button>
                <el-button size="small" type="success" @click="viewResults(scope.row)">查看结果</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>
        
        <el-tab-pane label="绩点管理" name="performance">
          <el-table :data="performancePoints" stripe style="width: 100%">
            <el-table-column prop="personnelName" label="人员姓名" width="150"></el-table-column>
            <el-table-column prop="organization" label="所属单位" width="200"></el-table-column>
            <el-table-column prop="totalPoints" label="总绩点" width="120"></el-table-column>
            <el-table-column prop="trainingPoints" label="训练绩点" width="120"></el-table-column>
            <el-table-column prop="examPoints" label="考核绩点" width="120"></el-table-column>
            <el-table-column prop="rank" label="排名" width="100"></el-table-column>
            <el-table-column label="操作" width="150">
              <template #default="scope">
                <el-button size="small" @click="viewDetail(scope.row)">详情</el-button>
                <el-button size="small" type="primary" @click="adjustPoints(scope.row)">调整</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>
      </el-tabs>
    </el-card>
    
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px">
      <el-form :model="form" label-width="100px">
        <el-form-item label="计划名称">
          <el-input v-model="form.planName" placeholder="请输入计划名称"></el-input>
        </el-form-item>
        <el-form-item label="训练类型">
          <el-select v-model="form.trainingType" placeholder="请选择训练类型" style="width: 100%">
            <el-option label="日常训练" value="daily"></el-option>
            <el-option label="专项训练" value="special"></el-option>
            <el-option label="联合演练" value="joint"></el-option>
            <el-option label="应急演练" value="emergency"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="开始时间">
          <el-date-picker
            v-model="form.startTime"
            type="datetime"
            placeholder="选择开始时间"
            style="width: 100%">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="结束时间">
          <el-date-picker
            v-model="form.endTime"
            type="datetime"
            placeholder="选择结束时间"
            style="width: 100%">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="训练内容">
          <el-input type="textarea" v-model="form.content" placeholder="请输入训练内容"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="savePlan">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'

const activeTab = ref('plan')
const dialogVisible = ref(false)
const dialogTitle = ref('新建训练计划')

const trainingPlans = ref([
  { id: 1, planName: '2024年第一季度日常训练', trainingType: '日常训练', startTime: '2024-01-01 08:00:00', endTime: '2024-03-31 18:00:00', status: '进行中' },
  { id: 2, planName: '高层建筑灭火救援专项训练', trainingType: '专项训练', startTime: '2024-02-15 09:00:00', endTime: '2024-02-20 17:00:00', status: '已完成' },
  { id: 3, planName: '危化品泄漏应急演练', trainingType: '应急演练', startTime: '2024-03-10 08:30:00', endTime: '2024-03-10 12:00:00', status: '待开始' }
])

const exams = ref([
  { id: 1, examName: '消防基础知识考核', examType: '理论考核', examTime: '2024-01-20 09:00:00', participants: 150, passRate: '92%' },
  { id: 2, examName: '灭火技能实操考核', examType: '实操考核', examTime: '2024-02-25 08:00:00', participants: 120, passRate: '88%' },
  { id: 3, examName: '应急指挥能力考核', examType: '综合考核', examTime: '2024-03-15 10:00:00', participants: 50, passRate: '90%' }
])

const performancePoints = ref([
  { id: 1, personnelName: '张三', organization: '珠海市消防救援支队', totalPoints: 1250, trainingPoints: 800, examPoints: 450, rank: 1 },
  { id: 2, personnelName: '李四', organization: '香洲区消防救援大队', totalPoints: 1180, trainingPoints: 750, examPoints: 430, rank: 2 },
  { id: 3, personnelName: '王五', organization: '斗门区消防救援大队', totalPoints: 1120, trainingPoints: 720, examPoints: 400, rank: 3 }
])

const form = reactive({
  planName: '',
  trainingType: '',
  startTime: '',
  endTime: '',
  content: ''
})

const getStatusType = (status: string) => {
  if (status === '进行中') return 'success'
  if (status === '已完成') return 'info'
  if (status === '待开始') return 'warning'
  return ''
}

const showCreateDialog = () => {
  dialogTitle.value = '新建训练计划'
  Object.assign(form, {
    planName: '',
    trainingType: '',
    startTime: '',
    endTime: '',
    content: ''
  })
  dialogVisible.value = true
}

const savePlan = () => {
  ElMessage.success('保存成功')
  dialogVisible.value = false
}

const viewPlan = (row: any) => {
  ElMessage.info('查看训练计划：' + row.planName)
}

const editPlan = (row: any) => {
  dialogTitle.value = '编辑训练计划'
  Object.assign(form, row)
  dialogVisible.value = true
}

const deletePlan = (row: any) => {
  ElMessageBox.confirm('确定要删除该训练计划吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    ElMessage.success('删除成功')
  }).catch(() => {})
}

const viewExam = (row: any) => {
  ElMessage.info('查看考核：' + row.examName)
}

const startExam = (row: any) => {
  ElMessage.info('开始考核：' + row.examName)
}

const viewResults = (row: any) => {
  ElMessage.info('查看考核结果：' + row.examName)
}

const viewDetail = (row: any) => {
  ElMessage.info('查看绩点详情：' + row.personnelName)
}

const adjustPoints = (row: any) => {
  ElMessage.info('调整绩点：' + row.personnelName)
}
</script>

<style scoped>
.training-view {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
