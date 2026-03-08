import { useEffect, useState } from 'react'
import {
  Row,
  Col,
  Card,
  Statistic,
  Table,
  Progress,
  Spin,
  message,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import {
  AlertOutlined,
  BellOutlined,
  FileTextOutlined,
  AuditOutlined,
} from '@ant-design/icons'
import {
  getTmsStatsDashboard,
  getTmsStatsWeekly,
  type TmsStatsDashboard,
} from '../../api/tms'
import type { TmsStatsDaily } from '../../api/types'
import PageHeader from '../../components/shared/PageHeader'

const { Title } = Typography

export default function TmsStatsPage() {
  const [dashboard, setDashboard] = useState<TmsStatsDashboard | null>(null)
  const [weekly, setWeekly] = useState<TmsStatsDaily[]>([])
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    const fetchAll = async () => {
      setLoading(true)
      try {
        const [dash, wk] = await Promise.all([
          getTmsStatsDashboard(),
          getTmsStatsWeekly(),
        ])
        setDashboard(dash)
        setWeekly(wk)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : 'TMS 통계 조회 실패')
      } finally {
        setLoading(false)
      }
    }
    fetchAll()
  }, [])

  const weeklyColumns: ColumnsType<TmsStatsDaily> = [
    { title: '날짜', dataIndex: 'stats_dt', key: 'stats_dt', width: 110 },
    {
      title: '총 알림',
      dataIndex: 'total_alerts',
      key: 'total_alerts',
      align: 'right',
    },
    {
      title: '신규',
      dataIndex: 'new_alerts',
      key: 'new_alerts',
      align: 'right',
    },
    {
      title: '검토',
      dataIndex: 'review_alerts',
      key: 'review_alerts',
      align: 'right',
    },
    {
      title: '종결',
      dataIndex: 'closed_alerts',
      key: 'closed_alerts',
      align: 'right',
    },
    {
      title: 'STR',
      dataIndex: 'str_count',
      key: 'str_count',
      align: 'right',
    },
    {
      title: 'CTR',
      dataIndex: 'ctr_count',
      key: 'ctr_count',
      align: 'right',
    },
  ]

  const scenarioColumns: ColumnsType<{ scnr_nm: string; count: number }> = [
    {
      title: '시나리오명',
      dataIndex: 'scnr_nm',
      key: 'scnr_nm',
    },
    {
      title: '알림건수',
      dataIndex: 'count',
      key: 'count',
      align: 'right',
      width: 100,
    },
    {
      title: '비율',
      key: 'ratio',
      width: 180,
      render: (_, record) => {
        const total =
          dashboard?.scenario_breakdown.reduce((s, r) => s + r.count, 0) || 1
        const pct = Math.round((record.count / total) * 100)
        return <Progress percent={pct} size="small" />
      },
    },
  ]

  const statusMax =
    Math.max(
      ...(dashboard?.status_breakdown.map((s) => s.count) ?? [1]),
      1
    )

  return (
    <div>
      <PageHeader
        title="TMS 통계"
        subtitle="거래모니터링 알림 및 처리 현황 통계"
      />

      {loading ? (
        <div style={{ textAlign: 'center', padding: 64 }}>
          <Spin size="large" />
        </div>
      ) : (
        <>
          {/* Top stat cards */}
          <Row gutter={16} style={{ marginBottom: 16 }}>
            <Col xs={24} sm={12} md={6}>
              <Card>
                <Statistic
                  title="오늘 총 알림"
                  value={dashboard?.today_total_alerts ?? 0}
                  prefix={<AlertOutlined style={{ color: '#1677ff' }} />}
                  valueStyle={{ color: '#1677ff' }}
                />
              </Card>
            </Col>
            <Col xs={24} sm={12} md={6}>
              <Card>
                <Statistic
                  title="신규 알림"
                  value={dashboard?.today_new_alerts ?? 0}
                  prefix={<BellOutlined style={{ color: '#fa8c16' }} />}
                  valueStyle={{ color: '#fa8c16' }}
                />
              </Card>
            </Col>
            <Col xs={24} sm={12} md={6}>
              <Card>
                <Statistic
                  title="STR 건수"
                  value={dashboard?.today_str_count ?? 0}
                  prefix={<FileTextOutlined style={{ color: '#ff4d4f' }} />}
                  valueStyle={{ color: '#ff4d4f' }}
                />
              </Card>
            </Col>
            <Col xs={24} sm={12} md={6}>
              <Card>
                <Statistic
                  title="CTR 건수"
                  value={dashboard?.today_ctr_count ?? 0}
                  prefix={<AuditOutlined style={{ color: '#52c41a' }} />}
                  valueStyle={{ color: '#52c41a' }}
                />
              </Card>
            </Col>
          </Row>

          {/* Weekly and status breakdown */}
          <Row gutter={16} style={{ marginBottom: 16 }}>
            <Col xs={24} lg={14}>
              <Card
                title={
                  <Title level={5} style={{ margin: 0 }}>
                    주간 알림 추이 (최근 7일)
                  </Title>
                }
              >
                <Table
                  dataSource={weekly}
                  columns={weeklyColumns}
                  rowKey="stats_dt"
                  size="small"
                  pagination={false}
                  locale={{ emptyText: '데이터가 없습니다.' }}
                />
              </Card>
            </Col>
            <Col xs={24} lg={10}>
              <Card
                title={
                  <Title level={5} style={{ margin: 0 }}>
                    상태별 알림 현황
                  </Title>
                }
              >
                {dashboard?.status_breakdown && dashboard.status_breakdown.length > 0 ? (
                  <div style={{ padding: '8px 0' }}>
                    {dashboard.status_breakdown.map((item) => {
                      const labelMap: Record<string, string> = {
                        NEW: '신규',
                        REVIEW: '검토중',
                        CLOSED: '종결',
                        ESCALATED: '상향',
                      }
                      const colorMap: Record<string, string> = {
                        NEW: '#1677ff',
                        REVIEW: '#fa8c16',
                        CLOSED: '#8c8c8c',
                        ESCALATED: '#722ed1',
                      }
                      const pct = Math.round((item.count / statusMax) * 100)
                      return (
                        <div
                          key={item.stat}
                          style={{
                            marginBottom: 12,
                            display: 'flex',
                            alignItems: 'center',
                            gap: 12,
                          }}
                        >
                          <div style={{ width: 60, textAlign: 'right', flexShrink: 0 }}>
                            {labelMap[item.stat] || item.stat}
                          </div>
                          <Progress
                            percent={pct}
                            showInfo={false}
                            strokeColor={colorMap[item.stat] || '#1677ff'}
                            style={{ flex: 1 }}
                          />
                          <div
                            style={{
                              width: 40,
                              textAlign: 'right',
                              fontWeight: 600,
                              flexShrink: 0,
                            }}
                          >
                            {item.count}
                          </div>
                        </div>
                      )
                    })}
                  </div>
                ) : (
                  <div
                    style={{ textAlign: 'center', padding: 32, color: '#8c8c8c' }}
                  >
                    데이터가 없습니다.
                  </div>
                )}
              </Card>
            </Col>
          </Row>

          {/* Scenario breakdown */}
          <Card
            title={
              <Title level={5} style={{ margin: 0 }}>
                시나리오별 알림 현황
              </Title>
            }
          >
            <Table
              dataSource={dashboard?.scenario_breakdown ?? []}
              columns={scenarioColumns}
              rowKey="scnr_nm"
              size="small"
              pagination={{ pageSize: 10 }}
              locale={{ emptyText: '데이터가 없습니다.' }}
            />
          </Card>
        </>
      )}
    </div>
  )
}
