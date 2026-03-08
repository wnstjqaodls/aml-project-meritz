import { useEffect, useState, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Table,
  Button,
  Form,
  Input,
  Select,
  Modal,
  message,
  Tag,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { PlusOutlined, EyeOutlined } from '@ant-design/icons'
import { getCases, createCase } from '../api/cases'
import type { Case } from '../api/types'
import PageHeader from '../components/shared/PageHeader'
import SearchForm from '../components/shared/SearchForm'
import StatusTag from '../components/shared/StatusTag'

const priorityColor: Record<string, string> = {
  HIGH: 'red',
  MEDIUM: 'orange',
  LOW: 'blue',
}
const priorityLabel: Record<string, string> = {
  HIGH: '높음',
  MEDIUM: '중간',
  LOW: '낮음',
}

const CASE_TYPES = ['STR', 'CTR', 'PEP', 'SANCTION', 'INTERNAL', 'REGULATORY']
const ANALYSTS = ['admin', 'analyst01', 'analyst02', 'analyst03']

export default function CasesPage() {
  const [searchForm] = Form.useForm()
  const [createForm] = Form.useForm()
  const navigate = useNavigate()

  const [cases, setCases] = useState<Case[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [searchParams, setSearchParams] = useState<Record<string, string>>({})
  const [createModalOpen, setCreateModalOpen] = useState(false)
  const [saving, setSaving] = useState(false)

  const fetchCases = useCallback(
    async (currentPage = 1, params = searchParams) => {
      setLoading(true)
      try {
        const res = await getCases({ ...params, page: currentPage, size: 10 })
        setCases(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : '케이스 목록 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [searchParams]
  )

  useEffect(() => {
    fetchCases(1, {})
  }, [])

  const handleSearch = () => {
    const values = searchForm.getFieldsValue()
    const params: Record<string, string> = {}
    if (values.case_tp) params.case_tp = values.case_tp
    if (values.stat) params.stat = values.stat
    if (values.analyst) params.analyst = values.analyst
    setSearchParams(params)
    setPage(1)
    fetchCases(1, params)
  }

  const handleReset = () => {
    setSearchParams({})
    setPage(1)
    fetchCases(1, {})
  }

  const handleCreate = async () => {
    try {
      const values = await createForm.validateFields()
      setSaving(true)
      const newCase = await createCase(values)
      message.success('케이스가 생성되었습니다.')
      setCreateModalOpen(false)
      createForm.resetFields()
      navigate(`/cases/${newCase.case_id}`)
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setSaving(false)
    }
  }

  const columns: ColumnsType<Case> = [
    { title: '케이스번호', dataIndex: 'case_no', key: 'case_no', width: 140 },
    { title: '케이스유형', dataIndex: 'case_tp', key: 'case_tp', width: 100 },
    { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
    {
      title: '우선순위',
      dataIndex: 'priority',
      key: 'priority',
      width: 90,
      render: (v: string) => (
        <Tag color={priorityColor[v] || 'default'}>{priorityLabel[v] || v}</Tag>
      ),
    },
    {
      title: '상태',
      dataIndex: 'stat',
      key: 'stat',
      render: (v) => <StatusTag status={v} type="case" />,
    },
    { title: '담당자', dataIndex: 'analyst', key: 'analyst', width: 100 },
    { title: '개시일', dataIndex: 'open_dt', key: 'open_dt', width: 110 },
    {
      title: '액션',
      key: 'action',
      width: 80,
      render: (_, record) => (
        <Button
          size="small"
          icon={<EyeOutlined />}
          onClick={(e) => {
            e.stopPropagation()
            navigate(`/cases/${record.case_id}`)
          }}
        >
          상세
        </Button>
      ),
    },
  ]

  return (
    <div>
      <PageHeader
        title="케이스관리"
        actions={
          <Button
            type="primary"
            icon={<PlusOutlined />}
            onClick={() => setCreateModalOpen(true)}
          >
            신규 케이스
          </Button>
        }
      />

      <SearchForm
        form={searchForm}
        onSearch={handleSearch}
        onReset={handleReset}
        loading={loading}
      >
        <Form.Item name="case_tp" label="케이스유형">
          <Select placeholder="전체" style={{ width: 130 }} allowClear>
            {CASE_TYPES.map((t) => (
              <Select.Option key={t} value={t}>
                {t}
              </Select.Option>
            ))}
          </Select>
        </Form.Item>
        <Form.Item name="stat" label="상태">
          <Select placeholder="전체" style={{ width: 120 }} allowClear>
            <Select.Option value="OPEN">진행중</Select.Option>
            <Select.Option value="REVIEW">검토중</Select.Option>
            <Select.Option value="CLOSED">종결</Select.Option>
            <Select.Option value="ESCALATED">상향</Select.Option>
            <Select.Option value="REPORTED">보고완료</Select.Option>
          </Select>
        </Form.Item>
        <Form.Item name="analyst" label="담당자">
          <Select placeholder="전체" style={{ width: 130 }} allowClear>
            {ANALYSTS.map((a) => (
              <Select.Option key={a} value={a}>
                {a}
              </Select.Option>
            ))}
          </Select>
        </Form.Item>
      </SearchForm>

      <Table
        dataSource={cases}
        columns={columns}
        rowKey="case_id"
        loading={loading}
        pagination={{
          current: page,
          pageSize: 10,
          total,
          showTotal: (t) => `총 ${t}건`,
          onChange: (p) => {
            setPage(p)
            fetchCases(p, searchParams)
          },
        }}
        onRow={(record) => ({
          onClick: () => navigate(`/cases/${record.case_id}`),
          style: { cursor: 'pointer' },
        })}
        size="middle"
      />

      <Modal
        title="신규 케이스 생성"
        open={createModalOpen}
        onOk={handleCreate}
        onCancel={() => {
          setCreateModalOpen(false)
          createForm.resetFields()
        }}
        confirmLoading={saving}
        width={560}
        okText="생성"
        cancelText="취소"
      >
        <Form form={createForm} layout="vertical" style={{ marginTop: 16 }}>
          <div style={{ display: 'flex', gap: 16 }}>
            <Form.Item
              name="cust_no"
              label="고객번호"
              rules={[{ required: true, message: '고객번호를 입력하세요' }]}
              style={{ flex: 1 }}
            >
              <Input />
            </Form.Item>
            <Form.Item
              name="case_tp"
              label="케이스유형"
              rules={[{ required: true, message: '케이스유형을 선택하세요' }]}
              style={{ flex: 1 }}
            >
              <Select>
                {CASE_TYPES.map((t) => (
                  <Select.Option key={t} value={t}>
                    {t}
                  </Select.Option>
                ))}
              </Select>
            </Form.Item>
          </div>
          <div style={{ display: 'flex', gap: 16 }}>
            <Form.Item
              name="priority"
              label="우선순위"
              rules={[{ required: true, message: '우선순위를 선택하세요' }]}
              style={{ flex: 1 }}
            >
              <Select>
                <Select.Option value="HIGH">높음</Select.Option>
                <Select.Option value="MEDIUM">중간</Select.Option>
                <Select.Option value="LOW">낮음</Select.Option>
              </Select>
            </Form.Item>
            <Form.Item name="analyst" label="담당자" style={{ flex: 1 }}>
              <Select allowClear>
                {ANALYSTS.map((a) => (
                  <Select.Option key={a} value={a}>
                    {a}
                  </Select.Option>
                ))}
              </Select>
            </Form.Item>
          </div>
          <Form.Item name="desc" label="내용">
            <Input.TextArea rows={4} />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  )
}
