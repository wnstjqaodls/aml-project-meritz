<template>
  <div>
    <div class="page-header">
      <div>
        <h2>RA 위험평가</h2>
        <p>고객별 위험평가(RA) 항목 관리 및 평가 결과 조회</p>
      </div>
    </div>

    <!-- 평가 실행 영역 -->
    <div class="eval-bar">
      <label>고객번호</label>
      <input v-model="evalCustNo" type="text" placeholder="고객번호 입력" style="width:200px" />
      <button class="btn-primary" @click="doEvaluate" :disabled="evaluating">
        {{ evaluating ? '평가 중...' : 'RA 평가 실행' }}
      </button>
      <span v-if="evalResult" :class="'badge badge-' + getRiskColor(evalResult.rskGrdCd)" style="font-size:14px; padding:4px 12px">
        결과: {{ evalResult.rskGrdCd }} 등급 ({{ evalResult.totalScore }}점)
      </span>
    </div>

    <!-- 탭 -->
    <div class="tab-nav">
      <button :class="['tab-btn', { active: activeTab === 'items' }]"   @click="activeTab = 'items'">RA 항목 목록</button>
      <button :class="['tab-btn', { active: activeTab === 'results' }]" @click="activeTab = 'results'">평가 결과</button>
    </div>

    <!-- RA 항목 목록 -->
    <div v-if="activeTab === 'items'">
      <DxDataGrid
        :data-source="raItems"
        :show-borders="true"
        :row-alternation-enabled="true"
        :column-auto-width="true"
        style="background:#fff;"
      >
        <DxColumn data-field="RA_ITEM_CD"   caption="항목코드"   :width="110" />
        <DxColumn data-field="RA_ITEM_NM"   caption="항목명"     :width="200" />
        <DxColumn data-field="RA_ITEM_TYPE" caption="유형"       :width="100" />
        <DxColumn data-field="RA_ITEM_WGHT" caption="가중치(%)"  :width="100" alignment="right" />
        <DxColumn data-field="RA_ITEM_ORD"  caption="정렬순서"   :width="90"  alignment="right" />
        <DxColumn data-field="USE_YN"       caption="사용여부"   :width="80"  cell-template="useTemplate" />
        <template #useTemplate="{ data }">
          <span :class="data.data.USE_YN === 'Y' ? 'badge badge-green' : 'badge badge-default'">
            {{ data.data.USE_YN === 'Y' ? '사용' : '미사용' }}
          </span>
        </template>
        <DxPaging :page-size="20" />
        <DxPager :show-page-size-selector="false" :show-info="true" info-text="총 {2}건" />
        <DxFilterRow :visible="true" />
        <DxScrolling mode="standard" />
      </DxDataGrid>
    </div>

    <!-- 평가 결과 -->
    <div v-if="activeTab === 'results'">
      <div class="search-bar">
        <label>위험등급</label>
        <select v-model="resultFilter.rskGrdCd">
          <option value="">전체</option>
          <option value="H">H (고위험)</option>
          <option value="M">M (중위험)</option>
          <option value="L">L (저위험)</option>
        </select>
        <button class="btn-primary" @click="fetchResults">조회</button>
      </div>
      <DxDataGrid
        :data-source="raResults"
        :show-borders="true"
        :row-alternation-enabled="true"
        :column-auto-width="true"
        style="background:#fff;"
      >
        <DxColumn data-field="CUST_NO"     caption="고객번호"   :width="130" />
        <DxColumn data-field="CUST_NM"     caption="고객명"     :width="140" />
        <DxColumn data-field="RSK_GRD_CD"  caption="위험등급"   :width="90"  cell-template="riskTemplate" />
        <DxColumn data-field="TOTAL_SCR"   caption="총점수"     :width="90"  alignment="right" />
        <DxColumn data-field="EDD_YN"      caption="EDD여부"    :width="80"  />
        <DxColumn data-field="EVAL_DT"     caption="평가일자"   :width="110" />
        <DxColumn data-field="NEXT_EVAL_DT" caption="차기평가일" :width="110" />
        <template #riskTemplate="{ data }">
          <span :class="'badge badge-' + getRiskColor(data.data.RSK_GRD_CD)">
            {{ data.data.RSK_GRD_CD || '-' }}
          </span>
        </template>
        <DxPaging :page-size="20" />
        <DxPager :show-page-size-selector="false" :show-info="true" info-text="총 {2}건" />
        <DxFilterRow :visible="true" />
        <DxScrolling mode="standard" />
      </DxDataGrid>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import {
  DxDataGrid, DxColumn, DxPaging, DxPager, DxFilterRow, DxScrolling
} from 'devextreme-vue/data-grid'
import { raApi } from '../../api/ra.js'

const raItems    = ref([])
const raResults  = ref([])
const activeTab  = ref('items')
const evaluating = ref(false)
const evalCustNo = ref('')
const evalResult = ref(null)

const resultFilter = ref({ rskGrdCd: '' })

const RISK_MAP = { H: 'red', M: 'orange', L: 'green' }
function getRiskColor(code) { return RISK_MAP[code] || 'default' }

async function fetchItems() {
  try {
    const res = await raApi.getItems()
    raItems.value = res.data.data || []
  } catch (e) {
    console.error('RA 항목 조회 실패', e)
  }
}

async function fetchResults() {
  try {
    const params = { page: 1, size: 100, ...resultFilter.value }
    const res = await raApi.getResults(params)
    raResults.value = res.data.data?.list || res.data.data?.content || []
  } catch (e) {
    alert('RA 평가결과 조회 실패: ' + e.message)
  }
}

async function doEvaluate() {
  if (!evalCustNo.value.trim()) { alert('고객번호를 입력하세요.'); return }
  evaluating.value = true
  evalResult.value = null
  try {
    const res = await raApi.evaluate(evalCustNo.value)
    evalResult.value = res.data.data
    alert('평가가 완료되었습니다.')
    await fetchResults()
  } catch (e) {
    alert('평가 실패: ' + e.message)
  } finally {
    evaluating.value = false
  }
}

onMounted(() => {
  fetchItems()
  fetchResults()
})
</script>

<style scoped>
.page-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px; }
.page-header h2 { margin: 0 0 4px; font-size: 20px; }
.page-header p  { margin: 0; color: #888; font-size: 13px; }
.eval-bar { display: flex; gap: 10px; align-items: center; background: #fff; padding: 12px 16px; border-radius: 6px; margin-bottom: 16px; flex-wrap: wrap; }
.eval-bar label { font-size: 13px; color: #555; }
.eval-bar input { padding: 6px 10px; border: 1px solid #d9d9d9; border-radius: 4px; font-size: 13px; }
.search-bar { display: flex; gap: 8px; align-items: center; background: #fff; padding: 12px 16px; border-radius: 6px; margin-bottom: 12px; flex-wrap: wrap; }
.search-bar label  { font-size: 13px; color: #555; }
.search-bar select { padding: 6px 10px; border: 1px solid #d9d9d9; border-radius: 4px; font-size: 13px; }
.tab-nav { display: flex; border-bottom: 2px solid #e8e8e8; margin-bottom: 16px; }
.tab-btn { padding: 8px 20px; border: none; background: none; cursor: pointer; font-size: 14px; color: #666; border-bottom: 2px solid transparent; margin-bottom: -2px; }
.tab-btn.active { color: #1890ff; border-bottom-color: #1890ff; font-weight: 500; }
.btn-primary { padding: 6px 16px; background: #1890ff; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-primary:hover { background: #40a9ff; }
.badge { display: inline-block; padding: 2px 8px; border-radius: 10px; font-size: 12px; font-weight: 500; }
.badge-red     { background: #fff2f0; color: #cf1322; border: 1px solid #ffa39e; }
.badge-orange  { background: #fff7e6; color: #d46b08; border: 1px solid #ffd591; }
.badge-green   { background: #f6ffed; color: #389e0d; border: 1px solid #b7eb8f; }
.badge-default { background: #f5f5f5; color: #595959; border: 1px solid #d9d9d9; }
</style>
