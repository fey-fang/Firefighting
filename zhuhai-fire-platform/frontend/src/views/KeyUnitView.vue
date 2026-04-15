<template>
  <div class="key-unit-view">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>重点单位管理</span>
          <div class="header-actions">
            <el-select v-model="districtFilter" placeholder="选择区域" style="width: 150px; margin-right: 10px;" clearable>
              <el-option label="全部区域" value=""></el-option>
              <el-option label="香洲区" value="香洲区"></el-option>
              <el-option label="斗门区" value="斗门区"></el-option>
              <el-option label="金湾区" value="金湾区"></el-option>
              <el-option label="高新区" value="高新区"></el-option>
            </el-select>
            <el-input
              v-model="searchQuery"
              placeholder="搜索单位"
              style="width: 200px; margin-right: 10px;"
              clearable
            >
              <template #prefix>
                <el-icon><Search /></el-icon>
              </template>
            </el-input>
            <el-button type="primary" @click="showCreateDialog">新增单位</el-button>
          </div>
        </div>
      </template>
      
      <el-table :data="filteredUnits" stripe style="width: 100%">
        <el-table-column prop="unitName" label="单位名称" width="200"></el-table-column>
        <el-table-column prop="unitType" label="单位类型" width="120"></el-table-column>
        <el-table-column prop="district" label="所属区域" width="120"></el-table-column>
        <el-table-column prop="address" label="地址" width="250"></el-table-column>
        <el-table-column prop="contactPerson" label="联系人" width="100"></el-table-column>
        <el-table-column prop="contactPhone" label="联系电话" width="130"></el-table-column>
        <el-table-column prop="riskLevel" label="风险等级" width="100">
          <template #default="scope">
            <el-tag :type="getRiskLevelType(scope.row.riskLevel)">
              {{ scope.row.riskLevel }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template #default="scope">
            <el-button size="small" @click="viewUnit(scope.row)">查看</el-button>
            <el-button size="small" type="primary" @click="editUnit(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="deleteUnit(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="700px">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="100px">
        <el-form-item label="单位名称" prop="unitName">
          <el-input v-model="form.unitName" placeholder="请输入单位名称"></el-input>
        </el-form-item>
        <el-form-item label="单位类型" prop="unitType">
          <el-select v-model="form.unitType" placeholder="请选择单位类型" style="width: 100%">
            <el-option label="石油化工" value="石油化工"></el-option>
            <el-option label="易燃易爆" value="易燃易爆"></el-option>
            <el-option label="人员密集" value="人员密集"></el-option>
            <el-option label="高层建筑" value="高层建筑"></el-option>
            <el-option label="地下建筑" value="地下建筑"></el-option>
            <el-option label="其他" value="其他"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="所属区域" prop="district">
          <el-select v-model="form.district" placeholder="请选择所属区域" style="width: 100%">
            <el-option label="香洲区" value="香洲区"></el-option>
            <el-option label="斗门区" value="斗门区"></el-option>
            <el-option label="金湾区" value="金湾区"></el-option>
            <el-option label="高新区" value="高新区"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入详细地址"></el-input>
        </el-form-item>
        <el-form-item label="联系人" prop="contactPerson">
          <el-input v-model="form.contactPerson" placeholder="请输入联系人"></el-input>
        </el-form-item>
        <el-form-item label="联系电话" prop="contactPhone">
          <el-input v-model="form.contactPhone" placeholder="请输入联系电话"></el-input>
        </el-form-item>
        <el-form-item label="风险等级" prop="riskLevel">
          <el-radio-group v-model="form.riskLevel">
            <el-radio label="重大">重大</el-radio>
            <el-radio label="较大">较大</el-radio>
            <el-radio label="一般">一般</el-radio>
            <el-radio label="低">低</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="建筑面积(㎡)" prop="buildingArea">
          <el-input-number v-model="form.buildingArea" :min="0" style="width: 100%"></el-input-number>
        </el-form-item>
        <el-form-item label="单位概况" prop="description">
          <el-input type="textarea" v-model="form.description" :rows="4" placeholder="请输入单位概况"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="submitForm">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, reactive } from 'vue'
import { ElMessage, ElMessageBox, type FormInstance, type FormRules } from 'element-plus'
import { Search } from '@element-plus/icons-vue'

const searchQuery = ref('')
const districtFilter = ref('')
const dialogVisible = ref(false)
const dialogTitle = ref('新增重点单位')
const formRef = ref<FormInstance>()

const keyUnits = ref([
  { 
    id: 1, 
    unitName: '珠海石化有限公司', 
    unitType: '石油化工', 
    district: '香洲区', 
    address: '珠海市香洲区化工园区1号', 
    contactPerson: '张经理', 
    contactPhone: '13900139001', 
    riskLevel: '重大',
    buildingArea: 50000,
    description: '大型石油化工企业，主要生产成品油'
  },
  { 
    id: 2, 
    unitName: '珠海茂业百货', 
    unitType: '人员密集', 
    district: '香洲区', 
    address: '珠海市香洲区紫荆路301号', 
    contactPerson: '李经理', 
    contactPhone: '13900139002', 
    riskLevel: '较大',
    buildingArea: 80000,
    description: '大型商业综合体，人流量大'
  },
  { 
    id: 3, 
    unitName: '珠海国际会展中心', 
    unitType: '人员密集', 
    district: '香洲区', 
    address: '珠海市香洲区湾仔南湾大道', 
    contactPerson: '王经理', 
    contactPhone: '13900139003', 
    riskLevel: '较大',
    buildingArea: 100000,
    description: '大型会展中心，经常举办大型活动'
  },
  { 
    id: 4, 
    unitName: '斗门加油站', 
    unitType: '易燃易爆', 
    district: '斗门区', 
    address: '珠海市斗门区斗门大道100号', 
    contactPerson: '赵经理', 
    contactPhone: '13900139004', 
    riskLevel: '重大',
    buildingArea: 2000,
    description: '加油站，储存有大量汽油柴油'
  }
])

const filteredUnits = computed(() => {
  let result = keyUnits.value
  
  if (districtFilter.value) {
    result = result.filter(unit => unit.district === districtFilter.value)
  }
  
  if (searchQuery.value) {
    result = result.filter(unit => 
      unit.unitName.includes(searchQuery.value) || 
      unit.address.includes(searchQuery.value) ||
      unit.contactPerson.includes(searchQuery.value)
    )
  }
  
  return result
})

const form = reactive({
  unitName: '',
  unitType: '',
  district: '',
  address: '',
  contactPerson: '',
  contactPhone: '',
  riskLevel: '一般',
  buildingArea: 0,
  description: ''
})

const rules: FormRules = {
  unitName: [{ required: true, message: '请输入单位名称', trigger: 'blur' }],
  unitType: [{ required: true, message: '请选择单位类型', trigger: 'change' }],
  district: [{ required: true, message: '请选择所属区域', trigger: 'change' }],
  address: [{ required: true, message: '请输入地址', trigger: 'blur' }],
  contactPerson: [{ required: true, message: '请输入联系人', trigger: 'blur' }],
  contactPhone: [{ required: true, message: '请输入联系电话', trigger: 'blur' }],
  riskLevel: [{ required: true, message: '请选择风险等级', trigger: 'change' }]
}

const getRiskLevelType = (level: string) => {
  if (level === '重大') return 'danger'
  if (level === '较大') return 'warning'
  if (level === '一般') return 'info'
  return 'success'
}

const showCreateDialog = () => {
  dialogTitle.value = '新增重点单位'
  Object.assign(form, {
    unitName: '',
    unitType: '',
    district: '',
    address: '',
    contactPerson: '',
    contactPhone: '',
    riskLevel: '一般',
    buildingArea: 0,
    description: ''
  })
  dialogVisible.value = true
}

const submitForm = async () => {
  if (!formRef.value) return
  await formRef.value.validate((valid) => {
    if (valid) {
      ElMessage.success(dialogTitle.value === '新增重点单位' ? '单位创建成功' : '单位更新成功')
      dialogVisible.value = false
    }
  })
}

const viewUnit = (row: any) => {
  ElMessage.info('查看单位：' + row.unitName)
}

const editUnit = (row: any) => {
  dialogTitle.value = '编辑重点单位'
  Object.assign(form, row)
  dialogVisible.value = true
}

const deleteUnit = (row: any) => {
  ElMessageBox.confirm('确定要删除该重点单位吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    ElMessage.success('删除成功')
  }).catch(() => {})
}
</script>

<style scoped>
.key-unit-view {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-actions {
  display: flex;
  align-items: center;
}
</style>
