import axiosInstance from './axiosInstance'
import type { ApiResponse, RaItem, RaResult, RaResultDetail } from './types'

export async function getRaItems(): Promise<RaItem[]> {
  const res = await axiosInstance.get<ApiResponse<RaItem[]>>('/ra/items')
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function createRaItem(payload: Partial<RaItem>): Promise<RaItem> {
  const res = await axiosInstance.post<ApiResponse<RaItem>>('/ra/items', payload)
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function updateRaItem(
  raItemCd: string,
  payload: Partial<RaItem>
): Promise<RaItem> {
  const res = await axiosInstance.put<ApiResponse<RaItem>>(
    `/ra/items/${raItemCd}`,
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function getRaResults(params: {
  cust_no?: string
  cust_nm?: string
  page?: number
  size?: number
} = {}): Promise<{ data: RaResult[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<RaResult[]>>('/ra/results', {
    params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
  })
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getRaResultDetail(
  raId: string
): Promise<{ result: RaResult; details: RaResultDetail[] }> {
  const res = await axiosInstance.get<
    ApiResponse<{ result: RaResult; details: RaResultDetail[] }>
  >(`/ra/results/${raId}`)
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function evaluateRisk(custNo: string): Promise<RaResult> {
  const res = await axiosInstance.post<ApiResponse<RaResult>>('/ra/evaluate', {
    cust_no: custNo,
  })
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
