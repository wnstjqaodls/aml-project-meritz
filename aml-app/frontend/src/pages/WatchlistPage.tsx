import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Form,
  Input,
  Select,
  Tabs,
  Modal,
  Progress,
  message,
  Space,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { SearchOutlined } from '@ant-design/icons'
import {
  getWatchlist,
  getScreeningResults,
  screenCustomer,
} from '../api/watchlist'
import type { WatchlistEntry, ScreeningResult } from '../api/types'
import PageHeader from '../components/shared/PageHeader'
import SearchForm from '../components/shared/SearchForm'
import StatusTag from '../components/shared/StatusTag'

export default function WatchlistPage() {
  const [wlSearchForm] = Form.useForm()
  const [scrSearchForm] = Form.useForm()
  const [screenForm] = Form.useForm()

  const [wlList, setWlList] = useState<WatchlistEntry[]>([])
  const [wlTotal, setWlTotal] = useState(0)
  const [wlPage, setWlPage] = useState(1)
  const [wlLoading, setWlLoading] = useState(false)

  const [scrResults, setScrResults] = useState<ScreeningResult[]>([])
  const [scrTotal, setScrTotal] = useState(0)
  const [scrPage, setScrPage] = useState(1)
  const [scrLoading, setScrLoading] = useState(false)

  const [screenModalOpen, setScreenModalOpen] = useState(false)
  const [screenLoading, setScreenLoading] = useState(false)
  const [screenResultData, setScreenResultData] = useState<ScreeningResult[]>([])

  const fetchWatchlist = useCallback(
    async (currentPage = 1, params: Record<string, string> = {}) => {
      setWlLoading(true)
      try {
        const res = await getWatchlist({ ...params, page: currentPage, size: 10 })
        setWlList(res.data)
        setWlTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : '워치리스트 조회 실패')
      } finally {
        setWlLoading(false)
      }
    },
    []
  )

  const fetchScreenResults = useCallback(
    async (currentPage = 1, params: Record<string, string> = {}) => {
      setScrLoading(true)
      try {
        const res = await getScreeningResults({ ...params, page: currentPage, size: 10 })
        setScrResults(res.data)
        setScrTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : '스크리닝 결과 조회 실패')
      } finally {
        setScrLoading(false)
      }
    },
    []
  )

  useEffect(() => {
    fetchWatchlist(1, {})
    fetchScreenResults(1, {})
  }, [])

  const handleWlSearch = () => {
    const values = wlSearchForm.getFieldsValue()
    const params: Record<string, string> = {}
    if (values.name) params.name = values.name
    if (values.source) params.source = values.source
    if (values.wl_tp) params.wl_tp = values.wl_tp
    setWlPage(1)
    fetchWatchlist(1, params)
  }

  const handleScrSearch = () => {
    const values = scrSearchForm.getFieldsValue()
    const params: Record<string, string> = {}
    if (values.cust_no) params.cust_no = values.cust_no
    if (values.stat) params.stat = values.stat
    setScrPage(1)
    fetchScreenResults(1, params)
  }

  const handleScreen = async () => {
    try {
      const values = await screenForm.validateFields()
      setScreenLoading(true)
      const results = await screenCustomer(values.cust_no)
      setScreenResultData(results)
      message.success(`스크리닝 완료: ${results.length}건 결과`)
      fetchScreenResults(1, {})
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setScreenLoading(false)
    }
  }

  const wlColumns: ColumnsType<WatchlistEntry> = [
    { title: 'ID', dataIndex: 'wl_id', key: 'wl_id', width: 80 },
    { title: '이름', dataIndex: 'name', key: 'name' },
    { title: '출처', dataIndex: 'source', key: 'source', width: 100 },
    { title: '유형', dataIndex: 'wl_tp', key: 'wl_tp', width: 100 },
    { title: '국적', dataIndex: 'nationality', key: 'nationality', width: 80 },
    { title: '제재유형', dataIndex: 'sanction_tp', key: 'sanction_tp' },
    { title: '등재일', dataIndex: 'list_dt', key: 'list_dt', width: 110 },
  ]

  const scrColumns: ColumnsType<ScreeningResult> = [
    { title: '고객번호', dataIndex: 'cust_no', key: 'cust_no', width: 120 },
    { title: '고객명', dataIndex: 'cust_nm', key: 'cust_nm' },
    { title: '워치리스트명', dataIndex: 'wl_nm', key: 'wl_nm' },
    {
      title: '일치도',
      dataIndex: 'match_scr',
      key: 'match_scr',
      width: 150,
      render: (v: number) => (
        <Progress
          percent={v}
          size="small"
          strokeColor={v >= 80 ? '#ff4d4f' : v >= 50 ? '#fa8c16' : '#52c41a'}
          format={(p) => `${p}%`}
        />
      ),
    },
    {
      title: '결과',
      dataIndex: 'stat',
      key: 'stat',
      render: (v) => <StatusTag status={v} type="screening" />,
    },
    { title: '스크리닝일', dataIndex: 'scr_dt', key: 'scr_dt', width: 110 },
  ]

  const screenResultColumns: ColumnsType<ScreeningResult> = [
    { title: '워치리스트명', dataIndex: 'wl_nm', key: 'wl_nm' },
    {
      title: '일치도',
      dataIndex: 'match_scr',
      key: 'match_scr',
      render: (v: number) => (
        <Progress
          percent={v}
          size="small"
          strokeColor={v >= 80 ? '#ff4d4f' : v >= 50 ? '#fa8c16' : '#52c41a'}
        />
      ),
    },
    {
      title: '결과',
      dataIndex: 'stat',
      key: 'stat',
      render: (v) => <StatusTag status={v} type="screening" />,
    },
  ]

  return (
    <div>
      <PageHeader
        title="워치리스트"
        actions={
          <Button
            type="primary"
            icon={<SearchOutlined />}
            onClick={() => setScreenModalOpen(true)}
          >
            고객 스크리닝
          </Button>
        }
      />

      <Tabs
        items={[
          {
            key: 'watchlist',
            label: '워치리스트 목록',
            children: (
              <>
                <SearchForm
                  form={wlSearchForm}
                  onSearch={handleWlSearch}
                  onReset={() => {
                    wlSearchForm.resetFields()
                    fetchWatchlist(1, {})
                  }}
                  loading={wlLoading}
                >
                  <Form.Item name="name" label="이름">
                    <Input placeholder="이름" style={{ width: 150 }} />
                  </Form.Item>
                  <Form.Item name="source" label="출처">
                    <Input placeholder="출처" style={{ width: 120 }} />
                  </Form.Item>
                  <Form.Item name="wl_tp" label="유형">
                    <Select placeholder="전체" style={{ width: 120 }} allowClear>
                      <Select.Option value="SANCTIONS">제재</Select.Option>
                      <Select.Option value="PEP">PEP</Select.Option>
                      <Select.Option value="ADVERSE_MEDIA">부정매체</Select.Option>
                    </Select>
                  </Form.Item>
                </SearchForm>
                <Table
                  dataSource={wlList}
                  columns={wlColumns}
                  rowKey="wl_id"
                  loading={wlLoading}
                  pagination={{
                    current: wlPage,
                    pageSize: 10,
                    total: wlTotal,
                    showTotal: (t) => `총 ${t}건`,
                    onChange: (p) => {
                      setWlPage(p)
                      const values = wlSearchForm.getFieldsValue()
                      fetchWatchlist(p, values)
                    },
                  }}
                  size="middle"
                />
              </>
            ),
          },
          {
            key: 'screening',
            label: '스크리닝 결과',
            children: (
              <>
                <SearchForm
                  form={scrSearchForm}
                  onSearch={handleScrSearch}
                  onReset={() => {
                    scrSearchForm.resetFields()
                    fetchScreenResults(1, {})
                  }}
                  loading={scrLoading}
                >
                  <Form.Item name="cust_no" label="고객번호">
                    <Input placeholder="고객번호" style={{ width: 150 }} />
                  </Form.Item>
                  <Form.Item name="stat" label="결과">
                    <Select placeholder="전체" style={{ width: 120 }} allowClear>
                      <Select.Option value="PENDING">대기</Select.Option>
                      <Select.Option value="MATCH">일치</Select.Option>
                      <Select.Option value="NO_MATCH">불일치</Select.Option>
                      <Select.Option value="POSSIBLE_MATCH">가능일치</Select.Option>
                    </Select>
                  </Form.Item>
                </SearchForm>
                <Table
                  dataSource={scrResults}
                  columns={scrColumns}
                  rowKey="scr_id"
                  loading={scrLoading}
                  pagination={{
                    current: scrPage,
                    pageSize: 10,
                    total: scrTotal,
                    showTotal: (t) => `총 ${t}건`,
                    onChange: (p) => {
                      setScrPage(p)
                      const values = scrSearchForm.getFieldsValue()
                      fetchScreenResults(p, values)
                    },
                  }}
                  size="middle"
                />
              </>
            ),
          },
        ]}
      />

      <Modal
        title="고객 스크리닝"
        open={screenModalOpen}
        onOk={handleScreen}
        onCancel={() => {
          setScreenModalOpen(false)
          screenForm.resetFields()
          setScreenResultData([])
        }}
        confirmLoading={screenLoading}
        okText="스크리닝 실행"
        cancelText="닫기"
        width={600}
      >
        <Form form={screenForm} layout="inline" style={{ marginBottom: 16 }}>
          <Form.Item
            name="cust_no"
            label="고객번호"
            rules={[{ required: true, message: '고객번호를 입력하세요' }]}
          >
            <Input placeholder="고객번호 입력" style={{ width: 200 }} />
          </Form.Item>
        </Form>
        {screenResultData.length > 0 && (
          <Table
            dataSource={screenResultData}
            columns={screenResultColumns}
            rowKey="scr_id"
            size="small"
            pagination={false}
            title={() => (
              <Space>
                <span>스크리닝 결과:</span>
                <strong>{screenResultData.length}건</strong>
              </Space>
            )}
          />
        )}
      </Modal>
    </div>
  )
}
