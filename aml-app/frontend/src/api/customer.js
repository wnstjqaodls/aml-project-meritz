import api from './axiosInstance.js'

export const customerApi = {
  getList: (params) => api.get('/customers', { params }),
  getDetail: (custNo) => api.get(`/customers/${custNo}`)
}
