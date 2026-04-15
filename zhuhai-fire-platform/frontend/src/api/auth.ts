import api from './index'

export interface LoginRequest {
  username: string
  password: string
}

export interface LoginResponse {
  token: string
  userInfo: {
    id: number
    username: string
    name: string
    roles: string[]
  }
}

export const authApi = {
  login: (data: LoginRequest) => {
    return api.post<LoginResponse>('/auth/login', data)
  },
  
  logout: () => {
    return api.post('/auth/logout')
  },
  
  getUserInfo: () => {
    return api.get('/auth/userInfo')
  }
}
