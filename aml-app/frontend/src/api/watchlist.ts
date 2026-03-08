import axiosInstance from './axiosInstance'
import type { ApiResponse, WatchlistEntry, ScreeningResult } from './types'

export interface WatchlistParams {
  name?: string
  source?: string
  wl_tp?: string
  page?: number
  size?: number
}

export async function getWatchlist(
  params: WatchlistParams = {}
): Promise<{ data: WatchlistEntry[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<WatchlistEntry[]>>(
    '/watchlist',
    {
      params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
    }
  )
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getScreeningResults(params: {
  cust_no?: string
  stat?: string
  page?: number
  size?: number
}): Promise<{ data: ScreeningResult[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<ScreeningResult[]>>(
    '/watchlist/screen-results',
    {
      params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
    }
  )
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function screenCustomer(
  custNo: string
): Promise<ScreeningResult[]> {
  const res = await axiosInstance.post<ApiResponse<ScreeningResult[]>>(
    '/watchlist/screen',
    { cust_no: custNo }
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
