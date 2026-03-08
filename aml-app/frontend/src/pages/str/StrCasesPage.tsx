import { useCallback, useEffect, useState } from 'react'
import {
  Button,
  Col,
  DatePicker,
  message,
  Row,
  Select,
  Space,
  Table,
  Tag,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import dayjs from 'dayjs'
import { strApi } from '../../api/str'
import type { StrCase } from '../../api/str'
import AmountDisplay from '../../components/shared/AmountDisplay'
import PageHeader from '../../components/shared/PageHeader'
import StrCaseDetailModal from './StrCaseDetailModal'

const { RangePicker } = DatePicker

const STATUS_OPTIONS = [
  { value: '', label: '전체' },
  { value: '9', label: '대기' },
  { value: '97', label: '검토중' },
  { value: '98', label: '결재완료' },
  { value: '10', label: 'FIU제출' },
]

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

function RiskTag({ grade }: { grade: string }) {
  const map: Record<string, { color: string; label: string }> = {
    H: { color: 'red', label: '고위험' },
    M: { color: 'orange', label: '중위험' },
    L: { color: 'green', label: '저위험' },
  }
  const info = map[grade] ?? { color: 'default', label: grade }
  return <Tag color={info.color}>{info.label}</Tag>
}

function formatDate(yyyymmdd: string): string {
  if (!yyyymmdd || yyyymmdd.length !== 8) return yyyymmdd
  return `${yyyymmdd.slice(0, 4)}-${yyyymmdd.slice(4, 6)}-${yyyymmdd.slice(6, 8)}`
}

export default function StrCasesPage() {
  const defaultRange: [dayjs.Dayjs, dayjs.Dayjs] = [
    dayjs().subtract(30, 'day'),
    dayjs(),
  ]

  const [dateRange, setDateRange] = useState<[dayjs.Dayjs, dayjs.Dayjs]>(defaultRange)
  const [scnrId, setScnrId] = useState('')
  const [statusCode, setStatusCode] = useState('')
  const [data, setData] = useState<StrCase[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [simulating, setSimulating] = useState(false)

  const [detailOpen, setDetailOpen] = useState(false)
  const [selectedCase, setSelectedCase] = useState<StrCase | null>(null)

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
        if (scnrId) params.scnrId = scnrId
        if (statusCode) params.rprPrgrsCcd = statusCode

        const res = await strApi.getCases(params)
        const payload = res.data.data
        setData(payload?.list ?? [])
        setTotal(payload?.total ?? 0)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : 'STR 케이스 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [dateRange, scnrId, statusCode]
  )

  useEffect(() => {
    fetchData(1)
    setPage(1)
  }, [dateRange, scnrId, statusCode])

  const handleSimulate = async () => {
    setSimulating(true)
    try {
      await strApi.simulate(10)
      message.success('배치 시뮬레이션이 완료되었습니다.')
      fetchData(page)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '시뮬레이션 실패')
    } finally {
      setSimulating(false)
    }
  }

  const openDetail = (record: StrCase) => {
    setSelectedCase(record)
    setDetailOpen(true)
  }

  const handleDetailClose = (refreshNeeded?: boolean) => {
    setDetailOpen(false)
    setSelectedCase(null)
    if (refreshNeeded) fetchData(page)
  }

  const columns: ColumnsType<StrCase> = [
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
      title: '시나리오',
      dataIndex: 'sspsTpCd',
      key: 'sspsTpCd',
      width: 130,
    },
    {
      title: '진행상태',
      dataIndex: 'rprPrgrsCcd',
      key: 'rprPrgrsCcd',
      width: 110,
      render: (v: string) => <StatusBadge code={v} />,
    },
    {
      title: '위험등급',
      dataIndex: 'rskGrdCd',
      key: 'rskGrdCd',
      width: 90,
      render: (v: string) => <RiskTag grade={v} />,
    },
    {
      title: '시나리오점수',
      dataIndex: 'scnrMrk',
      key: 'scnrMrk',
      width: 110,
      align: 'right',
      render: (v: number) => (v != null ? v.toFixed(2) : '-'),
    },
    {
      title: '거래금액',
      dataIndex: 'dlAmt',
      key: 'dlAmt',
      width: 150,
      align: 'right',
      render: (v: number) => <AmountDisplay amount={v} />,
    },
    {
      title: '거래건수',
      dataIndex: 'dlCnt',
      key: 'dlCnt',
      width: 90,
      align: 'right',
      render: (v: number) => (v != null ? `${v}건` : '-'),
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
        title="STR 처리"
        subtitle="혐의거래 보고(STR) 케이스 처리 및 FIU 제출 관리"
        actions={
          <Button
            type="default"
            onClick={handleSimulate}
            loading={simulating}
          >
            배치 시뮬레이션
          </Button>
        }
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
          <Select
            value={scnrId}
            onChange={(v) => setScnrId(v)}
            style={{ width: 160 }}
            placeholder="시나리오 ID"
            allowClear
            options={[{ value: '', label: '전체 시나리오' }]}
          />
        </Col>
        <Col>
          <Select
            value={statusCode}
            onChange={(v) => setStatusCode(v)}
            style={{ width: 130 }}
            placeholder="진행상태"
            options={STATUS_OPTIONS}
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
        <StrCaseDetailModal
          open={detailOpen}
          sspsDlCrtDt={selectedCase.sspsDlCrtDt}
          sspsDlId={selectedCase.sspsDlId}
          onClose={handleDetailClose}
        />
      )}
    </div>
  )
}
