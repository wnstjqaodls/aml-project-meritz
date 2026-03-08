import { useEffect, useState, useCallback } from 'react'
import {
  Table,
  Button,
  Tag,
  Select,
  Space,
  Modal,
  Form,
  Input,
  message,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { getSetVals, updateSetVal, getScenarios } from '../../api/tms'
import type { TmsSetVal, TmsScenario } from '../../api/types'
import PageHeader from '../../components/shared/PageHeader'

const { Text } = Typography

const valTypeLabelMap: Record<string, { color: string; label: string }> = {
  AMOUNT: { color: 'green', label: '금액' },
  COUNT: { color: 'blue', label: '건수' },
  DAYS: { color: 'purple', label: '기간' },
}

function ValTypeTag({ tp }: { tp?: string }) {
  if (!tp) return <Tag>-</Tag>
  const info = valTypeLabelMap[tp]
  if (!info) return <Tag>{tp}</Tag>
  return <Tag color={info.color}>{info.label}</Tag>
}

interface EditFormValues {
  set_val: string
}

export default function TmsSetValsPage() {
  const [filterScnrId, setFilterScnrId] = useState<string | undefined>()
  const [filterKey, setFilterKey] = useState('')
  const [data, setData] = useState<TmsSetVal[]>([])
  const [total, setTotal] = useState(0)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(false)
  const [scenarios, setScenarios] = useState<TmsScenario[]>([])

  const [editModalOpen, setEditModalOpen] = useState(false)
  const [editingRow, setEditingRow] = useState<TmsSetVal | null>(null)
  const [editLoading, setEditLoading] = useState(false)
  const [form] = Form.useForm<EditFormValues>()

  // Load scenarios for dropdown
  useEffect(() => {
    getScenarios({ size: 200 })
      .then((res) => setScenarios(res.data))
      .catch(() => {})
  }, [])

  const fetchData = useCallback(
    async (currentPage = 1) => {
      setLoading(true)
      try {
        const params: Record<string, unknown> = {
          page: currentPage,
          size: 20,
        }
        if (filterScnrId) params.scnr_id = filterScnrId
        if (filterKey) params.set_key = filterKey
        const res = await getSetVals(params)
        setData(res.data)
        setTotal(res.total)
      } catch (err: unknown) {
        message.error(err instanceof Error ? err.message : '임계값 조회 실패')
      } finally {
        setLoading(false)
      }
    },
    [filterScnrId, filterKey]
  )

  useEffect(() => {
    fetchData(1)
    setPage(1)
  }, [filterScnrId, filterKey])

  const openEdit = (e: React.MouseEvent, row: TmsSetVal) => {
    e.stopPropagation()
    setEditingRow(row)
    form.setFieldsValue({ set_val: row.set_val })
    setEditModalOpen(true)
  }

  const handleEditOk = async () => {
    if (!editingRow) return
    let values: EditFormValues
    try {
      values = await form.validateFields()
    } catch {
      return
    }
    setEditLoading(true)
    try {
      await updateSetVal(editingRow.set_id, { set_val: values.set_val })
      message.success('결재 요청이 생성되었습니다.')
      setEditModalOpen(false)
      fetchData(page)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '수정 실패')
    } finally {
      setEditLoading(false)
    }
  }

  const columns: ColumnsType<TmsSetVal> = [
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
      render: (v) => v || '-',
    },
    {
      title: '설정키',
      dataIndex: 'set_key',
      key: 'set_key',
      width: 160,
    },
    {
      title: '설정항목명',
      dataIndex: 'set_nm',
      key: 'set_nm',
      render: (v) => v || '-',
    },
    {
      title: '현재값',
      dataIndex: 'set_val',
      key: 'set_val',
      width: 130,
      render: (v, record) => {
        const tp = record.val_tp_cd
        if (tp === 'AMOUNT') {
          return (
            <Text>
              ₩{Number(v).toLocaleString('ko-KR')}
            </Text>
          )
        }
        return <Text>{v}</Text>
      },
    },
    {
      title: '이전값',
      dataIndex: 'prev_val',
      key: 'prev_val',
      width: 130,
      render: (v) => (v ? <Text type="secondary">{v}</Text> : '-'),
    },
    {
      title: '값유형',
      dataIndex: 'val_tp_cd',
      key: 'val_tp_cd',
      width: 90,
      render: (v) => <ValTypeTag tp={v} />,
    },
    {
      title: '수정일시',
      dataIndex: 'upd_dt',
      key: 'upd_dt',
      width: 160,
      render: (v) => v || '-',
    },
    {
      title: '액션',
      key: 'actions',
      width: 80,
      render: (_, record) => (
        <Button size="small" onClick={(e) => openEdit(e, record)}>
          수정
        </Button>
      ),
    },
  ]

  return (
    <div>
      <PageHeader
        title="임계값 관리"
        subtitle="TMS 시나리오별 임계값 설정 관리"
      />

      <Space style={{ marginBottom: 16 }}>
        <Select
          value={filterScnrId}
          onChange={(v) => setFilterScnrId(v)}
          style={{ width: 220 }}
          placeholder="시나리오 선택"
          allowClear
          showSearch
          optionFilterProp="label"
          options={scenarios.map((s) => ({
            value: s.scnr_id,
            label: `${s.scnr_id} - ${s.scnr_nm}`,
          }))}
        />
        <Input
          placeholder="설정키 검색"
          value={filterKey}
          onChange={(e) => setFilterKey(e.target.value)}
          style={{ width: 160 }}
          allowClear
        />
      </Space>

      <Table
        dataSource={data}
        columns={columns}
        rowKey="set_id"
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

      <Modal
        title="임계값 수정"
        open={editModalOpen}
        onOk={handleEditOk}
        onCancel={() => setEditModalOpen(false)}
        confirmLoading={editLoading}
        okText="저장 (결재요청)"
        cancelText="취소"
        destroyOnClose
      >
        {editingRow && (
          <>
            <div style={{ marginBottom: 16 }}>
              <Text type="secondary">시나리오: </Text>
              <Text strong>{editingRow.scnr_id}</Text>
              {editingRow.scnr_nm && (
                <Text type="secondary"> ({editingRow.scnr_nm})</Text>
              )}
              <br />
              <Text type="secondary">설정키: </Text>
              <Text strong>{editingRow.set_key}</Text>
              {editingRow.set_nm && (
                <Text type="secondary"> ({editingRow.set_nm})</Text>
              )}
              <br />
              <Text type="secondary">현재값: </Text>
              <Text>{editingRow.set_val}</Text>
            </div>
            <Form form={form} layout="vertical">
              <Form.Item
                name="set_val"
                label="변경값"
                rules={[{ required: true, message: '변경값을 입력하세요.' }]}
              >
                <Input placeholder="새 값 입력" />
              </Form.Item>
            </Form>
            <Text type="secondary" style={{ fontSize: 12 }}>
              저장 시 결재 요청이 자동으로 생성됩니다.
            </Text>
          </>
        )}
      </Modal>
    </div>
  )
}
