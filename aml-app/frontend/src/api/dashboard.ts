import axiosInstance from './axiosInstance'
import type { ApiResponse, DashboardStats } from './types'

export async function getDashboardStats(): Promise<DashboardStats> {
  const res = await axiosInstance.get<ApiResponse<DashboardStats>>(
    '/dashboard/stats'
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
