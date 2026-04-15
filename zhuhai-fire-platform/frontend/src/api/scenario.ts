import api from './index'

export interface ScenarioJob {
  id?: number
  jobName: string
  unitName: string
  disasterType: string
  createTime: string
  status: string
}

export const scenarioApi = {
  getScenarioList: () => {
    return api.get<ScenarioJob[]>('/scenario/list')
  },
  
  getScenarioById: (id: number) => {
    return api.get<ScenarioJob>(`/scenario/${id}`)
  },
  
  createScenario: (data: ScenarioJob) => {
    return api.post<ScenarioJob>('/scenario/create', data)
  },
  
  updateScenario: (data: ScenarioJob) => {
    return api.put<ScenarioJob>('/scenario/update', data)
  },
  
  deleteScenario: (id: number) => {
    return api.delete(`/scenario/delete/${id}`)
  },
  
  startScenario: (id: number) => {
    return api.post(`/scenario/start/${id}`)
  },
  
  pauseScenario: (id: number) => {
    return api.post(`/scenario/pause/${id}`)
  },
  
  stopScenario: (id: number) => {
    return api.post(`/scenario/stop/${id}`)
  }
}
