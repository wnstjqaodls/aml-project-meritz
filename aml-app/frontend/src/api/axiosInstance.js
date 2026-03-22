import axios from 'axios'

const instance = axios.create({
  baseURL: '/api',
  timeout: 30000,
  headers: { 'Content-Type': 'application/json' }
})

instance.interceptors.request.use(config => {
  const userId = localStorage.getItem('userId') || 'analyst1'
  config.headers['X-User-Id'] = userId
  return config
})

instance.interceptors.response.use(
  res => res,
  err => {
    const msg = err.response?.data?.message || err.message || '오류 발생'
    return Promise.reject(new Error(msg))
  }
)

export default instance
