<template>
  <div v-if="visible" class="modal-overlay" @click.self="close">
    <div class="modal-content">
      <div class="modal-header">
        <span>STR 케이스 상세 - {{ sspsDlId }}</span>
        <span v-if="detail" :class="'badge badge-' + getStatusColor(statusCode)">{{ getStatusLabel(statusCode) }}</span>
        <button class="close-btn" @click="close">✕</button>
      </div>

      <!-- 탭 네비게이션 -->
      <div class="tab-nav">
        <button
          v-for="tab in tabs"
          :key="tab.key"
          :class="['tab-btn', { active: activeTab === tab.key }]"
          @click="activeTab = tab.key"
        >{{ tab.label }}</button>
      </div>

      <div class="modal-body" v-if="detail">
        <!-- 탭 1: 기본정보 -->
        <div v-if="activeTab === 'basic'" class="tab-content">
          <h4>케이스 정보</h4>
          <table class="detail-table">
            <tr>
              <th>케이스일자</th><td>{{ formatDate(detail.caseInfo?.SSPS_DL_CRT_DT) }}</td>
              <th>케이스ID</th><td>{{ detail.caseInfo?.SSPS_DL_ID }}</td>
            </tr>
            <tr>
              <th>진행상태</th>
              <td><span :class="'badge badge-' + getStatusColor(statusCode)">{{ getStatusLabel(statusCode) }}</span></td>
              <th>시나리오유형</th><td>{{ detail.caseInfo?.SSPS_TYP_CD }}</td>
            </tr>
            <tr>
              <th>위험등급</th>
              <td><span :class="'badge badge-' + getRiskColor(detail.caseInfo?.RSK_GRD_CD)">{{ detail.caseInfo?.RSK_GRD_CD || '-' }}</span></td>
              <th>위험점수</th><td>{{ detail.caseInfo?.RSK_MRK }}</td>
            </tr>
            <tr>
              <th>시나리오점수</th><td>{{ detail.caseInfo?.SCNR_MRK }}</td>
              <th>AI 결과</th><td>{{ detail.caseInfo?.AI_RESULT || '-' }}</td>
            </tr>
            <tr v-if="detail.caseInfo?.FIU_RPT_NO">
              <th>FIU 접수번호</th>
              <td colspan="3" style="color:#1890ff;font-weight:bold">
                {{ detail.caseInfo.FIU_RPT_NO }} ({{ formatDate(detail.caseInfo.FIU_RPT_DT) }})
              </td>
            </tr>
          </table>

          <h4 style="margin-top:16px">당사자 정보</h4>
          <table class="detail-table">
            <tr>
              <th>거래자명</th><td>{{ detail.partyInfo?.DL_P_NM }}</td>
              <th>실명번호구분</th><td>{{ detail.partyInfo?.DL_P_RNM_NO_CCD }}</td>
            </tr>
            <tr>
              <th>생년월일</th><td>{{ formatDate(detail.partyInfo?.DL_P_BRTDY) }}</td>
              <th>성별</th>
              <td>{{ detail.partyInfo?.DL_P_SEX_CD === 'M' ? '남성' : detail.partyInfo?.DL_P_SEX_CD === 'F' ? '여성' : '-' }}</td>
            </tr>
            <tr>
              <th>직업코드</th><td>{{ detail.partyInfo?.OCPTN_CCD }}</td>
              <th>연락처</th><td>{{ detail.partyInfo?.DL_P_MBL_TEL_NO }}</td>
            </tr>
            <tr>
              <th>사업장명</th><td>{{ detail.partyInfo?.WP_NM }}</td>
              <th>주소</th><td>{{ detail.partyInfo?.DL_P_HSE_ADDR }}</td>
            </tr>
          </table>
        </div>

        <!-- 탭 2: 거래정보 -->
        <div v-if="activeTab === 'transactions'" class="tab-content">
          <h4>거래 목록 (NIC73B) - {{ (detail.transactions || []).length }}건</h4>
          <DxDataGrid :data-source="detail.transactions || []" :show-borders="true" :height="260">
            <DxColumn data-field="SEQ_NO" caption="순번" :width="60" />
            <DxColumn data-field="MN_DL_BRN_NM" caption="지점명" :width="120" />
            <DxColumn data-field="DL_DT" caption="거래일자" :width="100" />
            <DxColumn data-field="DL_TM" caption="거래시각" :width="90" />
            <DxColumn data-field="DL_TYP_CCD" caption="거래유형" :width="100" />
            <DxColumn data-field="DL_AMT" caption="거래금액" :width="140" data-type="number" :format="{ type: 'fixedPoint', precision: 0 }" alignment="right" />
            <DxColumn data-field="DL_CCY" caption="통화" :width="70" />
            <DxColumn data-field="CNTRP_NM" caption="상대방" :width="120" />
            <DxColumn data-field="CNTRP_AC_NO" caption="상대계좌" :width="150" />
            <DxPaging :enabled="false" />
          </DxDataGrid>

          <h4 style="margin-top:16px">계좌별 합계 (NIC75B)</h4>
          <DxDataGrid :data-source="detail.amounts || []" :show-borders="true" :height="160">
            <DxColumn data-field="GNL_AC_NO" caption="계좌번호" />
            <DxColumn data-field="DL_AMT" caption="합계금액" data-type="number" :format="{ type: 'fixedPoint', precision: 0 }" alignment="right" />
            <DxColumn data-field="DL_CCY" caption="통화" :width="70" />
            <DxPaging :enabled="false" />
          </DxDataGrid>
        </div>

        <!-- 탭 3: 보고서 -->
        <div v-if="activeTab === 'report'" class="tab-content">
          <form @submit.prevent="saveReport">
            <div class="form-row">
              <label>의심거래 등급 *</label>
              <select v-model="reportForm.dobtDlGrdCd" :disabled="isReadOnly" required>
                <option value="">등급 선택</option>
                <option value="H">고위험(H)</option>
                <option value="M">중위험(M)</option>
                <option value="L">저위험(L)</option>
              </select>
            </div>
            <div class="form-row">
              <label>보고사유 *</label>
              <textarea v-model="reportForm.rprRsnCntnt" :disabled="isReadOnly" rows="5" placeholder="의심거래 보고 사유를 상세히 입력하세요." required></textarea>
            </div>
            <div v-for="n in 6" :key="n" class="form-row">
              <label>항목 {{ n }}</label>
              <input
                v-model="reportForm['itemCntnt' + n]"
                :disabled="isReadOnly"
                type="text"
                :placeholder="['거래행태','자금출처','거래목적','직업/사업','관련인물','기타'][n-1] + ' 관련 사항'"
              />
            </div>
            <button v-if="!isReadOnly" type="submit" class="btn-primary" :disabled="reportSaving">
              {{ reportSaving ? '저장 중...' : '보고서 저장' }}
            </button>
          </form>
        </div>

        <!-- 탭 4: 결재이력 -->
        <div v-if="activeTab === 'approval'" class="tab-content">
          <div class="workflow-steps">
            <div v-for="(step, i) in workflowSteps" :key="i" :class="['step', { active: i === approvalStep, done: i < approvalStep }]">
              <div class="step-dot">{{ i < approvalStep ? '✓' : i + 1 }}</div>
              <div class="step-label">{{ step }}</div>
            </div>
          </div>
          <DxDataGrid :data-source="detail.approvals || []" :show-borders="true" :height="200">
            <DxColumn data-field="GYLJ_LINE_G_C" caption="결재선" :width="130" :calculate-display-value="(r) => APPROVAL_LINE_MAP[r.GYLJ_LINE_G_C] || r.GYLJ_LINE_G_C" />
            <DxColumn data-field="HNDL_DY_TM" caption="처리일시" :width="160" />
            <DxColumn data-field="HNDL_P_ENO" caption="처리자" :width="110" />
            <DxColumn data-field="SN_CCD" caption="상태" :width="80" cell-template="snTemplate" />
            <DxColumn data-field="RSN_CNTNT" caption="사유/의견" />
            <template #snTemplate="{ data }">
              <span :class="'badge badge-' + (data.data.SN_CCD === 'E' ? 'green' : data.data.SN_CCD === 'R' ? 'red' : 'orange')">
                {{ data.data.SN_CCD === 'E' ? '승인' : data.data.SN_CCD === 'R' ? '반려' : '대기' }}
              </span>
            </template>
            <DxPaging :enabled="false" />
          </DxDataGrid>
        </div>
      </div>

      <div v-else-if="loading" class="modal-body modal-loading">불러오는 중...</div>

      <!-- 푸터 액션 버튼 -->
      <div class="modal-footer">
        <div class="footer-actions">
          <template v-if="statusCode === '9'">
            <button class="btn-primary" @click="activeTab = 'report'">보고서 작성</button>
            <button class="btn-success" @click="showApprovalModal = true">결재 상신</button>
          </template>
          <template v-if="statusCode === '97'">
            <button class="btn-primary" @click="openProcessModal('E')">승인</button>
            <button class="btn-danger" @click="openProcessModal('R')">반려</button>
          </template>
          <template v-if="statusCode === '98'">
            <button class="btn-danger" @click="showFiuConfirm = true">FIU 제출</button>
          </template>
        </div>
        <button class="btn-default" @click="close">닫기</button>
      </div>
    </div>

    <!-- 결재 상신 서브모달 -->
    <div v-if="showApprovalModal" class="sub-modal-overlay">
      <div class="sub-modal">
        <h3>결재 상신</h3>
        <div class="form-row">
          <label>결재 요청 사유 *</label>
          <textarea v-model="approvalRsn" rows="4" placeholder="결재 요청 사유를 입력하세요."></textarea>
        </div>
        <div class="sub-modal-footer">
          <button class="btn-primary" @click="submitApproval" :disabled="approvalSubmitting">
            {{ approvalSubmitting ? '처리중...' : '상신' }}
          </button>
          <button class="btn-default" @click="showApprovalModal = false; approvalRsn = ''">취소</button>
        </div>
      </div>
    </div>

    <!-- 승인/반려 서브모달 -->
    <div v-if="showProcessModal" class="sub-modal-overlay">
      <div class="sub-modal">
        <h3>{{ processAction === 'E' ? '결재 승인' : '결재 반려' }}</h3>
        <div class="form-row">
          <label>{{ processAction === 'E' ? '승인 의견' : '반려 사유 *' }}</label>
          <textarea v-model="processRsn" rows="4" :placeholder="processAction === 'E' ? '의견 입력 (선택)' : '반려 사유를 입력하세요.'"></textarea>
        </div>
        <div class="sub-modal-footer">
          <button :class="processAction === 'E' ? 'btn-primary' : 'btn-danger'" @click="doProcessApproval" :disabled="processSubmitting">
            {{ processSubmitting ? '처리중...' : processAction === 'E' ? '승인' : '반려' }}
          </button>
          <button class="btn-default" @click="showProcessModal = false; processRsn = ''">취소</button>
        </div>
      </div>
    </div>

    <!-- FIU 확인 모달 -->
    <div v-if="showFiuConfirm" class="sub-modal-overlay">
      <div class="sub-modal">
        <h3>FIU 제출 확인</h3>
        <p>FIU(금융정보분석원)에 혐의거래 보고서를 제출하시겠습니까?</p>
        <p style="color:#faad14">⚠ 제출 후에는 취소가 불가능합니다.</p>
        <div class="sub-modal-footer">
          <button class="btn-danger" @click="doSubmitFiu" :disabled="fiuSubmitting">
            {{ fiuSubmitting ? '제출중...' : '제출' }}
          </button>
          <button class="btn-default" @click="showFiuConfirm = false">취소</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { DxDataGrid, DxColumn, DxPaging } from 'devextreme-vue/data-grid'
import { strApi } from '../../api/str.js'

const props = defineProps({
  visible: Boolean,
  sspsDlCrtDt: String,
  sspsDlId: String
})
const emit = defineEmits(['close'])

const detail = ref(null)
const loading = ref(false)
const activeTab = ref('basic')

const reportForm = ref({
  dobtDlGrdCd: '', rprRsnCntnt: '',
  itemCntnt1: '', itemCntnt2: '', itemCntnt3: '',
  itemCntnt4: '', itemCntnt5: '', itemCntnt6: ''
})
const reportSaving = ref(false)

const showApprovalModal = ref(false)
const approvalRsn = ref('')
const approvalSubmitting = ref(false)

const showProcessModal = ref(false)
const processAction = ref('E')
const processRsn = ref('')
const processSubmitting = ref(false)
const processTargetAppNo = ref('')

const showFiuConfirm = ref(false)
const fiuSubmitting = ref(false)

const STATUS_MAP = {
  '9':  ['orange', '대기'],
  '97': ['blue',   '검토중'],
  '98': ['green',  '결재완료'],
  '10': ['purple', 'FIU제출']
}
const RISK_MAP = { H: 'red', M: 'orange', L: 'green' }
const APPROVAL_LINE_MAP = {
  TMS1: '1차결재(TMS)', TMS2: '2차결재(TMS)',
  RA1:  '1차결재(RA)',  RA2:  '2차결재(RA)', RA3: '3차결재(RA)'
}

const tabs = [
  { key: 'basic',        label: '기본정보' },
  { key: 'transactions', label: '거래정보' },
  { key: 'report',       label: '보고서'  },
  { key: 'approval',     label: '결재이력' }
]
const workflowSteps = ['대기', '검토중', '결재완료', 'FIU제출']

const statusCode  = computed(() => detail.value?.caseInfo?.RPR_PRGRS_CCD || '')
const isReadOnly  = computed(() => statusCode.value === '10')
const approvalStep = computed(() => ({ '10': 3, '98': 2, '97': 1 }[statusCode.value] || 0))

function getStatusLabel(code) { return STATUS_MAP[code]?.[1] || code || '-' }
function getStatusColor(code) { return STATUS_MAP[code]?.[0] || 'default' }
function getRiskColor(code)   { return RISK_MAP[code] || 'default' }

function formatDate(v) {
  if (!v || v.length !== 8) return v || '-'
  return `${v.slice(0, 4)}-${v.slice(4, 6)}-${v.slice(6, 8)}`
}

async function loadDetail() {
  if (!props.sspsDlCrtDt || !props.sspsDlId) return
  loading.value = true
  try {
    const res = await strApi.getDetail(props.sspsDlCrtDt, props.sspsDlId)
    detail.value = res.data.data
    const r = detail.value?.report
    if (r) {
      reportForm.value = {
        dobtDlGrdCd: r.DOBT_DL_GRD_CD || r.dobtDlGrdCd || '',
        rprRsnCntnt: r.RPR_RSN_CNTNT  || r.rprRsnCntnt  || '',
        itemCntnt1:  r.ITEM_CNTNT1    || r.itemCntnt1    || '',
        itemCntnt2:  r.ITEM_CNTNT2    || r.itemCntnt2    || '',
        itemCntnt3:  r.ITEM_CNTNT3    || r.itemCntnt3    || '',
        itemCntnt4:  r.ITEM_CNTNT4    || r.itemCntnt4    || '',
        itemCntnt5:  r.ITEM_CNTNT5    || r.itemCntnt5    || '',
        itemCntnt6:  r.ITEM_CNTNT6    || r.itemCntnt6    || '',
      }
    }
  } catch (e) {
    alert('상세 조회 실패: ' + e.message)
  } finally {
    loading.value = false
  }
}

watch(() => props.visible, (v) => {
  if (v) { activeTab.value = 'basic'; loadDetail() }
  else   { detail.value = null }
})

async function saveReport() {
  reportSaving.value = true
  try {
    await strApi.saveReport(props.sspsDlCrtDt, props.sspsDlId, reportForm.value)
    alert('보고서가 저장되었습니다.')
    await loadDetail()
  } catch (e) {
    alert('저장 실패: ' + e.message)
  } finally {
    reportSaving.value = false
  }
}

async function submitApproval() {
  if (!approvalRsn.value.trim()) { alert('결재 요청 사유를 입력하세요.'); return }
  approvalSubmitting.value = true
  try {
    await strApi.submitApproval(props.sspsDlCrtDt, props.sspsDlId, { rsnCntnt: approvalRsn.value })
    alert('결재가 상신되었습니다.')
    showApprovalModal.value = false
    approvalRsn.value = ''
    await loadDetail()
  } catch (e) {
    alert('결재 상신 실패: ' + e.message)
  } finally {
    approvalSubmitting.value = false
  }
}

function openProcessModal(action) {
  processAction.value = action
  processRsn.value = ''
  const pending = detail.value?.approvals?.find(a => a.SN_CCD === 'N' || !a.SN_CCD)
  processTargetAppNo.value = pending?.APP_NO || ''
  showProcessModal.value = true
}

async function doProcessApproval() {
  if (processAction.value === 'R' && !processRsn.value.trim()) {
    alert('반려 사유를 입력하세요.'); return
  }
  processSubmitting.value = true
  try {
    await strApi.approveCase(processTargetAppNo.value, {
      snCcd: processAction.value,
      rsnCntnt: processRsn.value,
      apprUsrId: ''
    })
    alert(processAction.value === 'E' ? '승인되었습니다.' : '반려되었습니다.')
    showProcessModal.value = false
    await loadDetail()
  } catch (e) {
    alert('처리 실패: ' + e.message)
  } finally {
    processSubmitting.value = false
  }
}

async function doSubmitFiu() {
  fiuSubmitting.value = true
  try {
    await strApi.submitFiu(props.sspsDlCrtDt, props.sspsDlId)
    alert('FIU에 보고서가 제출되었습니다.')
    showFiuConfirm.value = false
    await loadDetail()
    close(true)
  } catch (e) {
    alert('FIU 제출 실패: ' + e.message)
  } finally {
    fiuSubmitting.value = false
  }
}

function close(refresh = false) { emit('close', refresh) }
</script>

<style scoped>
.modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 1000; display: flex; align-items: center; justify-content: center; }
.modal-content { background: #fff; border-radius: 8px; width: 1100px; max-width: 95vw; max-height: 90vh; display: flex; flex-direction: column; }
.modal-header { padding: 16px 20px; border-bottom: 1px solid #e8e8e8; display: flex; align-items: center; gap: 12px; font-size: 16px; font-weight: bold; }
.close-btn { margin-left: auto; background: none; border: none; font-size: 18px; cursor: pointer; color: #888; }
.tab-nav { display: flex; border-bottom: 1px solid #e8e8e8; background: #fafafa; }
.tab-btn { padding: 10px 20px; border: none; background: none; cursor: pointer; font-size: 14px; color: #666; border-bottom: 2px solid transparent; }
.tab-btn.active { color: #1890ff; border-bottom-color: #1890ff; background: #fff; }
.modal-body { padding: 20px; overflow-y: auto; flex: 1; min-height: 300px; }
.modal-loading { display: flex; align-items: center; justify-content: center; color: #888; }
.tab-content h4 { font-size: 13px; color: #555; margin: 0 0 8px; padding-bottom: 4px; border-bottom: 1px solid #f0f0f0; }
.detail-table { width: 100%; border-collapse: collapse; font-size: 13px; }
.detail-table th, .detail-table td { padding: 7px 10px; border: 1px solid #f0f0f0; }
.detail-table th { background: #fafafa; color: #666; width: 14%; white-space: nowrap; }
.form-row { margin-bottom: 12px; }
.form-row label { display: block; font-size: 13px; color: #555; margin-bottom: 4px; }
.form-row input, .form-row textarea, .form-row select { width: 100%; padding: 8px 10px; border: 1px solid #d9d9d9; border-radius: 4px; font-size: 13px; box-sizing: border-box; }
.form-row input:disabled, .form-row textarea:disabled, .form-row select:disabled { background: #f5f5f5; color: #999; }
.workflow-steps { display: flex; align-items: center; margin-bottom: 16px; padding: 12px; background: #f9f9f9; border-radius: 6px; }
.step { display: flex; flex-direction: column; align-items: center; flex: 1; }
.step-dot { width: 28px; height: 28px; border-radius: 50%; background: #d9d9d9; color: #fff; display: flex; align-items: center; justify-content: center; font-size: 12px; }
.step.active .step-dot { background: #1890ff; }
.step.done .step-dot { background: #52c41a; }
.step-label { font-size: 11px; color: #888; margin-top: 4px; }
.step.active .step-label { color: #1890ff; font-weight: bold; }
.modal-footer { padding: 12px 20px; border-top: 1px solid #e8e8e8; display: flex; justify-content: space-between; align-items: center; }
.footer-actions { display: flex; gap: 8px; }
.sub-modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.4); z-index: 1100; display: flex; align-items: center; justify-content: center; }
.sub-modal { background: #fff; border-radius: 8px; padding: 24px; width: 460px; }
.sub-modal h3 { margin: 0 0 16px; font-size: 16px; }
.sub-modal p { margin: 0 0 8px; font-size: 14px; }
.sub-modal-footer { display: flex; gap: 8px; justify-content: flex-end; margin-top: 16px; }
.btn-primary { padding: 6px 16px; background: #1890ff; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-primary:hover { background: #40a9ff; }
.btn-success { padding: 6px 16px; background: #52c41a; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-success:hover { background: #73d13d; }
.btn-danger { padding: 6px 16px; background: #ff4d4f; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-danger:hover { background: #ff7875; }
.btn-default { padding: 6px 16px; background: #fff; border: 1px solid #d9d9d9; border-radius: 4px; cursor: pointer; font-size: 13px; }
.btn-default:hover { border-color: #1890ff; color: #1890ff; }
.badge { display: inline-block; padding: 2px 8px; border-radius: 10px; font-size: 12px; font-weight: 500; }
.badge-orange { background: #fff7e6; color: #d46b08; border: 1px solid #ffd591; }
.badge-blue   { background: #e6f7ff; color: #096dd9; border: 1px solid #91d5ff; }
.badge-green  { background: #f6ffed; color: #389e0d; border: 1px solid #b7eb8f; }
.badge-purple { background: #f9f0ff; color: #531dab; border: 1px solid #d3adf7; }
.badge-red    { background: #fff2f0; color: #cf1322; border: 1px solid #ffa39e; }
.badge-default { background: #f5f5f5; color: #595959; border: 1px solid #d9d9d9; }
</style>
