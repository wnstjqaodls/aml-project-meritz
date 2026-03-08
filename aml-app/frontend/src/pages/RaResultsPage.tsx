import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Form,
  Input,
  Modal,
  Drawer,
  Descriptions,
  message,
  Tag,
  Progress,
  Typography,
  Divider,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { PlayCircleOutlined } from '@ant-design/icons'
import { getRaResults, getRaResultDetail, evaluateRisk } from '../api/ra'
import { getCustomers } from '../api/customers'
import type { RaResult, RaResultDetail, Customer } from '../api/types'
import PageHeader from '../components/shared/PageHeader'
import SearchForm from '../components/shared/SearchForm'
import StatusTag from '../components/shared/StatusTag'

const { Title } = Typography

export default function RaResultsPage() {
  const [searchForm] = Form.useForm()
  const [evalForm] = Form.useForm()

  const [results, setResults] = useState<RaResult[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [searchParams, setSearchParams] = useState<Record<string, string>>({})

  const [evalModalOpen, setEvalModalOpen] = useState(false)
  const [evaluating, setEvaluating] = useState(false)
  const [evalResult, setEvalResult] = useState<RaResult | null>(null)

  const [drawerOpen, setDrawerOpen] = useState(false)
  const [drawerLoading, setDrawerLoading] = useState(false)
  const [selectedResult, setSelectedResult] = useState<RaResult | null>(null)
  const [detailItems, setDetailItems] = useState<RaResultDetail[]>([])

  const [customers, setCustomers] = useState<Customer[]>([])
  const [custSearching, setCustSearching] = useState(false)

  const fetchResults = useCallback(
    async (currentPage = 1, params = searchParams) => {
      setLoading(true)
      try {
        const res = await getRaResults({ ...params, page: currentPage, size: 10 })
        setResults(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : 'RA 결과 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [searchParams]
  )

  useEffect(() => {
    fetchResults(1, {})
  }, [])

  const handleSearch = () => {
    const values = searchForm.getFieldsValue()
    const params: Record<string, string> = {}
    if (values.cust_no) params.cust_no = values.cust_no
    if (values.cust_nm) params.cust_nm = values.cust_nm
    setSearchParams(params)
    setPage(1)
    fetchResults(1, params)
  }

  const handleReset = () => {
    setSearchParams({})
    setPage(1)
    fetchResults(1, {})
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

  const handleEvaluate = async () => {
    try {
      const values = await evalForm.validateFields()
      setEvaluating(true)
      setEvalResult(null)
      const result = await evaluateRisk(values.cust_no)
      setEvalResult(result)
      message.success('위험평가가 완료되었습니다.')
      fetchResults(page, searchParams)
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setEvaluating(false)
    }
  }

  const openDetail = async (result: RaResult) => {
    setSelectedResult(result)
    setDrawerOpen(true)
    setDrawerLoading(true)
    try {
      const detail = await getRaResultDetail(result.ra_id)
      setDetailItems(detail.details)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '상세 조회 실패')
    } finally {
      setDrawerLoading(false)
    }
  }

  const detailColumns: ColumnsType<RaResultDetail> = [
    { title: '항목코드', dataIndex: 'ra_item_cd', key: 'ra_item_cd', width: 130 },
    { title: '항목명', dataIndex: 'ra_item_nm', key: 'ra_item_nm' },
    {
      title: '취득점수',
      dataIndex: 'item_scr',
      key: 'item_scr',
      width: 100,
      render: (v, r) => `${v} / ${r.max_scr}`,
    },
    {
      title: '가중치',
      dataIndex: 'wght',
      key: 'wght',
      width: 90,
      render: (v) => `${v}%`,
    },
  ]

  const columns: ColumnsType<RaResult> = [
    { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
    { title: '고객번호', dataIndex: 'cust_no', key: 'cust_no', width: 120 },
    { title: '평가일', dataIndex: 'eval_dt', key: 'eval_dt', width: 110 },
    {
      title: '위험점수',
      dataIndex: 'risk_scr',
      key: 'risk_scr',
      width: 150,
      render: (v: number) => (
        <Progress
          percent={v}
          size="small"
          strokeColor={v >= 70 ? '#ff4d4f' : v >= 40 ? '#fa8c16' : '#52c41a'}
          format={(p) => `${p}점`}
        />
      ),
    },
    {
      title: '위험등급',
      dataIndex: 'risk_grd',
      key: 'risk_grd',
      width: 90,
      render: (v) => <StatusTag status={v} type="risk" />,
    },
    {
      title: 'EDD 여부',
      dataIndex: 'edd_yn',
      key: 'edd_yn',
      width: 90,
      render: (v) =>
        v === 'Y' ? (
          <Tag color="red">EDD 필요</Tag>
        ) : (
          <Tag color="green">해당없음</Tag>
        ),
    },
    { title: '다음평가일', dataIndex: 'next_eval_dt', key: 'next_eval_dt', width: 110 },
  ]

  return (
    <div>
      <PageHeader
        title="고객위험평가"
        actions={
          <Button
            type="primary"
            icon={<PlayCircleOutlined />}
            onClick={() => {
              evalForm.resetFields()
              setEvalResult(null)
              setCustomers([])
              setEvalModalOpen(true)
            }}
          >
            위험평가 실행
          </Button>
        }
      />

      <SearchForm
        form={searchForm}
        onSearch={handleSearch}
        onReset={handleReset}
        loading={loading}
      >
        <Form.Item name="cust_no" label="고객번호">
          <Input placeholder="고객번호" style={{ width: 150 }} />
        </Form.Item>
        <Form.Item name="cust_nm" label="고객명">
          <Input placeholder="고객명" style={{ width: 150 }} />
        </Form.Item>
      </SearchForm>

      <Table
        dataSource={results}
        columns={columns}
        rowKey="ra_id"
        loading={loading}
        pagination={{
          current: page,
          pageSize: 10,
          total,
          showTotal: (t) => `총 ${t}건`,
          onChange: (p) => {
            setPage(p)
            fetchResults(p, searchParams)
          },
        }}
        onRow={(record) => ({
          onClick: () => openDetail(record),
          style: { cursor: 'pointer' },
        })}
        size="middle"
      />

      <Modal
        title="고객 위험평가 실행"
        open={evalModalOpen}
        onOk={handleEvaluate}
        onCancel={() => {
          setEvalModalOpen(false)
          evalForm.resetFields()
          setEvalResult(null)
        }}
        confirmLoading={evaluating}
        okText="평가 실행"
        cancelText="닫기"
        width={500}
      >
        <Form form={evalForm} layout="vertical" style={{ marginBottom: 16 }}>
          <Form.Item
            name="cust_no"
            label="고객번호"
            rules={[{ required: true, message: '고객번호를 입력하세요' }]}
          >
            <Input placeholder="고객번호 입력" />
          </Form.Item>
        </Form>

        {evalResult && (
          <>
            <Divider />
            <Title level={5}>평가 결과</Title>
            <Descriptions bordered column={2} size="small">
              <Descriptions.Item label="고객명">
                {evalResult.cust_nm}
              </Descriptions.Item>
              <Descriptions.Item label="위험등급">
                <StatusTag status={evalResult.risk_grd} type="risk" />
              </Descriptions.Item>
              <Descriptions.Item label="위험점수">
                <Progress
                  percent={evalResult.risk_scr}
                  size="small"
                  strokeColor={
                    evalResult.risk_scr >= 70
                      ? '#ff4d4f'
                      : evalResult.risk_scr >= 40
                      ? '#fa8c16'
                      : '#52c41a'
                  }
                />
              </Descriptions.Item>
              <Descriptions.Item label="EDD 여부">
                {evalResult.edd_yn === 'Y' ? (
                  <Tag color="red">EDD 필요</Tag>
                ) : (
                  <Tag color="green">해당없음</Tag>
                )}
              </Descriptions.Item>
              <Descriptions.Item label="평가일">
                {evalResult.eval_dt}
              </Descriptions.Item>
              <Descriptions.Item label="다음 평가일">
                {evalResult.next_eval_dt}
              </Descriptions.Item>
            </Descriptions>
          </>
        )}
      </Modal>

      <Drawer
        title={`위험평가 상세 - ${selectedResult?.cust_nm || ''}`}
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        width={600}
        loading={drawerLoading}
      >
        {selectedResult && (
          <>
            <Descriptions bordered column={2} size="small" style={{ marginBottom: 16 }}>
              <Descriptions.Item label="고객명">
                {selectedResult.cust_nm}
              </Descriptions.Item>
              <Descriptions.Item label="위험등급">
                <StatusTag status={selectedResult.risk_grd} type="risk" />
              </Descriptions.Item>
              <Descriptions.Item label="위험점수" span={2}>
                <Progress
                  percent={selectedResult.risk_scr}
                  strokeColor={
                    selectedResult.risk_scr >= 70
                      ? '#ff4d4f'
                      : selectedResult.risk_scr >= 40
                      ? '#fa8c16'
                      : '#52c41a'
                  }
                />
              </Descriptions.Item>
              <Descriptions.Item label="평가일">
                {selectedResult.eval_dt}
              </Descriptions.Item>
              <Descriptions.Item label="다음 평가일">
                {selectedResult.next_eval_dt}
              </Descriptions.Item>
            </Descriptions>

            <Divider />
            <Title level={5}>항목별 평가 결과</Title>
            <Table
              dataSource={detailItems}
              columns={detailColumns}
              rowKey="ra_item_cd"
              size="small"
              pagination={false}
              summary={(data) => {
                const totalScore = data.reduce((sum, r) => sum + r.item_scr, 0)
                return (
                  <Table.Summary.Row>
                    <Table.Summary.Cell index={0} colSpan={2}>
                      <strong>합계</strong>
                    </Table.Summary.Cell>
                    <Table.Summary.Cell index={1}>
                      <strong>{totalScore}점</strong>
                    </Table.Summary.Cell>
                    <Table.Summary.Cell index={2} />
                  </Table.Summary.Row>
                )
              }}
            />
          </>
        )}
      </Drawer>
    </div>
  )
}
