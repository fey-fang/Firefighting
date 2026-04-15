import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/LoginView.vue')
  },
  {
    path: '/main',
    name: 'Main',
    component: () => import('../views/MainView.vue'),
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('../views/DashboardView.vue')
      },
      {
        path: 'plan',
        name: 'Plan',
        component: () => import('../views/PlanView.vue')
      },
      {
        path: 'scenario',
        name: 'Scenario',
        component: () => import('../views/ScenarioView.vue')
      },
      {
        path: 'training',
        name: 'Training',
        component: () => import('../views/TrainingView.vue')
      },
      {
        path: 'statistics',
        name: 'Statistics',
        component: () => import('../views/StatisticsView.vue')
      },
      {
        path: 'user',
        name: 'User',
        component: () => import('../views/UserManagementView.vue')
      },
      {
        path: 'keyunit',
        name: 'KeyUnit',
        component: () => import('../views/KeyUnitView.vue')
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
