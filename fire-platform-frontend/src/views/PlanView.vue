<template>
  <div class="plan">
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
        <h2>三维数字化预案编制管理</h2>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-card shadow="hover">
              <template #header>
                <div class="card-header">
                  <el-icon><el-icon-folder /></el-icon>
                  <span>消防机构管理</span>
                </div>
              </template>
              <el-table :data="orgData" style="width: 100%">
                <el-table-column prop="name" label="机构名称" width="180" />
                <el-table-column prop="code" label="机构代码" width="180" />
                <el-table-column prop="level" label="机构级别" width="180" />
                <el-table-column prop="address" label="地址" />
                <el-table-column label="操作">
                  <template #default="scope">
                    <el-button size="small" type="primary">编辑</el-button>
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
                  <el-icon><el-icon-office-building /></el-icon>
                  <span>重点单位管理</span>
                </div>
              </template>
              <el-table :data="unitData" style="width: 100%">
                <el-table-column prop="name" label="单位名称" width="180" />
                <el-table-column prop="code" label="单位代码" width="180" />
                <el-table-column prop="type" label="单位类型" width="180" />
                <el-table-column prop="level" label="单位级别" width="180" />
                <el-table-column label="操作">
                  <template #default="scope">
                    <el-button size="small" type="primary">编辑</el-button>
                    <el-button size="small" type="success">查看预案</el-button>
                    <el-button size="small" type="danger">删除</el-button>
                  </template>
                </el-table-column>
              </el-table>
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
const activeIndex = ref('plan')

const handleSelect = (key: string) => {
  activeIndex.value = key
  router.push(`/${key}`)
}

// 模拟数据
const orgData = [
  { name: '珠海市消防救援支队', code: '440400', level: '支队', address: '珠海市香洲区梅华东路301号' },
  { name: '香洲区消防救援大队', code: '440401', level: '大队', address: '珠海市香洲区香洲路123号' },
  { name: '金湾区消防救援大队', code: '440402', level: '大队', address: '珠海市金湾区金湾路456号' },
  { name: '斗门区消防救援大队', code: '440403', level: '大队', address: '珠海市斗门区斗门大道789号' }
]

const unitData = [
  { name: '珠海国际会展中心', code: '001', type: '大型场馆', level: '一级', address: '珠海市香洲区湾仔银湾路1663号' },
  { name: '珠海格力电器总部', code: '002', type: '工业企业', level: '一级', address: '珠海市香洲区前山金鸡路685号' },
  { name: '珠海长隆海洋王国', code: '003', type: '旅游景区', level: '一级', address: '珠海市横琴新区富祥湾' },
  { name: '珠海华发商都', code: '004', type: '商业综合体', level: '二级', address: '珠海市香洲区珠海大道8号' }
]
</script>

<style scoped>
.plan {
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

.footer {
  background-color: #333;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
