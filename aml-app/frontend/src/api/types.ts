export interface ApiResponse<T> {
  success: boolean
  data: T
  message: string
  total?: number
}

export interface Customer {
  cust_no: string
  cust_nm: string
  cust_tp: string
  nationality: string
  risk_grd: 'H' | 'M' | 'L'
  kyc_stat: string
  acct_open_dt: string
  email?: string
  phone?: string
  address?: string
  birth_dt?: string
  id_tp?: string
  id_no?: string
}

export interface KycRecord {
  kyc_id: string
  cust_no: string
  cust_nm: string
  kyc_tp: string
  stat: string
  id_tp: string
  pep_yn: string
  perf_dt: string
  next_kyc_dt: string
  rmk?: string
}

export interface WatchlistEntry {
  wl_id: string
  name: string
  source: string
  wl_tp: string
  nationality: string
  sanction_tp: string
  list_dt: string
}

export interface ScreeningResult {
  scr_id: string
  cust_no: string
  cust_nm: string
  wl_nm: string
  match_scr: number
  stat: string
  scr_dt: string
}

export interface TmsAlert {
  alert_id: string
  alert_no: string
  cust_no: string
  cust_nm: string
  rule_nm: string
  detect_amt: number
  detect_cnt: number
  risk_scr: number
  stat: string
  analyst: string
  reg_dt: string
}

export interface TmsTransaction {
  tx_id: string
  tx_dt: string
  tx_amt: number
  tx_tp: string
  acct_no: string
  counterparty: string
}

export interface Case {
  case_id: string
  case_no: string
  case_tp: string
  cust_no: string
  cust_nm: string
  priority: string
  stat: string
  analyst: string
  open_dt: string
  close_dt?: string
  str_yn: string
  ctr_yn: string
  desc?: string
}

export interface CaseComment {
  comment_id: string
  case_id: string
  author: string
  content: string
  created_at: string
}

export interface StrReport {
  str_id: string
  str_no: string
  cust_no: string
  cust_nm: string
  rep_dt: string
  sus_amt: number
  sus_fr_dt: string
  sus_to_dt: string
  sus_reason: string
  stat: string
  fiu_no?: string
  case_no?: string
}

export interface CtrReport {
  ctr_id: string
  ctr_no: string
  cust_no: string
  cust_nm: string
  tx_dt: string
  tx_amt: number
  currency: string
  stat: string
  fiu_no?: string
}

export interface RaItem {
  ra_item_cd: string
  ra_item_nm: string
  ra_item_tp: string
  max_scr: number
  wght: number
  use_yn: string
}

export interface RaResult {
  ra_id: string
  cust_no: string
  cust_nm: string
  eval_dt: string
  risk_scr: number
  risk_grd: string
  edd_yn: string
  next_eval_dt: string
}

export interface RaResultDetail {
  ra_item_cd: string
  ra_item_nm: string
  item_scr: number
  max_scr: number
  wght: number
}

export interface DashboardStats {
  new_alerts: number
  open_cases: number
  pending_kyc: number
  high_risk_customers: number
  recent_alerts: TmsAlert[]
  recent_cases: Case[]
}

export interface TmsScenario {
  scnr_id: string
  scnr_nm: string
  scnr_nm_en?: string
  scnr_tp_cd: string
  scnr_cat_cd?: string
  period_day?: number
  threshold_amt?: number
  threshold_cnt?: number
  alert_yn: string
  use_yn: string
  lst_app_no?: number
  remark?: string
  reg_dt?: string
}

export interface TmsSetVal {
  set_id: number
  scnr_id: string
  scnr_nm?: string
  set_key: string
  set_nm?: string
  set_val: string
  prev_val?: string
  val_tp_cd?: string
  use_yn: string
  upd_dt?: string
}

export interface TmsAppr {
  appr_id: number
  appr_no: string
  appr_tp_cd: string
  ref_id?: string
  appr_title: string
  appr_content?: string
  appr_st_cd: string
  req_id?: string
  req_dt?: string
  appr_usr_id?: string
  appr_dt?: string
  appr_cmnt?: string
  reject_rsn?: string
  reg_dt?: string
}

export interface TmsStatsDaily {
  stats_dt: string
  total_alerts: number
  new_alerts: number
  review_alerts: number
  closed_alerts: number
  str_count: number
  ctr_count: number
  high_risk_count: number
  total_detect_amt: number
}

export interface TmsTransactionItem {
  trxn_id: number
  cust_no?: string
  cust_nm?: string
  acct_no?: string
  trxn_dt?: string
  trxn_tm?: string
  trxn_tp_cd?: string
  trxn_amt?: number
  trxn_ccy?: string
  cntrp_nm?: string
  cntrp_bank_cd?: string
  chnl_cd?: string
  branch_cd?: string
}
