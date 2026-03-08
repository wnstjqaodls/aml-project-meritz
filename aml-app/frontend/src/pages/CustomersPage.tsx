import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Form,
  Input,
  Select,
  Modal,
  Tabs,
  Descriptions,
  message,
  Tag,
  Space,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { PlusOutlined, EyeOutlined } from '@ant-design/icons'
import {
  getCustomers,
  getCustomer,
  createCustomer,
  updateCustomer,
} from '../api/customers'
import { getKycList } from '../api/kyc'
import { getRaResults } from '../api/ra'
import { getScreeningResults } from '../api/watchlist'
import type { Customer, KycRecord, RaResult, ScreeningResult } from '../api/types'
import PageHeader from '../components/shared/PageHeader'
import SearchForm from '../components/shared/SearchForm'
import StatusTag from '../components/shared/StatusTag'

const riskGradeColor: Record<string, string> = {
  H: 'red',
  M: 'orange',
  L: 'green',
}

const riskGradeLabel: Record<string, string> = {
  H: '고위험',
  M: '중위험',
  L: '저위험',
}

export default function CustomersPage() {
  const [searchForm] = Form.useForm()
  const [createForm] = Form.useForm()
  const [editForm] = Form.useForm()

  const [customers, setCustomers] = useState<Customer[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [searchParams, setSearchParams] = useState<Record<string, string>>({})

  const [createModalOpen, setCreateModalOpen] = useState(false)
  const [detailModalOpen, setDetailModalOpen] = useState(false)
  const [selectedCustomer, setSelectedCustomer] = useState<Customer | null>(null)
  const [kycHistory, setKycHistory] = useState<KycRecord[]>([])
  const [raResults, setRaResults] = useState<RaResult[]>([])
  const [screenResults, setScreenResults] = useState<ScreeningResult[]>([])
  const [detailLoading, setDetailLoading] = useState(false)
  const [saving, setSaving] = useState(false)
  const [editMode, setEditMode] = useState(false)

  const fetchCustomers = useCallback(
    async (currentPage = 1, params = searchParams) => {
      setLoading(true)
      try {
        const res = await getCustomers({ ...params, page: currentPage, size: 10 })
        setCustomers(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : '고객 목록 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [searchParams]
  )

  useEffect(() => {
    fetchCustomers(1, {})
  }, [])

  const handleSearch = () => {
    const values = searchForm.getFieldsValue()
    const params: Record<string, string> = {}
    if (values.cust_nm) params.cust_nm = values.cust_nm
    if (values.cust_tp) params.cust_tp = values.cust_tp
    if (values.risk_grd) params.risk_grd = values.risk_grd
    setSearchParams(params)
    setPage(1)
    fetchCustomers(1, params)
  }

  const handleReset = () => {
    setSearchParams({})
    setPage(1)
    fetchCustomers(1, {})
  }

  const openDetail = async (custNo: string) => {
    setDetailLoading(true)
    setDetailModalOpen(true)
    setEditMode(false)
    try {
      const [cust, kyc, ra, scr] = await Promise.all([
        getCustomer(custNo),
        getKycList({ cust_no: custNo, size: 100 }),
        getRaResults({ cust_no: custNo, size: 100 }),
        getScreeningResults({ cust_no: custNo, size: 100 }),
      ])
      setSelectedCustomer(cust)
      setKycHistory(kyc.data)
      setRaResults(ra.data)
      setScreenResults(scr.data)
      editForm.setFieldsValue(cust)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '고객 정보 조회 실패')
    } finally {
      setDetailLoading(false)
    }
  }

  const handleCreate = async () => {
    try {
      const values = await createForm.validateFields()
      setSaving(true)
      await createCustomer(values)
      message.success('고객이 등록되었습니다.')
      setCreateModalOpen(false)
      createForm.resetFields()
      fetchCustomers(page, searchParams)
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setSaving(false)
    }
  }

  const handleUpdate = async () => {
    if (!selectedCustomer) return
    try {
      const values = await editForm.validateFields()
      setSaving(true)
      await updateCustomer(selectedCustomer.cust_no, values)
      message.success('고객 정보가 수정되었습니다.')
      setEditMode(false)
      openDetail(selectedCustomer.cust_no)
      fetchCustomers(page, searchParams)
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setSaving(false)
    }
  }

  const kycColumns: ColumnsType<KycRecord> = [
    { title: 'KYC ID', dataIndex: 'kyc_id', key: 'kyc_id', width: 120 },
    { title: 'KYC 유형', dataIndex: 'kyc_tp', key: 'kyc_tp' },
    {
      title: '상태',
      dataIndex: 'stat',
      key: 'stat',
      render: (v) => <StatusTag status={v} type="kyc" />,
    },
    { title: '수행일', dataIndex: 'perf_dt', key: 'perf_dt' },
    { title: '다음 KYC일', dataIndex: 'next_kyc_dt', key: 'next_kyc_dt' },
  ]

  const raColumns: ColumnsType<RaResult> = [
    { title: '평가일', dataIndex: 'eval_dt', key: 'eval_dt' },
    { title: '위험점수', dataIndex: 'risk_scr', key: 'risk_scr', render: (v) => `${v}점` },
    {
      title: '위험등급',
      dataIndex: 'risk_grd',
      key: 'risk_grd',
      render: (v) => <StatusTag status={v} type="risk" />,
    },
    {
      title: 'EDD 여부',
      dataIndex: 'edd_yn',
      key: 'edd_yn',
      render: (v) => (v === 'Y' ? <Tag color="red">예</Tag> : <Tag color="green">아니오</Tag>),
    },
    { title: '다음평가일', dataIndex: 'next_eval_dt', key: 'next_eval_dt' },
  ]

  const screenColumns: ColumnsType<ScreeningResult> = [
    { title: '워치리스트명', dataIndex: 'wl_nm', key: 'wl_nm' },
    {
      title: '일치도',
      dataIndex: 'match_scr',
      key: 'match_scr',
      render: (v) => `${v}%`,
    },
    {
      title: '결과',
      dataIndex: 'stat',
      key: 'stat',
      render: (v) => <StatusTag status={v} type="screening" />,
    },
    { title: '스크리닝일', dataIndex: 'scr_dt', key: 'scr_dt' },
  ]

  const columns: ColumnsType<Customer> = [
    { title: '고객번호', dataIndex: 'cust_no', key: 'cust_no', width: 120 },
    { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
    { title: '고객유형', dataIndex: 'cust_tp', key: 'cust_tp', width: 100 },
    { title: '국적', dataIndex: 'nationality', key: 'nationality', width: 80 },
    {
      title: '위험등급',
      dataIndex: 'risk_grd',
      key: 'risk_grd',
      width: 90,
      render: (v: string) => (
        <Tag color={riskGradeColor[v] || 'default'}>{riskGradeLabel[v] || v}</Tag>
      ),
    },
    {
      title: 'KYC 상태',
      dataIndex: 'kyc_stat',
      key: 'kyc_stat',
      render: (v) => <StatusTag status={v} type="kyc" />,
    },
    { title: '계좌개설일', dataIndex: 'acct_open_dt', key: 'acct_open_dt', width: 110 },
    {
      title: '액션',
      key: 'action',
      width: 80,
      render: (_, record) => (
        <Button
          size="small"
          icon={<EyeOutlined />}
          onClick={() => openDetail(record.cust_no)}
        >
          상세
        </Button>
      ),
    },
  ]

  return (
    <div>
      <PageHeader
        title="고객관리"
        actions={
          <Button
            type="primary"
            icon={<PlusOutlined />}
            onClick={() => setCreateModalOpen(true)}
          >
            신규등록
          </Button>
        }
      />

      <SearchForm
        form={searchForm}
        onSearch={handleSearch}
        onReset={handleReset}
        loading={loading}
      >
        <Form.Item name="cust_nm" label="고객명">
          <Input placeholder="고객명" style={{ width: 150 }} />
        </Form.Item>
        <Form.Item name="cust_tp" label="고객유형">
          <Select placeholder="전체" style={{ width: 120 }} allowClear>
            <Select.Option value="INDIVIDUAL">개인</Select.Option>
            <Select.Option value="CORPORATE">법인</Select.Option>
          </Select>
        </Form.Item>
        <Form.Item name="risk_grd" label="위험등급">
          <Select placeholder="전체" style={{ width: 110 }} allowClear>
            <Select.Option value="H">고위험</Select.Option>
            <Select.Option value="M">중위험</Select.Option>
            <Select.Option value="L">저위험</Select.Option>
          </Select>
        </Form.Item>
      </SearchForm>

      <Table
        dataSource={customers}
        columns={columns}
        rowKey="cust_no"
        loading={loading}
        pagination={{
          current: page,
          pageSize: 10,
          total,
          showTotal: (t) => `총 ${t}건`,
          onChange: (p) => {
            setPage(p)
            fetchCustomers(p, searchParams)
          },
        }}
        size="middle"
      />

      {/* 신규등록 Modal */}
      <Modal
        title="신규 고객 등록"
        open={createModalOpen}
        onOk={handleCreate}
        onCancel={() => {
          setCreateModalOpen(false)
          createForm.resetFields()
        }}
        confirmLoading={saving}
        width={600}
        okText="등록"
        cancelText="취소"
      >
        <Form form={createForm} layout="vertical" style={{ marginTop: 16 }}>
          <Space style={{ width: '100%' }} direction="vertical" size={0}>
            <div style={{ display: 'flex', gap: 16 }}>
              <Form.Item
                name="cust_nm"
                label="고객명"
                rules={[{ required: true, message: '고객명을 입력하세요' }]}
                style={{ flex: 1 }}
              >
                <Input />
              </Form.Item>
              <Form.Item
                name="cust_tp"
                label="고객유형"
                rules={[{ required: true, message: '고객유형을 선택하세요' }]}
                style={{ flex: 1 }}
              >
                <Select>
                  <Select.Option value="INDIVIDUAL">개인</Select.Option>
                  <Select.Option value="CORPORATE">법인</Select.Option>
                </Select>
              </Form.Item>
            </div>
            <div style={{ display: 'flex', gap: 16 }}>
              <Form.Item
                name="nationality"
                label="국적"
                rules={[{ required: true, message: '국적을 입력하세요' }]}
                style={{ flex: 1 }}
              >
                <Input placeholder="예: KR" />
              </Form.Item>
              <Form.Item
                name="risk_grd"
                label="위험등급"
                rules={[{ required: true, message: '위험등급을 선택하세요' }]}
                style={{ flex: 1 }}
              >
                <Select>
                  <Select.Option value="H">고위험</Select.Option>
                  <Select.Option value="M">중위험</Select.Option>
                  <Select.Option value="L">저위험</Select.Option>
                </Select>
              </Form.Item>
            </div>
            <div style={{ display: 'flex', gap: 16 }}>
              <Form.Item name="birth_dt" label="생년월일" style={{ flex: 1 }}>
                <Input placeholder="YYYY-MM-DD" />
              </Form.Item>
              <Form.Item name="id_tp" label="신분증유형" style={{ flex: 1 }}>
                <Select allowClear>
                  <Select.Option value="PASSPORT">여권</Select.Option>
                  <Select.Option value="ID_CARD">주민등록증</Select.Option>
                  <Select.Option value="DRIVER">운전면허증</Select.Option>
                </Select>
              </Form.Item>
            </div>
            <Form.Item name="id_no" label="신분증번호">
              <Input />
            </Form.Item>
            <Form.Item name="email" label="이메일">
              <Input />
            </Form.Item>
            <Form.Item name="phone" label="연락처">
              <Input />
            </Form.Item>
            <Form.Item name="address" label="주소">
              <Input />
            </Form.Item>
          </Space>
        </Form>
      </Modal>

      {/* 고객 상세 Modal */}
      <Modal
        title={`고객 상세 - ${selectedCustomer?.cust_nm || ''}`}
        open={detailModalOpen}
        onCancel={() => {
          setDetailModalOpen(false)
          setEditMode(false)
        }}
        width={800}
        footer={
          <Space>
            {editMode ? (
              <>
                <Button onClick={() => setEditMode(false)}>취소</Button>
                <Button type="primary" onClick={handleUpdate} loading={saving}>
                  저장
                </Button>
              </>
            ) : (
              <>
                <Button onClick={() => setEditMode(true)}>수정</Button>
                <Button onClick={() => setDetailModalOpen(false)}>닫기</Button>
              </>
            )}
          </Space>
        }
      >
        <Tabs
          items={[
            {
              key: 'basic',
              label: '기본정보',
              children: detailLoading ? null : editMode ? (
                <Form form={editForm} layout="vertical">
                  <div style={{ display: 'flex', gap: 16 }}>
                    <Form.Item name="cust_nm" label="고객명" style={{ flex: 1 }}>
                      <Input />
                    </Form.Item>
                    <Form.Item name="cust_tp" label="고객유형" style={{ flex: 1 }}>
                      <Select>
                        <Select.Option value="INDIVIDUAL">개인</Select.Option>
                        <Select.Option value="CORPORATE">법인</Select.Option>
                      </Select>
                    </Form.Item>
                  </div>
                  <div style={{ display: 'flex', gap: 16 }}>
                    <Form.Item name="nationality" label="국적" style={{ flex: 1 }}>
                      <Input />
                    </Form.Item>
                    <Form.Item name="risk_grd" label="위험등급" style={{ flex: 1 }}>
                      <Select>
                        <Select.Option value="H">고위험</Select.Option>
                        <Select.Option value="M">중위험</Select.Option>
                        <Select.Option value="L">저위험</Select.Option>
                      </Select>
                    </Form.Item>
                  </div>
                  <Form.Item name="email" label="이메일">
                    <Input />
                  </Form.Item>
                  <Form.Item name="phone" label="연락처">
                    <Input />
                  </Form.Item>
                  <Form.Item name="address" label="주소">
                    <Input />
                  </Form.Item>
                </Form>
              ) : (
                <Descriptions bordered column={2} size="small">
                  <Descriptions.Item label="고객번호">
                    {selectedCustomer?.cust_no}
                  </Descriptions.Item>
                  <Descriptions.Item label="고객명">
                    {selectedCustomer?.cust_nm}
                  </Descriptions.Item>
                  <Descriptions.Item label="고객유형">
                    {selectedCustomer?.cust_tp}
                  </Descriptions.Item>
                  <Descriptions.Item label="국적">
                    {selectedCustomer?.nationality}
                  </Descriptions.Item>
                  <Descriptions.Item label="위험등급">
                    {selectedCustomer && (
                      <Tag color={riskGradeColor[selectedCustomer.risk_grd]}>
                        {riskGradeLabel[selectedCustomer.risk_grd]}
                      </Tag>
                    )}
                  </Descriptions.Item>
                  <Descriptions.Item label="KYC 상태">
                    {selectedCustomer && (
                      <StatusTag status={selectedCustomer.kyc_stat} type="kyc" />
                    )}
                  </Descriptions.Item>
                  <Descriptions.Item label="계좌개설일">
                    {selectedCustomer?.acct_open_dt}
                  </Descriptions.Item>
                  <Descriptions.Item label="생년월일">
                    {selectedCustomer?.birth_dt}
                  </Descriptions.Item>
                  <Descriptions.Item label="이메일">
                    {selectedCustomer?.email}
                  </Descriptions.Item>
                  <Descriptions.Item label="연락처">
                    {selectedCustomer?.phone}
                  </Descriptions.Item>
                  <Descriptions.Item label="주소" span={2}>
                    {selectedCustomer?.address}
                  </Descriptions.Item>
                </Descriptions>
              ),
            },
            {
              key: 'kyc',
              label: 'KYC 이력',
              children: (
                <Table
                  dataSource={kycHistory}
                  columns={kycColumns}
                  rowKey="kyc_id"
                  size="small"
                  pagination={{ pageSize: 5 }}
                />
              ),
            },
            {
              key: 'ra',
              label: '위험평가 결과',
              children: (
                <Table
                  dataSource={raResults}
                  columns={raColumns}
                  rowKey="ra_id"
                  size="small"
                  pagination={{ pageSize: 5 }}
                />
              ),
            },
            {
              key: 'wl',
              label: '워치리스트 스크리닝',
              children: (
                <Table
                  dataSource={screenResults}
                  columns={screenColumns}
                  rowKey="scr_id"
                  size="small"
                  pagination={{ pageSize: 5 }}
                />
              ),
            },
          ]}
        />
      </Modal>
    </div>
  )
}
