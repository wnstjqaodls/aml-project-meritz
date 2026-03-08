import { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Form,
  Input,
  Button,
  Card,
  Typography,
  message,
  Space,
} from 'antd'
import { UserOutlined, LockOutlined, BankOutlined } from '@ant-design/icons'
import { login } from '../api/auth'
import { useAuthStore } from '../store/authStore'

const { Title, Text } = Typography

interface LoginForm {
  userId: string
  password: string
}

export default function LoginPage() {
  const [form] = Form.useForm<LoginForm>()
  const navigate = useNavigate()
  const { user, setUser } = useAuthStore()

  useEffect(() => {
    if (user) {
      navigate('/dashboard', { replace: true })
    }
  }, [user, navigate])

  const handleSubmit = async (values: LoginForm) => {
    try {
      const userData = await login(values)
      setUser(userData)
      message.success('로그인 성공')
      navigate('/dashboard', { replace: true })
    } catch (err: unknown) {
      const msg =
        err instanceof Error ? err.message : '로그인에 실패했습니다.'
      message.error(msg)
    }
  }

  return (
    <div
      style={{
        minHeight: '100vh',
        background: 'linear-gradient(135deg, #001529 0%, #003366 100%)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
      }}
    >
      <Card
        style={{
          width: 400,
          borderRadius: 12,
          boxShadow: '0 20px 60px rgba(0,0,0,0.3)',
        }}
        styles={{ body: { padding: '40px 48px' } }}
      >
        <Space
          direction="vertical"
          style={{ width: '100%', textAlign: 'center', marginBottom: 32 }}
          size={4}
        >
          <div
            style={{
              width: 56,
              height: 56,
              background: '#001529',
              borderRadius: 12,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              margin: '0 auto 12px',
            }}
          >
            <BankOutlined style={{ fontSize: 28, color: '#1677ff' }} />
          </div>
          <Title level={3} style={{ margin: 0, color: '#001529' }}>
            AMLExpress
          </Title>
          <Text type="secondary" style={{ fontSize: 13 }}>
            자금세탁방지 통합관리 시스템
          </Text>
        </Space>

        <Form
          form={form}
          onFinish={handleSubmit}
          layout="vertical"
          size="large"
        >
          <Form.Item
            name="userId"
            rules={[{ required: true, message: '사용자 ID를 입력하세요' }]}
          >
            <Input
              prefix={<UserOutlined style={{ color: '#bfbfbf' }} />}
              placeholder="사용자 ID"
              autoComplete="username"
            />
          </Form.Item>

          <Form.Item
            name="password"
            rules={[{ required: true, message: '비밀번호를 입력하세요' }]}
          >
            <Input.Password
              prefix={<LockOutlined style={{ color: '#bfbfbf' }} />}
              placeholder="비밀번호"
              autoComplete="current-password"
            />
          </Form.Item>

          <Form.Item style={{ marginBottom: 0 }}>
            <Button
              type="primary"
              htmlType="submit"
              block
              style={{ height: 44, borderRadius: 8, marginTop: 8 }}
            >
              로그인
            </Button>
          </Form.Item>
        </Form>

        <div style={{ textAlign: 'center', marginTop: 20 }}>
          <Text type="secondary" style={{ fontSize: 12 }}>
            © 2025 AMLExpress. All rights reserved.
          </Text>
        </div>
      </Card>
    </div>
  )
}
