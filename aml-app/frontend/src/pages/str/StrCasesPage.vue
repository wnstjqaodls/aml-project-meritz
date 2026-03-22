<template>
  <div>
    <div class="page-header">
      <div>
        <h2>STR 처리</h2>
        <p>혐의거래 보고(STR) 케이스 처리 및 FIU 제출 관리</p>
      </div>
      <button class="btn-default" @click="handleSimulate" :disabled="simulating">
        {{ simulating ? '시뮬레이션 중...' : '배치 시뮬레이션' }}
      </button>
    </div>

    <!-- 검색 조건 -->
    <div class="search-bar">
      <label>기간</label>
      <input type="date" v-model="stDate" />
      <span>~</span>
      <input type="date" v-model="edDate" />

      <label>진행상태</label>
      <select v-model="rprPrgrsCcd">
        <option value="">전체</option>
        <option value="9">대기</option>
        <option value="97">검토중</option>
        <option value="98">결재완료</option>
        <option value="10">FIU제출</option>
      </select>

      <button class="btn-primary" @click="fetchData">조회</button>
    </div>

    <!-- DevExtreme DataGrid -->
    <DxDataGrid
      :data-source="cases"
      :show-borders="true"
      :row-alternation-enabled="true"
      :hover-state-enabled="true"
      :column-auto-width="true"
      key-expr="SSPS_DL_ID"
      @row-click="onRowClick"
      style="cursor:pointer; background:#fff;"
    >
      <DxColumn data-field="sspsDlId"      caption="케이스ID"   :width="140" />
      <DxColumn data-field="sspsDlCrtDt"   caption="생성일"     :width="110" :calculate-display-value="(r) => formatDate(r.SSPS_DL_CRT_DT || r.sspsDlCrtDt)" />
      <DxColumn data-field="DL_P_NM"       caption="거래자명"   :width="120" />
      <DxColumn data-field="SSPS_TYP_CD"   caption="시나리오"   :width="130" />
      <DxColumn data-field="RPR_PRGRS_CCD" caption="진행상태"   :width="110" cell-template="statusTemplate" />
      <DxColumn data-field="RSK_GRD_CD"    caption="위험등급"   :width="90"  cell-template="riskTemplate" />
      <DxColumn data-field="SCNR_MRK"      caption="시나리오점수" :width="110" data-type="number" :format="{ type: 'fixedPoint', precision: 2 }" />
      <DxColumn data-field="DL_AMT"        caption="거래금액"   :width="150" data-type="number" :format="{ type: 'fixedPoint', precision: 0 }" alignment="right" />
      <DxColumn data-field="DL_CNT"        caption="거래건수"   :width="80"  alignment="right" />

      <template #statusTemplate="{ data }">
        <span :class="'badge badge-' + getStatusColor(data.data.RPR_PRGRS_CCD || data.data.rprPrgrsCcd)">
          {{ getStatusLabel(data.data.RPR_PRGRS_CCD || data.data.rprPrgrsCcd) }}
        </span>
      </template>
      <template #riskTemplate="{ data }">
        <span :class="'badge badge-' + getRiskColor(data.data.RSK_GRD_CD || data.data.rskGrdCd)">
          {{ data.data.RSK_GRD_CD || data.data.rskGrdCd || '-' }}
        </span>
      </template>

      <DxPaging :page-size="20" />
      <DxPager :show-page-size-selector="false" :show-info="true" info-text="총 {2}건" />
      <DxFilterRow :visible="true" />
      <DxScrolling mode="standard" />
    </DxDataGrid>

    <!-- 상세 모달 -->
    <StrCaseDetailModal
      v-if="selectedCase"
      :visible="detailVisible"
      :ssps-dl-crt-dt="selectedCase.SSPS_DL_CRT_DT || selectedCase.sspsDlCrtDt"
      :ssps-dl-id="selectedCase.SSPS_DL_ID || selectedCase.sspsDlId"
      @close="onDetailClose"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import dayjs from 'dayjs'
import {
  DxDataGrid, DxColumn, DxPaging, DxPager, DxFilterRow, DxScrolling
} from 'devextreme-vue/data-grid'
import { strApi } from '../../api/str.js'
import StrCaseDetailModal from './StrCaseDetailModal.vue'

const cases       = ref([])
const loading     = ref(false)
const simulating  = ref(false)
const detailVisible = ref(false)
const selectedCase  = ref(null)

const stDate       = ref(dayjs().subtract(30, 'day').format('YYYY-MM-DD'))
const edDate       = ref(dayjs().format('YYYY-MM-DD'))
const rprPrgrsCcd  = ref('')

const STATUS_MAP = {
  '9':  ['orange', '대기'],
  '97': ['blue',   '검토중'],
  '98': ['green',  '결재완료'],
  '10': ['purple', 'FIU제출']
}
const RISK_MAP = { H: 'red', M: 'orange', L: 'green' }

function getStatusLabel(code) { return STATUS_MAP[code]?.[1] || code || '-' }
function getStatusColor(code) { return STATUS_MAP[code]?.[0] || 'default' }
function getRiskColor(code)   { return RISK_MAP[code] || 'default' }

function formatDate(v) {
  if (!v || v.length !== 8) return v || '-'
  return `${v.slice(0, 4)}-${v.slice(4, 6)}-${v.slice(6, 8)}`
}

async function fetchData() {
  loading.value = true
  try {
    const params = {
      stDate: stDate.value.replace(/-/g, ''),
      edDate: edDate.value.replace(/-/g, ''),
      page: 1, size: 100
    }
    if (rprPrgrsCcd.value) params.rprPrgrsCcd = rprPrgrsCcd.value
    const res = await strApi.getCases(params)
    cases.value = res.data.data?.list || res.data.data?.content || []
  } catch (e) {
    alert('STR 케이스 조회 실패: ' + e.message)
  } finally {
    loading.value = false
  }
}

async function handleSimulate() {
  simulating.value = true
  try {
    await strApi.simulate(10)
    alert('배치 시뮬레이션이 완료되었습니다.')
    fetchData()
  } catch (e) {
    alert('시뮬레이션 실패: ' + e.message)
  } finally {
    simulating.value = false
  }
}

function onRowClick({ data }) {
  selectedCase.value = data
  detailVisible.value = true
}

function onDetailClose(refreshNeeded) {
  detailVisible.value = false
  selectedCase.value  = null
  if (refreshNeeded) fetchData()
}

onMounted(fetchData)
</script>

<style scoped>
.page-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px; }
.page-header h2 { margin: 0 0 4px; font-size: 20px; }
.page-header p  { margin: 0; color: #888; font-size: 13px; }
.search-bar { display: flex; gap: 8px; align-items: center; background: #fff; padding: 12px 16px; border-radius: 6px; margin-bottom: 16px; flex-wrap: wrap; }
.search-bar label  { font-size: 13px; color: #555; }
.search-bar input, .search-bar select { padding: 6px 10px; border: 1px solid #d9d9d9; border-radius: 4px; font-size: 13px; }
.btn-primary { padding: 6px 16px; background: #1890ff; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-primary:hover { background: #40a9ff; }
.btn-default { padding: 6px 16px; background: #fff; border: 1px solid #d9d9d9; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-default:hover { border-color: #1890ff; color: #1890ff; }
.badge { display: inline-block; padding: 2px 8px; border-radius: 10px; font-size: 12px; font-weight: 500; }
.badge-orange  { background: #fff7e6; color: #d46b08; border: 1px solid #ffd591; }
.badge-blue    { background: #e6f7ff; color: #096dd9; border: 1px solid #91d5ff; }
.badge-green   { background: #f6ffed; color: #389e0d; border: 1px solid #b7eb8f; }
.badge-purple  { background: #f9f0ff; color: #531dab; border: 1px solid #d3adf7; }
.badge-red     { background: #fff2f0; color: #cf1322; border: 1px solid #ffa39e; }
.badge-default { background: #f5f5f5; color: #595959; border: 1px solid #d9d9d9; }
</style>
