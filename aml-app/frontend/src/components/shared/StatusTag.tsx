import { Tag } from 'antd'

interface StatusTagProps {
  status: string
  type?: 'alert' | 'case' | 'kyc' | 'risk' | 'report' | 'screening' | 'general'
}

const alertStatusMap: Record<string, { color: string; label: string }> = {
  NEW: { color: 'blue', label: '신규' },
  REVIEW: { color: 'orange', label: '검토중' },
  CLOSED: { color: 'default', label: '종결' },
  ESCALATED: { color: 'purple', label: '상향' },
}

const caseStatusMap: Record<string, { color: string; label: string }> = {
  OPEN: { color: 'blue', label: '진행중' },
  REVIEW: { color: 'orange', label: '검토중' },
  CLOSED: { color: 'default', label: '종결' },
  ESCALATED: { color: 'purple', label: '상향' },
  REPORTED: { color: 'green', label: '보고완료' },
}

const kycStatusMap: Record<string, { color: string; label: string }> = {
  PENDING: { color: 'gold', label: '대기' },
  IN_PROGRESS: { color: 'blue', label: '진행중' },
  COMPLETE: { color: 'green', label: '완료' },
  EXPIRED: { color: 'red', label: '만료' },
  REJECTED: { color: 'red', label: '거부' },
}

const riskGradeMap: Record<string, { color: string; label: string }> = {
  H: { color: 'red', label: '고위험' },
  M: { color: 'orange', label: '중위험' },
  L: { color: 'green', label: '저위험' },
}

const reportStatusMap: Record<string, { color: string; label: string }> = {
  DRAFT: { color: 'default', label: '초안' },
  SUBMITTED: { color: 'blue', label: '제출' },
  ACCEPTED: { color: 'green', label: '접수' },
  REJECTED: { color: 'red', label: '반려' },
  PENDING: { color: 'gold', label: '대기' },
}

const screeningStatusMap: Record<string, { color: string; label: string }> = {
  PENDING: { color: 'gold', label: '대기' },
  MATCH: { color: 'red', label: '일치' },
  NO_MATCH: { color: 'green', label: '불일치' },
  POSSIBLE_MATCH: { color: 'orange', label: '가능일치' },
}

const generalMap: Record<string, { color: string; label: string }> = {
  Y: { color: 'red', label: '예' },
  N: { color: 'green', label: '아니오' },
  ACTIVE: { color: 'green', label: '활성' },
  INACTIVE: { color: 'default', label: '비활성' },
}

export default function StatusTag({ status, type = 'general' }: StatusTagProps) {
  let map: Record<string, { color: string; label: string }>

  switch (type) {
    case 'alert':
      map = alertStatusMap
      break
    case 'case':
      map = caseStatusMap
      break
    case 'kyc':
      map = kycStatusMap
      break
    case 'risk':
      map = riskGradeMap
      break
    case 'report':
      map = reportStatusMap
      break
    case 'screening':
      map = screeningStatusMap
      break
    default:
      map = { ...generalMap, ...alertStatusMap, ...caseStatusMap, ...kycStatusMap }
  }

  const entry = map[status]
  if (!entry) {
    return <Tag>{status}</Tag>
  }

  return <Tag color={entry.color}>{entry.label}</Tag>
}
