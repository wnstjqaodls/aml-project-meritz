import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import {
  Button,
  Descriptions,
  Divider,
  Tag,
  Typography,
  Input,
  Space,
  message,
  Spin,
  Select,
  Timeline,
  Card,
  Row,
  Col,
  Modal,
  Form,
  DatePicker,
} from 'antd'
import {
  ArrowLeftOutlined,
  SendOutlined,
  FileTextOutlined,
} from '@ant-design/icons'
import dayjs from 'dayjs'
import {
  getCaseDetail,
  updateCase,
  getCaseComments,
  addCaseComment,
} from '../api/cases'
import { createStrReport } from '../api/reports'
import type { Case, CaseComment } from '../api/types'
import StatusTag from '../components/shared/StatusTag'
import AmountDisplay from '../components/shared/AmountDisplay'

const { Title, Text } = Typography
const { TextArea } = Input

const priorityColor: Record<string, string> = {
  HIGH: 'red',
  MEDIUM: 'orange',
  LOW: 'blue',
}
const priorityLabel: Record<string, string> = {
  HIGH: '높음',
  MEDIUM: '중간',
  LOW: '낮음',
}
const ANALYSTS = ['admin', 'analyst01', 'analyst02', 'analyst03']

export default function CaseDetailPage() {
  const { caseId } = useParams<{ caseId: string }>()
  const navigate = useNavigate()
  const [strForm] = Form.useForm()

  const [caseData, setCaseData] = useState<Case | null>(null)
  const [comments, setComments] = useState<CaseComment[]>([])
  const [loading, setLoading] = useState(true)
  const [commentText, setCommentText] = useState('')
  const [addingComment, setAddingComment] = useState(false)
  const [updating, setUpdating] = useState(false)

  const [strModalOpen, setStrModalOpen] = useState(false)
  const [strSaving, setStrSaving] = useState(false)

  const fetchData = async () => {
    if (!caseId) return
    setLoading(true)
    try {
      const [caseDetail, caseComments] = await Promise.all([
        getCaseDetail(caseId),
        getCaseComments(caseId),
      ])
      setCaseData(caseDetail)
      setComments(caseComments)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '케이스 조회 실패')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchData()
  }, [caseId])

  const handleStatusChange = async (newStat: string) => {
    if (!caseData) return
    setUpdating(true)
    try {
      const updated = await updateCase(caseData.case_id, { stat: newStat })
      setCaseData(updated)
      message.success('상태가 변경되었습니다.')
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '상태 변경 실패')
    } finally {
      setUpdating(false)
    }
  }

  const handleAssignAnalyst = async (analyst: string) => {
    if (!caseData) return
    setUpdating(true)
    try {
      const updated = await updateCase(caseData.case_id, { analyst })
      setCaseData(updated)
      message.success('담당자가 변경되었습니다.')
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '담당자 변경 실패')
    } finally {
      setUpdating(false)
    }
  }

  const handleAddComment = async () => {
    if (!commentText.trim() || !caseId) return
    setAddingComment(true)
    try {
      const newComment = await addCaseComment(caseId, commentText.trim())
      setComments((prev) => [...prev, newComment])
      setCommentText('')
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '댓글 추가 실패')
    } finally {
      setAddingComment(false)
    }
  }

  const handleStrReport = async () => {
    try {
      const values = await strForm.validateFields()
      setStrSaving(true)
      await createStrReport({
        ...values,
        cust_no: caseData?.cust_no,
        case_no: caseData?.case_no,
        sus_fr_dt: values.sus_period?.[0]?.format('YYYY-MM-DD'),
        sus_to_dt: values.sus_period?.[1]?.format('YYYY-MM-DD'),
      })
      await updateCase(caseData!.case_id, { str_yn: 'Y' })
      message.success('STR 보고서가 생성되었습니다.')
      setStrModalOpen(false)
      strForm.resetFields()
      fetchData()
    } catch (err: unknown) {
      if (err instanceof Error) message.error(err.message)
    } finally {
      setStrSaving(false)
    }
  }

  if (loading) {
    return (
      <div style={{ textAlign: 'center', paddingTop: 80 }}>
        <Spin size="large" />
      </div>
    )
  }

  if (!caseData) {
    return <div>케이스를 찾을 수 없습니다.</div>
  }

  return (
    <div>
      <div style={{ marginBottom: 16 }}>
        <Button
          icon={<ArrowLeftOutlined />}
          onClick={() => navigate('/cases')}
          type="text"
        >
          케이스 목록
        </Button>
      </div>

      <Row gutter={[16, 16]}>
        <Col xs={24} lg={16}>
          <Card
            title={
              <Space>
                <Title level={5} style={{ margin: 0 }}>
                  케이스 정보
                </Title>
                <Tag color={priorityColor[caseData.priority] || 'default'}>
                  {priorityLabel[caseData.priority] || caseData.priority}
                </Tag>
                <StatusTag status={caseData.stat} type="case" />
              </Space>
            }
            extra={
              <Space>
                {caseData.str_yn === 'N' && (
                  <Button
                    icon={<FileTextOutlined />}
                    onClick={() => setStrModalOpen(true)}
                    size="small"
                  >
                    STR 보고
                  </Button>
                )}
              </Space>
            }
          >
            <Descriptions bordered column={2} size="small">
              <Descriptions.Item label="케이스번호">
                {caseData.case_no}
              </Descriptions.Item>
              <Descriptions.Item label="케이스유형">
                {caseData.case_tp}
              </Descriptions.Item>
              <Descriptions.Item label="고객번호">
                {caseData.cust_no}
              </Descriptions.Item>
              <Descriptions.Item label="고객명">
                {caseData.cust_nm}
              </Descriptions.Item>
              <Descriptions.Item label="STR 보고여부">
                {caseData.str_yn === 'Y' ? (
                  <Tag color="green">완료</Tag>
                ) : (
                  <Tag color="default">미보고</Tag>
                )}
              </Descriptions.Item>
              <Descriptions.Item label="CTR 보고여부">
                {caseData.ctr_yn === 'Y' ? (
                  <Tag color="green">완료</Tag>
                ) : (
                  <Tag color="default">미보고</Tag>
                )}
              </Descriptions.Item>
              <Descriptions.Item label="개시일">
                {caseData.open_dt}
              </Descriptions.Item>
              <Descriptions.Item label="종결일">
                {caseData.close_dt || '-'}
              </Descriptions.Item>
              <Descriptions.Item label="내용" span={2}>
                {caseData.desc || '-'}
              </Descriptions.Item>
            </Descriptions>

            <Divider />

            <Space size="large" wrap>
              <div>
                <Text type="secondary">담당자 변경</Text>
                <div style={{ marginTop: 8 }}>
                  <Select
                    value={caseData.analyst || undefined}
                    onChange={handleAssignAnalyst}
                    style={{ width: 160 }}
                    loading={updating}
                    placeholder="담당자 선택"
                  >
                    {ANALYSTS.map((a) => (
                      <Select.Option key={a} value={a}>
                        {a}
                      </Select.Option>
                    ))}
                  </Select>
                </div>
              </div>
              <div>
                <Text type="secondary">상태 변경</Text>
                <div style={{ marginTop: 8 }}>
                  <Space>
                    <Button
                      onClick={() => handleStatusChange('REVIEW')}
                      disabled={
                        caseData.stat === 'REVIEW' ||
                        caseData.stat === 'CLOSED' ||
                        caseData.stat === 'REPORTED'
                      }
                      loading={updating}
                      size="small"
                    >
                      검토중
                    </Button>
                    <Button
                      onClick={() => handleStatusChange('REPORTED')}
                      disabled={
                        caseData.stat === 'CLOSED' ||
                        caseData.stat === 'REPORTED'
                      }
                      loading={updating}
                      size="small"
                    >
                      보고완료
                    </Button>
                    <Button
                      danger
                      onClick={() => handleStatusChange('CLOSED')}
                      disabled={
                        caseData.stat === 'CLOSED' ||
                        caseData.stat === 'REPORTED'
                      }
                      loading={updating}
                      size="small"
                    >
                      종결
                    </Button>
                  </Space>
                </div>
              </div>
            </Space>
          </Card>
        </Col>

        <Col xs={24} lg={8}>
          <Card title="의견 이력" style={{ height: '100%' }}>
            <div style={{ maxHeight: 300, overflowY: 'auto', marginBottom: 16 }}>
              {comments.length === 0 ? (
                <Text type="secondary">등록된 의견이 없습니다.</Text>
              ) : (
                <Timeline
                  items={comments.map((c) => ({
                    key: c.comment_id,
                    children: (
                      <div>
                        <div>
                          <Text strong style={{ fontSize: 12 }}>
                            {c.author}
                          </Text>
                          <Text
                            type="secondary"
                            style={{ fontSize: 11, marginLeft: 8 }}
                          >
                            {c.created_at}
                          </Text>
                        </div>
                        <div style={{ marginTop: 4 }}>{c.content}</div>
                      </div>
                    ),
                  }))}
                />
              )}
            </div>

            <Divider style={{ margin: '12px 0' }} />

            <div>
              <TextArea
                value={commentText}
                onChange={(e) => setCommentText(e.target.value)}
                placeholder="의견을 입력하세요..."
                rows={3}
                style={{ marginBottom: 8 }}
              />
              <Button
                type="primary"
                icon={<SendOutlined />}
                onClick={handleAddComment}
                loading={addingComment}
                disabled={!commentText.trim()}
                size="small"
              >
                등록
              </Button>
            </div>
          </Card>
        </Col>
      </Row>

      <Modal
        title="STR 혐의거래 보고"
        open={strModalOpen}
        onOk={handleStrReport}
        onCancel={() => {
          setStrModalOpen(false)
          strForm.resetFields()
        }}
        confirmLoading={strSaving}
        okText="보고서 생성"
        cancelText="취소"
        width={560}
      >
        <Form form={strForm} layout="vertical" style={{ marginTop: 16 }}>
          <Descriptions size="small" column={1} bordered style={{ marginBottom: 16 }}>
            <Descriptions.Item label="고객">
              {caseData.cust_nm} ({caseData.cust_no})
            </Descriptions.Item>
            <Descriptions.Item label="케이스">
              {caseData.case_no}
            </Descriptions.Item>
          </Descriptions>
          <Form.Item
            name="sus_amt"
            label="혐의금액 (원)"
            rules={[{ required: true, message: '혐의금액을 입력하세요' }]}
          >
            <Input type="number" suffix="원" />
          </Form.Item>
          <Form.Item
            name="sus_period"
            label="혐의기간"
            rules={[{ required: true, message: '혐의기간을 선택하세요' }]}
          >
            <DatePicker.RangePicker style={{ width: '100%' }} />
          </Form.Item>
          <Form.Item
            name="sus_reason"
            label="혐의사유"
            rules={[{ required: true, message: '혐의사유를 입력하세요' }]}
          >
            <TextArea rows={4} placeholder="혐의사유를 상세히 입력하세요" />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  )
}
