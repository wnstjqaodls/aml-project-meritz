import { useState, useCallback } from 'react'
import {
  Table,
  Form,
  Input,
  Select,
  Button,
  Space,
  DatePicker,
  InputNumber,
  Tag,
  Card,
  Row,
  Col,
  message,
  Collapse,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { SearchOutlined, DownloadOutlined, ReloadOutlined } from '@ant-design/icons'
import dayjs from 'dayjs'
import { searchTransactions } from '../../api/tms'
import type { TmsTransactionItem } from '../../api/types'
import PageHeader from '../../components/shared/PageHeader'
import AmountDisplay from '../../components/shared/AmountDisplay'

const { RangePicker } = DatePicker

const TRXN_TYPE_OPTIONS = [
  { value: '', label: '전체' },
  { value: 'DEPOSIT', label: '입금' },
  { value: 'WITHDRAW', label: '출금' },
  { value: 'TRANSFER', label: '이체' },
  { value: 'OVERSEAS', label: '해외송금' },
]

const trxnTypeLabel: Record<string, { label: string; color: string }> = {
  DEPOSIT: { label: '입금', color: 'green' },
  WITHDRAW: { label: '출금', color: 'red' },
  TRANSFER: { label: '이체', color: 'blue' },
  OVERSEAS: { label: '해외송금', color: 'purple' },
}

export default function TmsTransactionsPage() {
  const [form] = Form.useForm()
  const [data, setData] = useState<TmsTransactionItem[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [searched, setSearched] = useState(false)

  const fetchData = useCallback(
    async (currentPage = 1, formValues?: Record<string, unknown>) => {
      const values = formValues ?? form.getFieldsValue()
      const dateRange = values.date_range as [dayjs.Dayjs, dayjs.Dayjs] | undefined

      const params: Record<string, unknown> = {
        page: currentPage,
        size: 20,
      }
      if (values.cust_no) params.cust_no = values.cust_no
      if (values.acct_no) params.acct_no = values.acct_no
      if (values.trxn_tp_cd) params.trxn_tp_cd = values.trxn_tp_cd
      if (dateRange?.[0]) params.trxn_dt_from = dateRange[0].format('YYYY-MM-DD')
      if (dateRange?.[1]) params.trxn_dt_to = dateRange[1].format('YYYY-MM-DD')
      if (values.amt_min != null) params.amt_min = values.amt_min
      if (values.amt_max != null) params.amt_max = values.amt_max

      setLoading(true)
      try {
        const res = await searchTransactions(params)
        setData(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : '거래 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [form]
  )

  const handleSearch = async () => {
    setPage(1)
    setSearched(true)
    await fetchData(1)
  }

  const handleReset = () => {
    form.resetFields()
    setData([])
    setTotal(0)
    setPage(1)
    setSearched(false)
  }

  const handleExport = () => {
    message.info('엑셀 내보내기 기능은 준비 중입니다.')
  }

  const columns: ColumnsType<TmsTransactionItem> = [
    {
      title: '거래일자',
      dataIndex: 'trxn_dt',
      key: 'trxn_dt',
      width: 110,
    },
    {
      title: '거래시간',
      dataIndex: 'trxn_tm',
      key: 'trxn_tm',
      width: 90,
    },
    {
      title: '고객번호',
      dataIndex: 'cust_no',
      key: 'cust_no',
      width: 120,
    },
    {
      title: '계좌번호',
      dataIndex: 'acct_no',
      key: 'acct_no',
      width: 150,
    },
    {
      title: '거래유형',
      dataIndex: 'trxn_tp_cd',
      key: 'trxn_tp_cd',
      width: 100,
      render: (v: string) => {
        const info = trxnTypeLabel[v]
        if (!info) return <Tag>{v || '-'}</Tag>
        return <Tag color={info.color}>{info.label}</Tag>
      },
    },
    {
      title: '거래금액',
      dataIndex: 'trxn_amt',
      key: 'trxn_amt',
      width: 150,
      align: 'right',
      render: (v, record) => (
        <AmountDisplay amount={v} currency={record.trxn_ccy || 'KRW'} />
      ),
    },
    {
      title: '통화',
      dataIndex: 'trxn_ccy',
      key: 'trxn_ccy',
      width: 70,
      render: (v) => v || 'KRW',
    },
    {
      title: '상대방',
      dataIndex: 'cntrp_nm',
      key: 'cntrp_nm',
    },
    {
      title: '상대은행',
      dataIndex: 'cntrp_bank_cd',
      key: 'cntrp_bank_cd',
      width: 100,
    },
    {
      title: '채널',
      dataIndex: 'chnl_cd',
      key: 'chnl_cd',
      width: 90,
    },
  ]

  return (
    <div>
      <PageHeader
        title="거래조회"
        subtitle="TMS 거래모니터링 - 거래 내역 조회"
        actions={
          <Button
            icon={<DownloadOutlined />}
            onClick={handleExport}
            disabled={data.length === 0}
          >
            내보내기
          </Button>
        }
      />

      <Card style={{ marginBottom: 16 }}>
        <Collapse
          defaultActiveKey={['search']}
          ghost
          items={[
            {
              key: 'search',
              label: '검색 조건',
              children: (
                <Form form={form} layout="vertical">
                  <Row gutter={16}>
                    <Col xs={24} sm={12} md={6}>
                      <Form.Item name="cust_no" label="고객번호">
                        <Input placeholder="고객번호 입력" allowClear />
                      </Form.Item>
                    </Col>
                    <Col xs={24} sm={12} md={6}>
                      <Form.Item name="acct_no" label="계좌번호">
                        <Input placeholder="계좌번호 입력" allowClear />
                      </Form.Item>
                    </Col>
                    <Col xs={24} sm={12} md={6}>
                      <Form.Item name="trxn_tp_cd" label="거래유형">
                        <Select
                          options={TRXN_TYPE_OPTIONS}
                          placeholder="전체"
                          allowClear
                        />
                      </Form.Item>
                    </Col>
                    <Col xs={24} sm={12} md={6}>
                      <Form.Item name="date_range" label="거래일자">
                        <RangePicker style={{ width: '100%' }} />
                      </Form.Item>
                    </Col>
                    <Col xs={24} sm={12} md={6}>
                      <Form.Item name="amt_min" label="최소금액">
                        <InputNumber
                          style={{ width: '100%' }}
                          placeholder="0"
                          min={0}
                          formatter={(v) =>
                            `${v}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
                          }
                        />
                      </Form.Item>
                    </Col>
                    <Col xs={24} sm={12} md={6}>
                      <Form.Item name="amt_max" label="최대금액">
                        <InputNumber
                          style={{ width: '100%' }}
                          placeholder="제한 없음"
                          min={0}
                          formatter={(v) =>
                            `${v}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
                          }
                        />
                      </Form.Item>
                    </Col>
                    <Col xs={24} style={{ display: 'flex', alignItems: 'flex-end' }}>
                      <Space>
                        <Button
                          type="primary"
                          icon={<SearchOutlined />}
                          onClick={handleSearch}
                          loading={loading}
                        >
                          조회
                        </Button>
                        <Button
                          icon={<ReloadOutlined />}
                          onClick={handleReset}
                        >
                          초기화
                        </Button>
                      </Space>
                    </Col>
                  </Row>
                </Form>
              ),
            },
          ]}
        />
      </Card>

      <Table
        dataSource={data}
        columns={columns}
        rowKey="trxn_id"
        loading={loading}
        size="middle"
        scroll={{ x: 1100 }}
        locale={{
          emptyText: searched ? '조회 결과가 없습니다.' : '검색 조건을 입력하고 조회하세요.',
        }}
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
    </div>
  )
}
