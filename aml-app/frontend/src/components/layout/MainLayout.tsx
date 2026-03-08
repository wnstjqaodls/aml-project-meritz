import { useState } from 'react'
import { Outlet, useNavigate, useLocation } from 'react-router-dom'
import {
  Layout,
  Menu,
  Button,
  Avatar,
  Dropdown,
  Space,
  Typography,
  theme,
} from 'antd'
import type { MenuProps } from 'antd'
import {
  DashboardOutlined,
  UserOutlined,
  SafetyCertificateOutlined,
  SearchOutlined,
  AlertOutlined,
  FolderOpenOutlined,
  FileTextOutlined,
  BarChartOutlined,
  LogoutOutlined,
  MenuFoldOutlined,
  MenuUnfoldOutlined,
  BankOutlined,
  TransactionOutlined,
  ApartmentOutlined,
  SettingOutlined,
  AuditOutlined,
  PieChartOutlined,
  MonitorOutlined,
} from '@ant-design/icons'
import { useAuthStore } from '../../store/authStore'

const { Header, Sider, Content } = Layout
const { Text } = Typography

type MenuItem = Required<MenuProps>['items'][number]

function getItem(
  label: React.ReactNode,
  key: string,
  icon?: React.ReactNode,
  children?: MenuItem[]
): MenuItem {
  return { key, icon, children, label } as MenuItem
}

const menuItems: MenuItem[] = [
  getItem('대시보드', '/dashboard', <DashboardOutlined />),
  getItem('고객관리', '/customers', <UserOutlined />),
  getItem('KYC 고객확인', '/kyc', <SafetyCertificateOutlined />),
  getItem('워치리스트', '/watchlist', <SearchOutlined />),
  getItem('TMS 거래모니터링', 'tms', <MonitorOutlined />, [
    getItem('거래조회', '/tms/transactions', <TransactionOutlined />),
    getItem('알림관리', '/tms/alerts', <AlertOutlined />),
    getItem('STR 처리', '/str/cases', <FileTextOutlined />),
    getItem('CTR 처리', '/ctr/cases', <AuditOutlined />),
    getItem('시나리오 관리', '/tms/scenarios', <ApartmentOutlined />),
    getItem('임계값 관리', '/tms/setvals', <SettingOutlined />),
    getItem('TMS 결재', '/tms/approvals', <FolderOpenOutlined />),
    getItem('TMS 통계', '/tms/stats', <PieChartOutlined />),
  ]),
  getItem('케이스관리', '/cases', <FolderOpenOutlined />),
  getItem('보고서', 'reports', <FileTextOutlined />, [
    getItem('STR 혐의거래', '/reports/str'),
    getItem('CTR 고액현금', '/reports/ctr'),
  ]),
  getItem('위험평가 (RA)', 'ra', <BarChartOutlined />, [
    getItem('RA 항목관리', '/ra/items'),
    getItem('고객위험평가', '/ra/results'),
  ]),
]

export default function MainLayout() {
  const [collapsed, setCollapsed] = useState(false)
  const navigate = useNavigate()
  const location = useLocation()
  const { user, clearUser } = useAuthStore()

  const selectedKey = (() => {
    const path = location.pathname
    if (path.startsWith('/cases/')) return '/cases'
    return path
  })()

  const openKeys = (() => {
    if (location.pathname.startsWith('/tms')) return ['tms']
    if (location.pathname.startsWith('/str')) return ['tms']
    if (location.pathname.startsWith('/ctr')) return ['tms']
    if (location.pathname.startsWith('/reports')) return ['reports']
    if (location.pathname.startsWith('/ra')) return ['ra']
    return []
  })()

  const handleMenuClick: MenuProps['onClick'] = ({ key }) => {
    if (key.startsWith('/')) {
      navigate(key)
    }
  }

  const handleLogout = () => {
    clearUser()
    navigate('/login')
  }

  const userMenuItems: MenuProps['items'] = [
    {
      key: 'logout',
      icon: <LogoutOutlined />,
      label: '로그아웃',
      onClick: handleLogout,
    },
  ]

  return (
    <Layout style={{ minHeight: '100vh' }}>
      <Sider
        trigger={null}
        collapsible
        collapsed={collapsed}
        width={220}
        style={{
          background: '#001529',
          overflow: 'auto',
          height: '100vh',
          position: 'fixed',
          left: 0,
          top: 0,
          bottom: 0,
          zIndex: 100,
        }}
      >
        <div
          style={{
            height: 64,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            borderBottom: '1px solid rgba(255,255,255,0.1)',
            padding: '0 16px',
          }}
        >
          <BankOutlined style={{ color: '#1677ff', fontSize: 22 }} />
          {!collapsed && (
            <Text
              style={{
                color: '#fff',
                fontSize: 16,
                fontWeight: 700,
                marginLeft: 10,
                letterSpacing: 1,
              }}
            >
              AMLExpress
            </Text>
          )}
        </div>
        <Menu
          theme="dark"
          mode="inline"
          selectedKeys={[selectedKey]}
          defaultOpenKeys={openKeys}
          items={menuItems}
          onClick={handleMenuClick}
          style={{ borderRight: 0, marginTop: 8 }}
        />
      </Sider>

      <Layout style={{ marginLeft: collapsed ? 80 : 220, transition: 'margin-left 0.2s' }}>
        <Header
          style={{
            padding: '0 24px',
            background: '#fff',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            boxShadow: '0 1px 4px rgba(0,21,41,.08)',
            position: 'sticky',
            top: 0,
            zIndex: 99,
          }}
        >
          <Button
            type="text"
            icon={collapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
            onClick={() => setCollapsed(!collapsed)}
            style={{ fontSize: 16, width: 40, height: 40 }}
          />
          <Space>
            <Dropdown menu={{ items: userMenuItems }} placement="bottomRight">
              <Space style={{ cursor: 'pointer' }}>
                <Avatar
                  icon={<UserOutlined />}
                  style={{ backgroundColor: '#1677ff' }}
                  size="small"
                />
                <Text>{user?.userName || user?.userId || '관리자'}</Text>
              </Space>
            </Dropdown>
          </Space>
        </Header>

        <Content
          style={{
            margin: 24,
            padding: 24,
            background: '#fff',
            borderRadius: 8,
            minHeight: 'calc(100vh - 112px)',
          }}
        >
          <Outlet />
        </Content>
      </Layout>
    </Layout>
  )
}
