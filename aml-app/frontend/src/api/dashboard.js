import api from './axiosInstance.js'

export const dashboardApi = {
  getStats: () => api.get('/dashboard/stats')
}
