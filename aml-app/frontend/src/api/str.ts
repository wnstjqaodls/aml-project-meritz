import axiosInstance from './axiosInstance'
import type { ApiResponse } from './types'

export interface StrCase {
  sspsDlCrtDt: string
  sspsDlId: string
  sspsTpCd: string
  rprPrgrsCcd: string
  dlPNm: string
  dlPRnmcno: string
  rskGrdCd: string
  scnrMrk: number
  dlAmt: number
  dlCnt: number
}

export interface StrTransaction {
  seqNo: number
  mnDlBrnCd: string
  mnDlBrnNm: string
  dlDt: string
  dlTm: string
  dlAmt: number
  dlTypCcd: string
  dlCcy: string
  cntrpAcNo: string
  cntrpNm: string
}

export interface StrAmount {
  gnlAcNo: string
  dlAmt: number
  dlCcy: string
}

export interface StrReport {
  rprRsnCntnt: string
  itemCntnt1?: string
  itemCntnt2?: string
  itemCntnt3?: string
  itemCntnt4?: string
  itemCntnt5?: string
  itemCntnt6?: string
  dobtDlGrdCd: string
}

export interface StrApproval {
  appNo: string
  gylj: string
  numSq: number
  appDt: string
  snCcd: string
  apprRoleId: string
  rsnCntnt: string
  hndlDyTm: string
  hndlPEno: string
}

export interface StrCaseInfo {
  sspsDlCrtDt: string
  sspsDlId: string
  sspsTpCd: string
  rprPrgrsCcd: string
  dlPRnmcno: string
  rskMrk: number
  rskGrdCd: string
  okCcd: string
  scnrMrk: number
  aiResult: string
  fiuRptNo: string
  fiuRptDt: string
}

export interface StrPartyInfo {
  dlPNm: string
  dlPRnmNoCcd: string
  indvCorpCcd: string
  dlPBrtdy: string
  dlPSexCd: string
  ocptnCcd: string
  dlPHseAddr: string
  dlPMblTelNo: string
  wpNm: string
}

export interface StrCaseDetail {
  caseInfo: StrCaseInfo
  partyInfo: StrPartyInfo
  transactions: StrTransaction[]
  amounts: StrAmount[]
  report: StrReport | null
  approvals: StrApproval[]
}

export interface CtrCase {
  sspsDlCrtDt: string
  sspsDlId: string
  rprPrgrsCcd: string
  dlPNm: string
  dlAmt: number
  dlCcy: string
}

export interface CtrCaseDetail {
  caseInfo: Record<string, string>
  partyInfo: Record<string, string>
  transactions: StrTransaction[]
  amounts: StrAmount[]
  approvals: StrApproval[]
}

export const strApi = {
  getCases: (params: Record<string, unknown>) =>
    axiosInstance.get<ApiResponse<{ list: StrCase[]; total: number }>>('/str/cases', { params }),

  getDetail: (dt: string, id: string) =>
    axiosInstance.get<ApiResponse<StrCaseDetail>>(`/str/cases/${dt}/${id}`),

  saveReport: (dt: string, id: string, data: Partial<StrReport>) =>
    axiosInstance.put<ApiResponse<unknown>>(`/str/cases/${dt}/${id}/report`, data),

  submitApproval: (dt: string, id: string, data: { rsnCntnt: string }) =>
    axiosInstance.post<ApiResponse<unknown>>(`/str/cases/${dt}/${id}/submit-approval`, data),

  approveCase: (appNo: string, data: { snCcd: 'E' | 'R'; rsnCntnt: string; apprUsrId: string }) =>
    axiosInstance.put<ApiResponse<unknown>>(`/str/approvals/${appNo}/approve`, data),

  submitFiu: (dt: string, id: string) =>
    axiosInstance.post<ApiResponse<unknown>>(`/str/cases/${dt}/${id}/submit-fiu`),

  simulate: (count = 10) =>
    axiosInstance.post<ApiResponse<unknown>>(`/tms/batch/simulate?count=${count}`),
}

export const ctrApi = {
  getCases: (params: Record<string, unknown>) =>
    axiosInstance.get<ApiResponse<{ list: CtrCase[]; total: number }>>('/ctr/cases', { params }),

  getDetail: (dt: string, id: string) =>
    axiosInstance.get<ApiResponse<CtrCaseDetail>>(`/ctr/cases/${dt}/${id}`),

  updateStatus: (dt: string, id: string, data: { rprPrgrsCcd: string }) =>
    axiosInstance.put<ApiResponse<unknown>>(`/ctr/cases/${dt}/${id}/status`, data),

  submitFiu: (dt: string, id: string) =>
    axiosInstance.post<ApiResponse<unknown>>(`/ctr/cases/${dt}/${id}/submit-fiu`),
}
