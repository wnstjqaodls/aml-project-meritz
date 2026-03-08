import axiosInstance from './axiosInstance'
import type { ApiResponse, Case, CaseComment } from './types'

export interface CaseListParams {
  case_tp?: string
  stat?: string
  analyst?: string
  page?: number
  size?: number
}

export async function getCases(
  params: CaseListParams = {}
): Promise<{ data: Case[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<Case[]>>('/cases', {
    params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
  })
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getCaseDetail(caseId: string): Promise<Case> {
  const res = await axiosInstance.get<ApiResponse<Case>>(`/cases/${caseId}`)
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function createCase(payload: Partial<Case>): Promise<Case> {
  const res = await axiosInstance.post<ApiResponse<Case>>('/cases', payload)
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function updateCase(
  caseId: string,
  payload: Partial<Case>
): Promise<Case> {
  const res = await axiosInstance.put<ApiResponse<Case>>(
    `/cases/${caseId}`,
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function getCaseComments(caseId: string): Promise<CaseComment[]> {
  const res = await axiosInstance.get<ApiResponse<CaseComment[]>>(
    `/cases/${caseId}/comments`
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function addCaseComment(
  caseId: string,
  content: string
): Promise<CaseComment> {
  const res = await axiosInstance.post<ApiResponse<CaseComment>>(
    `/cases/${caseId}/comments`,
    { content }
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
