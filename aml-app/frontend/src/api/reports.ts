import axiosInstance from './axiosInstance'
import type { ApiResponse, StrReport, CtrReport } from './types'

export interface StrListParams {
  stat?: string
  page?: number
  size?: number
}

export async function getStrReports(
  params: StrListParams = {}
): Promise<{ data: StrReport[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<StrReport[]>>('/reports/str', {
    params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
  })
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function createStrReport(
  payload: Partial<StrReport>
): Promise<StrReport> {
  const res = await axiosInstance.post<ApiResponse<StrReport>>(
    '/reports/str',
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function updateStrReport(
  strId: string,
  payload: Partial<StrReport>
): Promise<StrReport> {
  const res = await axiosInstance.put<ApiResponse<StrReport>>(
    `/reports/str/${strId}`,
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function getCtrReports(params: {
  stat?: string
  page?: number
  size?: number
} = {}): Promise<{ data: CtrReport[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<CtrReport[]>>('/reports/ctr', {
    params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
  })
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function createCtrReport(
  payload: Partial<CtrReport>
): Promise<CtrReport> {
  const res = await axiosInstance.post<ApiResponse<CtrReport>>(
    '/reports/ctr',
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
