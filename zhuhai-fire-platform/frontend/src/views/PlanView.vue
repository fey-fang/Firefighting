<template>
  <div class="plan-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>预案管理</span>
          <el-button type="primary" @click="showAddDialog">
            <el-icon><Plus /></el-icon>
            新增预案
          </el-button>
        </div>
      </template>
      
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="预案名称">
          <el-input v-model="searchForm.name" placeholder="请输入预案名称" />
        </el-form-item>
        <el-form-item label="单位">
          <el-select v-model="searchForm.unitId" placeholder="请选择单位" clearable>
            <el-option label="珠海XX商场" :value="1" />
            <el-option label="珠海XX化工厂" :value="2" />
            <el-option label="珠海XX大厦" :value="3" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="search">搜索</el-button>
          <el-button @click="reset">重置</el-button>
        </el-form-item>
      </el-form>

      <el-table :data="planList" style="width: 100%" border>
        <el-table-column prop="name" label="预案名称" />
        <el-table-column prop="unitName" label="所属单位" />
        <el-table-column prop="type" label="类型">
          <template #default="{ row }">
            <el-tag :type="row.type === 1 ? 'primary' : 'success'">
              {{ row.type === 1 ? '火灾预案' : '其他灾害' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" />
        <el-table-column label="操作" width="250">
          <template #default="{ row }">
            <el-button size="small" @click="viewPlan(row)">查看</el-button>
            <el-button size="small" type="primary" @click="editPlan(row)">编辑</el-button>
            <el-button size="small" type="danger" @click="deletePlan(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[10, 20, 50, 100]"
        :total="total"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        style="margin-top: 20px; justify-content: flex-end"
      />
    </el-card>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px">
      <el-form :model="planForm" :rules="planRules" ref="planFormRef" label-width="100px">
        <el-form-item label="预案名称" prop="name">
          <el-input v-model="planForm.name" placeholder="请输入预案名称" />
        </el-form-item>
        <el-form-item label="所属单位" prop="unitId">
          <el-select v-model="planForm.unitId" placeholder="请选择单位" style="width: 100%">
            <el-option label="珠海XX商场" :value="1" />
            <el-option label="珠海XX化工厂" :value="2" />
            <el-option label="珠海XX大厦" :value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="预案类型" prop="type">
          <el-select v-model="planForm.type" placeholder="请选择类型" style="width: 100%">
            <el-option label="火灾预案" :value="1" />
            <el-option label="其他灾害" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="预案内容" prop="content">
          <el-input
            v-model="planForm.content"
            type="textarea"
            :rows="5"
            placeholder="请输入预案内容"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitPlan">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'

const dialogVisible = ref(false)
const dialogTitle = ref('新增预案')
const planFormRef = ref()
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const planList = ref<any[]>([])

const searchForm = reactive({
  name: '',
  unitId: null
})

const planForm = reactive({
  id: null,
  name: '',
  unitId: null,
  type: 1,
  content: ''
})

const planRules = {
  name: [{ required: true, message: '请输入预案名称', trigger: 'blur' }],
  unitId: [{ required: true, message: '请选择所属单位', trigger: 'change' }],
  type: [{ required: true, message: '请选择预案类型', trigger: 'change' }]
}

const fetchData = async () => {
  try {
    // 模拟数据
    planList.value = [
      {
        id: 1,
        name: '重点单位火灾预案',
        unitName: '珠海XX商场',
        type: 1,
        createTime: '2026-04-15',
        content: '这是火灾预案的详细内容...'
      },
      {
        id: 2,
        name: '化工企业泄漏预案',
        unitName: '珠海XX化工厂',
        type: 2,
        createTime: '2026-04-14',
        content: '这是泄漏预案的详细内容...'
      },
      {
        id: 3,
        name: '高层建筑救援预案',
        unitName: '珠海XX大厦',
        type: 1,
        createTime: '2026-04-13',
        content: '这是救援预案的详细内容...'
      }
    ]
    total.value = planList.value.length
  } catch (error) {
    console.error('获取数据失败', error)
  }
}

const search = () => {
  fetchData()
}

const reset = () => {
  searchForm.name = ''
  searchForm.unitId = null
  fetchData()
}

const showAddDialog = () => {
  dialogTitle.value = '新增预案'
  Object.assign(planForm, {
    id: null,
    name: '',
    unitId: null,
    type: 1,
    content: ''
  })
  dialogVisible.value = true
}

const editPlan = (row: any) => {
  dialogTitle.value = '编辑预案'
  Object.assign(planForm, row)
  dialogVisible.value = true
}

const viewPlan = (row: any) => {
  ElMessage.info(`查看预案：${row.name}`)
}

const deletePlan = async (_row: any) => {
  try {
    await ElMessageBox.confirm('确定要删除该预案吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    ElMessage.success('删除成功')
    fetchData()
  } catch (error) {
    // 用户取消
  }
}

const submitPlan = async () => {
  await planFormRef.value.validate()
  ElMessage.success(dialogTitle.value === '新增预案' ? '新增成功' : '编辑成功')
  dialogVisible.value = false
  fetchData()
}

const handleSizeChange = (val: number) => {
  pageSize.value = val
  fetchData()
}

const handleCurrentChange = (val: number) => {
  currentPage.value = val
  fetchData()
}

onMounted(() => {
  fetchData()
})
</script>

<style scoped>
.plan-container {
  padding: 0;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.search-form {
  margin-bottom: 20px;
}
</style>
