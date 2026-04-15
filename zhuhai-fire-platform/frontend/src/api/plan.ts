import api from './index'

export interface PlanInfo {
  id?: number
  planName: string
  unitName: string
  planType: string
  createTime: string
  status: string
}

export const planApi = {
  getPlanList: () => {
    return api.get<PlanInfo[]>('/plan/list')
  },
  
  getPlanById: (id: number) => {
    return api.get<PlanInfo>(`/plan/${id}`)
  },
  
  createPlan: (data: PlanInfo) => {
    return api.post<PlanInfo>('/plan/create', data)
  },
  
  updatePlan: (data: PlanInfo) => {
    return api.put<PlanInfo>('/plan/update', data)
  },
  
  deletePlan: (id: number) => {
    return api.delete(`/plan/delete/${id}`)
  }
}
