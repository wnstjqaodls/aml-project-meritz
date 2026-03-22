import api from './axiosInstance.js'

export const strApi = {
  getCases: (params) => api.get('/str/cases', { params }),
  getDetail: (dt, id) => api.get(`/str/cases/${dt}/${id}`),
  saveReport: (dt, id, data) => api.put(`/str/cases/${dt}/${id}/report`, data),
  submitApproval: (dt, id, data) => api.post(`/str/cases/${dt}/${id}/submit-approval`, data),
  approveCase: (appNo, data) => api.put(`/str/approvals/${appNo}/approve`, data),
  submitFiu: (dt, id) => api.post(`/str/cases/${dt}/${id}/submit-fiu`),
  simulate: (count = 10) => api.post(`/tms/batch/simulate?count=${count}`)
}

export const ctrApi = {
  getCases: (params) => api.get('/ctr/cases', { params }),
  getDetail: (dt, id) => api.get(`/ctr/cases/${dt}/${id}`),
  submitFiu: (dt, id) => api.post(`/ctr/cases/${dt}/${id}/submit-fiu`)
}
