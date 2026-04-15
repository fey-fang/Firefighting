<template>
  <div class="user-management-view">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>用户管理</span>
          <div class="header-actions">
            <el-input
              v-model="searchQuery"
              placeholder="搜索用户"
              style="width: 200px; margin-right: 10px;"
              clearable
            >
              <template #prefix>
                <el-icon><Search /></el-icon>
              </template>
            </el-input>
            <el-button type="primary" @click="showCreateDialog">新增用户</el-button>
          </div>
        </div>
      </template>
      
      <el-table :data="filteredUsers" stripe style="width: 100%">
        <el-table-column prop="username" label="用户名" width="150"></el-table-column>
        <el-table-column prop="name" label="姓名" width="120"></el-table-column>
        <el-table-column prop="organization" label="所属单位" width="200"></el-table-column>
        <el-table-column prop="roles" label="角色" width="180">
          <template #default="scope">
            <el-tag v-for="role in scope.row.roles" :key="role" size="small" style="margin-right: 5px;">
              {{ role }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="phone" label="联系电话" width="150"></el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="scope">
            <el-tag :type="scope.row.status === '启用' ? 'success' : 'danger'">
              {{ scope.row.status }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template #default="scope">
            <el-button size="small" @click="viewUser(scope.row)">查看</el-button>
            <el-button size="small" type="primary" @click="editUser(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="deleteUser(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="100px">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name" placeholder="请输入姓名"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password" v-if="dialogTitle === '新增用户'">
          <el-input v-model="form.password" type="password" placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item label="所属单位" prop="organization">
          <el-select v-model="form.organization" placeholder="请选择所属单位" style="width: 100%">
            <el-option label="珠海市消防救援支队" value="珠海市消防救援支队"></el-option>
            <el-option label="香洲区消防救援大队" value="香洲区消防救援大队"></el-option>
            <el-option label="斗门区消防救援大队" value="斗门区消防救援大队"></el-option>
            <el-option label="金湾区消防救援大队" value="金湾区消防救援大队"></el-option>
            <el-option label="高新区消防救援大队" value="高新区消防救援大队"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="角色" prop="roles">
          <el-select v-model="form.roles" multiple placeholder="请选择角色" style="width: 100%">
            <el-option label="系统管理员" value="系统管理员"></el-option>
            <el-option label="支队长" value="支队长"></el-option>
            <el-option label="大队长" value="大队长"></el-option>
            <el-option label="中队长" value="中队长"></el-option>
            <el-option label="战斗员" value="战斗员"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="联系电话" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入联系电话"></el-input>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="启用">启用</el-radio>
            <el-radio label="禁用">禁用</el-radio>
          </el-radio-group>
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
const dialogVisible = ref(false)
const dialogTitle = ref('新增用户')
const formRef = ref<FormInstance>()

const users = ref([
  { id: 1, username: 'admin', name: '管理员', organization: '珠海市消防救援支队', roles: ['系统管理员'], phone: '13800138000', status: '启用' },
  { id: 2, username: 'zhangsan', name: '张三', organization: '香洲区消防救援大队', roles: ['大队长'], phone: '13800138001', status: '启用' },
  { id: 3, username: 'lisi', name: '李四', organization: '斗门区消防救援大队', roles: ['中队长', '战斗员'], phone: '13800138002', status: '启用' },
  { id: 4, username: 'wangwu', name: '王五', organization: '金湾区消防救援大队', roles: ['战斗员'], phone: '13800138003', status: '禁用' }
])

const filteredUsers = computed(() => {
  if (!searchQuery.value) return users.value
  return users.value.filter(user => 
    user.username.includes(searchQuery.value) || 
    user.name.includes(searchQuery.value) ||
    user.organization.includes(searchQuery.value)
  )
})

const form = reactive({
  username: '',
  name: '',
  password: '',
  organization: '',
  roles: [] as string[],
  phone: '',
  status: '启用'
})

const rules: FormRules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  name: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
  organization: [{ required: true, message: '请选择所属单位', trigger: 'change' }],
  roles: [{ required: true, message: '请选择角色', trigger: 'change' }],
  phone: [{ required: true, message: '请输入联系电话', trigger: 'blur' }]
}

const showCreateDialog = () => {
  dialogTitle.value = '新增用户'
  Object.assign(form, {
    username: '',
    name: '',
    password: '',
    organization: '',
    roles: [],
    phone: '',
    status: '启用'
  })
  dialogVisible.value = true
}

const submitForm = async () => {
  if (!formRef.value) return
  await formRef.value.validate((valid) => {
    if (valid) {
      ElMessage.success(dialogTitle.value === '新增用户' ? '用户创建成功' : '用户更新成功')
      dialogVisible.value = false
    }
  })
}

const viewUser = (row: any) => {
  ElMessage.info('查看用户：' + row.name)
}

const editUser = (row: any) => {
  dialogTitle.value = '编辑用户'
  Object.assign(form, row)
  dialogVisible.value = true
}

const deleteUser = (row: any) => {
  ElMessageBox.confirm('确定要删除该用户吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    ElMessage.success('删除成功')
  }).catch(() => {})
}
</script>

<style scoped>
.user-management-view {
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
