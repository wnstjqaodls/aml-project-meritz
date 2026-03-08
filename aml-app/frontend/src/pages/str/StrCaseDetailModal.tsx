import { useEffect, useState } from 'react'
import {
  Button,
  Descriptions,
  Divider,
  Drawer,
  Form,
  Input,
  message,
  Modal,
  Select,
  Space,
  Steps,
  Table,
  Tabs,
  Tag,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { strApi } from '../../api/str'
import type { StrCaseDetail, StrTransaction, StrAmount, StrApproval } from '../../api/str'
import AmountDisplay from '../../components/shared/AmountDisplay'

const { TextArea } = Input
const { Text } = Typography

interface Props {
  open: boolean
  sspsDlCrtDt: string
  sspsDlId: string
  onClose: (refreshNeeded?: boolean) => void
}

function formatDate(v: string): string {
  if (!v || v.length !== 8) return v || '-'
  return `${v.slice(0, 4)}-${v.slice(4, 6)}-${v.slice(6, 8)}`
}

function formatDateTime(dt: string, tm?: string): string {
  const d = formatDate(dt)
  if (!tm) return d
  const t = tm.length >= 6 ? `${tm.slice(0, 2)}:${tm.slice(2, 4)}:${tm.slice(4, 6)}` : tm
  return `${d} ${t}`
}

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
    H: { color: 'red', label: '고위험(H)' },
    M: { color: 'orange', label: '중위험(M)' },
    L: { color: 'green', label: '저위험(L)' },
  }
  const info = map[grade] ?? { color: 'default', label: grade || '-' }
  return <Tag color={info.color}>{info.label}</Tag>
}

const GENDER_MAP: Record<string, string> = { M: '남성', F: '여성' }
const CORP_MAP: Record<string, string> = { I: '개인', C: '법인' }

export default function StrCaseDetailModal({ open, sspsDlCrtDt, sspsDlId, onClose }: Props) {
  const [detail, setDetail] = useState<StrCaseDetail | null>(null)
  const [loading, setLoading] = useState(false)
  const [activeTab, setActiveTab] = useState('party')

  // Report form
  const [reportForm] = Form.useForm()
  const [reportSaving, setReportSaving] = useState(false)

  // Approval request modal
  const [approvalModalOpen, setApprovalModalOpen] = useState(false)
  const [approvalForm] = Form.useForm()
  const [approvalSubmitting, setApprovalSubmitting] = useState(false)

  // FIU submit confirm
  const [fiuConfirmOpen, setFiuConfirmOpen] = useState(false)
  const [fiuSubmitting, setFiuSubmitting] = useState(false)

  const fetchDetail = async () => {
    setLoading(true)
    try {
      const res = await strApi.getDetail(sspsDlCrtDt, sspsDlId)
      const d = res.data.data
      setDetail(d)
      if (d.report) {
        reportForm.setFieldsValue({
          dobtDlGrdCd: d.report.dobtDlGrdCd,
          rprRsnCntnt: d.report.rprRsnCntnt,
          itemCntnt1: d.report.itemCntnt1,
          itemCntnt2: d.report.itemCntnt2,
          itemCntnt3: d.report.itemCntnt3,
        })
      } else {
        reportForm.resetFields()
      }
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '상세 조회 실패')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    if (open) {
      setActiveTab('party')
      fetchDetail()
    }
  }, [open, sspsDlCrtDt, sspsDlId])

  const handleSaveReport = async () => {
    let values: Record<string, string>
    try {
      values = await reportForm.validateFields()
    } catch {
      return
    }
    setReportSaving(true)
    try {
      await strApi.saveReport(sspsDlCrtDt, sspsDlId, values)
      message.success('보고서가 저장되었습니다.')
      await fetchDetail()
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '저장 실패')
    } finally {
      setReportSaving(false)
    }
  }

  const handleSubmitApproval = async () => {
    let values: { rsnCntnt: string }
    try {
      values = await approvalForm.validateFields()
    } catch {
      return
    }
    setApprovalSubmitting(true)
    try {
      await strApi.submitApproval(sspsDlCrtDt, sspsDlId, values)
      message.success('결재가 요청되었습니다.')
      setApprovalModalOpen(false)
      approvalForm.resetFields()
      await fetchDetail()
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : '결재 요청 실패')
    } finally {
      setApprovalSubmitting(false)
    }
  }

  const handleSubmitFiu = async () => {
    setFiuSubmitting(true)
    try {
      await strApi.submitFiu(sspsDlCrtDt, sspsDlId)
      message.success('FIU에 제출되었습니다.')
      setFiuConfirmOpen(false)
      await fetchDetail()
      onClose(true)
    } catch (err: unknown) {
      message.error(err instanceof Error ? err.message : 'FIU 제출 실패')
    } finally {
      setFiuSubmitting(false)
    }
  }

  const txColumns: ColumnsType<StrTransaction> = [
    { title: '순번', dataIndex: 'seqNo', key: 'seqNo', width: 60, align: 'center' },
    { title: '지점코드', dataIndex: 'mnDlBrnCd', key: 'mnDlBrnCd', width: 90 },
    { title: '지점명', dataIndex: 'mnDlBrnNm', key: 'mnDlBrnNm', width: 110 },
    {
      title: '거래일자',
      key: 'dlDt',
      width: 140,
      render: (_, r) => formatDateTime(r.dlDt, r.dlTm),
    },
    { title: '거래유형', dataIndex: 'dlTypCcd', key: 'dlTypCcd', width: 90 },
    {
      title: '거래금액',
      dataIndex: 'dlAmt',
      key: 'dlAmt',
      width: 140,
      align: 'right',
      render: (v: number, r) => <AmountDisplay amount={v} currency={r.dlCcy} />,
    },
    { title: '통화', dataIndex: 'dlCcy', key: 'dlCcy', width: 70 },
    { title: '상대계좌', dataIndex: 'cntrpAcNo', key: 'cntrpAcNo', width: 160 },
    { title: '상대방', dataIndex: 'cntrpNm', key: 'cntrpNm', width: 120 },
  ]

  const amtColumns: ColumnsType<StrAmount> = [
    { title: '계좌번호', dataIndex: 'gnlAcNo', key: 'gnlAcNo' },
    {
      title: '합계금액',
      dataIndex: 'dlAmt',
      key: 'dlAmt',
      align: 'right',
      render: (v: number, r) => <AmountDisplay amount={v} currency={r.dlCcy} />,
    },
    { title: '통화', dataIndex: 'dlCcy', key: 'dlCcy', width: 80 },
  ]

  const approvalColumns: ColumnsType<StrApproval> = [
    { title: '순번', dataIndex: 'numSq', key: 'numSq', width: 60, align: 'center' },
    { title: '결재선구분', dataIndex: 'gylj', key: 'gylj', width: 100 },
    {
      title: '처리일시',
      dataIndex: 'hndlDyTm',
      key: 'hndlDyTm',
      width: 150,
      render: (v: string) => v || '-',
    },
    { title: '처리자', dataIndex: 'hndlPEno', key: 'hndlPEno', width: 100 },
    {
      title: '상태',
      dataIndex: 'snCcd',
      key: 'snCcd',
      width: 80,
      render: (v: string) => {
        if (v === 'E') return <Tag color="green">승인</Tag>
        if (v === 'R') return <Tag color="red">반려</Tag>
        return <Tag color="default">{v || '대기'}</Tag>
      },
    },
    { title: '사유', dataIndex: 'rsnCntnt', key: 'rsnCntnt', render: (v: string) => v || '-' },
  ]

  const statusCode = detail?.caseInfo?.rprPrgrsCcd ?? ''

  const approvalStep = (() => {
    if (statusCode === '10') return 2
    if (statusCode === '98') return 1
    if (statusCode === '97') return 1
    return 0
  })()

  const tabItems = [
    {
      key: 'party',
      label: '거래자 정보',
      children: detail ? (
        <Descriptions bordered column={2} size="small">
          <Descriptions.Item label="거래자명">
            {detail.partyInfo?.dlPNm || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="실명번호">
            {detail.partyInfo?.dlPRnmNoCcd || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="개인/법인">
            {CORP_MAP[detail.partyInfo?.indvCorpCcd] || detail.partyInfo?.indvCorpCcd || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="생년월일">
            {formatDate(detail.partyInfo?.dlPBrtdy)}
          </Descriptions.Item>
          <Descriptions.Item label="성별">
            {GENDER_MAP[detail.partyInfo?.dlPSexCd] || detail.partyInfo?.dlPSexCd || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="직업코드">
            {detail.partyInfo?.ocptnCcd || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="주소" span={2}>
            {detail.partyInfo?.dlPHseAddr || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="연락처">
            {detail.partyInfo?.dlPMblTelNo || '-'}
          </Descriptions.Item>
          <Descriptions.Item label="사업장명">
            {detail.partyInfo?.wpNm || '-'}
          </Descriptions.Item>
        </Descriptions>
      ) : null,
    },
    {
      key: 'transactions',
      label: '거래 내역',
      children: detail ? (
        <>
          <Table
            dataSource={detail.transactions ?? []}
            columns={txColumns}
            rowKey={(r) => `${r.dlDt}-${r.seqNo}`}
            size="small"
            pagination={false}
            scroll={{ x: 900 }}
          />
          <Divider />
          <Text strong>계좌별 합계</Text>
          <Table
            dataSource={detail.amounts ?? []}
            columns={amtColumns}
            rowKey="gnlAcNo"
            size="small"
            pagination={false}
            style={{ marginTop: 8 }}
          />
        </>
      ) : null,
    },
    {
      key: 'report',
      label: '보고서 작성',
      children: (
        <Form form={reportForm} layout="vertical">
          <Form.Item
            name="dobtDlGrdCd"
            label="의심거래 등급"
            rules={[{ required: true, message: '등급을 선택하세요.' }]}
          >
            <Select
              style={{ width: 160 }}
              options={[
                { value: 'H', label: '고위험(H)' },
                { value: 'M', label: '중위험(M)' },
                { value: 'L', label: '저위험(L)' },
              ]}
              placeholder="등급 선택"
            />
          </Form.Item>
          <Form.Item
            name="rprRsnCntnt"
            label="보고사유"
            rules={[{ required: true, message: '보고사유를 입력하세요.' }]}
          >
            <TextArea
              rows={5}
              placeholder="의심거래 보고 사유를 상세히 입력하세요."
              style={{ resize: 'vertical' }}
            />
          </Form.Item>
          <Form.Item name="itemCntnt1" label="추가항목 1">
            <Input placeholder="추가 정보 1" />
          </Form.Item>
          <Form.Item name="itemCntnt2" label="추가항목 2">
            <Input placeholder="추가 정보 2" />
          </Form.Item>
          <Form.Item name="itemCntnt3" label="추가항목 3">
            <Input placeholder="추가 정보 3" />
          </Form.Item>
          <Button
            type="primary"
            onClick={handleSaveReport}
            loading={reportSaving}
          >
            저장
          </Button>
        </Form>
      ),
    },
    {
      key: 'approval',
      label: '결재/보고',
      children: detail ? (
        <>
          <Steps
            current={approvalStep}
            style={{ marginBottom: 24 }}
            items={[
              { title: '작성완료' },
              { title: '1차결재' },
              { title: 'FIU제출' },
            ]}
          />

          <Descriptions bordered column={2} size="small" style={{ marginBottom: 16 }}>
            <Descriptions.Item label="진행상태">
              <StatusBadge code={statusCode} />
            </Descriptions.Item>
            <Descriptions.Item label="위험등급">
              <RiskTag grade={detail.caseInfo?.rskGrdCd} />
            </Descriptions.Item>
            {detail.caseInfo?.fiuRptNo && (
              <Descriptions.Item label="FIU 접수번호" span={2}>
                <Text strong style={{ color: '#1677ff' }}>
                  {detail.caseInfo.fiuRptNo}
                </Text>
                {detail.caseInfo.fiuRptDt && (
                  <Text type="secondary" style={{ marginLeft: 12 }}>
                    ({formatDate(detail.caseInfo.fiuRptDt)})
                  </Text>
                )}
              </Descriptions.Item>
            )}
          </Descriptions>

          <Space style={{ marginBottom: 16 }}>
            {statusCode === '97' && (
              <Button
                type="primary"
                onClick={() => setApprovalModalOpen(true)}
              >
                결재요청
              </Button>
            )}
            {statusCode === '98' && (
              <Button
                type="primary"
                danger
                onClick={() => setFiuConfirmOpen(true)}
              >
                FIU 제출
              </Button>
            )}
          </Space>

          <Divider />
          <Text strong>결재 이력</Text>
          <Table
            dataSource={detail.approvals ?? []}
            columns={approvalColumns}
            rowKey="appNo"
            size="small"
            pagination={false}
            style={{ marginTop: 8 }}
            locale={{ emptyText: '결재 이력이 없습니다.' }}
          />
        </>
      ) : null,
    },
  ]

  return (
    <>
      <Drawer
        title={`STR 케이스 상세 - ${sspsDlId}`}
        open={open}
        onClose={() => onClose()}
        width="80%"
        loading={loading}
        styles={{ body: { paddingTop: 8 } }}
      >
        <Tabs
          activeKey={activeTab}
          onChange={setActiveTab}
          items={tabItems}
        />
      </Drawer>

      <Modal
        title="결재 요청"
        open={approvalModalOpen}
        onOk={handleSubmitApproval}
        onCancel={() => {
          setApprovalModalOpen(false)
          approvalForm.resetFields()
        }}
        confirmLoading={approvalSubmitting}
        okText="요청"
        cancelText="취소"
        destroyOnClose
      >
        <Form form={approvalForm} layout="vertical" style={{ marginTop: 16 }}>
          <Form.Item
            name="rsnCntnt"
            label="결재 요청 사유"
            rules={[{ required: true, message: '사유를 입력하세요.' }]}
          >
            <TextArea rows={4} placeholder="결재 요청 사유를 입력하세요." />
          </Form.Item>
        </Form>
      </Modal>

      <Modal
        title="FIU 제출 확인"
        open={fiuConfirmOpen}
        onOk={handleSubmitFiu}
        onCancel={() => setFiuConfirmOpen(false)}
        confirmLoading={fiuSubmitting}
        okText="제출"
        okButtonProps={{ danger: true }}
        cancelText="취소"
      >
        <p>FIU에 혐의거래 보고서를 제출하시겠습니까?</p>
        <p>제출 후에는 취소가 불가능합니다.</p>
      </Modal>
    </>
  )
}
