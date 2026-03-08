import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Row,
  Col,
  Card,
  Statistic,
  Table,
  Typography,
  message,
  Spin,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import {
  AlertOutlined,
  FolderOpenOutlined,
  SafetyCertificateOutlined,
  UserOutlined,
} from '@ant-design/icons'
import { getDashboardStats } from '../api/dashboard'
import type { DashboardStats, TmsAlert, Case } from '../api/types'
import StatusTag from '../components/shared/StatusTag'
import AmountDisplay from '../components/shared/AmountDisplay'

const { Title } = Typography

const alertColumns: ColumnsType<TmsAlert> = [
  { title: '알림번호', dataIndex: 'alert_no', key: 'alert_no', width: 120 },
  { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
  {
    title: '탐지금액',
    dataIndex: 'detect_amt',
    key: 'detect_amt',
    render: (v) => <AmountDisplay amount={v} />,
  },
  {
    title: '위험점수',
    dataIndex: 'risk_scr',
    key: 'risk_scr',
    width: 80,
    render: (v) => `${v}점`,
  },
  {
    title: '상태',
    dataIndex: 'stat',
    key: 'stat',
    render: (v) => <StatusTag status={v} type="alert" />,
  },
]

const caseColumns: ColumnsType<Case> = [
  { title: '케이스번호', dataIndex: 'case_no', key: 'case_no', width: 130 },
  { title: '유형', dataIndex: 'case_tp', key: 'case_tp', width: 80 },
  { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
  { title: '개시일', dataIndex: 'open_dt', key: 'open_dt', width: 100 },
  {
    title: '상태',
    dataIndex: 'stat',
    key: 'stat',
    render: (v) => <StatusTag status={v} type="case" />,
  },
]

export default function DashboardPage() {
  const [stats, setStats] = useState<DashboardStats | null>(null)
  const [loading, setLoading] = useState(true)
  const navigate = useNavigate()

  useEffect(() => {
    fetchStats()
  }, [])

  const fetchStats = async () => {
    setLoading(true)
    try {
      const data = await getDashboardStats()
      setStats(data)
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : '데이터를 불러올 수 없습니다.'
      message.error(msg)
    } finally {
      setLoading(false)
    }
  }

  const statCards = [
    {
      title: '신규 알림',
      value: stats?.new_alerts ?? 0,
      icon: <AlertOutlined style={{ fontSize: 24, color: '#1677ff' }} />,
      color: '#e6f4ff',
      onClick: () => navigate('/tms/alerts'),
    },
    {
      title: '진행중 케이스',
      value: stats?.open_cases ?? 0,
      icon: <FolderOpenOutlined style={{ fontSize: 24, color: '#fa8c16' }} />,
      color: '#fff7e6',
      onClick: () => navigate('/cases'),
    },
    {
      title: 'KYC 미완료',
      value: stats?.pending_kyc ?? 0,
      icon: <SafetyCertificateOutlined style={{ fontSize: 24, color: '#52c41a' }} />,
      color: '#f6ffed',
      onClick: () => navigate('/kyc'),
    },
    {
      title: '고위험 고객',
      value: stats?.high_risk_customers ?? 0,
      icon: <UserOutlined style={{ fontSize: 24, color: '#ff4d4f' }} />,
      color: '#fff1f0',
      onClick: () => navigate('/customers'),
    },
  ]

  if (loading) {
    return (
      <div style={{ textAlign: 'center', paddingTop: 80 }}>
        <Spin size="large" />
      </div>
    )
  }

  return (
    <div>
      <Title level={4} style={{ marginBottom: 20 }}>
        대시보드
      </Title>

      <Row gutter={[16, 16]} style={{ marginBottom: 24 }}>
        {statCards.map((card) => (
          <Col xs={24} sm={12} lg={6} key={card.title}>
            <Card
              hoverable
              onClick={card.onClick}
              style={{ cursor: 'pointer' }}
              styles={{ body: { padding: '20px 24px' } }}
            >
              <div
                style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}
              >
                <Statistic
                  title={card.title}
                  value={card.value}
                  valueStyle={{ fontSize: 28, fontWeight: 700 }}
                />
                <div
                  style={{
                    width: 52,
                    height: 52,
                    background: card.color,
                    borderRadius: 12,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  {card.icon}
                </div>
              </div>
            </Card>
          </Col>
        ))}
      </Row>

      <Row gutter={[16, 16]}>
        <Col xs={24} xl={12}>
          <Card title="최근 TMS 알림" extra={<a onClick={() => navigate('/tms/alerts')}>전체보기</a>}>
            <Table
              dataSource={stats?.recent_alerts ?? []}
              columns={alertColumns}
              rowKey="alert_id"
              pagination={false}
              size="small"
            />
          </Card>
        </Col>
        <Col xs={24} xl={12}>
          <Card title="최근 케이스" extra={<a onClick={() => navigate('/cases')}>전체보기</a>}>
            <Table
              dataSource={stats?.recent_cases ?? []}
              columns={caseColumns}
              rowKey="case_id"
              pagination={false}
              size="small"
            />
          </Card>
        </Col>
      </Row>
    </div>
  )
}
