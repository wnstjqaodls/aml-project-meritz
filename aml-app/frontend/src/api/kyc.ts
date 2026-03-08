import axiosInstance from './axiosInstance'
import type { ApiResponse, KycRecord } from './types'

export interface KycListParams {
  stat?: string
  cust_no?: string
  page?: number
  size?: number
}

export async function getKycList(
  params: KycListParams = {}
): Promise<{ data: KycRecord[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<KycRecord[]>>('/kyc', {
    params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
  })
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getKycDetail(kycId: string): Promise<KycRecord> {
  const res = await axiosInstance.get<ApiResponse<KycRecord>>(`/kyc/${kycId}`)
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function createKyc(payload: Partial<KycRecord>): Promise<KycRecord> {
  const res = await axiosInstance.post<ApiResponse<KycRecord>>('/kyc', payload)
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function updateKyc(
  kycId: string,
  payload: Partial<KycRecord>
): Promise<KycRecord> {
  const res = await axiosInstance.put<ApiResponse<KycRecord>>(
    `/kyc/${kycId}`,
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
