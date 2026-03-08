import axiosInstance from './axiosInstance'
import type { ApiResponse } from './types'

export interface CodeItem {
  code: string
  name: string
}

export async function getCodes(codeGroup: string): Promise<CodeItem[]> {
  const res = await axiosInstance.get<ApiResponse<CodeItem[]>>('/codes', {
    params: { group: codeGroup },
  })
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
