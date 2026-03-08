import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Form,
  Input,
  Select,
  Modal,
  DatePicker,
  message,
  Space,
  Descriptions,
  Tag,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { PlusOutlined } from '@ant-design/icons'
import { getStrReports, createStrReport, updateStrReport } from '../api/reports'
import { getCustomers } from '../api/customers'
import type { StrReport, Customer } from '../api/types'
import PageHeader from '../components/shared/PageHeader'
import SearchForm from '../components/shared/SearchForm'
import StatusTag from '../components/shared/StatusTag'
import AmountDisplay from '../components/shared/AmountDisplay'

export default function StrReportPage() {
  const [searchForm] = Form.useForm()
  const [strForm] = Form.useForm()

  const [reports, setReports] = useState<StrReport[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [searchParams, setSearchParams] = useState<Record<string, string>>({})

  const [modalOpen, setModalOpen] = useState(false)
  const [editReport, setEditReport] = useState<StrReport | null>(null)
  const [saving, setSaving] = useState(false)

  const [customers, setCustomers] = useState<Customer[]>([])
  const [custSearching, setCustSearching] = useState(false)

  const fetchReports = useCallback(
    async (currentPage = 1, params = searchParams) => {
      setLoading(true)
      try {
        const res = await getStrReports({ ...params, page: currentPage, size: 10 })
        setReports(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : 'STR 목록 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [searchParams]
  )

  useEffect(() => {
    fetchReports(1, {})
  }, [])

  const handleSearch = () => {
    const values = searchForm.getFieldsValue()
    const params: Record<string, string> = {}
    if (values.stat) params.stat = values.stat
    setSearchParams(params)
    setPage(1)
    fetchReports(1, params)
  }

  const handleReset = () => {
    setSearchParams({})
    setPage(1)
    fetchReports(1, {})
  }

  const handleCustSearch = async (keyword: string) => {
    if (!keyword) return
    setCustSearching(true)
    try {
      const res = await getCustomers({ cust_nm: keyword, size: 20 })
      setCustomers(res.data)
    } catch {
      // silently fail
    } finally {
      setCustSearching(false)
    }
  }

  const openCreate = () => {
    setEditReport(null)
    strForm.resetFields()
    setCustomers([])
    setModalOpen(true)
  }

  const openEdit = (report: StrReport) => {
    setEditReport(report)
    strForm.setFieldsValue(report)
    setModalOpen(true)
  }

  const handleSave = async () => {
    try {
      const values = await strForm.validateFields()
      setSaving(true)
      const payload = {
        ...values,
        sus_fr_dt: values.sus_period?.[0]?.format('YYYY-MM-DD'),
        sus_to_dt: values.sus_period?.[1]?.format('YYYY-MM-DD'),
      }
      delete payload.sus_period
      if (editReport) {
        await updateStrReport(editReport.str_id, payload)
        message.success('STR 보고서가 수정되었습니다.')
      } else {
        await createStrReport(payload)
        message.success('STR 보고서가 등록되었습니다.')
      }
      setModalOpen(false)
      strForm.resetFields()
      fetchReports(page, searchParams)
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setSaving(false)
    }
  }

  const columns: ColumnsType<StrReport> = [
    { title: 'STR 번호', dataIndex: 'str_no', key: 'str_no', width: 130 },
    { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
    { title: '보고일', dataIndex: 'rep_dt', key: 'rep_dt', width: 110 },
    {
      title: '혐의금액',
      dataIndex: 'sus_amt',
      key: 'sus_amt',
      render: (v) => <AmountDisplay amount={v} />,
    },
    {
      title: '혐의기간',
      key: 'sus_period',
      render: (_, r) => `${r.sus_fr_dt} ~ ${r.sus_to_dt}`,
    },
    {
      title: '상태',
      dataIndex: 'stat',
      key: 'stat',
      render: (v) => <StatusTag status={v} type="report" />,
    },
    {
      title: 'FIU 접수번호',
      dataIndex: 'fiu_no',
      key: 'fiu_no',
      render: (v) => v || '-',
    },
    {
      title: '액션',
      key: 'action',
      width: 70,
      render: (_, record) => (
        <Button
          size="small"
          onClick={(e) => {
            e.stopPropagation()
            openEdit(record)
          }}
        >
          수정
        </Button>
      ),
    },
  ]

  return (
    <div>
      <PageHeader
        title="STR 혐의거래보고"
        actions={
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            신규 STR
          </Button>
        }
      />

      <SearchForm
        form={searchForm}
        onSearch={handleSearch}
        onReset={handleReset}
        loading={loading}
      >
        <Form.Item name="stat" label="상태">
          <Select placeholder="전체" style={{ width: 120 }} allowClear>
            <Select.Option value="DRAFT">초안</Select.Option>
            <Select.Option value="SUBMITTED">제출</Select.Option>
            <Select.Option value="ACCEPTED">접수</Select.Option>
            <Select.Option value="REJECTED">반려</Select.Option>
          </Select>
        </Form.Item>
      </SearchForm>

      <Table
        dataSource={reports}
        columns={columns}
        rowKey="str_id"
        loading={loading}
        pagination={{
          current: page,
          pageSize: 10,
          total,
          showTotal: (t) => `총 ${t}건`,
          onChange: (p) => {
            setPage(p)
            fetchReports(p, searchParams)
          },
        }}
        size="middle"
      />

      <Modal
        title={editReport ? 'STR 보고서 수정' : '신규 STR 보고서'}
        open={modalOpen}
        onOk={handleSave}
        onCancel={() => {
          setModalOpen(false)
          strForm.resetFields()
        }}
        confirmLoading={saving}
        width={580}
        okText={editReport ? '저장' : '등록'}
        cancelText="취소"
      >
        <Form form={strForm} layout="vertical" style={{ marginTop: 16 }}>
          <Form.Item
            name="cust_no"
            label="고객 선택"
            rules={[{ required: true, message: '고객을 선택하세요' }]}
          >
            <Select
              showSearch
              placeholder="고객명으로 검색"
              filterOption={false}
              onSearch={handleCustSearch}
              loading={custSearching}
              notFoundContent={custSearching ? '검색 중...' : '검색 결과 없음'}
              disabled={!!editReport}
            >
              {customers.map((c) => (
                <Select.Option key={c.cust_no} value={c.cust_no}>
                  {c.cust_nm} ({c.cust_no})
                </Select.Option>
              ))}
            </Select>
          </Form.Item>
          <Form.Item
            name="sus_amt"
            label="혐의금액 (원)"
            rules={[{ required: true, message: '혐의금액을 입력하세요' }]}
          >
            <Input type="number" suffix="원" />
          </Form.Item>
          <Form.Item
            name="sus_period"
            label="혐의기간"
            rules={[{ required: true, message: '혐의기간을 선택하세요' }]}
          >
            <DatePicker.RangePicker style={{ width: '100%' }} />
          </Form.Item>
          <Form.Item
            name="sus_reason"
            label="혐의사유"
            rules={[{ required: true, message: '혐의사유를 입력하세요' }]}
          >
            <Input.TextArea rows={4} placeholder="혐의사유를 상세히 입력하세요" />
          </Form.Item>
          <Form.Item name="case_no" label="관련 케이스 번호">
            <Input placeholder="케이스 번호 (선택)" />
          </Form.Item>
          {editReport && (
            <Form.Item name="stat" label="상태">
              <Select>
                <Select.Option value="DRAFT">초안</Select.Option>
                <Select.Option value="SUBMITTED">제출</Select.Option>
                <Select.Option value="ACCEPTED">접수</Select.Option>
                <Select.Option value="REJECTED">반려</Select.Option>
              </Select>
            </Form.Item>
          )}
          {editReport && (
            <Form.Item name="fiu_no" label="FIU 접수번호">
              <Input />
            </Form.Item>
          )}
        </Form>
      </Modal>
    </div>
  )
}
