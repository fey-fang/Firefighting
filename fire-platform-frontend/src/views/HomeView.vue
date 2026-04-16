<template>
  <div class="home">
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
        <el-carousel :interval="5000" type="card" height="400px">
          <el-carousel-item v-for="item in 4" :key="item">
            <div class="carousel-item">
              <h3>数字化战训平台</h3>
              <p>实现大数据、一张图、一键式、可视化的智能高效数据汇聚、应用</p>
            </div>
          </el-carousel-item>
        </el-carousel>
        <div class="feature-section">
          <h2>核心功能</h2>
          <el-row :gutter="20">
            <el-col :span="6">
              <el-card shadow="hover">
                <template #header>
                  <div class="card-header">
                    <el-icon><el-icon-map /></el-icon>
                    <span>三维数字化预案编制</span>
                  </div>
                </template>
                <p>基于三维模型的预案编制与管理，支持重点单位信息可视化</p>
              </el-card>
            </el-col>
            <el-col :span="6">
              <el-card shadow="hover">
                <template #header>
                  <div class="card-header">
                    <el-icon><el-icon-video-camera /></el-icon>
                    <span>三维数字化沙盘推演</span>
                  </div>
                </template>
                <p>基于三维场景的作战推演与考评，支持灾情模拟与力量部署</p>
              </el-card>
            </el-col>
            <el-col :span="6">
              <el-card shadow="hover">
                <template #header>
                  <div class="card-header">
                    <el-icon><el-icon-sunny /></el-icon>
                    <span>数字化训练考核</span>
                  </div>
                </template>
                <p>基于数据的训练规划与考核管理，支持绩点核算与统计分析</p>
              </el-card>
            </el-col>
            <el-col :span="6">
              <el-card shadow="hover">
                <template #header>
                  <div class="card-header">
                    <el-icon><el-icon-phone /></el-icon>
                    <span>移动端App</span>
                  </div>
                </template>
                <p>支持Android和iOS双平台，实现移动化战训管理</p>
              </el-card>
            </el-col>
          </el-row>
        </div>
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
const activeIndex = ref('home')

const handleSelect = (key: string) => {
  activeIndex.value = key
  router.push(`/${key}`)
}
</script>

<style scoped>
.home {
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

.carousel-item {
  height: 400px;
  background-color: #1890ff;
  color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 0 20px;
}

.carousel-item h3 {
  font-size: 32px;
  margin-bottom: 20px;
}

.carousel-item p {
  font-size: 18px;
  max-width: 800px;
}

.feature-section {
  margin-top: 40px;
}

.feature-section h2 {
  text-align: center;
  margin-bottom: 30px;
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
