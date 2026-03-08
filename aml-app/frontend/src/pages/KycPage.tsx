import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Form,
  Input,
  Select,
  Modal,
  Descriptions,
  message,
  Tag,
  Space,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { PlusOutlined } from '@ant-design/icons'
import { getKycList, createKyc, updateKyc } from '../api/kyc'
import type { KycRecord } from '../api/types'
import PageHeader from '../components/shared/PageHeader'
import SearchForm from '../components/shared/SearchForm'
import StatusTag from '../components/shared/StatusTag'

const kycTypeOptions = [
  { value: 'INITIAL', label: '최초' },
  { value: 'PERIODIC', label: '정기' },
  { value: 'TRIGGERED', label: '이벤트' },
  { value: 'EDD', label: 'EDD' },
]

const idTypeOptions = [
  { value: 'PASSPORT', label: '여권' },
  { value: 'ID_CARD', label: '주민등록증' },
  { value: 'DRIVER', label: '운전면허증' },
  { value: 'BUSINESS_REG', label: '사업자등록증' },
]

export default function KycPage() {
  const [searchForm] = Form.useForm()
  const [kycForm] = Form.useForm()

  const [records, setRecords] = useState<KycRecord[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [searchParams, setSearchParams] = useState<Record<string, string>>({})

  const [modalOpen, setModalOpen] = useState(false)
  const [editRecord, setEditRecord] = useState<KycRecord | null>(null)
  const [saving, setSaving] = useState(false)

  const fetchRecords = useCallback(
    async (currentPage = 1, params = searchParams) => {
      setLoading(true)
      try {
        const res = await getKycList({ ...params, page: currentPage, size: 10 })
        setRecords(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : 'KYC 목록 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [searchParams]
  )

  useEffect(() => {
    fetchRecords(1, {})
  }, [])

  const handleSearch = () => {
    const values = searchForm.getFieldsValue()
    const params: Record<string, string> = {}
    if (values.stat) params.stat = values.stat
    if (values.cust_no) params.cust_no = values.cust_no
    setSearchParams(params)
    setPage(1)
    fetchRecords(1, params)
  }

  const handleReset = () => {
    setSearchParams({})
    setPage(1)
    fetchRecords(1, {})
  }

  const openCreate = () => {
    setEditRecord(null)
    kycForm.resetFields()
    setModalOpen(true)
  }

  const openEdit = (record: KycRecord) => {
    setEditRecord(record)
    kycForm.setFieldsValue(record)
    setModalOpen(true)
  }

  const handleSave = async () => {
    try {
      const values = await kycForm.validateFields()
      setSaving(true)
      if (editRecord) {
        await updateKyc(editRecord.kyc_id, values)
        message.success('KYC 정보가 수정되었습니다.')
      } else {
        await createKyc(values)
        message.success('KYC가 등록되었습니다.')
      }
      setModalOpen(false)
      kycForm.resetFields()
      fetchRecords(page, searchParams)
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setSaving(false)
    }
  }

  const columns: ColumnsType<KycRecord> = [
    { title: 'KYC ID', dataIndex: 'kyc_id', key: 'kyc_id', width: 130 },
    { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
    {
      title: 'KYC 유형',
      dataIndex: 'kyc_tp',
      key: 'kyc_tp',
      render: (v) => kycTypeOptions.find((o) => o.value === v)?.label || v,
    },
    {
      title: '상태',
      dataIndex: 'stat',
      key: 'stat',
      render: (v) => <StatusTag status={v} type="kyc" />,
    },
    {
      title: '신분증유형',
      dataIndex: 'id_tp',
      key: 'id_tp',
      render: (v) => idTypeOptions.find((o) => o.value === v)?.label || v,
    },
    {
      title: 'PEP 여부',
      dataIndex: 'pep_yn',
      key: 'pep_yn',
      render: (v) =>
        v === 'Y' ? (
          <Tag color="red">PEP</Tag>
        ) : (
          <Tag color="green">해당없음</Tag>
        ),
    },
    { title: '수행일', dataIndex: 'perf_dt', key: 'perf_dt', width: 110 },
    { title: '다음 KYC일', dataIndex: 'next_kyc_dt', key: 'next_kyc_dt', width: 110 },
    {
      title: '액션',
      key: 'action',
      width: 70,
      render: (_, record) => (
        <Button size="small" onClick={() => openEdit(record)}>
          수정
        </Button>
      ),
    },
  ]

  return (
    <div>
      <PageHeader
        title="KYC 고객확인"
        actions={
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            신규 KYC
          </Button>
        }
      />

      <SearchForm
        form={searchForm}
        onSearch={handleSearch}
        onReset={handleReset}
        loading={loading}
      >
        <Form.Item name="stat" label="KYC 상태">
          <Select placeholder="전체" style={{ width: 140 }} allowClear>
            <Select.Option value="PENDING">대기</Select.Option>
            <Select.Option value="IN_PROGRESS">진행중</Select.Option>
            <Select.Option value="COMPLETE">완료</Select.Option>
            <Select.Option value="EXPIRED">만료</Select.Option>
            <Select.Option value="REJECTED">거부</Select.Option>
          </Select>
        </Form.Item>
        <Form.Item name="cust_no" label="고객번호">
          <Input placeholder="고객번호" style={{ width: 150 }} />
        </Form.Item>
      </SearchForm>

      <Table
        dataSource={records}
        columns={columns}
        rowKey="kyc_id"
        loading={loading}
        pagination={{
          current: page,
          pageSize: 10,
          total,
          showTotal: (t) => `총 ${t}건`,
          onChange: (p) => {
            setPage(p)
            fetchRecords(p, searchParams)
          },
        }}
        onRow={(record) => ({
          onClick: () => openEdit(record),
          style: { cursor: 'pointer' },
        })}
        size="middle"
      />

      <Modal
        title={editRecord ? 'KYC 수정' : '신규 KYC 등록'}
        open={modalOpen}
        onOk={handleSave}
        onCancel={() => {
          setModalOpen(false)
          kycForm.resetFields()
        }}
        confirmLoading={saving}
        width={600}
        okText={editRecord ? '저장' : '등록'}
        cancelText="취소"
      >
        <Form form={kycForm} layout="vertical" style={{ marginTop: 16 }}>
          <div style={{ display: 'flex', gap: 16 }}>
            <Form.Item
              name="cust_no"
              label="고객번호"
              rules={[{ required: true, message: '고객번호를 입력하세요' }]}
              style={{ flex: 1 }}
            >
              <Input disabled={!!editRecord} />
            </Form.Item>
            <Form.Item
              name="kyc_tp"
              label="KYC 유형"
              rules={[{ required: true, message: 'KYC 유형을 선택하세요' }]}
              style={{ flex: 1 }}
            >
              <Select options={kycTypeOptions} />
            </Form.Item>
          </div>
          <div style={{ display: 'flex', gap: 16 }}>
            <Form.Item
              name="stat"
              label="상태"
              rules={[{ required: true, message: '상태를 선택하세요' }]}
              style={{ flex: 1 }}
            >
              <Select>
                <Select.Option value="PENDING">대기</Select.Option>
                <Select.Option value="IN_PROGRESS">진행중</Select.Option>
                <Select.Option value="COMPLETE">완료</Select.Option>
                <Select.Option value="EXPIRED">만료</Select.Option>
                <Select.Option value="REJECTED">거부</Select.Option>
              </Select>
            </Form.Item>
            <Form.Item
              name="id_tp"
              label="신분증유형"
              rules={[{ required: true, message: '신분증유형을 선택하세요' }]}
              style={{ flex: 1 }}
            >
              <Select options={idTypeOptions} />
            </Form.Item>
          </div>
          <div style={{ display: 'flex', gap: 16 }}>
            <Form.Item
              name="pep_yn"
              label="PEP 여부"
              rules={[{ required: true }]}
              style={{ flex: 1 }}
              initialValue="N"
            >
              <Select>
                <Select.Option value="Y">예 (PEP)</Select.Option>
                <Select.Option value="N">아니오</Select.Option>
              </Select>
            </Form.Item>
            <Form.Item name="perf_dt" label="수행일" style={{ flex: 1 }}>
              <Input placeholder="YYYY-MM-DD" />
            </Form.Item>
          </div>
          <Form.Item name="next_kyc_dt" label="다음 KYC 예정일">
            <Input placeholder="YYYY-MM-DD" />
          </Form.Item>
          <Form.Item name="rmk" label="비고">
            <Input.TextArea rows={3} />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  )
}
