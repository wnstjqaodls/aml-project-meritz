import axiosInstance from './axiosInstance'
import type { ApiResponse, Customer } from './types'

export interface CustomerListParams {
  cust_nm?: string
  cust_tp?: string
  risk_grd?: string
  page?: number
  size?: number
}

export async function getCustomers(
  params: CustomerListParams = {}
): Promise<{ data: Customer[]; total: number }> {
  const res = await axiosInstance.get<ApiResponse<Customer[]>>('/customers', {
    params: { ...params, page: params.page ?? 1, size: params.size ?? 10 },
  })
  if (!res.data.success) throw new Error(res.data.message)
  return { data: res.data.data, total: res.data.total ?? res.data.data.length }
}

export async function getCustomer(custNo: string): Promise<Customer> {
  const res = await axiosInstance.get<ApiResponse<Customer>>(
    `/customers/${custNo}`
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function createCustomer(
  payload: Partial<Customer>
): Promise<Customer> {
  const res = await axiosInstance.post<ApiResponse<Customer>>(
    '/customers',
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}

export async function updateCustomer(
  custNo: string,
  payload: Partial<Customer>
): Promise<Customer> {
  const res = await axiosInstance.put<ApiResponse<Customer>>(
    `/customers/${custNo}`,
    payload
  )
  if (!res.data.success) throw new Error(res.data.message)
  return res.data.data
}
