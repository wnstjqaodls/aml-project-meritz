import axiosInstance from './axiosInstance'
import type {
  ApiResponse,
  TmsAlert,
  TmsTransaction,
  TmsScenario,
  TmsSetVal,
  TmsAppr,
  TmsStatsDaily,
  TmsTransactionItem,
} from './types'

export interface TmsAlertParams {
  stat?: string
  page?: number
  size?: number
}

export async function getTmsAlerts(
  params: TmsAlertParams = {}
): Promise<{ data: TmsAlert[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<TmsAlert[]>>('/tms/alerts', {
    params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
  })
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getTmsAlertDetail(alertId: string): Promise<TmsAlert> {
  const res = await axiosInstance.get<ApiResponse<TmsAlert>>(
    `/tms/alerts/${alertId}`
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function getAlertTransactions(
  alertId: string
): Promise<TmsTransaction[]> {
  const res = await axiosInstance.get<ApiResponse<TmsTransaction[]>>(
    `/tms/alerts/${alertId}/transactions`
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function updateTmsAlert(
  alertId: string,
  payload: { stat?: string; analyst?: string }
): Promise<TmsAlert> {
  const res = await axiosInstance.put<ApiResponse<TmsAlert>>(
    `/tms/alerts/${alertId}`,
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

// ─── Transactions ────────────────────────────────────────────────────────────

export interface TmsTransactionParams {
  cust_no?: string
  acct_no?: string
  trxn_tp_cd?: string
  trxn_dt_from?: string
  trxn_dt_to?: string
  amt_min?: number
  amt_max?: number
  page?: number
  size?: number
}

export async function searchTransactions(
  params: TmsTransactionParams = {}
): Promise<{ data: TmsTransactionItem[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<TmsTransactionItem[]>>(
    '/tms/transactions',
    { params: { ...params, page: params.page ?? 1, size: params.size ?? 20 } }
  )
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

// ─── Scenarios ───────────────────────────────────────────────────────────────

export interface TmsScenarioParams {
  scnr_tp_cd?: string
  use_yn?: string
  page?: number
  size?: number
}

export async function getScenarios(
  params: TmsScenarioParams = {}
): Promise<{ data: TmsScenario[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<TmsScenario[]>>(
    '/tms/scenarios',
    { params: { ...params, page: params.page ?? 1, size: params.size ?? 20 } }
  )
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getScenario(scnrId: string): Promise<TmsScenario> {
  const res = await axiosInstance.get<ApiResponse<TmsScenario>>(
    `/tms/scenarios/${scnrId}`
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function createScenario(
  data: Partial<TmsScenario>
): Promise<TmsScenario> {
  const res = await axiosInstance.post<ApiResponse<TmsScenario>>(
    '/tms/scenarios',
    data
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function updateScenario(
  scnrId: string,
  data: Partial<TmsScenario>
): Promise<TmsScenario> {
  const res = await axiosInstance.put<ApiResponse<TmsScenario>>(
    `/tms/scenarios/${scnrId}`,
    data
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

// ─── Set Values ──────────────────────────────────────────────────────────────

export interface TmsSetValParams {
  scnr_id?: string
  set_key?: string
  page?: number
  size?: number
}

export async function getSetVals(
  params: TmsSetValParams = {}
): Promise<{ data: TmsSetVal[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<TmsSetVal[]>>(
    '/tms/setvals',
    { params: { ...params, page: params.page ?? 1, size: params.size ?? 20 } }
  )
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getSetValsByScnr(scnrId: string): Promise<TmsSetVal[]> {
  const res = await axiosInstance.get<ApiResponse<TmsSetVal[]>>(
    `/tms/setvals/${scnrId}`
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function updateSetVal(
  setId: number,
  data: Partial<TmsSetVal>
): Promise<TmsSetVal> {
  const res = await axiosInstance.put<ApiResponse<TmsSetVal>>(
    `/tms/setvals/${setId}`,
    data
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

// ─── Approvals ───────────────────────────────────────────────────────────────

export interface TmsApprParams {
  appr_st_cd?: string
  appr_tp_cd?: string
  page?: number
  size?: number
}

export async function getApprovals(
  params: TmsApprParams = {}
): Promise<{ data: TmsAppr[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<TmsAppr[]>>(
    '/tms/approvals',
    { params: { ...params, page: params.page ?? 1, size: params.size ?? 20 } }
  )
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getApproval(apprId: number): Promise<TmsAppr> {
  const res = await axiosInstance.get<ApiResponse<TmsAppr>>(
    `/tms/approvals/${apprId}`
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function approveApproval(
  apprId: number,
  data: { appr_cmnt?: string }
): Promise<TmsAppr> {
  const res = await axiosInstance.post<ApiResponse<TmsAppr>>(
    `/tms/approvals/${apprId}/approve`,
    data
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function rejectApproval(
  apprId: number,
  data: { reject_rsn: string }
): Promise<TmsAppr> {
  const res = await axiosInstance.post<ApiResponse<TmsAppr>>(
    `/tms/approvals/${apprId}/reject`,
    data
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function createApproval(
  data: Partial<TmsAppr>
): Promise<TmsAppr> {
  const res = await axiosInstance.post<ApiResponse<TmsAppr>>(
    '/tms/approvals',
    data
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

// ─── Stats ───────────────────────────────────────────────────────────────────

export interface TmsStatsDashboard {
  today_total_alerts: number
  today_new_alerts: number
  today_str_count: number
  today_ctr_count: number
  status_breakdown: { stat: string; count: number }[]
  scenario_breakdown: { scnr_nm: string; count: number }[]
}

export async function getTmsStatsDashboard(): Promise<TmsStatsDashboard> {
  const res = await axiosInstance.get<ApiResponse<TmsStatsDashboard>>(
    '/tms/stats/dashboard'
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function getTmsStatsWeekly(): Promise<TmsStatsDaily[]> {
  const res = await axiosInstance.get<ApiResponse<TmsStatsDaily[]>>(
    '/tms/stats/weekly'
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function getTmsStatsBreakdown(): Promise<
  { label: string; value: number }[]
> {
  const res = await axiosInstance.get<
    ApiResponse<{ label: string; value: number }[]>
  >('/tms/stats/breakdown')
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
