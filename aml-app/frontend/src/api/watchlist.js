import api from './axiosInstance.js'

export const watchlistApi = {
  search: (params) => api.get('/watchlist', { params }),
  screenResults: (params) => api.get('/watchlist/screen-results', { params }),
  screen: (data) => api.post('/watchlist/screen', data)
}
