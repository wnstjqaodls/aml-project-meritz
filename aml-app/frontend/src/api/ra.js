import api from './axiosInstance.js'

export const raApi = {
  getItems: () => api.get('/ra/items'),
  getResults: (params) => api.get('/ra/results', { params }),
  evaluate: (custNo) => api.post('/ra/evaluate', { custNo })
}
