# AMLXpress 7.0 프로젝트 분석 문서

> **작성일**: 2026-03-08
> **작성자**: 외주 개발자 (메리츠증권 AML TMS 담당)
> **대상 시스템**: gtone AMLXpress 7.0
> **작업 폴더**: `D:\dev\workspace\aml-project-meritz`
> **소스 원본 (추출됨)**: `C:\tmp\aml_work\RA_소스\`

---

## 1. 시스템 개요

### AMLXpress 7.0 (gtone)
- **목적**: 자금세탁방지(AML) 솔루션 — STR(혐의거래보고), CTR(고액현금거래보고), 위험평가 등
- **기술 스택**: Spring Framework + MyBatis(iBatis) XML mapper + Oracle DB
- **DB 스키마**: `SSQ` (앱 접속 계정: `JSQ0APP`, synonym으로 접근)
- **Oracle JDBC**: `jdbc:oracle:thin:@172.16.21.49:1521:orcl`
- **룰 엔진**: BRMiner (현재 메리츠 미사용) → `useBRMiner='N'` → TMS_APPL 기반으로 동작

---

## 2. 메뉴 구조 (AMLXpress 7.4 기준)

```
AMLXpress 7.0
├── TMS (이상거래감시)
│   ├── STR (혐의거래보고)
│   ├── CTR (고액현금거래보고)
│   ├── 룰셋관리
│   ├── 설정값관리
│   ├── TMS결재관리
│   └── TMS기준정보관리
│       ├── STR추출기준관리
│       ├── CTR추출기준관리
│       ├── 시나리오별 주기
│       ├── STR설정값관리
│       ├── CTR설정값관리
│       ├── 시뮬레이션조회
│       └── TMS배치관리
├── WLF (워치리스트 필터링)  — Apache Lucene 기반, 스코어 임계치 90F
├── RA  (고객위험평가)
├── KYC (고객확인)
├── RBA (부점위험평가 배치)
├── 내부통제
├── QA
├── AI 관리
├── 보고서
└── 시스템관리
```

---

## 3. MyBatis XML Mapper → 모듈 매핑

| Namespace | 파일 | 역할 |
|-----------|------|------|
| `AML_00` | AML_00.xml | 공통 콤보/코드 조회 |
| `AML_10` | AML_10.xml | **WLF** (WatchList Filtering), NIC92B 코드 |
| `AML_20` | AML_20.xml | **STR/CTR 케이스** 목록·상세·결재 (1.1MB, 메인) |
| `AML_20_KOFIU` | AML_20_KOFIU.xml | KOFIU 제출 STR |
| `AML_20_SS` | AML_20_SS.xml | 삼성증권 커스텀 STR |
| `AML_30` | AML_30.xml | **Link 분석** (거래관계도) — V_LNK_ACT_INFO, V_LNK_TRN_INFO |
| `AML_40` | AML_40.xml | (빈 파일) |
| `AML_50` | AML_50.xml | **룰셋관리·시뮬레이션·TMS결재·RA결재** |
| `AML_60` | AML_60.xml | **CTR/STR 보고서** (NIC86B 보고기관 정보) |
| `AML_70` | AML_70.xml | Factiva 고객상세 팝업 |
| `AML_90` | AML_90.xml | 사용자 권한 (NIC97B) |
| `AML_100` | AML_100.xml | (빈 파일) |

---

## 4. NIC* 테이블 일람

> NIC00B ~ NIC99B 범위의 테이블이 존재. 현재까지 발견된 것들:

| 테이블 | 역할 | 주요 컬럼 |
|--------|------|-----------|
| `NIC01B` | 고객 기본 | RNMCNO, INDV_CORP_CCD, CS_TYP_CD, CS_NM, LG_AMT_ASTS_F |
| `NIC17B` | 계좌 | GNL_AC_NO |
| `NIC19B_FACTIVA_UA` | WLF 제재 목록 | WLF_UNIQ_NO, WLF_FLNM_CNTT, WLF_FIRST/MIDDLE/LAST_NAME_CNTT, WLF_NTNT_CNTT, SPLM_DATE |
| `NIC35B` | 고객 위험 | RNMCNO, RSK_GRD_CD, LST_RSK_EAL_SOR |
| `NIC41B` | 부점/부서 | DPRT_CD, DPRT_NM, HG_RNK_DPRT_CD, USE_CCD |
| **`NIC58B`** | **룰 승인 상태** | RULE_ID, SN_PRGRS_CCD, RULE_UPD_MAJ_VER, RULE_UPD_MIN_VER, RULE_LST_MAJ_VER, RULE_LST_MIN_VER, INST_ID, SN_REQ_DY_TM, SN_REQ_CMNT, SN_REQ_P_ENO |
| `NIC61B` | 거래 원장 | (Link 분석용) |
| `NIC62B` | 상대방 거래 | (Link 분석용) |
| `NIC64B` | 파일 첨부 | SSPS_DL_CRT_DT, SSPS_DL_ID |
| **`NIC66B`** | **STR/CTR 케이스 메인** | SSPS_DL_CRT_DT, SSPS_DL_ID, **SSPS_TYP_CD**(=시나리오ID), RPR_PRGRS_CCD, SSPS_DL_CRT_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, INST_ID, SCNR_MRK, AI_RESULT |
| `NIC67B` | STR 보고 내용 | SSPS_DL_CRT_DT, SSPS_DL_ID, RPR_RSN_CNTNT(CLOB), ITEM_CNTNT1~6, DOBT_DL_GRD_CD |
| `NIC68B` | 관련 문서 | SSPS_DL_CRT_DT, SSPS_DL_ID |
| **`NIC70B`** | **거래자 기본** | SSPS_DL_CRT_DT, DL_P_RNMCNO, DL_P_NM, DL_P_RNM_NO_CCD, INDV_CORP_CCD |
| **`NIC73B`** | **거래 목록** | SSPS_DL_CRT_DT, SSPS_DL_ID, MN_DL_BRN_CD, MN_DL_BRN_NM |
| `NIC75B` | 계좌·거래금액 | SSPS_DL_CRT_DT, SSPS_DL_ID, GNL_AC_NO, DL_AMT |
| `NIC78B` | 거래자 상세 | SSPS_DL_CRT_DT, DL_P_RNMCNO, DL_P_BRTDY, DL_P_SEX_CD, OCPTN_CCD, DL_P_HSE_ADDR, DL_P_MBL_TEL_NO, WP_NM, RNM_CMBNTN_NO |
| `NIC80B_LOG` | 처리 로그 | SSPS_DL_CRT_DT, SSPS_DL_ID, PROC_FALG(0=정상,1=오류) |
| `NIC86B` | 보고기관 정보 | RPR_OGN_NM, RPR_RSPSB_P_NM, RPR_CHRG_P_NM, RPR_CHRG_P_TEL_NO |
| `NIC89B` | 협의 이력 | SSPS_DL_CRT_DT, SSPS_DL_ID, MN_DL_BRN_CD |
| `NIC92B` | 공통 코드 | CD, CNTNT, CD_NM |
| `NIC97B` | 사용자 권한 | USER_ID |

### NIC66B 핵심 컬럼 설명

```
SSPS_DL_CRT_DT    : 혐의거래 생성 날짜 (PK 일부)
SSPS_DL_ID        : 혐의거래 ID (PK 일부) — CTR/STR 구분 포함
SSPS_TYP_CD       : 시나리오 코드 = TMS_APPL.SCNR_ID = MMA010TB.MA01_6
SSPS_DL_CRT_CCD   : 케이스 유형 ('STR', 'CTR', 'KYC', 'CAC' 등)
RPR_PRGRS_CCD     : 보고 진행 코드 ('9'대기, '97','98','99'완료, '10'제출)
DL_P_RNMCNO       : 거래자 실명확인번호
OK_CCD            : 확인 구분 ('0'미확인, '1'확인)
INST_ID           : 워크플로우 인스턴스ID
SCNR_MRK          : 시나리오 점수
AI_RESULT         : AI 분석 결과
```

---

## 5. TMS 룰 관련 테이블 (BRS/MMA/TMS 시리즈)

### 5.1 룰 구조 테이블 (BRMiner 엔진용 — 참고용)

```
C_BIZ            → 업무(룰) 카탈로그
                   BIZ_ID, BIZ_NM(의심거래유형명), BIZ_DESC, PAR_BIZ_ID

MMA010TB         → 룰 마스터
                   MA01_2(=RS31_1), MA01_6(=룰ID/SCNR_ID), MA01_8('S'=사용중), RT30_1(=BIZ_ID), RT31_1

MMA070TB         → 룰 매핑
                   MA06_1('M'=메인), MA07_1(=MA01_6)

C_PKG_BIZ_MAP    → 패키지-업무 매핑
                   PKG_ID('6'=TMS 시나리오), BIZ_ID

BRS310TB         → 룰 단계 정의
                   RS31_1(룰키), RS31_3(MinVer기준), RS31_6, RS31_T, RS31_U, RS31_Y(수정일시), RS31_Z(수정자)

BRS320TB         → 룰 버전 정보
                   RS31_1, RS32_1(MajorVer), RS32_2(룰분류명/RULE_ID), RS32_3, RS32_4

BRS330TB         → 룰 파라미터
                   RS31_1, RS32_1, RS33_1(SEQ), RS33_2(TYPE), RS33_3(NAME)

BRS340TB         → 룰 조건/버전
                   RS31_1, RS32_1(MajVer), RS34_1(MinVer), RS34_2(1=활성), RS34_U(2=최신배포)

BRS3A0TB         → 룰 입력값
                   RS31_1, RS32_1, RS33_1, RS3A_1(INPUT값)

BRS360TB         → 룰 단계6
                   RS31_1, RS32_1, RS34_1, RS35_1, RS36_1, RS36_2

BRT3B0TB         → 룰 트리/번들
                   RT31_1(트리키), RS31_1, RS32_1, RT32_1
```

### 5.2 TMS 시나리오/설정값 테이블 (핵심 — useBRMiner=N 환경)

```
TMS_APPL         → 시나리오 적용 목록 (화면에 표시되는 시나리오 목록)
                   SCNR_ID, SCNR_NM, SCNR_CCD('STR'/'CTR'), BZDM_CD, LST_APP_NO

TMS_REQ          → 시나리오 요청/기준 정보
                   SCNR_ID, SCNR_NM, SCNR_CCD

TMS_SET_VAL      → 시나리오별 설정값 (임계치)
                   SCNR_ID, CS_CCD, SET_VAL_CD, SET_VAL
                   REG_ID, REG_DTTM, UPD_ID, UPD_DTTM

TMS_SET_VAL_APP  → 설정값 결재 요청
                   APP_NO, SCNR_ID

TMS_SET_VAL_APP_DTL → 설정값 결재 요청 상세
                      APP_NO, CS_CCD, SET_VAL_CD, SET_VAL_NM, SET_VAL
```

### 5.3 결재 관련 테이블

```
AML_APPR         → 결재
                   APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD
                   APPR_ROLE_ID, TARGET_ROLE_ID, RSN_CNTNT
                   HNDL_DY_TM, HNDL_P_ENO, WLR_SQ, REG_DT, PRV_APP_NO

AML_APPR_HIST    → 결재 이력
                   APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD
                   BRN_CD, APPR_ROLE_ID, TARGET_ROLE_ID, RSN_CNTNT(CLOB)
                   HNDL_DY_TM, HNDL_P_ENO

시퀀스: AML_APPR_HIST_SEQ (NUM_SQ 생성용)
```

### 5.4 결재선(GYLJ_LINE_G_C) 분류

| 값 | 대상 |
|----|------|
| `TMS1` | TMS 룰셋 1차 결재 |
| `TMS2` | TMS 룰셋 2차 결재 |
| `RA1` | 위험평가등급 결재 |
| `RA2` | 위험평가항목점수 결재 |
| `RA3` | 위험평가항목가중치 결재 |

### 5.5 코드 테이블 (GET_CODE_NAME 함수 참고)

| 코드그룹 | 설명 |
|----------|------|
| `S041` | 룰 결재 진행 상태 (SN_PRGRS_CCD) |
| `A038` | 결재 상태 (SN_CCD: N=미결재, E=완료 등) |
| `A029` | 보고 진행 코드 (RPR_PRGRS_CCD) |
| `A004` | 위험등급 (RSK_GRD_CD: H/M/L) |
| `A101` | 케이스 유형 (STR/CTR/CAC 등) |
| `M002` | 실명번호 구분 코드 |
| `M012` | 고객 유형 |

---

## 6. 핵심 관계 정리

### SSPS_TYP_CD = SCNR_ID = MA01_6 = 룰ID

```
NIC66B.SSPS_TYP_CD  ←→  TMS_APPL.SCNR_ID  ←→  MMA010TB.MA01_6
```
- NIC66B(케이스)의 `SSPS_TYP_CD`가 곧 시나리오/룰 코드
- `GET_SYNARIO_NAME(SSPS_TYP_CD)` 함수 → TMS_APPL에서 시나리오명 반환

### useBRMiner 분기 (메리츠 = 'N')

```sql
-- useBRMiner = 'N' (메리츠)
→ 시나리오 조회: TMS_APPL (SCNR_ID, SCNR_NM, SCNR_CCD)
→ 설정값: TMS_SET_VAL (SCNR_ID, CS_CCD, SET_VAL_CD, SET_VAL)
→ 룰명표시: '[' || SCNR_ID || ']' || SCNR_NM

-- useBRMiner = 'Y' (BRMiner 엔진 사용 시)
→ 시나리오 조회: C_BIZ + MMA010TB (MA01_6, BIZ_NM)
→ 룰 구조: BRS310TB, BRS320TB, BRS340TB 등
```

---

## 7. 핵심 SQL 쿼리 모음 (TMS 담당자용)

### 7.1 시나리오(룰) 목록 조회

```sql
-- STR 시나리오 전체 목록 (메리츠 방식: useBRMiner=N)
SELECT SCNR_CCD
      ,SCNR_ID                        AS CODE
      ,SCNR_ID || '::' || SCNR_NM    AS NAME
  FROM TMS_APPL
 WHERE SCNR_CCD = 'STR'
 ORDER BY SCNR_ID ASC;

-- CTR 시나리오 목록
SELECT SCNR_CCD, SCNR_ID, SCNR_NM
  FROM TMS_APPL
 WHERE SCNR_CCD = 'CTR'
 ORDER BY SCNR_ID ASC;

-- STR + 수기등록 포함 목록 (화면 콤보용)
SELECT 'STR' AS SCNR_CCD, 'KYC0' AS CODE, 'KYC0::수기 등록' AS NAME
  FROM DUAL
UNION ALL
SELECT SCNR_CCD, SCNR_ID AS CODE, SCNR_ID || '::' || SCNR_NM AS NAME
  FROM TMS_APPL
 WHERE SCNR_CCD = 'STR'
 ORDER BY SCNR_CCD DESC, CODE ASC;
```

### 7.2 시나리오별 설정값(임계치) 조회

```sql
-- 특정 시나리오의 현재 설정값 (임계치) 조회
SELECT SCNR_ID, CS_CCD, SET_VAL_CD, SET_VAL
  FROM TMS_SET_VAL
 WHERE SCNR_ID = :SCNR_ID   -- 예: 'STR001'
 ORDER BY CS_CCD, SET_VAL_CD;

-- 설정값 변경 이력 (결재 완료된 것 포함)
SELECT A.SCNR_ID
      ,C.SCNR_NM
      ,B.APP_NO
      ,B.CS_CCD
      ,B.SET_VAL_CD
      ,B.SET_VAL_NM
      ,B.SET_VAL
  FROM TMS_SET_VAL_APP A
 INNER JOIN TMS_SET_VAL_APP_DTL B ON A.APP_NO = B.APP_NO
 INNER JOIN TMS_REQ C ON A.SCNR_ID = C.SCNR_ID
 WHERE A.SCNR_ID = :SCNR_ID
 ORDER BY TO_NUMBER(B.APP_NO) DESC, B.CS_CCD, B.SET_VAL_CD;

-- 직전 결재 설정값 (변경 전 값 비교용)
WITH TMP AS (
    SELECT APP_NO AS APP_NO2
      FROM (
           SELECT APP_NO, ROW_NUMBER() OVER (ORDER BY TO_NUMBER(APP_NO) DESC) AS RN
             FROM TMS_SET_VAL_APP
            WHERE SCNR_ID = :SCNR_ID
           ) WHERE RN = 2
)
SELECT A.SCNR_ID, C.SCNR_NM, B.APP_NO, B.CS_CCD, B.SET_VAL_CD, B.SET_VAL_NM, B.SET_VAL
  FROM TMS_SET_VAL_APP A
 INNER JOIN TMS_SET_VAL_APP_DTL B ON A.APP_NO = B.APP_NO
 INNER JOIN TMS_REQ C ON A.SCNR_ID = C.SCNR_ID
 WHERE A.APP_NO = (SELECT APP_NO2 FROM TMP)
   AND A.SCNR_ID = :SCNR_ID
 ORDER BY B.CS_CCD, B.SET_VAL_CD;
```

### 7.3 설정값 수정 (UPSERT)

```sql
-- 설정값 저장 (없으면 INSERT, 있으면 UPDATE)
MERGE INTO TMS_SET_VAL A
USING DUAL
   ON (A.SCNR_ID    = :SCNR_ID
   AND A.CS_CCD     = :CS_CCD
   AND A.SET_VAL_CD = :SET_VAL_CD)
 WHEN MATCHED THEN
      UPDATE SET A.SET_VAL  = :SET_VAL
                ,A.UPD_ID   = :USER_ID
                ,A.UPD_DTTM = TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS')
 WHEN NOT MATCHED THEN
      INSERT (A.SCNR_ID, A.CS_CCD, A.SET_VAL_CD, A.SET_VAL, A.REG_ID, A.REG_DTTM)
      VALUES (:SCNR_ID, :CS_CCD, :SET_VAL_CD, :SET_VAL, :USER_ID, TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS'));

-- 특정 시나리오 설정값 전체 삭제
DELETE FROM TMS_SET_VAL WHERE SCNR_ID = :SCNR_ID;
```

### 7.4 STR 케이스 목록 조회

```sql
-- STR 케이스 목록 (NIC66B 기준)
SELECT P.SSPS_DL_ID
      ,P.SSPS_DL_CRT_DT
      ,P.SSPS_DL_CRT_DT || '-' || REPLACE(P.SSPS_DL_ID, 'CTR', 'STR') AS SSPS_DL_CRT_DT_A
      ,Q.DL_P_NM                                               -- 거래자명 (NIC70B)
      ,Q.DL_P_RNM_NO_CCD
      ,P.DL_P_RNMCNO
      ,P.SSPS_TYP_CD                                           -- 시나리오ID
      ,NVL(GET_SYNARIO_NAME(P.SSPS_TYP_CD), '수기등록')  AS SSPS_TYP_NM  -- 시나리오명
      ,P.RPR_PRGRS_CCD
      ,GET_CODE_NAME('A029', P.RPR_PRGRS_CCD)          AS RPR_CCD_NM
      ,(SELECT SUM(I.DL_AMT) FROM NIC75B I
         WHERE I.SSPS_DL_CRT_DT = P.SSPS_DL_CRT_DT
           AND I.SSPS_DL_ID     = P.SSPS_DL_ID)         AS DL_AMT      -- 거래총액
      ,(SELECT COUNT(*) FROM NIC73B J
         WHERE J.SSPS_DL_CRT_DT = P.SSPS_DL_CRT_DT
           AND J.SSPS_DL_ID     = P.SSPS_DL_ID)         AS SSPS_DL_CNT -- 건수
      ,P.OK_CCD
      ,P.SCNR_MRK                                              -- 시나리오 점수
  FROM NIC66B P
      ,NIC70B Q
 WHERE P.SSPS_DL_CRT_DT = Q.SSPS_DL_CRT_DT
   AND P.DL_P_RNMCNO    = Q.DL_P_RNMCNO
   AND P.SSPS_DL_CRT_CCD NOT IN ('CTR', 'CAC')               -- STR만
   AND P.SSPS_DL_CRT_DT BETWEEN :stDate AND :edDate           -- 기간
-- AND P.SSPS_TYP_CD = :SCNR_ID                               -- 시나리오 필터 (선택)
-- AND P.RPR_PRGRS_CCD IN ('9', '97', '98')                   -- 진행상태 필터 (선택)
 ORDER BY P.SSPS_DL_CRT_DT DESC;
```

### 7.5 CTR 케이스 목록 조회

```sql
-- CTR 케이스 목록 (NIC66B에서 CTR 타입)
SELECT P.SSPS_DL_ID
      ,P.SSPS_DL_CRT_DT
      ,Q.DL_P_NM
      ,P.DL_P_RNMCNO
      ,P.RPR_PRGRS_CCD
      ,GET_CODE_NAME('A029', P.RPR_PRGRS_CCD) AS RPR_CCD_NM
      ,(SELECT SUM(I.DL_AMT) FROM NIC75B I
         WHERE I.SSPS_DL_CRT_DT = P.SSPS_DL_CRT_DT
           AND I.SSPS_DL_ID     = P.SSPS_DL_ID) AS DL_AMT
  FROM NIC66B P
      ,NIC70B Q
 WHERE P.SSPS_DL_CRT_DT = Q.SSPS_DL_CRT_DT
   AND P.DL_P_RNMCNO    = Q.DL_P_RNMCNO
   AND P.SSPS_DL_CRT_CCD = 'CTR'
   AND P.SSPS_DL_CRT_DT BETWEEN :stDate AND :edDate
 ORDER BY P.SSPS_DL_CRT_DT DESC;
```

### 7.6 룰 승인 상태 조회 (NIC58B)

```sql
-- 특정 룰의 현재 결재/배포 상태
SELECT SN_PRGRS_CCD
      ,NVL(SN_PRGRS_CCD_NM, '미결재') AS SN_PRGRS_CCD_NM
      ,IS_UPD
      ,DECODE(IS_UPD, 'X', '0', DEPLOY_DT) AS DEPLOY_DT
  FROM (
    SELECT NVL(A.SN_PRGRS_CCD, 'X')                              AS SN_PRGRS_CCD
          ,GET_CODE_NAME('S041', A.SN_PRGRS_CCD)                 AS SN_PRGRS_CCD_NM
          ,CASE WHEN D.RS32_1=C.RS31_3 AND D.RS34_2=1
                THEN 'O' ELSE 'X' END                            AS IS_UPD
          ,CASE WHEN NVL(A.SN_PRGRS_CCD,'9')='9'
                 AND D.RS32_1=C.RS31_6
                 AND D.RS34_U=2
                THEN SUBSTR(C.RS31_Y,1,8) ELSE '0' END          AS DEPLOY_DT
      FROM NIC58B A
          ,BRS320TB B
          ,BRS310TB C
          ,BRS340TB D
     WHERE B.RS32_2  = DECODE(:RULE_ID, '0000', 'CTR기준금액', :RULE_ID)
       AND B.RS31_1  = C.RS31_1
       AND C.RS31_1  = D.RS31_1
       AND D.RS32_1  = A.RULE_UPD_MAJ_VER(+)
       AND D.RS34_1  = A.RULE_UPD_MIN_VER(+)
       AND A.RULE_ID(+) = REPLACE(:RULE_ID, '기준DATA_', '')
     ORDER BY D.RS32_1 DESC, D.RS34_1 DESC, A.INST_ID DESC NULLS LAST
  )
 WHERE ROWNUM = 1;

-- 인스턴스별 룰 상태 (INST_ID 기준)
SELECT RULE_ID, SN_PRGRS_CCD, RULE_UPD_MAJ_VER, RULE_UPD_MIN_VER
      ,RULE_LST_MAJ_VER, RULE_LST_MIN_VER
      ,SN_REQ_DY_TM, SN_REQ_CMNT, SN_REQ_P_ENO
  FROM NIC58B
 WHERE RULE_ID = :RULE_ID
   AND INST_ID = :INST_ID;
```

### 7.7 TMS 결재 목록 조회

```sql
-- 결재 대기 목록 (담당자별)
SELECT A.APP_NO
      ,TO_CHAR(TO_DATE(A.APP_DT,'YYYYMMDD'),'YYYY-MM-DD') AS APP_DT
      ,B.SCNR_ID
      ,B.SCNR_CCD
      ,'[' || B.SCNR_ID || ']' || B.SCNR_NM               AS CATEGORY
      ,B.SCNR_NM
      ,A.SN_CCD
      ,A.RSN_CNTNT                                         -- 결재 사유
  FROM AML_APPR A
 INNER JOIN TMS_APPL B ON A.APP_NO = B.LST_APP_NO
 INNER JOIN TMS_REQ C  ON B.SCNR_ID = C.SCNR_ID
 WHERE A.GYLJ_LINE_G_C IN ('TMS1','TMS2')
   AND A.TARGET_ROLE_ID = :APPR_ROLE_ID                    -- 결재할 사람 역할
   AND A.SN_CCD != 'E'                                     -- 완료 제외
   AND A.APP_DT BETWEEN :stDate AND :edDate
 ORDER BY A.APP_DT DESC;

-- 결재 전체 이력 (완료 포함)
SELECT A.APP_NO
      ,TO_CHAR(TO_DATE(A.APP_DT,'YYYYMMDD'),'YYYY-MM-DD') AS APP_DT
      ,B.SCNR_ID
      ,'[' || B.SCNR_ID || ']' || B.SCNR_NM               AS CATEGORY
      ,A.SN_CCD
      ,CASE WHEN A.SN_CCD = 'E' THEN A.APP_DT END          AS SN_END_DY_TM
      ,A.RSN_CNTNT
  FROM AML_APPR A
 INNER JOIN TMS_APPL B ON A.APP_NO = B.LST_APP_NO
 INNER JOIN TMS_REQ C  ON B.SCNR_ID = C.SCNR_ID
 WHERE A.GYLJ_LINE_G_C IN ('TMS1','TMS2')
   AND A.APP_DT BETWEEN :stDate AND :edDate
 ORDER BY A.APP_DT DESC;

-- 결재 상세 (특정 APP_NO)
SELECT A.APP_NO, B.SCNR_ID, B.SCNR_NM
      ,A.HNDL_P_ENO AS USER_ID
      ,D.USER_NM
      ,TO_CHAR(A.HNDL_DY_TM,'YYYY-MM-DD HH24:MI:SS') AS REQ_DTTM
      ,A.RSN_CNTNT
      ,B.SCNR_CCD
  FROM AML_APPR A
 INNER JOIN TMS_APPL B ON A.APP_NO = B.LST_APP_NO
 INNER JOIN TMS_REQ C  ON B.SCNR_ID = C.SCNR_ID
 INNER JOIN C_USER D   ON A.HNDL_P_ENO = D.USER_ID
 WHERE A.APP_NO = :APP_NO;

-- 결재 이력 (처리 순서별)
SELECT ROW_NUMBER() OVER(ORDER BY A.NUM_SQ ASC) AS ROW_NUM
      ,A.SNO, A.SN_CCD, A.APPR_ROLE_ID, A.RSN_CNTNT
      ,TO_CHAR(A.HNDL_DY_TM,'YYYY-MM-DD HH24:MI:SS') AS HNDL_DY_TM
      ,A.HNDL_P_ENO
      ,B.USER_NM
  FROM AML_APPR_HIST A
 INNER JOIN C_USER B ON A.HNDL_P_ENO = B.USER_ID
 WHERE A.APP_NO = :APP_NO
 ORDER BY A.NUM_SQ DESC;
```

### 7.8 결재 처리 (UPDATE)

```sql
-- 결재 처리
UPDATE AML_APPR
   SET APP_DT        = TO_CHAR(SYSDATE,'YYYYMMDD')
      ,NUM_SQ        = :NUM_SQ
      ,SNO           = :SNO
      ,SN_CCD        = :SN_CCD           -- 결재 상태 코드
      ,APPR_ROLE_ID  = :ROLE_ID
      ,TARGET_ROLE_ID = :TARGET_ROLE_ID
      ,RSN_CNTNT     = :APP_CNTNT
      ,HNDL_DY_TM    = SYSDATE
      ,HNDL_P_ENO    = :USER_ID
 WHERE APP_NO = :APP_NO
   AND GYLJ_LINE_G_C = :GYLJ_LINE_G_C;

-- 결재 이력 INSERT
INSERT INTO AML_APPR_HIST
VALUES (
    :APP_NO, :GYLJ_LINE_G_C, :NUM_SQ,
    TO_CHAR(SYSDATE,'YYYYMMDD'), 0, TO_CHAR(SYSDATE,'YYYYMMDD'),
    :SNO, :SN_CCD, :BRN_CD, :ROLE_ID, :TARGET_ROLE_ID, :APP_CNTNT,
    SYSDATE, :USER_ID
);

-- NUM_SQ 채번
SELECT AML_APPR_HIST_SEQ.NEXTVAL AS NUM_SQ FROM DUAL;
```

---

## 8. 배치 모듈 구조 (AMLXpress_7_Batch)

| 배치명 | 클래스 | DB 지원 | 역할 |
|--------|--------|---------|------|
| `AMLDATAB` | DATAB_Main | Oracle | 운영 초기 데이터 적재 (일회성 유틸) |
| `AMLKRAB` | KRAB_Main | Oracle | 고객 위험평가 배치 (RA) — RA_CS_RA_RSLT, RA_CS_RA_RSLT_DTL |
| `AMLWALB` | WALB_Main | Oracle/MySQL/PostgreSQL | WatchList Alert 배치 (WLF) — Lucene 검색, NIC19B_FACTIVA_UA |
| `AMLWLSTB` | WLSTB_Main | Oracle/MySQL/PostgreSQL | WatchList 적재 배치 |
| `AMLWLRTB` | WLRTB_Main | Oracle/MySQL/PostgreSQL | WatchList 보고서 배치 |

> **TMS STR 추출 배치**: 별도 BRMiner 엔진 또는 DB 저장 프로시저가 담당 (소스 미포함)
> 실제 시나리오 실행 결과는 NIC66B에 INSERT됨
> **다중 DB 지원**: WALB/WLSTB/WLRTB는 Oracle, MySQL, PostgreSQL 3종 SQL 클래스 병존 (`WALB_Sql_Oracle.java`, `WALB_Sql_MySQL.java`, `WALB_Sql_Postgre.java`)

---

## 9. RA (고객위험평가) 테이블 (참고)

DDL.txt 기준 63개 테이블 확인. 주요:

```
RA_RISK_FACTOR        → 위험요소 정의
RA_ITEM_NTN/IDJOB/CORJOB/COMMON → 위험 항목
RA_GRD_STD            → 위험등급 기준
RA_ITEM_WGHT          → 항목 가중치
RA_CS_RA_RSLT         → 고객 RA 결과 (요약)
RA_CS_RA_RSLT_DTL     → 고객 RA 결과 상세
RA_CS_TYP_MNG         → 고객 유형 관리 (LST_WGHT_APP_NO, LST_GRD_APP_NO)
RA_ITEM               → RA 항목 (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, LST_APP_NO)
SRBA_*                → 부점 RBA (노출위험, 통제요소, 잔여위험, KRI)
KYC_PRD_*             → 신규상품 위험평가
```

---

## 10. RBA 배치 구조 (rba 패키지)

```
RbaBatchMain.java      — 메인 RBA 배치 (노출/통제/평가)
KriBatchMain.java      — KRI(핵심위험지표) 배치 (일별 실행)
KofiuBatchMain.java    — KOFIU 제출 배치 (규제 보고)
CddBatchMain.java      — CDD(고객확인) 배치
MartBatchMain.java     — 데이터마트 배치
DashboardBatchMain.java — 대시보드 갱신 배치
RbaTrnBatchMain.java   — 거래 데이터 배치

실행 인수 (RbaBatchMain):
  args[0] = 기준년도/월 (YYYYMM)
  args[1] = "2.3" 또는 "M" → 노출/사업위험 추출 (STEP01: 진행상태 40→41)
            "3.3" 또는 "M" → 통제요소 부점 배분 (STEP02: 진행상태 60→61)
            "3.4" 또는 "M" → 내부통제 효과성 집계 (STEP03: 진행상태 70→71)
            완료시: STEPEND (99)

RBA 모듈 규모: Java 151개, JSP 192개, XML 25개
  RBA_30: 설정/구성 (2 클래스)
  RBA_50: 메인 평가 로직 (77 클래스, RBA_50_01~10)
  RBA_90: 시스템/설정 (22 클래스)
  RBA_99: 공통 유틸 (7 클래스)

VO 상위클래스: jbit.core.domain.DefaultVO (한국 금융 기관용 jBIT 프레임워크)
```

---

## 11. WLF 구조 (참고)

```java
// WLFLoaderTest.java 기준
Oracle: jdbc:oracle:thin:@172.16.21.49:1521:orcl / jbbank
테이블: NIC19B_FACTIVA_UA (WLF_FLNM_CNTT, WLF_FIRST/MIDDLE/LAST_NAME_CNTT)
Lucene 인덱스 경로: C:\ijs\meriz\index\WPEP01\
매칭 임계 스코어: 90F

카테고리: SIE, UN, RCA, SIP, KFSC, W180, UN-FINCEN, EURO, FATF, KFIU, PEPs, ETC, OFAC
```

---

## 12. 현재 담당자 요구사항 / TODO

### 담당 영역
- **TMS 모듈** (이상거래감시) 담당
- **룰 관련 쿼리가 제일 급함**

### 필요한 것들 (우선순위 순)

#### [긴급] TMS 룰 관련
- [ ] 메리츠 실제 환경에서 `TMS_APPL` 조회 → 어떤 SCNR_ID들이 있는지 확인
- [ ] `TMS_SET_VAL` 조회 → 각 시나리오별 임계치(SET_VAL) 현황 파악
- [ ] `NIC66B.SSPS_TYP_CD` 분포 확인 → 어떤 룰로 STR이 생성되는지
- [ ] `NIC58B` 조회 → 각 룰의 현재 결재 상태

#### [중요] STR 추출 기준
- [ ] 어떤 테이블/뷰가 STR 추출 조건을 저장하는지 확인 필요
  - BRMiner 미사용이면 `TMS_APPL` + `TMS_SET_VAL` 조합으로 조건 관리
  - 또는 DB 저장 프로시저 확인 필요
- [ ] STR 추출 배치 실행 방식 파악 (DB Job? 별도 배치 서버?)

#### [참고] 추가 파악 필요 항목
- [ ] `TMS_APPL.BZDM_CD` 의미 파악 (업무 도메인 코드?)
- [ ] `TMS_APPL.LST_APP_NO` — 최근 결재 번호 연결 방식
- [ ] `CS_CCD` 컬럼 의미 파악 (TMS_SET_VAL에서 사용)
- [ ] `SET_VAL_CD` 코드 목록 파악 (어떤 종류의 임계치들이 있는지)
- [ ] STR추출기준관리, CTR추출기준관리 화면의 실제 백엔드 로직 확인

---

## 13. 소스 파일 위치 (로컬 추출본)

```
C:\tmp\aml_work\
├── RBA\
│   ├── DDL.txt                  ← Oracle DDL 6,282줄, 63개 테이블
│   ├── java\rba\
│   │   ├── main\RbaBatchMain.java
│   │   ├── controller\RbaController.java
│   │   ├── service\RbaService.java
│   │   └── domain\StandardVO.java
│   └── xml\                     ← MyBatis XML mapper들 (RBA 전용)
│
└── RA_소스\
    ├── AMLXpress_7\
    │   ├── src\sql\aml\         ← 핵심 MyBatis XML mapper
    │   │   ├── AML_20.xml       ← STR/CTR 케이스 (1.1MB)
    │   │   ├── AML_50.xml       ← 룰셋관리/시뮬레이션/TMS결재
    │   │   ├── AML_10.xml       ← WLF (1.1MB)
    │   │   ├── AML_60.xml       ← 보고서
    │   │   └── ...
    │   ├── src\com\gtone\aml\server\AML_10\ ← WLF Java 소스
    │   └── WebContent\WEB-INF\Package\AML\  ← JSP 화면
    │
    └── AMLXpress_7_Batch\
        └── src\com\gtone\aml\batch\
            ├── AMLKRAB\         ← 고객 RA 배치 (KRAB_Sql_Oracle.java)
            ├── AMLWALB\         ← WLF Alert 배치 (WALB_Sql_Oracle.java)
            ├── AMLWLSTB\        ← WLF 적재 배치
            ├── AMLWLRTB\        ← WLF 보고서 배치
            └── AMLDATAB\        ← 초기 데이터 적재 (일회성)
```

---

## 14. 자주 쓰는 함수

| 함수 | 설명 | 예시 |
|------|------|------|
| `GET_CODE_NAME(그룹, 코드)` | 코드명 반환 | `GET_CODE_NAME('A029', RPR_PRGRS_CCD)` |
| `GET_SYNARIO_NAME(SCNR_ID)` | 시나리오명 반환 | `GET_SYNARIO_NAME(SSPS_TYP_CD)` |
| `GET_USER_NAME(USER_ID)` | 사용자명 반환 | `GET_USER_NAME(RS31_Z)` |
| `FN_CDINFO_VAR(...)` | 코드정보 반환 | (Link분석 뷰에서 사용) |

---

---

## 15. AML_10 모듈 상세 분석 (RA 항목관리 화면)

> **수정 사항**: 기존 문서에서 AML_10.xml = WLF로만 분류했으나,
> 실제 Java 소스 (`src/com/gtone/aml/server/AML_10/`) 확인 결과 **RA 항목관리 화면** 전담임.
> AML_10.xml (10,000+줄)은 WLF 공통 코드 조회 + **RA 항목 전체 SQL**을 포함하는 복합 mapper.

### 15.1 AML_10 하위 화면 매핑

| 화면ID | Java 클래스 | 담당 기능 | 주요 테이블 |
|--------|------------|----------|------------|
| AML_10_25 | AML_10_25_01_01 | 신상품 체크리스트 관리 | KYC_PRD_CK, KYC_PRD_CK_LST |
| AML_10_36 | AML_10_36_01_01 | RA 항목 관리 (CRUD) | RA_ITEM, RA_CS_TYP_MNG |
| AML_10_37 | AML_10_37_01_01 | RA 위험평가항목 점수 관리 | RA_ITEM, RA_ITEM_SCR_REQ |
| AML_10_38 | AML_10_38_01_01~03 | RA 항목 가중치 구간기준 결재 | RA_ITEM_WGHT, RA_ITEM_WGHT_APPR, RA_ITEM_WGHT_APPR_DTL |
| AML_10_39 | AML_10_39_01_01 | RA 가중치 시뮬레이션/적용 관리 | RA_CS_TYP_MNG, AML_APPR |

### 15.2 RA 관련 핵심 테이블 (소스 확인)

#### RA_ITEM (위험평가항목 마스터)
```sql
RA_ITEM_CD        VARCHAR2   -- 항목 코드 (PK)
RA_ITEM_NM        VARCHAR2   -- 항목명
RA_MDL_GBN_CD     VARCHAR2   -- 모델구분코드: 'I'=개인, 'B'=법인 (코드그룹 A040)
REFF_COMN_CD      VARCHAR2   -- 참조 공통코드 (NIC92B.CD 참조)
MISS_VAL_SCR      NUMBER     -- 누락값 점수
INTV_VAL_YN       VARCHAR2   -- 구간값 여부
USE_YN            VARCHAR2   -- 사용여부
SRT_SQ            NUMBER     -- 정렬순서
LST_APP_NO        VARCHAR2   -- 최근 결재번호 (AML_APPR.APP_NO)
REG_ID, REG_DT, UPD_ID, UPD_DT
```

#### RA_ITEM_SCR_REQ (RA 항목 점수 요청)
```sql
RA_ITEM_CD        VARCHAR2   -- 항목코드 (FK → RA_ITEM)
RA_ITEM_VAL       VARCHAR2   -- 항목값 (코드값 또는 구간값)
RA_ITEM_SCR       NUMBER     -- 항목점수
ABS_HRSK_YN       VARCHAR2   -- 당연고위험여부
```

#### RA_CS_TYP_MNG (고객유형별 RA 관리)
```sql
CS_TYP_CD          VARCHAR2  -- 고객유형코드 (코드그룹 M012)
NEW_OLD_GBN_CD     VARCHAR2  -- 신규/기존 구분 (코드그룹 A030)
LST_WGHT_APP_NO    VARCHAR2  -- 최근 가중치 결재번호 (GYLJ_LINE_G_C='RA3')
LST_GRD_APP_NO     VARCHAR2  -- 최근 등급기준 결재번호 (GYLJ_LINE_G_C='RA1')
LST_RA_ID          VARCHAR2  -- 최근 RA ID
REG_ID, REG_DT, UPD_ID, UPD_DT
```

#### RA_ITEM_WGHT / RA_ITEM_WGHT_APPR / RA_ITEM_WGHT_APPR_DTL
```
RA_ITEM_WGHT         → 항목 가중치 저장
RA_ITEM_WGHT_APPR    → 가중치 결재 요청 헤더
RA_ITEM_WGHT_APPR_DTL → 가중치 결재 요청 상세
```

### 15.3 RA 결재선(GYLJ_LINE_G_C) 상세

| GYLJ_LINE_G_C | 대상 | 관련 컬럼 |
|---------------|------|---------|
| `RA1` | 위험등급 판정기준 결재 | RA_CS_TYP_MNG.LST_GRD_APP_NO |
| `RA2` | 위험평가 항목점수 결재 | RA_ITEM.LST_APP_NO |
| `RA3` | 위험평가 항목가중치 결재 | RA_CS_TYP_MNG.LST_WGHT_APP_NO |

### 15.4 RA 코드 테이블

| 코드그룹 | 설명 | 예시값 |
|----------|------|--------|
| `A040` | RA 모델구분 | I=개인/개인사업자, B=법인 |
| `A030` | 신규/기존 구분 | (신규고객, 기존고객) |
| `M012` | 고객유형 | (개인, 법인 등 세부유형) |
| `A038` | 결재상태 | N=미결재, E=완료 |

### 15.5 AML_10_37 위험평가항목 점수 상세 조회 로직

```java
// RA_ITEM_CD 코드에 따라 다른 SQL 사용:
if("I001".equals(RA_ITEM_CD))    // 국가 → AML_10_37_01_01_doSerch2
else if("I002".equals(RA_ITEM_CD)) // 직업 → AML_10_37_01_01_doSerch3
else if("I003".equals(RA_ITEM_CD)) // 업종 → AML_10_37_01_01_doSerch4
else                               // 공통 → AML_10_37_01_01_doSerch5
```

---

## 16. RBA 배치 모듈 상세 (com.gtone.rba.*)

> **패키지**: `com.gtone.rba.*` — AML 메인(`com.gtone.aml.*`)과 완전히 별개
> **실행방식**: Spring ClassPathXmlApplicationContext 기동 → Controller → Service → DAO (DefaultDAO + SqlMapClient)

### 16.1 도메인 VO 목록

| VO 클래스 | 역할 |
|-----------|------|
| `SchdVO` | 평가 일정 (BasYyyy, ValtTrn, TgtTrnSdt/Edt, BasYymm) |
| `StandardVO` | 위험평가 기준데이터 VO |
| `MltfVO` | ML/TF 위험산출 VO (BasYymm, BasYymmS/E, TgtTrnSdt/Edt) |
| `IndicatorVO` | 위험지표 VO |
| `CddVO` | CDD(고객확인) 배치 VO (yyyymmdd, monCode) |
| `CommVO` | 공통 VO (로그 이력용) |
| `KofiuVO` | KOFIU 제출 VO |
| `KriVO` | KRI(핵심위험지표) VO |
| `MartVO` | Mart 데이터 VO |
| `DashboardVO` | 대시보드 VO |

### 16.2 Controller → Service 흐름

```
RbaBatchMain.java          ← Spring entry point (ClassPathXmlApplicationContext)
    ↓ args[1] 분기
    "2.3" → excuteMltfStep2()   → ML/TF 위험산출
    "3.3" → excuteTongjeStep1() → 통제요소 부점 배분
    "3.4" → excuteTongjeStep2() → 내부통제 효과성

RbaController.java
    selectIngStep()         → 총평가회차 및 진행중 회차 조회
    selectSchd()            → 위험평가 일정 조회
    excuteMltfStep1()       → 노출위험/사업위험 추출 (주석처리됨)
    excuteMltfStep2()       → ML/TF 위험산출 지표 추출 + 지점별 배분
    excuteMltf()            → 노출위험 평가 (국가/직업 스냅샷 → 고객정보 → 이벤트별)

CddBatchMain.java
    monCode="ALL" → service.setCdd_ALL(paramVO)
    monCode="CDD_03" → 개별 CDD 배치 실행
```

### 16.3 ML/TF 위험산출 단계별 처리

```
STEP1 (진행상태=10 → 완료=11):
  1. setNatJobI()          → 평가회차별 기준데이터 생성 (국가/직업 스냅샷)
  2. setCustI()             → 평가회차별 고객정보 생성
  3. setEventNatCustT()    → 이벤트별 국가/고객 정보 생성
  4. setIndicatorStep1()   → 노출위험/사업위험 지표 추출

STEP2 (진행상태=20 → 완료=21):
  1. setIndicatorStep1(MltfVO) → ML/TF 위험지표 추출 (BasYymmS~BasYymmE 기간)
     → SRBA_ETC_I INSERT (BAS_YYMM, RSK_ELMT_C, RA_ITEM_CODE, RA_ITEM_SCR 등)
```

### 16.4 SRBA_ETC_I 테이블 (ML/TF 부점 위험 데이터)

```sql
BAS_YYMM         CHAR(6)    -- 기준년월
RSK_ELMT_C       VARCHAR2   -- 위험요소코드 (R5% = ML/TF 관련)
RA_ITEM_CODE     VARCHAR2   -- RA 항목 코드
RA_ITEM_NM       VARCHAR2   -- RA 항목명
RSK_VALT_ITEM    VARCHAR2   -- 위험평가 항목
RA_ITEM_CD       VARCHAR2   -- RA 항목 코드
RA_ST_INTV_VAL   NUMBER     -- 구간 시작값
RA_ET_INTV_VAL   NUMBER     -- 구간 종료값
RA_ITEM_SCR      NUMBER     -- 항목 점수
ABS_HRSK_YN      VARCHAR2   -- 당연고위험여부
DR_DT            VARCHAR2   -- 추출일자
DR_TIME          VARCHAR2   -- 추출시간
```

### 16.5 RBA XML Mapper 파일 목록

| 파일명 | namespace | 역할 |
|--------|-----------|------|
| mltf.xml | mltf | ML/TF 위험산출 (SRBA_ETC_I) |
| standard.xml | standard | 기준데이터 |
| tongje.xml | tongje | 통제요소 |
| kri.xml | kri | KRI 지표 |
| cdd.xml | cdd | CDD 배치 |
| kofiu.xml | kofiu | KOFIU 제출 |
| mart.xml | mart | Mart 데이터 |
| dashboard.xml | dashboard | 대시보드 |
| schd.xml | schd | 평가 일정 |
| trn.xml | trn | 거래 데이터 |
| cust.xml | cust | 고객 데이터 |
| proc.xml | proc | DB 프로시저 |
| comm.xml | comm | 공통 |
| RBA_50.xml | RBA_50 | 부점 RBA (화면) |
| RBA_99.xml | RBA_99 | 보고서 |

---

## 17. 주요 코드 클래스 패턴 (공통)

### Singleton Service 패턴
```java
// 모든 AML 서버 클래스 공통 패턴
public class AML_10_36_01_01 extends GetResultObject {
    private static AML_10_36_01_01 instance = null;

    public static AML_10_36_01_01 getInstance() {
        if (instance == null) instance = new AML_10_36_01_01();
        return instance;
    }

    public DataObj getSearch(DataObj input) {
        // MDaoUtilSingle.getData("SQL_ID", input) → 단건 조회
        output = MDaoUtilSingle.getData("AML_10_36_01_01_doSearch_7.4", input);
        gdRes = Common.setGridData(output); // jWizard Grid 데이터 변환
    }

    public DataObj doSave(DataObj input) {
        MDaoUtil mDao = new MDaoUtil();
        mDao.begin(); // 트랜잭션 시작
        // ...
        mDao.commit() / mDao.rollback();
    }
}
```

### 에러 코드
| ERRCODE | 의미 |
|---------|------|
| `00000` | 정상 처리 |
| `00001` | 오류 발생 |

### MessageHelper 메시지 키
| 키 | 메시지 |
|----|--------|
| `0001` | 조회된 정보가 없습니다 |
| `0002` | 정상처리 되었습니다 |
| `0003` | 처리할 데이터가 없습니다 |
| `0005` | 처리중 오류가 발생하였습니다 |

### 의존 프레임워크/라이브러리
| 라이브러리 | 패키지 | 역할 |
|-----------|--------|------|
| jWizard | `kr.co.itplus.jwizard.dataformat.DataSet` | UI 데이터 포맷 |
| jspeed | `jspeed.base.util.StringHelper` | 문자열 유틸 |
| AMLXpress Framework | `com.gtone.express.server.helper.MessageHelper` | 다국어 메시지 |
| AMLXpress Framework | `com.gtone.aml.basic.common.data.DataObj` | 데이터 컨테이너 |
| AMLXpress Framework | `com.gtone.aml.dao.common.MDaoUtil/MDaoUtilSingle` | MyBatis DAO |
| Spring | `com.itplus.common.server.user.SessionHelper` | 세션 관리 |

---

## 18. KRAB 배치 RA 점수 계산 로직 (핵심)

> 소스: `KRAB_Sql_Oracle.java`

### 18.1 RA_CS_RA_RSLT_DTL 테이블 (RA 결과 상세)

```sql
-- KRAB_INSERT_RA_CS_RA_RSLT_DTL_001 에서 INSERT
RA_ID          NUMBER     -- RA 식별자 (MAX+1 채번, 시퀀스 미사용)
RNMCNO         VARCHAR2   -- 고객 실명확인번호
RA_ITEM_CD     VARCHAR2   -- 평가항목코드 (I001, I009, B020 등)
CS_TYP_CD      VARCHAR2   -- 고객유형코드
NEW_OLD_GBN_CD VARCHAR2   -- 신규/기존 구분
RA_ITEM_VAL    VARCHAR2   -- 항목값 (코드 또는 숫자)
RA_ITEM_SCR    NUMBER     -- 항목점수
RA_ITEM_WGHT   NUMBER     -- 항목가중치
RA_ITEM_LST_SCR NUMBER    -- 최종점수 = RA_ITEM_SCR * RA_ITEM_WGHT
```

### 18.2 EDD(당연고위험) 판정 조건

| EDD 플래그 | RA_ITEM_CD | 조건 | 의미 |
|-----------|-----------|------|------|
| EDD_YN1  | I001 | RA_ITEM_SCR.ABS_HRSK_YN IN ('Y','H') | 국가 (제재국/고위험국) |
| EDD_YN2  | I009 | RA_ITEM_VAL = '02' | 고액자산가 |
| EDD_YN3  | I011 | RA_ITEM_VAL = '02' | 당사지정 요주의인물 |
| EDD_YN4  | I012 | RA_ITEM_VAL = '02' | 요주의인물 |
| EDD_YN5  | (미확인) | '02' | 혐의거래 보고자 |
| EDD_YN6  | (미확인) | '02' | 가상자산사업자 |
| EDD_YN7  | (미확인) | '02' | 금융범죄 연루 고객 |
| EDD_YN16 | (미확인) | '02' | 선물옵션 거래여부 |
| EDD_YN17 | B020 | ABS_HRSK_YN = 'Y' | 거래종목 (법인) |

### 18.3 RA 등급 결정 알고리즘

```sql
-- 1. 총점 계산
RA_GRD_SCR = TRUNC(SUM(RA_ITEM_LST_SCR), 0) / 10

-- 2. EDD 강제 H 등급 (당연고위험)
IF EDD_YN1='Y' OR EDD_YN2='Y' OR ... OR EDD_YN17='Y' THEN
    LST_RA_GRD_CD = 'H'  -- 강제 고위험

-- 3. 점수 기반 등급 판정 (RA_GRD_STD 조회)
ELSE
    LST_RA_GRD_CD = SELECT RA_GRD_CD FROM RA_GRD_STD
                    WHERE CS_TYP_CD = :CS_TYP_CD
                      AND NEW_OLD_GBN_CD = :NEW_OLD_GBN_CD
                      AND RA_GRD_SCR_MAX = (
                          SELECT MIN(RA_GRD_SCR_MAX) FROM RA_GRD_STD
                          WHERE ... AND :RA_GRD_SCR < RA_GRD_SCR_MAX
                      )
    -- 점수가 최고 구간 초과시: MAX(RA_GRD_SCR_MAX) 등급 사용 (NVL 처리)
```

### 18.4 RA_ITEM_SCR vs RA_ITEM_SCR_REQ (중요 구분!)

| 테이블 | 용도 | 시점 |
|--------|------|------|
| `RA_ITEM_SCR_REQ` | 결재 요청 중인 점수 (임시) | 화면 CRUD, 결재 전 |
| `RA_ITEM_SCR` | 실제 적용 중인 점수 | 결재 완료 후 → KRAB 배치에서 참조 |

> KRAB 배치는 `RA_ITEM_SCR`(결재 완료된 확정값)로 점수 계산
> 화면(AML_10_37)은 `RA_ITEM_SCR_REQ`(결재 요청중 값)을 관리

### 18.5 KRAB 배치 실행 인수

```
args[0] = 처리구분 (ONE: 개인, ALL: 전체, MTH: 최근3개월)
args[1] = 기준일/보고일 (YYYYMMDD)
args[2] = USER_ID

영업일 체크: NIC93B 테이블의 TAGT_DATE 조회 → 비영업일이면 배치 스킵
```

### 18.6 배치 로그 테이블 (NIC93B / NIC93B_LOG)

```sql
NIC93B:      배치 작업 마스터 (JOB_ID, JOB_ST_CD, STRT_DY_TM, END_DY_TM, TAGT_DATE)
NIC93B_LOG:  배치 실행 로그 (JOB_DT, JOB_SEQ, JOB_ID, JOB_ST_CD, PROC_FLAG, TRADE_DT, REPORT_DT)
```

---

## 19. DB 연결 정보 (개발/운영)

```
개발DB (WLF 소스 기준):
  jdbc:oracle:thin:@172.16.21.49:1521:orcl / jbbank

운영 DB (사진에서 확인):
  DBBDN1: 172.17.170.46
  DBBDN2: 172.17.170.48
  DBTTN1: 172.17.175.46
  DBTTN2: 172.17.175.48
  DBBCN:  172.17.160.100

메리츠 재경관리시스템 DB:
  Chakra Max Client v2.0.9.20 으로 접속
  DB 유형: Oracle (DB Browser Tree View)

WLF Lucene 인덱스 경로 (운영):
  C:\ijs\meriz\index\WPEP01\
```

---

## 20. 운영 인프라 (사진 분석 결과)

> 출처: photos/PHOTO_ANALYSIS.md (117장 iPhone 사진 분석 완료 2026-03-08)

### 운영/개발 서버

| 항목 | 값 |
|------|-----|
| 운영 URL | `aml.lmeritz.com/indexSso2.jsp` |
| LENA 관리 콘솔 | `172.17.172.243:7700/lena/server/serverMain` |
| 개발 서버 hostname | **daaml11** |
| 개발 서버 IP | **172.17.172.243** |
| OS | RHEL 9 (5.14.0-570.17.1-el9-6-x86_64, amd64) |
| Java Runtime | OpenJDK 1.8.0_452 (Red Hat, Inc.) |
| Timezone | Asia/Seoul |
| Catalina Base | `/mtsw/lenawax/1.3/servers/RBA` |
| JSP 포트 | 7501 (index5so2.jsp 진입점) |
| LENA 포트 | 7700 |
| DB Admin IP | 172.17.118.171 (Meritz 자금세탁 시스템) |
| SVN 버전 | subversion 1.14.1-5.e19_0 |

### WAS 노드 목록 (LENA 대시보드)

| 노드명 | 유형 | 상태 |
|--------|------|------|
| daaml111_was | Web Application Server (Backend) | Active |
| daaml111_web | Web Frontend Server | Active |
| RBA | Risk-Based Analysis 서버 | Running |
| RBA_SE | RBA Secondary/Extended | Running |
| test_8000 | 테스트 인스턴스 | Running |

### 라이센스 (Trial)

- 유형: Trial System (UNLIMITED cores/instances)
- 기간: **2025/11/04 ~ 2026/01/04** (만료)
- 적용 노드: daaml111_web, daaml111_was
- 적용 모듈: WLF, RBA, 열람권

### JSP 요청 흐름 (재구성)

```
브라우저 → aml.lmeritz.com/indexSso2.jsp (Production)
         → LENA SSO (HIWARE OTP 인증)
         → 172.17.172.243:7501/index5so2.jsp (내부)
         → form[emlfirm] POST → /sao/request_service.jsp (SAO 모듈)
         → request.getSession().getAttribute("USER_ID")
         → 모듈 라우팅
```

- 인코딩: **EUC-KR**
- DOCTYPE: HTML 4.01 Transitional
- SAO = Service Application Object

### 연동 시스템 (브라우저 탭에서 확인)

| 시스템 | 역할 |
|--------|------|
| HIWARE MOBILEQTP | SSO/OTP 인증 (Site ID: HIWOTP) |
| ASIS | 역할/권한 관리 |
| 인사정성 관리 | HR/인사 시스템 |
| AML 운영(TQ-BD) | AML 운영 게시판 |
| LENA | LG CNS 미들웨어 (WAS 관리) |

### 시스템 아키텍처 다이어그램 (P20251020)

```
Data Sources → KYC → CDD/EDD → WL(Watchlist) ←→ Watchlist 관리
                                     ↓
                              TMS (Transaction Monitoring)
                                     ↓
                              RBA (Risk-Based Approach)
                                     ↓
                         자금세탁방지 솔루션 (AML Engine)
                                     ↓
                         STR/CTR 보고 → 보고시스템
```

### 운영 UI 구조 (aml.lmeritz.com 스크린샷)

**상단 탭:** STR | CTR | KYC

**좌측 네비게이션:**
- RBA
- KYC
- Scoring
- ALERT 관리
- CASE Management
- REPORT
- AML 관리

**WatchList 데이터:** 업데이트 이력 (20190401 ~ 20200102, 순번 10~22)

---

*문서 끝*
