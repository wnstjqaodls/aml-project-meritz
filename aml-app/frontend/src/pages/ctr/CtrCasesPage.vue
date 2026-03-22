<template>
  <div>
    <div class="page-header">
      <div>
        <h2>CTR 처리</h2>
        <p>고액현금거래 보고(CTR) 케이스 처리 및 FIU 제출 관리</p>
      </div>
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
        <option value="98">완료</option>
        <option value="10">FIU제출</option>
      </select>

      <button class="btn-primary" @click="fetchData">조회</button>
    </div>

    <DxDataGrid
      :data-source="cases"
      :show-borders="true"
      :row-alternation-enabled="true"
      :hover-state-enabled="true"
      :column-auto-width="true"
      style="background:#fff;"
    >
      <DxColumn data-field="CTR_DL_CRT_DT" caption="생성일자"   :width="110" />
      <DxColumn data-field="CTR_DL_ID"     caption="케이스ID"   :width="150" />
      <DxColumn data-field="DL_P_NM"       caption="거래자명"   :width="130" />
      <DxColumn data-field="DL_AMT"        caption="거래금액"   :width="150" data-type="number" :format="{ type: 'fixedPoint', precision: 0 }" alignment="right" />
      <DxColumn data-field="DL_CCY"        caption="통화"       :width="70" />
      <DxColumn data-field="RPR_PRGRS_CCD" caption="진행상태"   :width="110" cell-template="statusTemplate" />
      <DxColumn data-field="FIU_RPT_NO"    caption="FIU접수번호" :width="160" />
      <DxColumn data-field="RPT_DT"        caption="보고일자"   :width="110" />

      <template #statusTemplate="{ data }">
        <span :class="'badge badge-' + getStatusColor(data.data.RPR_PRGRS_CCD)">
          {{ getStatusLabel(data.data.RPR_PRGRS_CCD) }}
        </span>
      </template>

      <DxPaging :page-size="20" />
      <DxPager :show-page-size-selector="false" :show-info="true" info-text="총 {2}건" />
      <DxFilterRow :visible="true" />
      <DxScrolling mode="standard" />
    </DxDataGrid>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import dayjs from 'dayjs'
import {
  DxDataGrid, DxColumn, DxPaging, DxPager, DxFilterRow, DxScrolling
} from 'devextreme-vue/data-grid'
import { ctrApi } from '../../api/str.js'

const cases       = ref([])
const stDate      = ref(dayjs().subtract(30, 'day').format('YYYY-MM-DD'))
const edDate      = ref(dayjs().format('YYYY-MM-DD'))
const rprPrgrsCcd = ref('')

const STATUS_MAP = {
  '9':  ['orange', '대기'],
  '97': ['blue',   '검토중'],
  '98': ['green',  '완료'],
  '10': ['purple', 'FIU제출']
}

function getStatusLabel(code) { return STATUS_MAP[code]?.[1] || code || '-' }
function getStatusColor(code) { return STATUS_MAP[code]?.[0] || 'default' }

async function fetchData() {
  try {
    const params = {
      stDate: stDate.value.replace(/-/g, ''),
      edDate: edDate.value.replace(/-/g, ''),
      page: 1, size: 100
    }
    if (rprPrgrsCcd.value) params.rprPrgrsCcd = rprPrgrsCcd.value
    const res = await ctrApi.getCases(params)
    cases.value = res.data.data?.list || res.data.data?.content || []
  } catch (e) {
    alert('CTR 케이스 조회 실패: ' + e.message)
  }
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
.badge { display: inline-block; padding: 2px 8px; border-radius: 10px; font-size: 12px; font-weight: 500; }
.badge-orange  { background: #fff7e6; color: #d46b08; border: 1px solid #ffd591; }
.badge-blue    { background: #e6f7ff; color: #096dd9; border: 1px solid #91d5ff; }
.badge-green   { background: #f6ffed; color: #389e0d; border: 1px solid #b7eb8f; }
.badge-purple  { background: #f9f0ff; color: #531dab; border: 1px solid #d3adf7; }
.badge-default { background: #f5f5f5; color: #595959; border: 1px solid #d9d9d9; }
</style>
