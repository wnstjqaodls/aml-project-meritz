import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    userId: localStorage.getItem('userId') || 'analyst1',
    userNm: localStorage.getItem('userNm') || '분석담당자',
    roleId: localStorage.getItem('roleId') || 'ANALYST',
  }),
  actions: {
    login(userId, userNm, roleId) {
      this.userId = userId
      this.userNm = userNm
      this.roleId = roleId
      localStorage.setItem('userId', userId)
      localStorage.setItem('userNm', userNm)
      localStorage.setItem('roleId', roleId)
    },
    logout() {
      this.userId = ''
      this.userNm = ''
      this.roleId = ''
      localStorage.clear()
    }
  }
})
