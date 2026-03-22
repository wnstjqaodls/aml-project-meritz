<template>
  <div>
    <div class="page-header">
      <h2>대시보드</h2>
      <p>AMLXpress7 주요 현황</p>
    </div>

    <div v-if="loading" class="loading-msg">로딩중...</div>
    <div v-else-if="error" class="error-msg">{{ error }}</div>
    <template v-else>
      <!-- 6-card stats grid -->
      <div class="stats-grid">
        <div class="stat-card stat-orange">
          <div class="stat-value">{{ stats.pendingStrCount ?? 0 }}</div>
          <div class="stat-label">STR 대기</div>
        </div>
        <div class="stat-card stat-green">
          <div class="stat-value">{{ stats.completedStrCount ?? 0 }}</div>
          <div class="stat-label">STR 결재완료</div>
        </div>
        <div class="stat-card stat-blue">
          <div class="stat-value">{{ stats.pendingCtrCount ?? 0 }}</div>
          <div class="stat-label">CTR 대기</div>
        </div>
        <div class="stat-card stat-red">
          <div class="stat-value">{{ stats.highRiskCustomerCount ?? 0 }}</div>
          <div class="stat-label">고위험 고객</div>
        </div>
        <div class="stat-card stat-purple">
          <div class="stat-value">{{ stats.pendingKycCount ?? 0 }}</div>
          <div class="stat-label">KYC 대기</div>
        </div>
        <div class="stat-card stat-teal">
          <div class="stat-value">{{ stats.openAlertCount ?? 0 }}</div>
          <div class="stat-label">알림 처리대기</div>
        </div>
      </div>

      <!-- STR 상태별 현황 bar -->
      <div class="section-box">
        <h3 class="section-title">STR 상태별 현황</h3>
        <div class="bar-chart">
          <div
            v-for="bar in strBars"
            :key="bar.label"
            class="bar-item"
          >
            <div class="bar-label">{{ bar.label }}</div>
            <div class="bar-track">
              <div
                class="bar-fill"
                :style="{ width: barWidth(bar.value) + '%', background: bar.color }"
              ></div>
            </div>
            <div class="bar-value">{{ bar.value }}</div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { dashboardApi } from '../../api/dashboard.js'

const stats   = ref({})
const loading = ref(false)
const error   = ref('')

const strBars = computed(() => [
  { label: 'STR 대기',    value: stats.value.pendingStrCount   ?? 0, color: '#faad14' },
  { label: 'STR 결재완료', value: stats.value.completedStrCount ?? 0, color: '#52c41a' },
  { label: 'FIU 제출',    value: stats.value.fiuStrCount       ?? 0, color: '#722ed1' },
  { label: 'CTR 대기',    value: stats.value.pendingCtrCount   ?? 0, color: '#1890ff' },
  { label: '알림 대기',   value: stats.value.openAlertCount    ?? 0, color: '#ff4d4f' },
])

function barWidth(value) {
  const max = Math.max(...strBars.value.map(b => b.value), 1)
  return Math.round((value / max) * 100)
}

onMounted(async () => {
  loading.value = true
  error.value = ''
  try {
    const res = await dashboardApi.getStats()
    stats.value = res.data.data || {}
  } catch (e) {
    error.value = '대시보드 데이터를 불러올 수 없습니다.'
    console.error('Dashboard load failed', e)
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.page-header { margin-bottom: 24px; }
.page-header h2 { margin: 0 0 4px; font-size: 20px; }
.page-header p { margin: 0; color: #888; font-size: 13px; }
.loading-msg { padding: 40px; text-align: center; color: #888; }
.error-msg { padding: 40px; text-align: center; color: #ff4d4f; }

.stats-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; margin-bottom: 24px; }
@media (min-width: 1200px) { .stats-grid { grid-template-columns: repeat(6, 1fr); } }

.stat-card { background: #fff; border-radius: 8px; padding: 24px; text-align: center; border-top: 4px solid; }
.stat-orange  { border-color: #faad14; }
.stat-green   { border-color: #52c41a; }
.stat-blue    { border-color: #1890ff; }
.stat-red     { border-color: #ff4d4f; }
.stat-purple  { border-color: #722ed1; }
.stat-teal    { border-color: #13c2c2; }
.stat-value { font-size: 32px; font-weight: bold; color: #333; }
.stat-label { font-size: 13px; color: #888; margin-top: 4px; }

.section-box { background: #fff; border-radius: 8px; padding: 20px; }
.section-title { margin: 0 0 16px; font-size: 15px; color: #333; }

.bar-chart { display: flex; flex-direction: column; gap: 12px; }
.bar-item { display: flex; align-items: center; gap: 12px; }
.bar-label { width: 80px; font-size: 13px; color: #555; text-align: right; flex-shrink: 0; }
.bar-track { flex: 1; height: 20px; background: #f5f5f5; border-radius: 4px; overflow: hidden; }
.bar-fill { height: 100%; border-radius: 4px; transition: width 0.4s ease; min-width: 4px; }
.bar-value { width: 40px; font-size: 13px; color: #333; font-weight: 500; }
</style>
