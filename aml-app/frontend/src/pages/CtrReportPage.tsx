import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Form,
  Input,
  Select,
  Modal,
  message,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { PlusOutlined } from '@ant-design/icons'
import { getCtrReports, createCtrReport } from '../api/reports'
import { getCustomers } from '../api/customers'
import type { CtrReport, Customer } from '../api/types'
import PageHeader from '../components/shared/PageHeader'
import SearchForm from '../components/shared/SearchForm'
import StatusTag from '../components/shared/StatusTag'
import AmountDisplay from '../components/shared/AmountDisplay'

export default function CtrReportPage() {
  const [searchForm] = Form.useForm()
  const [ctrForm] = Form.useForm()

  const [reports, setReports] = useState<CtrReport[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [searchParams, setSearchParams] = useState<Record<string, string>>({})
  const [modalOpen, setModalOpen] = useState(false)
  const [saving, setSaving] = useState(false)
  const [customers, setCustomers] = useState<Customer[]>([])
  const [custSearching, setCustSearching] = useState(false)

  const fetchReports = useCallback(
    async (currentPage = 1, params = searchParams) => {
      setLoading(true)
      try {
        const res = await getCtrReports({ ...params, page: currentPage, size: 10 })
        setReports(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : 'CTR 목록 조회 실패')
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

  const handleSave = async () => {
    try {
      const values = await ctrForm.validateFields()
      setSaving(true)
      await createCtrReport(values)
      message.success('CTR 보고서가 등록되었습니다.')
      setModalOpen(false)
      ctrForm.resetFields()
      fetchReports(page, searchParams)
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setSaving(false)
    }
  }

  const columns: ColumnsType<CtrReport> = [
    { title: 'CTR 번호', dataIndex: 'ctr_no', key: 'ctr_no', width: 130 },
    { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
    { title: '거래일', dataIndex: 'tx_dt', key: 'tx_dt', width: 110 },
    {
      title: '거래금액',
      dataIndex: 'tx_amt',
      key: 'tx_amt',
      render: (v, r) => <AmountDisplay amount={v} currency={r.currency} />,
    },
    { title: '통화', dataIndex: 'currency', key: 'currency', width: 70 },
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
  ]

  return (
    <div>
      <PageHeader
        title="CTR 고액현금거래보고"
        actions={
          <Button
            type="primary"
            icon={<PlusOutlined />}
            onClick={() => {
              ctrForm.resetFields()
              setCustomers([])
              setModalOpen(true)
            }}
          >
            신규 CTR
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
        rowKey="ctr_id"
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
        title="신규 CTR 고액현금거래 보고"
        open={modalOpen}
        onOk={handleSave}
        onCancel={() => {
          setModalOpen(false)
          ctrForm.resetFields()
        }}
        confirmLoading={saving}
        width={520}
        okText="등록"
        cancelText="취소"
      >
        <Form form={ctrForm} layout="vertical" style={{ marginTop: 16 }}>
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
            >
              {customers.map((c) => (
                <Select.Option key={c.cust_no} value={c.cust_no}>
                  {c.cust_nm} ({c.cust_no})
                </Select.Option>
              ))}
            </Select>
          </Form.Item>
          <div style={{ display: 'flex', gap: 16 }}>
            <Form.Item
              name="tx_dt"
              label="거래일"
              rules={[{ required: true, message: '거래일을 입력하세요' }]}
              style={{ flex: 1 }}
            >
              <Input placeholder="YYYY-MM-DD" />
            </Form.Item>
            <Form.Item
              name="currency"
              label="통화"
              rules={[{ required: true, message: '통화를 선택하세요' }]}
              style={{ flex: 1 }}
              initialValue="KRW"
            >
              <Select>
                <Select.Option value="KRW">KRW (원)</Select.Option>
                <Select.Option value="USD">USD (달러)</Select.Option>
                <Select.Option value="EUR">EUR (유로)</Select.Option>
                <Select.Option value="JPY">JPY (엔)</Select.Option>
                <Select.Option value="CNY">CNY (위안)</Select.Option>
              </Select>
            </Form.Item>
          </div>
          <Form.Item
            name="tx_amt"
            label="거래금액"
            rules={[
              { required: true, message: '거래금액을 입력하세요' },
              {
                validator: (_, v) =>
                  v && Number(v) >= 10000000
                    ? Promise.resolve()
                    : Promise.reject(new Error('CTR은 1천만원 이상 거래에 해당합니다')),
              },
            ]}
          >
            <Input type="number" suffix="원" placeholder="최소 10,000,000원" />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  )
}
