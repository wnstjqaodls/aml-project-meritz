<template>
  <div class="app-layout">
    <!-- 사이드바 -->
    <aside class="sidebar" :class="{ collapsed: sidebarCollapsed }">
      <div class="sidebar-brand">
        <span class="brand-logo">🛡</span>
        <span v-if="!sidebarCollapsed" class="brand-name">AMLXpress7</span>
      </div>
      <nav class="sidebar-nav">
        <div v-for="group in menuGroups" :key="group.key" class="menu-group">
          <div
            class="menu-group-header"
            @click="toggleGroup(group.key)"
            :class="{ active: openGroups.includes(group.key) }"
          >
            <span class="menu-icon">{{ group.icon }}</span>
            <span v-if="!sidebarCollapsed" class="menu-label">{{ group.label }}</span>
            <span v-if="!sidebarCollapsed" class="menu-arrow">{{ openGroups.includes(group.key) ? '▾' : '▸' }}</span>
          </div>
          <div v-if="openGroups.includes(group.key) && !sidebarCollapsed" class="menu-items">
            <router-link
              v-for="item in group.children"
              :key="item.path"
              :to="item.path"
              class="menu-item"
              :class="{ 'menu-item-disabled': item.disabled }"
            >
              {{ item.label }}
            </router-link>
          </div>
        </div>
      </nav>
    </aside>

    <!-- 메인 콘텐츠 -->
    <div class="main-container">
      <header class="app-header">
        <button class="collapse-btn" @click="sidebarCollapsed = !sidebarCollapsed">☰</button>
        <div class="header-right">
          <span class="user-info">{{ authStore.userNm }} ({{ authStore.roleId }})</span>
          <button class="logout-btn" @click="handleLogout">로그아웃</button>
        </div>
      </header>
      <main class="content-area">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../../store/auth.js'

const router = useRouter()
const authStore = useAuthStore()
const sidebarCollapsed = ref(false)
const openGroups = ref(['str'])

const menuGroups = [
  {
    key: 'dashboard', icon: '📊', label: '대시보드',
    children: [{ path: '/dashboard', label: '메인 대시보드' }]
  },
  {
    key: 'str', icon: '⚠', label: 'STR 혐의거래',
    children: [
      { path: '/str/cases', label: 'STR 케이스 관리' },
    ]
  },
  {
    key: 'ctr', icon: '💰', label: 'CTR 고액현금',
    children: [
      { path: '/ctr/cases', label: 'CTR 케이스 관리' },
    ]
  },
  {
    key: 'kyc', icon: '👤', label: 'KYC 고객확인',
    children: [
      { path: '/kyc/list', label: 'KYC 목록' },
    ]
  },
  {
    key: 'wlf', icon: '🔍', label: 'WLF 감시목록',
    children: [
      { path: '/wlf/search', label: '감시대상 검색' },
    ]
  },
  {
    key: 'ra', icon: '📈', label: 'RA 위험평가',
    children: [
      { path: '/ra/items', label: 'RA 항목/결과' },
    ]
  },
  {
    key: 'customer', icon: '🏢', label: '고객관리',
    children: [
      { path: '/customers', label: '고객 목록' },
    ]
  },
]

function toggleGroup(key) {
  const idx = openGroups.value.indexOf(key)
  if (idx >= 0) openGroups.value.splice(idx, 1)
  else openGroups.value.push(key)
}

function handleLogout() {
  authStore.logout()
  router.push('/login')
}
</script>

<style scoped>
.app-layout { display: flex; height: 100vh; overflow: hidden; font-family: 'Malgun Gothic', sans-serif; }
.sidebar { width: 220px; background: #001529; color: #fff; display: flex; flex-direction: column; transition: width 0.2s; flex-shrink: 0; }
.sidebar.collapsed { width: 56px; }
.sidebar-brand { padding: 16px 12px; display: flex; align-items: center; gap: 8px; border-bottom: 1px solid #1f3a5a; font-size: 16px; font-weight: bold; color: #1890ff; min-height: 56px; }
.brand-logo { font-size: 20px; }
.sidebar-nav { flex: 1; overflow-y: auto; padding: 8px 0; }
.menu-group { }
.menu-group-header { display: flex; align-items: center; padding: 10px 16px; cursor: pointer; color: #a6adb4; font-size: 13px; gap: 8px; transition: background 0.15s; }
.menu-group-header:hover, .menu-group-header.active { background: #0d2137; color: #fff; }
.menu-icon { font-size: 15px; min-width: 20px; }
.menu-label { flex: 1; }
.menu-arrow { font-size: 11px; }
.menu-items { background: #000c17; }
.menu-item { display: block; padding: 8px 16px 8px 44px; color: #8c9aa8; font-size: 13px; text-decoration: none; transition: all 0.15s; }
.menu-item:hover, .menu-item.router-link-active { color: #1890ff; background: #0d2137; }
.menu-item-disabled { color: #3d5066 !important; cursor: not-allowed; pointer-events: none; }
.main-container { flex: 1; display: flex; flex-direction: column; overflow: hidden; }
.app-header { height: 48px; background: #fff; border-bottom: 1px solid #e8e8e8; display: flex; align-items: center; padding: 0 16px; gap: 16px; }
.collapse-btn { background: none; border: none; font-size: 18px; cursor: pointer; color: #666; }
.header-right { margin-left: auto; display: flex; align-items: center; gap: 12px; }
.user-info { font-size: 13px; color: #666; }
.logout-btn { padding: 4px 12px; font-size: 12px; border: 1px solid #d9d9d9; background: #fff; cursor: pointer; border-radius: 4px; }
.logout-btn:hover { border-color: #1890ff; color: #1890ff; }
.content-area { flex: 1; overflow-y: auto; padding: 20px; background: #f0f2f5; }
</style>
