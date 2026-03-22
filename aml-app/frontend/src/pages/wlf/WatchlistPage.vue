<template>
  <div>
    <div class="page-header">
      <div>
        <h2>WLF 감시목록 검색</h2>
        <p>감시대상 필터링(WLF) - 고위험 인물·기관 조회 및 스크리닝</p>
      </div>
      <button class="btn-success" @click="handleScreen" :disabled="screening">
        {{ screening ? '스크리닝 중...' : '고객 스크리닝 실행' }}
      </button>
    </div>

    <!-- 검색 조건 -->
    <div class="search-bar">
      <label>성명</label>
      <input v-model="searchParams.wlfFlnmCntt" type="text" placeholder="성명 입력" style="width:140px" />

      <label>카테고리</label>
      <select v-model="searchParams.wlfIstuClsCntt" style="width:160px">
        <option value="">전체</option>
        <option value="UN제재">UN제재</option>
        <option value="OFAC">OFAC</option>
        <option value="EU제재">EU제재</option>
        <option value="국내제재">국내제재</option>
        <option value="PEP">PEP(정치적노출인물)</option>
        <option value="테러">테러관련</option>
        <option value="자금세탁">자금세탁관련</option>
        <option value="사기">사기관련</option>
        <option value="부패">부패관련</option>
        <option value="마약">마약관련</option>
        <option value="무기">무기관련</option>
        <option value="인권침해">인권침해관련</option>
        <option value="기타">기타</option>
      </select>

      <label>국적</label>
      <input v-model="searchParams.wlfNtntCntt" type="text" placeholder="국적 입력" style="width:100px" />

      <button class="btn-primary" @click="fetchData">조회</button>
    </div>

    <!-- 감시목록 DataGrid -->
    <DxDataGrid
      :data-source="watchlist"
      :show-borders="true"
      :row-alternation-enabled="true"
      :hover-state-enabled="true"
      :column-auto-width="true"
      @row-click="onRowClick"
      style="cursor:pointer; background:#fff;"
    >
      <DxColumn data-field="WLF_UNIQ_NO"      caption="고유번호"  :width="130" />
      <DxColumn data-field="WLF_ISTU_CLS_CNTT" caption="카테고리" :width="150" />
      <DxColumn data-field="WLF_FLNM_CNTT"    caption="성명"      :width="140" />
      <DxColumn data-field="WLF_NTNT_CNTT"    caption="국적"      :width="100" />
      <DxColumn data-field="WLF_BRTDY_CNTT"   caption="생년월일"  :width="110" />
      <DxColumn data-field="WLF_CRSPD_CNTT"   caption="대응내용"  />
      <DxColumn data-field="WLF_SPLMT_DT"     caption="보완일자"  :width="110" />

      <DxPaging :page-size="20" />
      <DxPager :show-page-size-selector="false" :show-info="true" info-text="총 {2}건" />
      <DxFilterRow :visible="true" />
      <DxScrolling mode="standard" />
    </DxDataGrid>

    <!-- 상세 모달 -->
    <div v-if="selectedItem" class="modal-overlay" @click.self="selectedItem = null">
      <div class="modal-content">
        <div class="modal-header">
          <span>감시대상 상세 - {{ selectedItem.WLF_FLNM_CNTT }}</span>
          <button class="close-btn" @click="selectedItem = null">✕</button>
        </div>
        <div class="modal-body">
          <table class="detail-table">
            <tr><th>고유번호</th><td>{{ selectedItem.WLF_UNIQ_NO }}</td><th>카테고리</th><td>{{ selectedItem.WLF_ISTU_CLS_CNTT }}</td></tr>
            <tr><th>성명</th><td>{{ selectedItem.WLF_FLNM_CNTT }}</td><th>국적</th><td>{{ selectedItem.WLF_NTNT_CNTT }}</td></tr>
            <tr><th>생년월일</th><td>{{ selectedItem.WLF_BRTDY_CNTT }}</td><th>보완일자</th><td>{{ selectedItem.WLF_SPLMT_DT }}</td></tr>
            <tr><th>대응내용</th><td colspan="3">{{ selectedItem.WLF_CRSPD_CNTT }}</td></tr>
            <tr><th>별칭</th><td colspan="3">{{ selectedItem.WLF_ALIAS_CNTT || '-' }}</td></tr>
            <tr><th>주소</th><td colspan="3">{{ selectedItem.WLF_ADDR_CNTT || '-' }}</td></tr>
          </table>
        </div>
        <div class="modal-footer">
          <button class="btn-default" @click="selectedItem = null">닫기</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import {
  DxDataGrid, DxColumn, DxPaging, DxPager, DxFilterRow, DxScrolling
} from 'devextreme-vue/data-grid'
import { watchlistApi } from '../../api/watchlist.js'

const watchlist  = ref([])
const screening  = ref(false)
const selectedItem = ref(null)

const searchParams = ref({
  wlfFlnmCntt:    '',
  wlfIstuClsCntt: '',
  wlfNtntCntt:    ''
})

async function fetchData() {
  try {
    const params = { page: 1, size: 100, ...searchParams.value }
    const res = await watchlistApi.search(params)
    watchlist.value = res.data.data?.list || res.data.data?.content || []
  } catch (e) {
    alert('감시목록 조회 실패: ' + e.message)
  }
}

async function handleScreen() {
  screening.value = true
  try {
    await watchlistApi.screen({})
    alert('스크리닝이 완료되었습니다.')
    await fetchData()
  } catch (e) {
    alert('스크리닝 실패: ' + e.message)
  } finally {
    screening.value = false
  }
}

function onRowClick({ data }) {
  selectedItem.value = data
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
.btn-success { padding: 6px 16px; background: #52c41a; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-success:hover { background: #73d13d; }
.modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 1000; display: flex; align-items: center; justify-content: center; }
.modal-content { background: #fff; border-radius: 8px; width: 800px; max-width: 95vw; max-height: 80vh; display: flex; flex-direction: column; }
.modal-header { padding: 16px 20px; border-bottom: 1px solid #e8e8e8; display: flex; align-items: center; justify-content: space-between; font-size: 16px; font-weight: bold; }
.close-btn { background: none; border: none; font-size: 18px; cursor: pointer; color: #888; }
.modal-body { padding: 20px; overflow-y: auto; flex: 1; }
.modal-footer { padding: 12px 20px; border-top: 1px solid #e8e8e8; display: flex; justify-content: flex-end; }
.detail-table { width: 100%; border-collapse: collapse; font-size: 13px; }
.detail-table th, .detail-table td { padding: 8px 10px; border: 1px solid #f0f0f0; }
.detail-table th { background: #fafafa; color: #666; width: 16%; white-space: nowrap; }
.btn-default { padding: 6px 16px; background: #fff; border: 1px solid #d9d9d9; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-default:hover { border-color: #1890ff; color: #1890ff; }
</style>
