<template>
  <div>
    <div class="page-header">
      <div>
        <h2>고객 목록</h2>
        <p>등록 고객 현황 및 위험등급 관리</p>
      </div>
    </div>

    <!-- 검색 조건 -->
    <div class="search-bar">
      <label>고객명</label>
      <input v-model="searchParams.custNm" type="text" placeholder="고객명 입력" style="width:150px" />

      <label>고객유형</label>
      <select v-model="searchParams.custTypCd" style="width:130px">
        <option value="">전체</option>
        <option value="I">개인</option>
        <option value="C">법인</option>
        <option value="F">외국인</option>
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
      :data-source="customers"
      :show-borders="true"
      :row-alternation-enabled="true"
      :hover-state-enabled="true"
      :column-auto-width="true"
      style="background:#fff;"
    >
      <DxColumn data-field="CUST_NO"     caption="고객번호"   :width="130" />
      <DxColumn data-field="CUST_NM"     caption="고객명"     :width="150" />
      <DxColumn data-field="CUST_TYP_CD" caption="고객유형"   :width="90"  cell-template="typeTemplate" />
      <DxColumn data-field="RSK_GRD_CD"  caption="위험등급"   :width="90"  cell-template="riskTemplate" />
      <DxColumn data-field="OCPTN_CCD"   caption="직업코드"   :width="100" />
      <DxColumn data-field="NTNT_CCD"    caption="국적"       :width="100" />
      <DxColumn data-field="BRTDY"       caption="생년월일"   :width="110" />
      <DxColumn data-field="REG_DT"      caption="등록일자"   :width="110" />
      <DxColumn data-field="PEP_YN"      caption="PEP여부"    :width="80"  cell-template="pepTemplate" />
      <DxColumn data-field="EDD_YN"      caption="EDD여부"    :width="80"  />

      <template #typeTemplate="{ data }">
        <span>{{ data.data.CUST_TYP_CD === 'I' ? '개인' : data.data.CUST_TYP_CD === 'C' ? '법인' : data.data.CUST_TYP_CD === 'F' ? '외국인' : (data.data.CUST_TYP_CD || '-') }}</span>
      </template>
      <template #riskTemplate="{ data }">
        <span :class="'badge badge-' + getRiskColor(data.data.RSK_GRD_CD)">
          {{ data.data.RSK_GRD_CD || '-' }}
        </span>
      </template>
      <template #pepTemplate="{ data }">
        <span v-if="data.data.PEP_YN === 'Y'" class="badge badge-red">PEP</span>
        <span v-else class="badge badge-default">-</span>
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
import { customerApi } from '../../api/customer.js'

const customers  = ref([])
const searchParams = ref({
  custNm:    '',
  custTypCd: '',
  rskGrdCd:  ''
})

const RISK_MAP = { H: 'red', M: 'orange', L: 'green' }
function getRiskColor(code) { return RISK_MAP[code] || 'default' }

async function fetchData() {
  try {
    const params = { page: 1, size: 50, ...searchParams.value }
    const res = await customerApi.getList(params)
    customers.value = res.data.data?.list || res.data.data?.content || []
  } catch (e) {
    alert('고객 목록 조회 실패: ' + e.message)
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
.badge-default { background: #f5f5f5; color: #595959; border: 1px solid #d9d9d9; }
</style>
