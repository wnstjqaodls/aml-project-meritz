import { Typography, Space } from 'antd'

const { Title } = Typography

interface PageHeaderProps {
  title: string
  subtitle?: string
  actions?: React.ReactNode
}

export default function PageHeader({ title, subtitle, actions }: PageHeaderProps) {
  return (
    <div className="page-header-row">
      <div>
        <Title level={4} style={{ margin: 0 }}>
          {title}
        </Title>
        {subtitle && (
          <p style={{ color: '#888', margin: '4px 0 0', fontSize: 13 }}>
            {subtitle}
          </p>
        )}
      </div>
      {actions && <Space>{actions}</Space>}
    </div>
  )
}
