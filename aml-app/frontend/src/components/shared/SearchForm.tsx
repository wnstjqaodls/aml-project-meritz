import { Form, Button, Space } from 'antd'
import type { FormInstance } from 'antd'
import { SearchOutlined, ReloadOutlined } from '@ant-design/icons'

interface SearchFormProps {
  form: FormInstance
  onSearch: () => void
  onReset: () => void
  loading?: boolean
  children: React.ReactNode
}

export default function SearchForm({
  form,
  onSearch,
  onReset,
  loading,
  children,
}: SearchFormProps) {
  const handleReset = () => {
    form.resetFields()
    onReset()
  }

  return (
    <div className="search-form-wrapper">
      <Form
        form={form}
        layout="inline"
        onFinish={onSearch}
        style={{ flexWrap: 'wrap', gap: 8 }}
      >
        {children}
        <Form.Item style={{ marginBottom: 8 }}>
          <Space>
            <Button
              type="primary"
              htmlType="submit"
              icon={<SearchOutlined />}
              loading={loading}
            >
              조회
            </Button>
            <Button icon={<ReloadOutlined />} onClick={handleReset}>
              초기화
            </Button>
          </Space>
        </Form.Item>
      </Form>
    </div>
  )
}
