import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Tag,
  Select,
  Space,
  Modal,
  Drawer,
  Form,
  Input,
  InputNumber,
  Switch,
  Descriptions,
  Divider,
  message,
  Row,
  Col,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { PlusOutlined } from '@ant-design/icons'
import {
  getScenarios,
  getScenario,
  createScenario,
  updateScenario,
  getSetValsByScnr,
} from '../../api/tms'
import type { TmsScenario, TmsSetVal } from '../../api/types'
import PageHeader from '../../components/shared/PageHeader'
import AmountDisplay from '../../components/shared/AmountDisplay'

const { Text } = Typography

const SCENARIO_TYPE_OPTIONS = [
  { value: '', label: '전체' },
  { value: 'STR', label: 'STR' },
  { value: 'CTR', label: 'CTR' },
]

const USE_YN_OPTIONS = [
  { value: '', label: '전체' },
  { value: 'Y', label: '사용' },
  { value: 'N', label: '미사용' },
]

const CATEGORY_OPTIONS = [
  { value: 'CASH', label: '현금' },
  { value: 'TRANSFER', label: '이체' },
  { value: 'OVERSEAS', label: '해외송금' },
  { value: 'PATTERN', label: '패턴' },
  { value: 'OTHER', label: '기타' },
]

const valTypeLabelMap: Record<string, { color: string; label: string }> = {
  AMOUNT: { color: 'green', label: '금액' },
  COUNT: { color: 'blue', label: '건수' },
  DAYS: { color: 'purple', label: '기간' },
}

function ScenarioTypeTag({ tp }: { tp: string }) {
  if (tp === 'STR') return <Tag color="red">STR</Tag>
  if (tp === 'CTR') return <Tag color="blue">CTR</Tag>
  return <Tag>{tp}</Tag>
}

function UseYnTag({ yn }: { yn: string }) {
  return yn === 'Y' ? (
    <Tag color="green">사용</Tag>
  ) : (
    <Tag color="default">미사용</Tag>
  )
}

interface ScenarioFormValues {
  scnr_id: string
  scnr_nm: string
  scnr_nm_en?: string
  scnr_tp_cd: string
  scnr_cat_cd?: string
  period_day?: number
  threshold_amt?: number
  threshold_cnt?: number
  alert_yn: boolean
  use_yn: boolean
  remark?: string
}

export default function TmsScenariosPage() {
  const [filterType, setFilterType] = useState('')
  const [filterUse, setFilterUse] = useState('')
  const [data, setData] = useState<TmsScenario[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)

  // Detail drawer
  const [drawerOpen, setDrawerOpen] = useState(false)
  const [selectedScenario, setSelectedScenario] = useState<TmsScenario | null>(null)
  const [setVals, setSetVals] = useState<TmsSetVal[]>([])
  const [drawerLoading, setDrawerLoading] = useState(false)

  // Create/edit modal
  const [modalOpen, setModalOpen] = useState(false)
  const [editingScenario, setEditingScenario] = useState<TmsScenario | null>(null)
  const [modalLoading, setModalLoading] = useState(false)
  const [form] = Form.useForm<ScenarioFormValues>()

  const fetchData = useCallback(
    async (currentPage = 1) => {
      setLoading(true)
      try {
        const params: Record<string, unknown> = {
          page: currentPage,
          size: 20,
        }
        if (filterType) params.scnr_tp_cd = filterType
        if (filterUse) params.use_yn = filterUse
        const res = await getScenarios(params)
        setData(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : '시나리오 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [filterType, filterUse]
  )

  useEffect(() => {
    fetchData(1)
    setPage(1)
  }, [filterType, filterUse])

  const openDetail = async (scenario: TmsScenario) => {
    setDrawerOpen(true)
    setDrawerLoading(true)
    try {
      const [detail, vals] = await Promise.all([
        getScenario(scenario.scnr_id),
        getSetValsByScnr(scenario.scnr_id),
      ])
      setSelectedScenario(detail)
      setSetVals(vals)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '시나리오 상세 조회 실패')
    } finally {
      setDrawerLoading(false)
    }
  }

  const openCreateModal = () => {
    setEditingScenario(null)
    form.resetFields()
    form.setFieldsValue({ alert_yn: true, use_yn: true })
    setModalOpen(true)
  }

  const openEditModal = (e: React.MouseEvent, scenario: TmsScenario) => {
    e.stopPropagation()
    setEditingScenario(scenario)
    form.setFieldsValue({
      scnr_id: scenario.scnr_id,
      scnr_nm: scenario.scnr_nm,
      scnr_nm_en: scenario.scnr_nm_en,
      scnr_tp_cd: scenario.scnr_tp_cd,
      scnr_cat_cd: scenario.scnr_cat_cd,
      period_day: scenario.period_day,
      threshold_amt: scenario.threshold_amt,
      threshold_cnt: scenario.threshold_cnt,
      alert_yn: scenario.alert_yn === 'Y',
      use_yn: scenario.use_yn === 'Y',
      remark: scenario.remark,
    })
    setModalOpen(true)
  }

  const handleModalOk = async () => {
    let values: ScenarioFormValues
    try {
      values = await form.validateFields()
    } catch {
      return
    }
    setModalLoading(true)
    try {
      const payload: Partial<TmsScenario> = {
        scnr_id: values.scnr_id,
        scnr_nm: values.scnr_nm,
        scnr_nm_en: values.scnr_nm_en,
        scnr_tp_cd: values.scnr_tp_cd,
        scnr_cat_cd: values.scnr_cat_cd,
        period_day: values.period_day,
        threshold_amt: values.threshold_amt,
        threshold_cnt: values.threshold_cnt,
        alert_yn: values.alert_yn ? 'Y' : 'N',
        use_yn: values.use_yn ? 'Y' : 'N',
        remark: values.remark,
      }
      if (editingScenario) {
        await updateScenario(editingScenario.scnr_id, payload)
        message.success('시나리오가 수정되었습니다.')
      } else {
        await createScenario(payload)
        message.success('시나리오가 등록되었습니다.')
      }
      setModalOpen(false)
      fetchData(page)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '저장 실패')
    } finally {
      setModalLoading(false)
    }
  }

  const setValColumns: ColumnsType<TmsSetVal> = [
    { title: '설정키', dataIndex: 'set_key', key: 'set_key', width: 150 },
    { title: '설정항목명', dataIndex: 'set_nm', key: 'set_nm' },
    { title: '현재값', dataIndex: 'set_val', key: 'set_val', width: 120 },
    {
      title: '값유형',
      dataIndex: 'val_tp_cd',
      key: 'val_tp_cd',
      width: 100,
      render: (v: string) => {
        const info = valTypeLabelMap[v]
        if (!info) return <Tag>{v || '-'}</Tag>
        return <Tag color={info.color}>{info.label}</Tag>
      },
    },
  ]

  const columns: ColumnsType<TmsScenario> = [
    {
      title: '시나리오ID',
      dataIndex: 'scnr_id',
      key: 'scnr_id',
      width: 130,
    },
    {
      title: '시나리오명',
      dataIndex: 'scnr_nm',
      key: 'scnr_nm',
    },
    {
      title: '구분',
      dataIndex: 'scnr_tp_cd',
      key: 'scnr_tp_cd',
      width: 80,
      render: (v) => <ScenarioTypeTag tp={v} />,
    },
    {
      title: '카테고리',
      dataIndex: 'scnr_cat_cd',
      key: 'scnr_cat_cd',
      width: 100,
      render: (v) => {
        const opt = CATEGORY_OPTIONS.find((o) => o.value === v)
        return opt ? opt.label : v || '-'
      },
    },
    {
      title: '탐지기간(일)',
      dataIndex: 'period_day',
      key: 'period_day',
      width: 110,
      align: 'right',
      render: (v) => (v != null ? `${v}일` : '-'),
    },
    {
      title: '임계금액',
      dataIndex: 'threshold_amt',
      key: 'threshold_amt',
      width: 150,
      align: 'right',
      render: (v) => (v != null ? <AmountDisplay amount={v} /> : '-'),
    },
    {
      title: '사용여부',
      dataIndex: 'use_yn',
      key: 'use_yn',
      width: 90,
      render: (v) => <UseYnTag yn={v} />,
    },
    {
      title: '결재번호',
      dataIndex: 'lst_app_no',
      key: 'lst_app_no',
      width: 100,
      render: (v) => v || '-',
    },
    {
      title: '등록일',
      dataIndex: 'reg_dt',
      key: 'reg_dt',
      width: 110,
    },
    {
      title: '액션',
      key: 'actions',
      width: 130,
      render: (_, record) => (
        <Space size="small">
          <Button
            size="small"
            onClick={(e) => {
              e.stopPropagation()
              openDetail(record)
            }}
          >
            상세
          </Button>
          <Button size="small" onClick={(e) => openEditModal(e, record)}>
            수정
          </Button>
        </Space>
      ),
    },
  ]

  return (
    <div>
      <PageHeader
        title="시나리오 관리"
        subtitle="TMS 탐지 시나리오 설정 및 관리"
        actions={
          <Button
            type="primary"
            icon={<PlusOutlined />}
            onClick={openCreateModal}
          >
            신규 등록
          </Button>
        }
      />

      <Space style={{ marginBottom: 16 }}>
        <Select
          value={filterType}
          onChange={(v) => setFilterType(v)}
          options={SCENARIO_TYPE_OPTIONS}
          style={{ width: 120 }}
          placeholder="시나리오유형"
        />
        <Select
          value={filterUse}
          onChange={(v) => setFilterUse(v)}
          options={USE_YN_OPTIONS}
          style={{ width: 120 }}
          placeholder="사용여부"
        />
      </Space>

      <Table
        dataSource={data}
        columns={columns}
        rowKey="scnr_id"
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

      {/* Detail Drawer */}
      <Drawer
        title={`시나리오 상세 - ${selectedScenario?.scnr_id || ''}`}
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        width={680}
        loading={drawerLoading}
      >
        {selectedScenario && (
          <>
            <Descriptions bordered column={2} size="small">
              <Descriptions.Item label="시나리오ID">
                {selectedScenario.scnr_id}
              </Descriptions.Item>
              <Descriptions.Item label="구분">
                <ScenarioTypeTag tp={selectedScenario.scnr_tp_cd} />
              </Descriptions.Item>
              <Descriptions.Item label="시나리오명" span={2}>
                {selectedScenario.scnr_nm}
              </Descriptions.Item>
              {selectedScenario.scnr_nm_en && (
                <Descriptions.Item label="영문명" span={2}>
                  {selectedScenario.scnr_nm_en}
                </Descriptions.Item>
              )}
              <Descriptions.Item label="카테고리">
                {CATEGORY_OPTIONS.find((o) => o.value === selectedScenario.scnr_cat_cd)?.label ||
                  selectedScenario.scnr_cat_cd || '-'}
              </Descriptions.Item>
              <Descriptions.Item label="탐지기간">
                {selectedScenario.period_day != null
                  ? `${selectedScenario.period_day}일`
                  : '-'}
              </Descriptions.Item>
              <Descriptions.Item label="임계금액">
                {selectedScenario.threshold_amt != null ? (
                  <AmountDisplay amount={selectedScenario.threshold_amt} />
                ) : (
                  '-'
                )}
              </Descriptions.Item>
              <Descriptions.Item label="임계건수">
                {selectedScenario.threshold_cnt != null
                  ? `${selectedScenario.threshold_cnt}건`
                  : '-'}
              </Descriptions.Item>
              <Descriptions.Item label="알림발생">
                <UseYnTag yn={selectedScenario.alert_yn} />
              </Descriptions.Item>
              <Descriptions.Item label="사용여부">
                <UseYnTag yn={selectedScenario.use_yn} />
              </Descriptions.Item>
              <Descriptions.Item label="최종결재번호">
                {selectedScenario.lst_app_no || '-'}
              </Descriptions.Item>
              <Descriptions.Item label="등록일">
                {selectedScenario.reg_dt || '-'}
              </Descriptions.Item>
              {selectedScenario.remark && (
                <Descriptions.Item label="비고" span={2}>
                  {selectedScenario.remark}
                </Descriptions.Item>
              )}
            </Descriptions>

            <Divider />

            <Typography.Title level={5}>하위 임계값 목록</Typography.Title>
            <Table
              dataSource={setVals}
              columns={setValColumns}
              rowKey="set_id"
              size="small"
              pagination={false}
              locale={{ emptyText: '등록된 임계값이 없습니다.' }}
            />
          </>
        )}
      </Drawer>

      {/* Create/Edit Modal */}
      <Modal
        title={editingScenario ? '시나리오 수정' : '시나리오 신규 등록'}
        open={modalOpen}
        onOk={handleModalOk}
        onCancel={() => setModalOpen(false)}
        confirmLoading={modalLoading}
        okText={editingScenario ? '수정' : '등록'}
        cancelText="취소"
        width={600}
        destroyOnClose
      >
        <Form form={form} layout="vertical" style={{ marginTop: 16 }}>
          <Row gutter={16}>
            <Col span={12}>
              <Form.Item
                name="scnr_id"
                label="시나리오ID"
                rules={[{ required: true, message: '시나리오ID를 입력하세요.' }]}
              >
                <Input
                  placeholder="SCNR001"
                  disabled={!!editingScenario}
                />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                name="scnr_tp_cd"
                label="구분"
                rules={[{ required: true, message: '구분을 선택하세요.' }]}
              >
                <Select
                  options={[
                    { value: 'STR', label: 'STR' },
                    { value: 'CTR', label: 'CTR' },
                  ]}
                  placeholder="선택"
                />
              </Form.Item>
            </Col>
            <Col span={24}>
              <Form.Item
                name="scnr_nm"
                label="시나리오명"
                rules={[{ required: true, message: '시나리오명을 입력하세요.' }]}
              >
                <Input placeholder="시나리오 명칭 입력" />
              </Form.Item>
            </Col>
            <Col span={24}>
              <Form.Item name="scnr_nm_en" label="영문명">
                <Input placeholder="Scenario name in English" />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item name="scnr_cat_cd" label="카테고리">
                <Select options={CATEGORY_OPTIONS} placeholder="선택" allowClear />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item name="period_day" label="탐지기간(일)">
                <InputNumber
                  style={{ width: '100%' }}
                  min={1}
                  placeholder="예: 30"
                />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item name="threshold_amt" label="임계금액">
                <InputNumber
                  style={{ width: '100%' }}
                  min={0}
                  placeholder="예: 10000000"
                  formatter={(v) => `${v}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')}
                />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item name="threshold_cnt" label="임계건수">
                <InputNumber
                  style={{ width: '100%' }}
                  min={1}
                  placeholder="예: 5"
                />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                name="alert_yn"
                label="알림발생"
                valuePropName="checked"
              >
                <Switch checkedChildren="Y" unCheckedChildren="N" />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                name="use_yn"
                label="사용여부"
                valuePropName="checked"
              >
                <Switch checkedChildren="사용" unCheckedChildren="미사용" />
              </Form.Item>
            </Col>
            <Col span={24}>
              <Form.Item name="remark" label="비고">
                <Input.TextArea rows={3} placeholder="비고 입력" />
              </Form.Item>
            </Col>
          </Row>
        </Form>
      </Modal>
    </div>
  )
}
