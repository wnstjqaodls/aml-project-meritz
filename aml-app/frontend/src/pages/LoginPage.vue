<template>
  <div class="login-wrap">
    <div class="login-box">
      <div class="login-header">
        <h1>🛡 AMLXpress7</h1>
        <p>메리츠증권 자금세탁방지시스템</p>
      </div>
      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label>사용자 ID</label>
          <input v-model="userId" type="text" placeholder="사용자 ID 입력" required />
        </div>
        <div class="form-group">
          <label>비밀번호</label>
          <input v-model="password" type="password" placeholder="비밀번호 입력" required />
        </div>
        <button type="submit" class="login-btn" :disabled="loading">
          {{ loading ? '로그인 중...' : '로그인' }}
        </button>
        <p v-if="error" class="error-msg">{{ error }}</p>
      </form>
      <div class="login-hint">
        <small>테스트 계정: analyst1 / admin1 / manager1</small>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../store/auth.js'

const router = useRouter()
const authStore = useAuthStore()
const userId = ref('analyst1')
const password = ref('1234')
const loading = ref(false)
const error = ref('')

const USERS = {
  analyst1:    { nm: 'STR분석담당자', role: 'ANALYST' },
  admin1:      { nm: '시스템관리자',  role: 'ADMIN' },
  manager1:    { nm: '준법감시팀장',  role: 'MANAGER' },
  kyc1:        { nm: 'KYC담당자',    role: 'KYC_OFFICER' },
  compliance1: { nm: 'Compliance담당', role: 'COMPLIANCE' },
}

async function handleLogin() {
  loading.value = true
  error.value = ''
  await new Promise(r => setTimeout(r, 300))
  const user = USERS[userId.value]
  if (user) {
    authStore.login(userId.value, user.nm, user.role)
    router.push('/dashboard')
  } else {
    error.value = '사용자 ID 또는 비밀번호가 올바르지 않습니다.'
  }
  loading.value = false
}
</script>

<style scoped>
.login-wrap { min-height: 100vh; background: #001529; display: flex; align-items: center; justify-content: center; }
.login-box { background: #fff; border-radius: 8px; padding: 40px; width: 360px; box-shadow: 0 8px 32px rgba(0,0,0,0.3); }
.login-header { text-align: center; margin-bottom: 28px; }
.login-header h1 { font-size: 24px; color: #001529; margin: 0 0 8px; }
.login-header p { color: #888; font-size: 13px; margin: 0; }
.form-group { margin-bottom: 16px; }
.form-group label { display: block; font-size: 13px; color: #444; margin-bottom: 6px; }
.form-group input { width: 100%; padding: 10px 12px; border: 1px solid #d9d9d9; border-radius: 4px; font-size: 14px; box-sizing: border-box; }
.form-group input:focus { border-color: #1890ff; outline: none; box-shadow: 0 0 0 2px rgba(24,144,255,0.2); }
.login-btn { width: 100%; padding: 12px; background: #1890ff; color: #fff; border: none; border-radius: 4px; font-size: 15px; cursor: pointer; margin-top: 8px; }
.login-btn:hover { background: #40a9ff; }
.login-btn:disabled { background: #bbd6f5; cursor: not-allowed; }
.error-msg { color: #ff4d4f; font-size: 13px; margin: 8px 0 0; text-align: center; }
.login-hint { text-align: center; margin-top: 16px; color: #aaa; }
</style>
