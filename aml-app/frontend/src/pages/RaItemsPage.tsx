import { useEffect, useState } from 'react'
import {
  Table,
  Button,
  Form,
  Input,
  Select,
  InputNumber,
  Modal,
  message,
  Tag,
  Switch,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { PlusOutlined, EditOutlined } from '@ant-design/icons'
import { getRaItems, createRaItem, updateRaItem } from '../api/ra'
import type { RaItem } from '../api/types'
import PageHeader from '../components/shared/PageHeader'

const RA_ITEM_TYPES = [
  { value: 'CUSTOMER', label: '고객특성' },
  { value: 'TRANSACTION', label: '거래특성' },
  { value: 'PRODUCT', label: '상품특성' },
  { value: 'CHANNEL', label: '채널특성' },
  { value: 'GEOGRAPHY', label: '지역특성' },
]

export default function RaItemsPage() {
  const [form] = Form.useForm()
  const [items, setItems] = useState<RaItem[]>([])
  const [loading, setLoading] = useState(false)
  const [modalOpen, setModalOpen] = useState(false)
  const [editItem, setEditItem] = useState<RaItem | null>(null)
  const [saving, setSaving] = useState(false)

  const fetchItems = async () => {
    setLoading(true)
    try {
      const data = await getRaItems()
      setItems(data)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : 'RA 항목 조회 실패')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchItems()
  }, [])

  const openCreate = () => {
    setEditItem(null)
    form.resetFields()
    form.setFieldsValue({ use_yn: 'Y' })
    setModalOpen(true)
  }

  const openEdit = (item: RaItem) => {
    setEditItem(item)
    form.setFieldsValue(item)
    setModalOpen(true)
  }

  const handleSave = async () => {
    try {
      const values = await form.validateFields()
      setSaving(true)
      if (editItem) {
        await updateRaItem(editItem.ra_item_cd, values)
        message.success('RA 항목이 수정되었습니다.')
      } else {
        await createRaItem(values)
        message.success('RA 항목이 등록되었습니다.')
      }
      setModalOpen(false)
      form.resetFields()
      fetchItems()
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setSaving(false)
    }
  }

  const columns: ColumnsType<RaItem> = [
    { title: '항목코드', dataIndex: 'ra_item_cd', key: 'ra_item_cd', width: 130 },
    { title: '항목명', dataIndex: 'ra_item_nm', key: 'ra_item_nm' },
    {
      title: '항목유형',
      dataIndex: 'ra_item_tp',
      key: 'ra_item_tp',
      render: (v) => RA_ITEM_TYPES.find((t) => t.value === v)?.label || v,
    },
    { title: '최대점수', dataIndex: 'max_scr', key: 'max_scr', width: 90, render: (v) => `${v}점` },
    {
      title: '가중치(%)',
      dataIndex: 'wght',
      key: 'wght',
      width: 100,
      render: (v) => `${v}%`,
    },
    {
      title: '사용여부',
      dataIndex: 'use_yn',
      key: 'use_yn',
      width: 90,
      render: (v) =>
        v === 'Y' ? (
          <Tag color="green">사용</Tag>
        ) : (
          <Tag color="default">미사용</Tag>
        ),
    },
    {
      title: '액션',
      key: 'action',
      width: 70,
      render: (_, record) => (
        <Button
          size="small"
          icon={<EditOutlined />}
          onClick={() => openEdit(record)}
        >
          수정
        </Button>
      ),
    },
  ]

  return (
    <div>
      <PageHeader
        title="RA 항목관리"
        actions={
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            항목추가
          </Button>
        }
      />

      <Table
        dataSource={items}
        columns={columns}
        rowKey="ra_item_cd"
        loading={loading}
        pagination={{ pageSize: 15, showTotal: (t) => `총 ${t}건` }}
        size="middle"
      />

      <Modal
        title={editItem ? 'RA 항목 수정' : 'RA 항목 추가'}
        open={modalOpen}
        onOk={handleSave}
        onCancel={() => {
          setModalOpen(false)
          form.resetFields()
        }}
        confirmLoading={saving}
        okText={editItem ? '저장' : '추가'}
        cancelText="취소"
        width={500}
      >
        <Form form={form} layout="vertical" style={{ marginTop: 16 }}>
          <div style={{ display: 'flex', gap: 16 }}>
            <Form.Item
              name="ra_item_cd"
              label="항목코드"
              rules={[{ required: true, message: '항목코드를 입력하세요' }]}
              style={{ flex: 1 }}
            >
              <Input disabled={!!editItem} placeholder="예: CUST_NATION" />
            </Form.Item>
            <Form.Item
              name="ra_item_tp"
              label="항목유형"
              rules={[{ required: true, message: '항목유형을 선택하세요' }]}
              style={{ flex: 1 }}
            >
              <Select options={RA_ITEM_TYPES} />
            </Form.Item>
          </div>
          <Form.Item
            name="ra_item_nm"
            label="항목명"
            rules={[{ required: true, message: '항목명을 입력하세요' }]}
          >
            <Input placeholder="예: 고객 국적 위험도" />
          </Form.Item>
          <div style={{ display: 'flex', gap: 16 }}>
            <Form.Item
              name="max_scr"
              label="최대점수"
              rules={[{ required: true, message: '최대점수를 입력하세요' }]}
              style={{ flex: 1 }}
            >
              <InputNumber min={1} max={100} style={{ width: '100%' }} suffix="점" />
            </Form.Item>
            <Form.Item
              name="wght"
              label="가중치 (%)"
              rules={[{ required: true, message: '가중치를 입력하세요' }]}
              style={{ flex: 1 }}
            >
              <InputNumber min={0} max={100} style={{ width: '100%' }} suffix="%" />
            </Form.Item>
          </div>
          <Form.Item name="use_yn" label="사용여부" valuePropName="checked"
            getValueFromEvent={(checked) => (checked ? 'Y' : 'N')}
            getValueProps={(value) => ({ checked: value === 'Y' })}
          >
            <Switch checkedChildren="사용" unCheckedChildren="미사용" />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  )
}
