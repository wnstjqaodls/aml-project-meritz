import { useCallback, useEffect, useState } from 'react'
import {
  Button,
  Col,
  DatePicker,
  Descriptions,
  Divider,
  Drawer,
  message,
  Modal,
  Row,
  Space,
  Steps,
  Table,
  Tabs,
  Tag,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import dayjs from 'dayjs'
import { ctrApi } from '../../api/str'
import type { CtrCase, CtrCaseDetail, StrTransaction, StrAmount, StrApproval } from '../../api/str'
import AmountDisplay from '../../components/shared/AmountDisplay'
import PageHeader from '../../components/shared/PageHeader'

const { RangePicker } = DatePicker
const { Text } = Typography

function formatDate(v: string): string {
  if (!v || v.length !== 8) return v || '-'
  return `${v.slice(0, 4)}-${v.slice(4, 6)}-${v.slice(6, 8)}`
}

function formatDateTime(dt: string, tm?: string): string {
  const d = formatDate(dt)
  if (!tm) return d
  const t = tm.length >= 6 ? `${tm.slice(0, 2)}:${tm.slice(2, 4)}:${tm.slice(4, 6)}` : tm
  return `${d} ${t}`
}

function StatusBadge({ code }: { code: string }) {
  const map: Record<string, { color: string; label: string }> = {
    '9': { color: 'orange', label: '대기' },
    '97': { color: 'blue', label: '검토중' },
    '98': { color: 'green', label: '결재완료' },
    '10': { color: 'purple', label: 'FIU제출' },
  }
  const info = map[code] ?? { color: 'default', label: code }
  return <Tag color={info.color}>{info.label}</Tag>
}

const GENDER_MAP: Record<string, string> = { M: '남성', F: '여성' }
const CORP_MAP: Record<string, string> = { I: '개인', C: '법인' }

interface DetailDrawerProps {
  open: boolean
  sspsDlCrtDt: string
  sspsDlId: string
  onClose: (refreshNeeded?: boolean) => void
}

function CtrDetailDrawer({ open, sspsDlCrtDt, sspsDlId, onClose }: DetailDrawerProps) {
  const [detail, setDetail] = useState<CtrCaseDetail | null>(null)
  const [loading, setLoading] = useState(false)
  const [activeTab, setActiveTab] = useState('party')
  const [fiuConfirmOpen, setFiuConfirmOpen] = useState(false)
  const [fiuSubmitting, setFiuSubmitting] = useState(false)

  const fetchDetail = async () => {
    setLoading(true)
    try {
      const res = await ctrApi.getDetail(sspsDlCrtDt, sspsDlId)
      setDetail(res.data.data)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : 'CTR 상세 조회 실패')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    if (open) {
      setActiveTab('party')
      fetchDetail()
    }
  }, [open, sspsDlCrtDt, sspsDlId])

  const handleSubmitFiu = async () => {
    setFiuSubmitting(true)
    try {
      await ctrApi.submitFiu(sspsDlCrtDt, sspsDlId)
      message.success('FIU에 제출되었습니다.')
      setFiuConfirmOpen(false)
      await fetchDetail()
      onClose(true)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : 'FIU 제출 실패')
    } finally {
      setFiuSubmitting(false)
    }
  }

  const txColumns: ColumnsType<StrTransaction> = [
    { title: '순번', dataIndex: 'seqNo', key: 'seqNo', width: 60, align: 'center' },
    { title: '지점코드', dataIndex: 'mnDlBrnCd', key: 'mnDlBrnCd', width: 90 },
    { title: '지점명', dataIndex: 'mnDlBrnNm', key: 'mnDlBrnNm', width: 110 },
    {
      title: '거래일시',
      key: 'dlDt',
      width: 150,
      render: (_, r) => formatDateTime(r.dlDt, r.dlTm),
    },
    { title: '거래유형', dataIndex: 'dlTypCcd', key: 'dlTypCcd', width: 90 },
    {
      title: '거래금액',
      dataIndex: 'dlAmt',
      key: 'dlAmt',
      width: 140,
      align: 'right',
      render: (v: number, r) => <AmountDisplay amount={v} currency={r.dlCcy} />,
    },
    { title: '통화', dataIndex: 'dlCcy', key: 'dlCcy', width: 70 },
    { title: '상대계좌', dataIndex: 'cntrpAcNo', key: 'cntrpAcNo', width: 160 },
    { title: '상대방', dataIndex: 'cntrpNm', key: 'cntrpNm', width: 120 },
  ]

  const amtColumns: ColumnsType<StrAmount> = [
    { title: '계좌번호', dataIndex: 'gnlAcNo', key: 'gnlAcNo' },
    {
      title: '합계금액',
      dataIndex: 'dlAmt',
      key: 'dlAmt',
      align: 'right',
      render: (v: number, r) => <AmountDisplay amount={v} currency={r.dlCcy} />,
    },
    { title: '통화', dataIndex: 'dlCcy', key: 'dlCcy', width: 80 },
  ]

  const approvalColumns: ColumnsType<StrApproval> = [
    { title: '순번', dataIndex: 'numSq', key: 'numSq', width: 60, align: 'center' },
    { title: '결재선구분', dataIndex: 'gylj', key: 'gylj', width: 100 },
    {
      title: '처리일시',
      dataIndex: 'hndlDyTm',
      key: 'hndlDyTm',
      width: 150,
      render: (v: string) => v || '-',
    },
    { title: '처리자', dataIndex: 'hndlPEno', key: 'hndlPEno', width: 100 },
    {
      title: '상태',
      dataIndex: 'snCcd',
      key: 'snCcd',
      width: 80,
      render: (v: string) => {
        if (v === 'E') return <Tag color="green">승인</Tag>
        if (v === 'R') return <Tag color="red">반려</Tag>
        return <Tag color="default">{v || '대기'}</Tag>
      },
    },
    { title: '사유', dataIndex: 'rsnCntnt', key: 'rsnCntnt', render: (v: string) => v || '-' },
  ]

  const statusCode = detail?.caseInfo?.rprPrgrsCcd ?? ''

  const approvalStep = (() => {
    if (statusCode === '10') return 2
    if (statusCode === '98') return 1
    return 0
  })()

  const tabItems = [
    {
      key: 'party',
      label: '거래자 정보',
      children: detail ? (
        <Descriptions bordered column={2} size="small">
          <Descriptions.Item label="거래자명">
            {detail.partyInfo?.dlPNm || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="실명번호">
            {detail.partyInfo?.dlPRnmNoCcd || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="개인/법인">
            {CORP_MAP[detail.partyInfo?.indvCorpCcd] || detail.partyInfo?.indvCorpCcd || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="생년월일">
            {formatDate(detail.partyInfo?.dlPBrtdy)}
          </Descriptions.Item>
          <Descriptions.Item label="성별">
            {GENDER_MAP[detail.partyInfo?.dlPSexCd] || detail.partyInfo?.dlPSexCd || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="직업코드">
            {detail.partyInfo?.ocptnCcd || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="주소" span={2}>
            {detail.partyInfo?.dlPHseAddr || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="연락처">
            {detail.partyInfo?.dlPMblTelNo || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="사업장명">
            {detail.partyInfo?.wpNm || '-'}
          </Descriptions.Item>
        </Descriptions>
      ) : null,
    },
    {
      key: 'transactions',
      label: '거래 내역',
      children: detail ? (
        <>
          <Table
            dataSource={detail.transactions ?? []}
            columns={txColumns}
            rowKey={(r) => `${r.dlDt}-${r.seqNo}`}
            size="small"
            pagination={false}
            scroll={{ x: 900 }}
          />
          <Divider />
          <Text strong>계좌별 합계</Text>
          <Table
            dataSource={detail.amounts ?? []}
            columns={amtColumns}
            rowKey="gnlAcNo"
            size="small"
            pagination={false}
            style={{ marginTop: 8 }}
          />
        </>
      ) : null,
    },
    {
      key: 'approval',
      label: '결재',
      children: detail ? (
        <>
          <Steps
            current={approvalStep}
            style={{ marginBottom: 24 }}
            items={[
              { title: '접수' },
              { title: '결재완료' },
              { title: 'FIU제출' },
            ]}
          />

          <Descriptions bordered column={2} size="small" style={{ marginBottom: 16 }}>
            <Descriptions.Item label="진행상태">
              <StatusBadge code={statusCode} />
            </Descriptions.Item>
            {detail.caseInfo?.fiuRptNo && (
              <Descriptions.Item label="FIU 접수번호" span={2}>
                <Text strong style={{ color: '#1677ff' }}>
                  {detail.caseInfo.fiuRptNo}
                </Text>
              </Descriptions.Item>
            )}
          </Descriptions>

          <Space style={{ marginBottom: 16 }}>
            {statusCode === '98' && (
              <Button
                type="primary"
                danger
                onClick={() => setFiuConfirmOpen(true)}
              >
                FIU 제출
              </Button>
            )}
          </Space>

          <Divider />
          <Text strong>결재 이력</Text>
          <Table
            dataSource={detail.approvals ?? []}
            columns={approvalColumns}
            rowKey="appNo"
            size="small"
            pagination={false}
            style={{ marginTop: 8 }}
            locale={{ emptyText: '결재 이력이 없습니다.' }}
          />

          <Modal
            title="FIU 제출 확인"
            open={fiuConfirmOpen}
            onOk={handleSubmitFiu}
            onCancel={() => setFiuConfirmOpen(false)}
            confirmLoading={fiuSubmitting}
            okText="제출"
            okButtonProps={{ danger: true }}
            cancelText="취소"
          >
            <p>FIU에 고액현금 보고서를 제출하시겠습니까?</p>
            <p>제출 후에는 취소가 불가능합니다.</p>
          </Modal>
        </>
      ) : null,
    },
  ]

  return (
    <Drawer
      title={`CTR 케이스 상세 - ${sspsDlId}`}
      open={open}
      onClose={() => onClose()}
      width="80%"
      loading={loading}
      styles={{ body: { paddingTop: 8 } }}
    >
      <Tabs activeKey={activeTab} onChange={setActiveTab} items={tabItems} />
    </Drawer>
  )
}

export default function CtrCasesPage() {
  const defaultRange: [dayjs.Dayjs, dayjs.Dayjs] = [
    dayjs().subtract(30, 'day'),
    dayjs(),
  ]

  const [dateRange, setDateRange] = useState<[dayjs.Dayjs, dayjs.Dayjs]>(defaultRange)
  const [data, setData] = useState<CtrCase[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)

  const [detailOpen, setDetailOpen] = useState(false)
  const [selectedCase, setSelectedCase] = useState<CtrCase | null>(null)

  const fetchData = useCallback(
    async (currentPage = 1) => {
      setLoading(true)
      try {
        const params: Record<string, unknown> = {
          stDate: dateRange[0].format('YYYYMMDD'),
          edDate: dateRange[1].format('YYYYMMDD'),
          page: currentPage,
          size: 20,
        }
        const res = await ctrApi.getCases(params)
        const payload = res.data.data
        setData(payload?.list ?? [])
        setTotal(payload?.total ?? 0)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : 'CTR 케이스 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [dateRange]
  )

  useEffect(() => {
    fetchData(1)
    setPage(1)
  }, [dateRange])

  const openDetail = (record: CtrCase) => {
    setSelectedCase(record)
    setDetailOpen(true)
  }

  const handleDetailClose = (refreshNeeded?: boolean) => {
    setDetailOpen(false)
    setSelectedCase(null)
    if (refreshNeeded) fetchData(page)
  }

  const columns: ColumnsType<CtrCase> = [
    {
      title: '케이스ID',
      dataIndex: 'sspsDlId',
      key: 'sspsDlId',
      width: 130,
    },
    {
      title: '생성일',
      dataIndex: 'sspsDlCrtDt',
      key: 'sspsDlCrtDt',
      width: 110,
      render: (v: string) => formatDate(v),
    },
    {
      title: '거래자명',
      dataIndex: 'dlPNm',
      key: 'dlPNm',
      width: 120,
    },
    {
      title: '진행상태',
      dataIndex: 'rprPrgrsCcd',
      key: 'rprPrgrsCcd',
      width: 110,
      render: (v: string) => <StatusBadge code={v} />,
    },
    {
      title: '거래금액',
      dataIndex: 'dlAmt',
      key: 'dlAmt',
      width: 150,
      align: 'right',
      render: (v: number, r) => <AmountDisplay amount={v} currency={r.dlCcy} />,
    },
    {
      title: '통화',
      dataIndex: 'dlCcy',
      key: 'dlCcy',
      width: 80,
    },
    {
      title: '액션',
      key: 'actions',
      width: 90,
      render: (_, record) => (
        <Button size="small" type="primary" onClick={() => openDetail(record)}>
          상세보기
        </Button>
      ),
    },
  ]

  return (
    <div>
      <PageHeader
        title="CTR 처리"
        subtitle="고액현금 보고(CTR) 케이스 처리 및 FIU 제출 관리"
      />

      <Row gutter={12} style={{ marginBottom: 16 }}>
        <Col>
          <RangePicker
            value={dateRange}
            onChange={(vals) => {
              if (vals && vals[0] && vals[1]) {
                setDateRange([vals[0], vals[1]])
              }
            }}
            format="YYYY-MM-DD"
          />
        </Col>
        <Col>
          <Space>
            <Button
              type="primary"
              onClick={() => {
                setPage(1)
                fetchData(1)
              }}
            >
              조회
            </Button>
          </Space>
        </Col>
      </Row>

      <Table
        dataSource={data}
        columns={columns}
        rowKey={(r) => `${r.sspsDlCrtDt}-${r.sspsDlId}`}
        loading={loading}
        size="middle"
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

      {selectedCase && (
        <CtrDetailDrawer
          open={detailOpen}
          sspsDlCrtDt={selectedCase.sspsDlCrtDt}
          sspsDlId={selectedCase.sspsDlId}
          onClose={handleDetailClose}
        />
      )}
    </div>
  )
}
