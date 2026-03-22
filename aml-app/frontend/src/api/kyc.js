import api from './axiosInstance.js'

export const kycApi = {
  getList: (params) => api.get('/kyc/list', { params }),
  getDetail: (custNo) => api.get(`/kyc/detail/${custNo}`),
  save: (data) => api.post('/kyc', data)
}
