import axiosInstance from './axiosInstance'
import type { ApiResponse } from './types'
import type { AuthUser as StoreAuthUser } from '../store/authStore'

interface LoginPayload {
  userId: string
  password: string
}

interface LoginResult {
  userId: string
  userName: string
  role: string
}

export async function login(payload: LoginPayload): Promise<StoreAuthUser> {
  const res = await axiosInstance.post<ApiResponse<LoginResult>>(
    '/auth/login',
    { userId: payload.userId, pwd: payload.password }
  )
  if (!res.data.success) {
    throw new Error(res.data.message || '로그인에 실패했습니다.')
  }
  const d = res.data.data as any
  return {
    userId: d.userId,
    userName: d.userNm ?? d.userName ?? d.userId,
    role: d.roleCd ?? d.role ?? 'ANALYST',
  }
}
