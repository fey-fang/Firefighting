import api from './index'

export interface TrainingPlan {
  id?: number
  planName: string
  trainingType: string
  startTime: string
  endTime: string
  status: string
}

export interface AssessmentInfo {
  id?: number
  examName: string
  examType: string
  examTime: string
  participants: number
  passRate: string
}

export const trainingApi = {
  getTrainingPlanList: () => {
    return api.get<TrainingPlan[]>('/training/list')
  },
  
  getTrainingPlanById: (id: number) => {
    return api.get<TrainingPlan>(`/training/${id}`)
  },
  
  createTrainingPlan: (data: TrainingPlan) => {
    return api.post<TrainingPlan>('/training/create', data)
  },
  
  updateTrainingPlan: (data: TrainingPlan) => {
    return api.put<TrainingPlan>('/training/update', data)
  },
  
  deleteTrainingPlan: (id: number) => {
    return api.delete(`/training/delete/${id}`)
  },
  
  getAssessmentList: () => {
    return api.get<AssessmentInfo[]>('/assessment/list')
  },
  
  getAssessmentById: (id: number) => {
    return api.get<AssessmentInfo>(`/assessment/${id}`)
  },
  
  createAssessment: (data: AssessmentInfo) => {
    return api.post<AssessmentInfo>('/assessment/create', data)
  },
  
  updateAssessment: (data: AssessmentInfo) => {
    return api.put<AssessmentInfo>('/assessment/update', data)
  },
  
  deleteAssessment: (id: number) => {
    return api.delete(`/assessment/delete/${id}`)
  }
}
