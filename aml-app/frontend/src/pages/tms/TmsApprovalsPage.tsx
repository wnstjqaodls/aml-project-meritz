import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Tag,
  Select,
  Space,
  Tabs,
  Drawer,
  Descriptions,
  Button,
  Form,
  Input,
  Divider,
  message,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import {
  getApprovals,
  getApproval,
  approveApproval,
  rejectApproval,
} from '../../api/tms'
import type { TmsAppr } from '../../api/types'
import PageHeader from '../../components/shared/PageHeader'

const { Text } = Typography
const { TextArea } = Input

const STATUS_TABS = [
  { key: '', label: '전체' },
  { key: 'REQUESTED', label: '대기중' },
  { key: 'APPROVED', label: '승인' },
  { key: 'REJECTED', label: '반려' },
]

const APPR_TYPE_OPTIONS = [
  { value: '', label: '전체 유형' },
  { value: 'SCENARIO', label: '시나리오' },
  { value: 'SETVAL', label: '임계값' },
]

function ApprStatusTag({ status }: { status: string }) {
  const map: Record<string, { color: string; label: string }> = {
    REQUESTED: { color: 'orange', label: '대기중' },
    APPROVED: { color: 'green', label: '승인' },
    REJECTED: { color: 'red', label: '반려' },
  }
  const info = map[status]
  if (!info) return <Tag>{status}</Tag>
  return <Tag color={info.color}>{info.label}</Tag>
}

function ApprTypeTag({ tp }: { tp: string }) {
  const map: Record<string, { color: string; label: string }> = {
    SCENARIO: { color: 'purple', label: '시나리오' },
    SETVAL: { color: 'cyan', label: '임계값' },
  }
  const info = map[tp]
  if (!info) return <Tag>{tp}</Tag>
  return <Tag color={info.color}>{info.label}</Tag>
}

export default function TmsApprovalsPage() {
  const [activeTab, setActiveTab] = useState('')
  const [filterType, setFilterType] = useState('')
  const [data, setData] = useState<TmsAppr[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)

  const [drawerOpen, setDrawerOpen] = useState(false)
  const [selectedAppr, setSelectedAppr] = useState<TmsAppr | null>(null)
  const [drawerLoading, setDrawerLoading] = useState(false)
  const [actionLoading, setActionLoading] = useState(false)

  const [approveForm] = Form.useForm<{ appr_cmnt: string }>()
  const [rejectForm] = Form.useForm<{ reject_rsn: string }>()

  const fetchData = useCallback(
    async (currentPage = 1) => {
      setLoading(true)
      try {
        const params: Record<string, unknown> = {
          page: currentPage,
          size: 20,
        }
        if (activeTab) params.appr_st_cd = activeTab
        if (filterType) params.appr_tp_cd = filterType
        const res = await getApprovals(params)
        setData(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : '결재 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [activeTab, filterType]
  )

  useEffect(() => {
    setPage(1)
    fetchData(1)
  }, [activeTab, filterType])

  const openDetail = async (record: TmsAppr) => {
    setDrawerOpen(true)
    setDrawerLoading(true)
    approveForm.resetFields()
    rejectForm.resetFields()
    try {
      const detail = await getApproval(record.appr_id)
      setSelectedAppr(detail)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '결재 상세 조회 실패')
    } finally {
      setDrawerLoading(false)
    }
  }

  const handleApprove = async () => {
    if (!selectedAppr) return
    let values: { appr_cmnt: string }
    try {
      values = await approveForm.validateFields()
    } catch {
      return
    }
    setActionLoading(true)
    try {
      const updated = await approveApproval(selectedAppr.appr_id, {
        appr_cmnt: values.appr_cmnt,
      })
      setSelectedAppr(updated)
      message.success('승인 처리되었습니다.')
      fetchData(page)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '승인 처리 실패')
    } finally {
      setActionLoading(false)
    }
  }

  const handleReject = async () => {
    if (!selectedAppr) return
    let values: { reject_rsn: string }
    try {
      values = await rejectForm.validateFields()
    } catch {
      return
    }
    setActionLoading(true)
    try {
      const updated = await rejectApproval(selectedAppr.appr_id, {
        reject_rsn: values.reject_rsn,
      })
      setSelectedAppr(updated)
      message.success('반려 처리되었습니다.')
      fetchData(page)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '반려 처리 실패')
    } finally {
      setActionLoading(false)
    }
  }

  const isActionable =
    selectedAppr?.appr_st_cd === 'REQUESTED'

  const columns: ColumnsType<TmsAppr> = [
    {
      title: '결재번호',
      dataIndex: 'appr_no',
      key: 'appr_no',
      width: 130,
    },
    {
      title: '결재유형',
      dataIndex: 'appr_tp_cd',
      key: 'appr_tp_cd',
      width: 100,
      render: (v) => <ApprTypeTag tp={v} />,
    },
    {
      title: '참조ID',
      dataIndex: 'ref_id',
      key: 'ref_id',
      width: 130,
      render: (v) => v || '-',
    },
    {
      title: '결재제목',
      dataIndex: 'appr_title',
      key: 'appr_title',
    },
    {
      title: '요청자',
      dataIndex: 'req_id',
      key: 'req_id',
      width: 100,
      render: (v) => v || '-',
    },
    {
      title: '요청일시',
      dataIndex: 'req_dt',
      key: 'req_dt',
      width: 150,
      render: (v) => v || '-',
    },
    {
      title: '결재자',
      dataIndex: 'appr_usr_id',
      key: 'appr_usr_id',
      width: 100,
      render: (v) => v || '-',
    },
    {
      title: '결재일시',
      dataIndex: 'appr_dt',
      key: 'appr_dt',
      width: 150,
      render: (v) => v || '-',
    },
    {
      title: '상태',
      dataIndex: 'appr_st_cd',
      key: 'appr_st_cd',
      width: 90,
      render: (v) => <ApprStatusTag status={v} />,
    },
  ]

  return (
    <div>
      <PageHeader
        title="TMS 결재"
        subtitle="시나리오 및 임계값 변경 결재 처리"
      />

      <Space style={{ marginBottom: 8 }}>
        <Select
          value={filterType}
          onChange={(v) => setFilterType(v)}
          options={APPR_TYPE_OPTIONS}
          style={{ width: 140 }}
        />
      </Space>

      <Tabs
        activeKey={activeTab}
        onChange={(key) => {
          setActiveTab(key)
          setPage(1)
        }}
        items={STATUS_TABS.map((t) => ({ key: t.key, label: t.label }))}
        style={{ marginBottom: 8 }}
      />

      <Table
        dataSource={data}
        columns={columns}
        rowKey="appr_id"
        loading={loading}
        size="middle"
        onRow={(record) => ({
          onClick: () => openDetail(record),
          style: { cursor: 'pointer' },
        })}
        pagination={{
          current: page,
          pageSize: 20,
          total,
          showTotal: (t) => `총 ${t}건`,
          showSizeChanger: false,
          onChange: (p) => {
            setPage(p)
            fetchData(p)
          },
        }}
      />

      <Drawer
        title={`결재 상세 - ${selectedAppr?.appr_no || ''}`}
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        width={680}
        loading={drawerLoading}
      >
        {selectedAppr && (
          <>
            <Descriptions bordered column={2} size="small">
              <Descriptions.Item label="결재번호">
                {selectedAppr.appr_no}
              </Descriptions.Item>
              <Descriptions.Item label="상태">
                <ApprStatusTag status={selectedAppr.appr_st_cd} />
              </Descriptions.Item>
              <Descriptions.Item label="결재유형">
                <ApprTypeTag tp={selectedAppr.appr_tp_cd} />
              </Descriptions.Item>
              <Descriptions.Item label="참조ID">
                {selectedAppr.ref_id || '-'}
              </Descriptions.Item>
              <Descriptions.Item label="결재제목" span={2}>
                {selectedAppr.appr_title}
              </Descriptions.Item>
              {selectedAppr.appr_content && (
                <Descriptions.Item label="결재내용" span={2}>
                  <Text style={{ whiteSpace: 'pre-wrap' }}>
                    {selectedAppr.appr_content}
                  </Text>
                </Descriptions.Item>
              )}
              <Descriptions.Item label="요청자">
                {selectedAppr.req_id || '-'}
              </Descriptions.Item>
              <Descriptions.Item label="요청일시">
                {selectedAppr.req_dt || '-'}
              </Descriptions.Item>
              <Descriptions.Item label="결재자">
                {selectedAppr.appr_usr_id || '-'}
              </Descriptions.Item>
              <Descriptions.Item label="결재일시">
                {selectedAppr.appr_dt || '-'}
              </Descriptions.Item>
              {selectedAppr.appr_cmnt && (
                <Descriptions.Item label="결재의견" span={2}>
                  {selectedAppr.appr_cmnt}
                </Descriptions.Item>
              )}
              {selectedAppr.reject_rsn && (
                <Descriptions.Item label="반려사유" span={2}>
                  <Text type="danger">{selectedAppr.reject_rsn}</Text>
                </Descriptions.Item>
              )}
            </Descriptions>

            {isActionable && (
              <>
                <Divider />

                <div style={{ marginBottom: 24 }}>
                  <Text strong style={{ fontSize: 14 }}>
                    승인 처리
                  </Text>
                  <Form
                    form={approveForm}
                    layout="vertical"
                    style={{ marginTop: 8 }}
                  >
                    <Form.Item name="appr_cmnt" label="결재의견">
                      <TextArea rows={3} placeholder="결재 의견을 입력하세요. (선택)" />
                    </Form.Item>
                  </Form>
                  <Button
                    type="primary"
                    onClick={handleApprove}
                    loading={actionLoading}
                    style={{ marginRight: 8 }}
                  >
                    승인
                  </Button>
                </div>

                <Divider dashed />

                <div>
                  <Text strong style={{ fontSize: 14 }}>
                    반려 처리
                  </Text>
                  <Form
                    form={rejectForm}
                    layout="vertical"
                    style={{ marginTop: 8 }}
                  >
                    <Form.Item
                      name="reject_rsn"
                      label="반려사유"
                      rules={[
                        { required: true, message: '반려 시 사유를 입력하세요.' },
                      ]}
                    >
                      <TextArea rows={3} placeholder="반려 사유를 입력하세요." />
                    </Form.Item>
                  </Form>
                  <Button
                    danger
                    onClick={handleReject}
                    loading={actionLoading}
                  >
                    반려
                  </Button>
                </div>
              </>
            )}

            {!isActionable && (
              <>
                <Divider />
                <Text type="secondary">
                  이미 처리된 결재건입니다. (
                  <ApprStatusTag status={selectedAppr.appr_st_cd} />)
                </Text>
              </>
            )}
          </>
        )}
      </Drawer>
    </div>
  )
}
