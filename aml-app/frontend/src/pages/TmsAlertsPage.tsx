import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Tabs,
  Drawer,
  Descriptions,
  Progress,
  Select,
  message,
  Space,
  Typography,
  Divider,
  Form,
  Modal,
  Input,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import {
  getTmsAlerts,
  getTmsAlertDetail,
  getAlertTransactions,
  updateTmsAlert,
  createApproval,
} from '../api/tms'
import type { TmsAlert, TmsTransaction } from '../api/types'
import PageHeader from '../components/shared/PageHeader'
import StatusTag from '../components/shared/StatusTag'
import AmountDisplay from '../components/shared/AmountDisplay'

const { Text, Title } = Typography
const { TextArea } = Input

const STATUS_TABS = [
  { key: '', label: '전체' },
  { key: 'NEW', label: '신규' },
  { key: 'REVIEW', label: '검토중' },
  { key: 'CLOSED', label: '종결' },
]

const ANALYSTS = ['admin', 'analyst01', 'analyst02', 'analyst03']

export default function TmsAlertsPage() {
  const [activeTab, setActiveTab] = useState('')
  const [alerts, setAlerts] = useState<TmsAlert[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)

  const [drawerOpen, setDrawerOpen] = useState(false)
  const [selectedAlert, setSelectedAlert] = useState<TmsAlert | null>(null)
  const [transactions, setTransactions] = useState<TmsTransaction[]>([])
  const [drawerLoading, setDrawerLoading] = useState(false)
  const [updating, setUpdating] = useState(false)

  // Approval request modal
  const [apprModalOpen, setApprModalOpen] = useState(false)
  const [apprLoading, setApprLoading] = useState(false)
  const [apprForm] = Form.useForm<{ appr_title: string; appr_content: string }>()

  const fetchAlerts = useCallback(
    async (currentPage = 1, stat = activeTab) => {
      setLoading(true)
      try {
        const params: Record<string, string | number> = {
          page: currentPage,
          size: 10,
        }
        if (stat) params.stat = stat
        const res = await getTmsAlerts(params)
        setAlerts(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : 'TMS 알림 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [activeTab]
  )

  useEffect(() => {
    fetchAlerts(1, activeTab)
  }, [activeTab])

  const openDetail = async (alert: TmsAlert) => {
    setDrawerOpen(true)
    setDrawerLoading(true)
    try {
      const [detail, txs] = await Promise.all([
        getTmsAlertDetail(alert.alert_id),
        getAlertTransactions(alert.alert_id),
      ])
      setSelectedAlert(detail)
      setTransactions(txs)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '알림 상세 조회 실패')
    } finally {
      setDrawerLoading(false)
    }
  }

  const handleStatusChange = async (newStat: string) => {
    if (!selectedAlert) return
    setUpdating(true)
    try {
      const updated = await updateTmsAlert(selectedAlert.alert_id, { stat: newStat })
      setSelectedAlert(updated)
      message.success(`상태가 '${newStat}'로 변경되었습니다.`)
      fetchAlerts(page, activeTab)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '상태 변경 실패')
    } finally {
      setUpdating(false)
    }
  }

  const handleStrEscalate = async () => {
    if (!selectedAlert) return
    setUpdating(true)
    try {
      const updated = await updateTmsAlert(selectedAlert.alert_id, {
        stat: 'ESCALATED',
      })
      setSelectedAlert(updated)
      message.success('STR 전환 처리되었습니다. 케이스가 생성됩니다.')
      fetchAlerts(page, activeTab)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : 'STR 전환 실패')
    } finally {
      setUpdating(false)
    }
  }

  const openApprModal = () => {
    if (!selectedAlert) return
    apprForm.setFieldsValue({
      appr_title: `알림 결재 요청 - ${selectedAlert.alert_no}`,
      appr_content: `알림번호: ${selectedAlert.alert_no}\n고객명: ${selectedAlert.cust_nm}\n룰명: ${selectedAlert.rule_nm}`,
    })
    setApprModalOpen(true)
  }

  const handleApprModalOk = async () => {
    if (!selectedAlert) return
    let values: { appr_title: string; appr_content: string }
    try {
      values = await apprForm.validateFields()
    } catch {
      return
    }
    setApprLoading(true)
    try {
      await createApproval({
        appr_tp_cd: 'ALERT',
        ref_id: selectedAlert.alert_id,
        appr_title: values.appr_title,
        appr_content: values.appr_content,
        appr_st_cd: 'REQUESTED',
      })
      message.success('결재 요청이 생성되었습니다.')
      setApprModalOpen(false)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '결재 요청 생성 실패')
    } finally {
      setApprLoading(false)
    }
  }

  const handleAssignAnalyst = async (analyst: string) => {
    if (!selectedAlert) return
    setUpdating(true)
    try {
      const updated = await updateTmsAlert(selectedAlert.alert_id, { analyst })
      setSelectedAlert(updated)
      message.success(`담당자가 '${analyst}'로 변경되었습니다.`)
      fetchAlerts(page, activeTab)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '담당자 변경 실패')
    } finally {
      setUpdating(false)
    }
  }

  const txColumns: ColumnsType<TmsTransaction> = [
    { title: '거래일시', dataIndex: 'tx_dt', key: 'tx_dt', width: 160 },
    { title: '거래유형', dataIndex: 'tx_tp', key: 'tx_tp', width: 100 },
    {
      title: '거래금액',
      dataIndex: 'tx_amt',
      key: 'tx_amt',
      render: (v) => <AmountDisplay amount={v} />,
    },
    { title: '계좌번호', dataIndex: 'acct_no', key: 'acct_no' },
    { title: '거래상대방', dataIndex: 'counterparty', key: 'counterparty' },
  ]

  const columns: ColumnsType<TmsAlert> = [
    { title: '알림번호', dataIndex: 'alert_no', key: 'alert_no', width: 130 },
    { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
    { title: '룰명', dataIndex: 'rule_nm', key: 'rule_nm' },
    {
      title: '탐지금액',
      dataIndex: 'detect_amt',
      key: 'detect_amt',
      render: (v) => <AmountDisplay amount={v} />,
    },
    { title: '건수', dataIndex: 'detect_cnt', key: 'detect_cnt', width: 70 },
    {
      title: '위험점수',
      dataIndex: 'risk_scr',
      key: 'risk_scr',
      width: 130,
      render: (v: number) => (
        <Progress
          percent={v}
          size="small"
          strokeColor={v >= 80 ? '#ff4d4f' : v >= 50 ? '#fa8c16' : '#52c41a'}
          format={(p) => `${p}점`}
        />
      ),
    },
    {
      title: '상태',
      dataIndex: 'stat',
      key: 'stat',
      render: (v) => <StatusTag status={v} type="alert" />,
    },
    { title: '담당자', dataIndex: 'analyst', key: 'analyst', width: 100 },
    { title: '등록일', dataIndex: 'reg_dt', key: 'reg_dt', width: 110 },
  ]

  return (
    <div>
      <PageHeader title="TMS 거래모니터링" />

      <Tabs
        activeKey={activeTab}
        onChange={(key) => {
          setActiveTab(key)
          setPage(1)
        }}
        items={STATUS_TABS.map((t) => ({ key: t.key, label: t.label }))}
        style={{ marginBottom: 16 }}
      />

      <Table
        dataSource={alerts}
        columns={columns}
        rowKey="alert_id"
        loading={loading}
        pagination={{
          current: page,
          pageSize: 10,
          total,
          showTotal: (t) => `총 ${t}건`,
          onChange: (p) => {
            setPage(p)
            fetchAlerts(p, activeTab)
          },
        }}
        onRow={(record) => ({
          onClick: () => openDetail(record),
          style: { cursor: 'pointer' },
        })}
        size="middle"
      />

      <Drawer
        title={`알림 상세 - ${selectedAlert?.alert_no || ''}`}
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        width={700}
        loading={drawerLoading}
      >
        {selectedAlert && (
          <>
            <Descriptions bordered column={2} size="small">
              <Descriptions.Item label="알림번호">
                {selectedAlert.alert_no}
              </Descriptions.Item>
              <Descriptions.Item label="상태">
                <StatusTag status={selectedAlert.stat} type="alert" />
              </Descriptions.Item>
              <Descriptions.Item label="고객번호">
                {selectedAlert.cust_no}
              </Descriptions.Item>
              <Descriptions.Item label="고객명">
                {selectedAlert.cust_nm}
              </Descriptions.Item>
              <Descriptions.Item label="룰명" span={2}>
                {selectedAlert.rule_nm}
              </Descriptions.Item>
              <Descriptions.Item label="탐지금액">
                <AmountDisplay amount={selectedAlert.detect_amt} />
              </Descriptions.Item>
              <Descriptions.Item label="탐지건수">
                {selectedAlert.detect_cnt}건
              </Descriptions.Item>
              <Descriptions.Item label="위험점수">
                <Progress
                  percent={selectedAlert.risk_scr}
                  size="small"
                  strokeColor={
                    selectedAlert.risk_scr >= 80
                      ? '#ff4d4f'
                      : selectedAlert.risk_scr >= 50
                      ? '#fa8c16'
                      : '#52c41a'
                  }
                />
              </Descriptions.Item>
              <Descriptions.Item label="담당자">
                {selectedAlert.analyst}
              </Descriptions.Item>
              <Descriptions.Item label="등록일" span={2}>
                {selectedAlert.reg_dt}
              </Descriptions.Item>
            </Descriptions>

            <Divider />

            <div style={{ marginBottom: 16 }}>
              <Title level={5}>담당자 지정</Title>
              <Select
                value={selectedAlert.analyst || undefined}
                onChange={handleAssignAnalyst}
                style={{ width: 200 }}
                placeholder="담당자 선택"
                loading={updating}
              >
                {ANALYSTS.map((a) => (
                  <Select.Option key={a} value={a}>
                    {a}
                  </Select.Option>
                ))}
              </Select>
            </div>

            <div style={{ marginBottom: 16 }}>
              <Title level={5}>상태 변경</Title>
              <Space wrap>
                <Button
                  onClick={() => handleStatusChange('REVIEW')}
                  disabled={selectedAlert.stat === 'REVIEW' || selectedAlert.stat === 'CLOSED'}
                  loading={updating}
                >
                  검토중으로 변경
                </Button>
                <Button
                  type="primary"
                  danger
                  onClick={handleStrEscalate}
                  disabled={selectedAlert.stat === 'CLOSED' || selectedAlert.stat === 'ESCALATED'}
                  loading={updating}
                >
                  STR 전환
                </Button>
                <Button
                  onClick={() => handleStatusChange('CLOSED')}
                  disabled={selectedAlert.stat === 'CLOSED'}
                  loading={updating}
                >
                  종결
                </Button>
                <Button
                  type="dashed"
                  onClick={openApprModal}
                  disabled={selectedAlert.stat === 'CLOSED'}
                >
                  결재 요청
                </Button>
              </Space>
            </div>

            <Divider />

            <Title level={5}>매칭 거래 내역</Title>
            <Table
              dataSource={transactions}
              columns={txColumns}
              rowKey="tx_id"
              size="small"
              pagination={{ pageSize: 5 }}
            />
          </>
        )}
      </Drawer>

      <Modal
        title="결재 요청 생성"
        open={apprModalOpen}
        onOk={handleApprModalOk}
        onCancel={() => setApprModalOpen(false)}
        confirmLoading={apprLoading}
        okText="결재 요청"
        cancelText="취소"
        destroyOnClose
      >
        <Form form={apprForm} layout="vertical" style={{ marginTop: 16 }}>
          <Form.Item
            name="appr_title"
            label="결재제목"
            rules={[{ required: true, message: '결재제목을 입력하세요.' }]}
          >
            <Input />
          </Form.Item>
          <Form.Item name="appr_content" label="결재내용">
            <TextArea rows={4} />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  )
}
