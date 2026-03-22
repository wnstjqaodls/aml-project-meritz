<template>
  <div>
    <div class="page-header">
      <div>
        <h2>KYC 고객확인</h2>
        <p>고객 신원확인(KYC) 현황 및 이행 관리</p>
      </div>
    </div>

    <!-- 검색 조건 -->
    <div class="search-bar">
      <label>고객명</label>
      <input v-model="searchParams.custNm" type="text" placeholder="고객명 입력" style="width:150px" />

      <label>KYC 상태</label>
      <select v-model="searchParams.kycStsCcd" style="width:140px">
        <option value="">전체</option>
        <option value="1">정상</option>
        <option value="2">갱신필요</option>
        <option value="3">미이행</option>
        <option value="4">거래거절</option>
      </select>

      <label>위험등급</label>
      <select v-model="searchParams.rskGrdCd" style="width:120px">
        <option value="">전체</option>
        <option value="H">H (고위험)</option>
        <option value="M">M (중위험)</option>
        <option value="L">L (저위험)</option>
      </select>

      <button class="btn-primary" @click="fetchData">조회</button>
    </div>

    <DxDataGrid
      :data-source="kycList"
      :show-borders="true"
      :row-alternation-enabled="true"
      :hover-state-enabled="true"
      :column-auto-width="true"
      style="background:#fff;"
    >
      <DxColumn data-field="CUST_NO"      caption="고객번호"   :width="130" />
      <DxColumn data-field="CUST_NM"      caption="고객명"     :width="140" />
      <DxColumn data-field="CUST_TYP_CD"  caption="고객유형"   :width="100" />
      <DxColumn data-field="RSK_GRD_CD"   caption="위험등급"   :width="90"  cell-template="riskTemplate" />
      <DxColumn data-field="KYC_STS_CCD"  caption="KYC상태"    :width="110" cell-template="statusTemplate" />
      <DxColumn data-field="KYC_DT"       caption="확인일자"   :width="110" />
      <DxColumn data-field="KYC_EXP_DT"   caption="만료일자"   :width="110" />
      <DxColumn data-field="NEXT_KYC_DT"  caption="차기KYC일"  :width="110" />
      <DxColumn data-field="KYC_CHK_P_NM" caption="확인담당자" :width="120" />

      <template #riskTemplate="{ data }">
        <span :class="'badge badge-' + getRiskColor(data.data.RSK_GRD_CD)">
          {{ data.data.RSK_GRD_CD || '-' }}
        </span>
      </template>
      <template #statusTemplate="{ data }">
        <span :class="'badge badge-' + getKycStatusColor(data.data.KYC_STS_CCD)">
          {{ getKycStatusLabel(data.data.KYC_STS_CCD) }}
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
import {
  DxDataGrid, DxColumn, DxPaging, DxPager, DxFilterRow, DxScrolling
} from 'devextreme-vue/data-grid'
import { kycApi } from '../../api/kyc.js'

const kycList = ref([])
const searchParams = ref({
  custNm:    '',
  kycStsCcd: '',
  rskGrdCd:  ''
})

const RISK_MAP   = { H: 'red', M: 'orange', L: 'green' }
const KYC_STATUS = {
  '1': ['green',  '정상'],
  '2': ['orange', '갱신필요'],
  '3': ['red',    '미이행'],
  '4': ['purple', '거래거절']
}

function getRiskColor(code)      { return RISK_MAP[code] || 'default' }
function getKycStatusLabel(code) { return KYC_STATUS[code]?.[1] || code || '-' }
function getKycStatusColor(code) { return KYC_STATUS[code]?.[0] || 'default' }

async function fetchData() {
  try {
    const params = { page: 1, size: 100, ...searchParams.value }
    const res = await kycApi.getList(params)
    kycList.value = res.data.data?.list || res.data.data?.content || []
  } catch (e) {
    alert('KYC 목록 조회 실패: ' + e.message)
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
.badge-red     { background: #fff2f0; color: #cf1322; border: 1px solid #ffa39e; }
.badge-orange  { background: #fff7e6; color: #d46b08; border: 1px solid #ffd591; }
.badge-green   { background: #f6ffed; color: #389e0d; border: 1px solid #b7eb8f; }
.badge-purple  { background: #f9f0ff; color: #531dab; border: 1px solid #d3adf7; }
.badge-default { background: #f5f5f5; color: #595959; border: 1px solid #d9d9d9; }
</style>
