-- AMLXpress7 Database Schema (Oracle 12c+ compatible)
-- Converted from schema.sql (H2) for Oracle production deployment
-- Type mappings: VARCHAR->VARCHAR2, BIGINT->NUMBER(19,0), INT->NUMBER(10,0),
--   DECIMAL(n,m)->NUMBER(n,m), CURRENT_TIMESTAMP->SYSTIMESTAMP,
--   AUTO_INCREMENT PRIMARY KEY->NUMBER(19,0) GENERATED ALWAYS AS IDENTITY PRIMARY KEY

-- ============================================================
-- NIC92B: Common Code
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC92B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC92B (
    CD       VARCHAR2(20)  NOT NULL,
    CNTNT    VARCHAR2(50)  NOT NULL,
    CD_NM    VARCHAR2(100),
    ORD_NO   NUMBER(10,0)  DEFAULT 0,
    USE_CCD  CHAR(1)       DEFAULT 'Y',
    PRIMARY KEY (CD, CNTNT)
);
/

-- ============================================================
-- C_USER: User
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE C_USER CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE C_USER (
    USER_ID   VARCHAR2(20)  PRIMARY KEY,
    USER_NM   VARCHAR2(50)  NOT NULL,
    DEPT_CD   VARCHAR2(20),
    EMAIL     VARCHAR2(100),
    PWD       VARCHAR2(256),
    ROLE_ID   VARCHAR2(20)  DEFAULT 'ANALYST',
    USE_CCD   CHAR(1)       DEFAULT 'Y',
    REG_DT    TIMESTAMP     DEFAULT SYSTIMESTAMP
);
/

-- ============================================================
-- NIC41B: Department/Branch
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC41B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC41B (
    DPRT_CD         VARCHAR2(10)  PRIMARY KEY,
    DPRT_NM         VARCHAR2(100),
    HG_RNK_DPRT_CD  VARCHAR2(10),
    USE_CCD         CHAR(1)       DEFAULT 'Y'
);
/

-- ============================================================
-- NIC01B: Customer Master
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC01B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC01B (
    RNMCNO        VARCHAR2(20)   PRIMARY KEY,
    INDV_CORP_CCD CHAR(1),
    CS_TYP_CD     VARCHAR2(10),
    CS_NM         VARCHAR2(100),
    LG_AMT_ASTS_F CHAR(1)        DEFAULT 'N',
    BRTH_DT       VARCHAR2(8),
    NAT_CD        VARCHAR2(5)    DEFAULT 'KR',
    ADDR          VARCHAR2(200),
    TEL_NO        VARCHAR2(20),
    EMAIL         VARCHAR2(100),
    ACNT_OPNG_DT  VARCHAR2(8),
    KYC_STS_CCD   VARCHAR2(10)   DEFAULT 'PEND',
    EDD_F         CHAR(1)        DEFAULT 'N',
    RSK_GRD_CD    VARCHAR2(5),
    RSK_SCR       NUMBER(10,2),
    USE_CCD       CHAR(1)        DEFAULT 'Y',
    REG_ID        VARCHAR2(20),
    REG_DT        TIMESTAMP      DEFAULT SYSTIMESTAMP,
    UPD_ID        VARCHAR2(20),
    UPD_DT        TIMESTAMP
);
/

-- ============================================================
-- NIC17B: Account
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC17B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC17B (
    GNL_AC_NO   VARCHAR2(30)  PRIMARY KEY,
    RNMCNO      VARCHAR2(20),
    AC_TYP_CCD  VARCHAR2(10),
    OPNG_DT     VARCHAR2(8),
    USE_CCD     CHAR(1)       DEFAULT 'Y',
    REG_DT      TIMESTAMP     DEFAULT SYSTIMESTAMP
);
/

-- ============================================================
-- NIC35B: Customer Risk
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC35B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC35B (
    RNMCNO          VARCHAR2(20)  PRIMARY KEY,
    RSK_GRD_CD      VARCHAR2(5),
    LST_RSK_EAL_SOR VARCHAR2(8)
);
/

-- ============================================================
-- NIC19B_FACTIVA_UA: Watchlist (20 columns)
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC19B_FACTIVA_UA CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC19B_FACTIVA_UA (
    WLF_UNIQ_NO            NUMBER(19,0)   GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    WLF_ISTU_CLS_CNTT      VARCHAR2(50),
    WLF_FLNM_CNTT          VARCHAR2(200),
    WLF_RLNM_CNTT          VARCHAR2(200),
    WLF_FCNM_CNTT          VARCHAR2(200),
    WLF_RSPS_CNTT          VARCHAR2(200),
    WLF_NTNT_CNTT          VARCHAR2(10),
    WLF_ADDR_CNTT          VARCHAR2(500),
    WLF_RGNO_CNTT          VARCHAR2(30),
    WLF_POB_CNTT           VARCHAR2(20),
    WLF_BRTH_NTNL_CNTT     VARCHAR2(100),
    WLF_BRTH_CITY_CNTT     VARCHAR2(100),
    WLF_SPLM_INFO_CNTT     VARCHAR2(500),
    FLXB_YN                CHAR(1)        DEFAULT 'N',
    SPLM_DATE              VARCHAR2(8),
    DEL_DATE               VARCHAR2(8),
    MNPL_YMDH              TIMESTAMP,
    WLF_FIRST_NAME_CNTT    VARCHAR2(100),
    WLF_MIDDLE_NAME_CNTT   VARCHAR2(100),
    WLF_LAST_NAME_CNTT     VARCHAR2(100)
);
/

-- ============================================================
-- WL_SCREEN_RSLT: Watchlist Screening Result
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE WL_SCREEN_RSLT CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE WL_SCREEN_RSLT (
    SCREEN_ID    NUMBER(19,0)   GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    RNMCNO       VARCHAR2(20),
    WLF_UNIQ_NO  NUMBER(19,0),
    MATCH_SCR    NUMBER(5,2),
    MATCH_ST_CCD VARCHAR2(20)   DEFAULT 'PENDING',
    SCREEN_DT    TIMESTAMP      DEFAULT SYSTIMESTAMP,
    REVIEW_ID    VARCHAR2(20),
    REVIEW_DT    TIMESTAMP,
    REMARK       VARCHAR2(1000),
    REG_ID       VARCHAR2(20),
    REG_DT       TIMESTAMP      DEFAULT SYSTIMESTAMP,
    UPD_ID       VARCHAR2(20),
    UPD_DT       TIMESTAMP
);
/

-- ============================================================
-- NIC66B: STR/CTR Case Main
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC66B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC66B (
    SSPS_DL_CRT_DT  VARCHAR2(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR2(30)  NOT NULL,
    SSPS_TYP_CD     VARCHAR2(20),
    SSPS_DL_CRT_CCD VARCHAR2(5),
    RPR_PRGRS_CCD   VARCHAR2(5),
    DL_P_RNMCNO     VARCHAR2(20),
    RSK_MRK         NUMBER(5,2),
    RSK_GRD_CD      VARCHAR2(5),
    OK_CCD          CHAR(1)       DEFAULT '0',
    INST_ID         VARCHAR2(50),
    SCNR_MRK        NUMBER(5,2),
    AI_RESULT       VARCHAR2(100),
    FIU_RPT_NO      VARCHAR2(50),
    FIU_RPT_DT      VARCHAR2(8),
    REG_ID          VARCHAR2(20),
    REG_DT          TIMESTAMP     DEFAULT SYSTIMESTAMP,
    UPD_ID          VARCHAR2(20),
    UPD_DT          TIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID)
);
/

-- ============================================================
-- NIC67B: STR Report Content
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC67B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC67B (
    SSPS_DL_CRT_DT  VARCHAR2(8)    NOT NULL,
    SSPS_DL_ID      VARCHAR2(30)   NOT NULL,
    RPR_RSN_CNTNT   VARCHAR2(4000),
    ITEM_CNTNT1     VARCHAR2(2000),
    ITEM_CNTNT2     VARCHAR2(2000),
    ITEM_CNTNT3     VARCHAR2(2000),
    ITEM_CNTNT4     VARCHAR2(2000),
    ITEM_CNTNT5     VARCHAR2(2000),
    ITEM_CNTNT6     VARCHAR2(2000),
    DOBT_DL_GRD_CD  VARCHAR2(5),
    REG_ID          VARCHAR2(20),
    REG_DT          TIMESTAMP      DEFAULT SYSTIMESTAMP,
    UPD_ID          VARCHAR2(20),
    UPD_DT          TIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID)
);
/

-- ============================================================
-- NIC68B: Case Documents
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC68B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC68B (
    SSPS_DL_CRT_DT  VARCHAR2(8)    NOT NULL,
    SSPS_DL_ID      VARCHAR2(30)   NOT NULL,
    SEQ_NO          NUMBER(10,0)   NOT NULL,
    DOC_NM          VARCHAR2(200),
    DOC_TP_CCD      VARCHAR2(10),
    FILE_PATH       VARCHAR2(500),
    REG_ID          VARCHAR2(20),
    REG_DT          TIMESTAMP      DEFAULT SYSTIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);
/

-- ============================================================
-- NIC70B: Transaction Party Basic
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC70B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC70B (
    SSPS_DL_CRT_DT  VARCHAR2(8)    NOT NULL,
    DL_P_RNMCNO     VARCHAR2(20)   NOT NULL,
    DL_P_NM         VARCHAR2(100),
    DL_P_RNM_NO_CCD CHAR(1),
    INDV_CORP_CCD   CHAR(1),
    PRIMARY KEY (SSPS_DL_CRT_DT, DL_P_RNMCNO)
);
/

-- ============================================================
-- NIC73B: Transaction List
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC73B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC73B (
    SSPS_DL_CRT_DT  VARCHAR2(8)    NOT NULL,
    SSPS_DL_ID      VARCHAR2(30)   NOT NULL,
    SEQ_NO          NUMBER(10,0)   NOT NULL,
    MN_DL_BRN_CD    VARCHAR2(10),
    MN_DL_BRN_NM    VARCHAR2(100),
    DL_DT           VARCHAR2(8),
    DL_TM           VARCHAR2(6),
    DL_AMT          NUMBER(20,2),
    DL_TYP_CCD      VARCHAR2(10),
    DL_CCY          VARCHAR2(5)    DEFAULT 'KRW',
    CNTRP_AC_NO     VARCHAR2(30),
    CNTRP_NM        VARCHAR2(100),
    CNTRP_BNK_CD    VARCHAR2(20),
    CHNL_CCD        VARCHAR2(20),
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);
/

-- ============================================================
-- NIC75B: Account Transaction Amount
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC75B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC75B (
    SSPS_DL_CRT_DT  VARCHAR2(8)    NOT NULL,
    SSPS_DL_ID      VARCHAR2(30)   NOT NULL,
    GNL_AC_NO       VARCHAR2(30)   NOT NULL,
    DL_AMT          NUMBER(20,2),
    DL_CCY          VARCHAR2(5)    DEFAULT 'KRW',
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, GNL_AC_NO)
);
/

-- ============================================================
-- NIC78B: Transaction Party Detail
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC78B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC78B (
    SSPS_DL_CRT_DT   VARCHAR2(8)    NOT NULL,
    DL_P_RNMCNO      VARCHAR2(20)   NOT NULL,
    DL_P_BRTDY       VARCHAR2(8),
    DL_P_SEX_CD      CHAR(1),
    OCPTN_CCD        VARCHAR2(10),
    DL_P_HSE_ADDR    VARCHAR2(200),
    DL_P_MBL_TEL_NO  VARCHAR2(20),
    WP_NM            VARCHAR2(100),
    RNM_CMBNTN_NO    VARCHAR2(20),
    PRIMARY KEY (SSPS_DL_CRT_DT, DL_P_RNMCNO)
);
/

-- ============================================================
-- NIC64B: File Attachment
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC64B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC64B (
    SSPS_DL_CRT_DT  VARCHAR2(8)    NOT NULL,
    SSPS_DL_ID      VARCHAR2(30)   NOT NULL,
    SEQ_NO          NUMBER(10,0)   NOT NULL,
    FILE_NM         VARCHAR2(200),
    FILE_PATH       VARCHAR2(500),
    FILE_SZ         NUMBER(19,0),
    REG_ID          VARCHAR2(20),
    REG_DT          TIMESTAMP      DEFAULT SYSTIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);
/

-- ============================================================
-- NIC80B_LOG: Process Log
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC80B_LOG CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC80B_LOG (
    SSPS_DL_CRT_DT  VARCHAR2(8)    NOT NULL,
    SSPS_DL_ID      VARCHAR2(30)   NOT NULL,
    SEQ_NO          NUMBER(10,0)   NOT NULL,
    PROC_FALG       CHAR(1)        DEFAULT '0',
    PROC_MSG        VARCHAR2(1000),
    PROC_DT         TIMESTAMP      DEFAULT SYSTIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);
/

-- ============================================================
-- NIC86B: Reporting Institution
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC86B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC86B (
    SEQ_NO              NUMBER(10,0)   NOT NULL PRIMARY KEY,
    RPR_OGN_NM          VARCHAR2(100),
    RPR_RSPSB_P_NM      VARCHAR2(50),
    RPR_CHRG_P_NM       VARCHAR2(50),
    RPR_CHRG_P_TEL_NO   VARCHAR2(20),
    USE_CCD             CHAR(1)        DEFAULT 'Y'
);
/

-- ============================================================
-- NIC89B: Consultation History
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC89B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC89B (
    SSPS_DL_CRT_DT  VARCHAR2(8)    NOT NULL,
    SSPS_DL_ID      VARCHAR2(30)   NOT NULL,
    SEQ_NO          NUMBER(10,0)   NOT NULL,
    MN_DL_BRN_CD    VARCHAR2(10),
    CNSLT_CNTNT     VARCHAR2(4000),
    REG_ID          VARCHAR2(20),
    REG_DT          TIMESTAMP      DEFAULT SYSTIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);
/

-- ============================================================
-- NIC58B: Rule Approval Status
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC58B CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC58B (
    RULE_ID          VARCHAR2(50)   NOT NULL,
    INST_ID          VARCHAR2(50)   NOT NULL,
    SN_PRGRS_CCD     VARCHAR2(10),
    RULE_UPD_MAJ_VER NUMBER(10,0),
    RULE_UPD_MIN_VER NUMBER(10,0),
    RULE_LST_MAJ_VER NUMBER(10,0),
    RULE_LST_MIN_VER NUMBER(10,0),
    SN_REQ_DY_TM     VARCHAR2(14),
    SN_REQ_CMNT      VARCHAR2(1000),
    SN_REQ_P_ENO     VARCHAR2(20),
    PRIMARY KEY (RULE_ID, INST_ID)
);
/

-- ============================================================
-- NIC93B_LOG: Batch Job Log
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE NIC93B_LOG CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE NIC93B_LOG (
    JOB_DT     VARCHAR2(14)   NOT NULL,
    JOB_ID     VARCHAR2(10)   NOT NULL,
    JOB_ST_CD  CHAR(1)        DEFAULT '0',
    JOB_MSG    VARCHAR2(1000),
    JOB_CNT    NUMBER(10,0)   DEFAULT 0,
    REG_DT     TIMESTAMP      DEFAULT SYSTIMESTAMP,
    PRIMARY KEY (JOB_DT, JOB_ID)
);
/

-- ============================================================
-- KYC_CUST: KYC Customer Verification
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE KYC_CUST CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE KYC_CUST (
    KYC_ID         NUMBER(19,0)   GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    RNMCNO         VARCHAR2(20)   NOT NULL,
    KYC_TP_CCD     VARCHAR2(20),
    KYC_STS_CCD    VARCHAR2(20)   DEFAULT 'IN_PROGRESS',
    ID_TP_CCD      VARCHAR2(20),
    ID_NO          VARCHAR2(50),
    ID_EXPIRE_DT   VARCHAR2(8),
    PURPOSE_CCD    VARCHAR2(20),
    FUND_SRC_CCD   VARCHAR2(20),
    PEP_F          CHAR(1)        DEFAULT 'N',
    BENEFICIAL_F   CHAR(1)        DEFAULT 'N',
    KYC_DT         VARCHAR2(8),
    NEXT_KYC_DT    VARCHAR2(8),
    REMARK         VARCHAR2(1000),
    REG_ID         VARCHAR2(20),
    REG_DT         TIMESTAMP      DEFAULT SYSTIMESTAMP,
    UPD_ID         VARCHAR2(20),
    UPD_DT         TIMESTAMP
);
/

-- ============================================================
-- TMS_APPL: Scenario Application List
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE TMS_APPL CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE TMS_APPL (
    SCNR_ID    VARCHAR2(20)   PRIMARY KEY,
    SCNR_NM    VARCHAR2(100)  NOT NULL,
    SCNR_CCD   VARCHAR2(5),
    BZDM_CD    VARCHAR2(20),
    LST_APP_NO VARCHAR2(20),
    USE_CCD    CHAR(1)        DEFAULT 'Y',
    REG_ID     VARCHAR2(20),
    REG_DT     TIMESTAMP      DEFAULT SYSTIMESTAMP,
    UPD_ID     VARCHAR2(20),
    UPD_DT     TIMESTAMP
);
/

-- ============================================================
-- TMS_REQ: Scenario Request/Standard
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE TMS_REQ CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE TMS_REQ (
    SCNR_ID    VARCHAR2(20)   PRIMARY KEY,
    SCNR_NM    VARCHAR2(100)  NOT NULL,
    SCNR_CCD   VARCHAR2(5),
    PERIOD_DAY NUMBER(10,0)   DEFAULT 1,
    USE_CCD    CHAR(1)        DEFAULT 'Y',
    REG_ID     VARCHAR2(20),
    REG_DT     TIMESTAMP      DEFAULT SYSTIMESTAMP
);
/

-- ============================================================
-- TMS_SET_VAL: Scenario Threshold Settings
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE TMS_SET_VAL CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE TMS_SET_VAL (
    SCNR_ID    VARCHAR2(20)   NOT NULL,
    CS_CCD     VARCHAR2(10)   NOT NULL,
    SET_VAL_CD VARCHAR2(50)   NOT NULL,
    SET_VAL    VARCHAR2(200),
    REG_ID     VARCHAR2(20),
    REG_DTTM   VARCHAR2(14),
    UPD_ID     VARCHAR2(20),
    UPD_DTTM   VARCHAR2(14),
    PRIMARY KEY (SCNR_ID, CS_CCD, SET_VAL_CD)
);
/

-- ============================================================
-- TMS_SET_VAL_APP: Setting Value Approval Request
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE TMS_SET_VAL_APP CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE TMS_SET_VAL_APP (
    APP_NO      VARCHAR2(20)   PRIMARY KEY,
    SCNR_ID     VARCHAR2(20),
    APP_STS_CCD VARCHAR2(5)    DEFAULT 'N',
    REQ_DT      VARCHAR2(8),
    REQ_ID      VARCHAR2(20),
    REG_DT      TIMESTAMP      DEFAULT SYSTIMESTAMP
);
/

-- ============================================================
-- TMS_SET_VAL_APP_DTL: Approval Request Detail
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE TMS_SET_VAL_APP_DTL CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE TMS_SET_VAL_APP_DTL (
    APP_NO      VARCHAR2(20)   NOT NULL,
    CS_CCD      VARCHAR2(10)   NOT NULL,
    SET_VAL_CD  VARCHAR2(50)   NOT NULL,
    SET_VAL_NM  VARCHAR2(100),
    SET_VAL     VARCHAR2(200),
    PREV_VAL    VARCHAR2(200),
    PRIMARY KEY (APP_NO, CS_CCD, SET_VAL_CD)
);
/

-- ============================================================
-- AML_APPR: Approval
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE AML_APPR CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE AML_APPR (
    APP_NO          VARCHAR2(20)   NOT NULL,
    GYLJ_LINE_G_C   VARCHAR2(10)   NOT NULL,
    NUM_SQ          NUMBER(10,0),
    APP_DT          VARCHAR2(8),
    SNO             NUMBER(10,0),
    SN_CCD          VARCHAR2(5),
    APPR_ROLE_ID    VARCHAR2(20),
    TARGET_ROLE_ID  VARCHAR2(20),
    RSN_CNTNT       VARCHAR2(4000),
    HNDL_DY_TM      TIMESTAMP,
    HNDL_P_ENO      VARCHAR2(20),
    WLR_SQ          NUMBER(10,0),
    REG_DT          TIMESTAMP      DEFAULT SYSTIMESTAMP,
    PRV_APP_NO      VARCHAR2(20),
    PRIMARY KEY (APP_NO, GYLJ_LINE_G_C)
);
/

-- ============================================================
-- AML_APPR_HIST: Approval History
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE AML_APPR_HIST CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE AML_APPR_HIST (
    APP_NO          VARCHAR2(20)   NOT NULL,
    GYLJ_LINE_G_C   VARCHAR2(10)   NOT NULL,
    NUM_SQ          NUMBER(10,0)   NOT NULL,
    APP_DT          VARCHAR2(8),
    SNO             NUMBER(10,0),
    SN_CCD          VARCHAR2(5),
    BRN_CD          VARCHAR2(10),
    APPR_ROLE_ID    VARCHAR2(20),
    TARGET_ROLE_ID  VARCHAR2(20),
    RSN_CNTNT       VARCHAR2(4000),
    HNDL_DY_TM      TIMESTAMP,
    HNDL_P_ENO      VARCHAR2(20),
    PRIMARY KEY (APP_NO, GYLJ_LINE_G_C, NUM_SQ)
);
/

-- ============================================================
-- RA_ITEM: Risk Assessment Item Master
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE RA_ITEM CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE RA_ITEM (
    RA_ITEM_CD    VARCHAR2(10)   PRIMARY KEY,
    LST_APP_NO    VARCHAR2(10),
    RA_ITEM_NM    VARCHAR2(100),
    RA_MDL_GBN_CD VARCHAR2(10)   NOT NULL,
    REFF_COMN_CD  VARCHAR2(4),
    MISS_VAL_SCR  NUMBER(9,2)    DEFAULT 0,
    INTV_VAL_YN   CHAR(1)        DEFAULT 'N',
    USE_YN        CHAR(1)        DEFAULT 'Y',
    SRT_SQ        NUMBER(10,0),
    REG_ID        VARCHAR2(20),
    REG_DT        TIMESTAMP      DEFAULT SYSTIMESTAMP,
    UPD_ID        VARCHAR2(20),
    UPD_DT        TIMESTAMP
);
/

-- ============================================================
-- RA_ITEM_WGHT: RA Item Weight Management
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE RA_ITEM_WGHT CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE RA_ITEM_WGHT (
    RA_ITEM_CD    VARCHAR2(10)   NOT NULL,
    RA_MDL_GBN_CD VARCHAR2(10)   NOT NULL,
    WGHT          NUMBER(5,2)    DEFAULT 0,
    MAX_SCR       NUMBER(9,2)    DEFAULT 0,
    LST_APP_NO    VARCHAR2(10),
    APP_DT        VARCHAR2(8),
    SN_CCD        CHAR(1)        DEFAULT 'N',
    USE_YN        CHAR(1)        DEFAULT 'Y',
    REG_DT        TIMESTAMP      DEFAULT SYSTIMESTAMP,
    PRIMARY KEY (RA_ITEM_CD, RA_MDL_GBN_CD)
);
/

-- ============================================================
-- RA_GRD_STD: RA Grade Standard
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE RA_GRD_STD CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE RA_GRD_STD (
    RA_GRD      VARCHAR2(5)    PRIMARY KEY,
    GRD_SCR_MIN NUMBER(10,2),
    GRD_SCR_MAX NUMBER(10,2),
    GRD_NM      VARCHAR2(50)
);
/

-- ============================================================
-- RA_RESULT: Customer Risk Assessment Result
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE RA_RESULT CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE RA_RESULT (
    RA_ID        NUMBER(19,0)   GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    RNMCNO       VARCHAR2(20)   NOT NULL,
    EVAL_DT      VARCHAR2(8),
    RA_GRD       VARCHAR2(5),
    RA_SCR       NUMBER(10,2),
    EDD_F        CHAR(1)        DEFAULT 'N',
    NEXT_EVAL_DT VARCHAR2(8),
    REMARK       VARCHAR2(1000),
    REG_ID       VARCHAR2(20),
    REG_DT       TIMESTAMP      DEFAULT SYSTIMESTAMP,
    UPD_ID       VARCHAR2(20),
    UPD_DT       TIMESTAMP
);
/

-- ============================================================
-- RA_RESULT_DTL: RA Result Detail
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE RA_RESULT_DTL CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE RA_RESULT_DTL (
    RA_DTL_ID    NUMBER(19,0)   GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    RA_ID        NUMBER(19,0)   NOT NULL,
    RA_ITEM_CD   VARCHAR2(10),
    ITEM_VAL     VARCHAR2(100),
    ITEM_SCR     NUMBER(10,2),
    ITEM_WGHT    NUMBER(5,2),
    ITEM_LST_SCR NUMBER(10,2),
    REG_DT       TIMESTAMP      DEFAULT SYSTIMESTAMP
);
/

-- ============================================================
-- RA_RISK_FACTOR: ML/TF Risk Factor Master
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE RA_RISK_FACTOR CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE RA_RISK_FACTOR (
    RISK_CATG1_C      VARCHAR2(10)   NOT NULL,
    RISK_CATG2_C      VARCHAR2(10)   NOT NULL,
    RISK_ELMT_C       VARCHAR2(10)   NOT NULL,
    RISK_ELMT_NM      VARCHAR2(400)  NOT NULL,
    RISK_INDI         CHAR(1),
    RISK_CORP         CHAR(1),
    RISK_VAL_ITEM     VARCHAR2(100),
    RISK_VAL_CAL_STD  VARCHAR2(100),
    RISK_APPL_YN      CHAR(1)        DEFAULT 'Y',
    RISK_APPL_MODEL_I CHAR(1)        DEFAULT 'N',
    RISK_APPL_MODEL_B CHAR(1)        DEFAULT 'N',
    RISK_HRSK_YN      CHAR(1)        DEFAULT 'N',
    RISK_SCR          NUMBER(6,4),
    RISK_RSN_DESC     VARCHAR2(4000),
    RISK_RMRK         VARCHAR2(4000),
    RISK_REG_DT       TIMESTAMP      DEFAULT SYSTIMESTAMP,
    RISK_REG_ID       VARCHAR2(20),
    RISK_UPD_DT       TIMESTAMP,
    RISK_UPD_ID       VARCHAR2(20),
    PRIMARY KEY (RISK_CATG1_C, RISK_CATG2_C, RISK_ELMT_C)
);
/

-- ============================================================
-- RA_ITEM_NTN: Country Risk Score Master
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE RA_ITEM_NTN CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE RA_ITEM_NTN (
    RA_ITEM_CD         VARCHAR2(10)   NOT NULL,
    RA_ITEM_CODE       VARCHAR2(100)  NOT NULL,
    RA_ITEM_NTN_CD     VARCHAR2(100),
    RA_ITEM_NM         VARCHAR2(200),
    ABS_HRSK_YN        CHAR(1)        DEFAULT 'N',
    RA_ITEM_SCR        NUMBER(4,2),
    FATF_BLACK_LIST_YN CHAR(1)        DEFAULT 'N',
    FATF_GREY_LIST_YN  CHAR(1)        DEFAULT 'N',
    FINCEN_LIST_YN     CHAR(1)        DEFAULT 'N',
    UN_SANTIONS_YN     CHAR(1)        DEFAULT 'N',
    OFAC_SANTIONS_YN   CHAR(1)        DEFAULT 'N',
    OECD_YN            CHAR(1)        DEFAULT 'N',
    EU_SANTIONS_YN     CHAR(1)        DEFAULT 'N',
    EU_HRT_YN          CHAR(1)        DEFAULT 'N',
    TICPI_CPI_IDX      NUMBER(4,2),
    BASEL_RIK_IDX      NUMBER(4,2),
    HNDL_DY_TM         TIMESTAMP      DEFAULT SYSTIMESTAMP,
    PRIMARY KEY (RA_ITEM_CD, RA_ITEM_CODE)
);
/

-- ============================================================
-- SRBA_SCHD: RBA Evaluation Schedule
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE SRBA_SCHD CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE SRBA_SCHD (
    BAS_YYMM        VARCHAR2(6)    PRIMARY KEY,
    VALT_TRN        VARCHAR2(2),
    ING_STEP        VARCHAR2(5)    DEFAULT '00',
    TGT_TRN_SDT     VARCHAR2(8),
    TGT_TRN_EDT     VARCHAR2(8),
    APPR_DT         VARCHAR2(8),
    SCHD_CMPLT_DT   VARCHAR2(8),
    USE_YN          CHAR(1)        DEFAULT 'Y',
    REG_ID          VARCHAR2(20),
    REG_DT          TIMESTAMP      DEFAULT SYSTIMESTAMP
);
/

-- ============================================================
-- TMS_STATS_DAILY: Daily Statistics Snapshot
-- ============================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE TMS_STATS_DAILY CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE TMS_STATS_DAILY (
    STATS_DT         VARCHAR2(8)    NOT NULL,
    TOTAL_ALERTS     NUMBER(10,0)   DEFAULT 0,
    NEW_ALERTS       NUMBER(10,0)   DEFAULT 0,
    REVIEW_ALERTS    NUMBER(10,0)   DEFAULT 0,
    CLOSED_ALERTS    NUMBER(10,0)   DEFAULT 0,
    STR_COUNT        NUMBER(10,0)   DEFAULT 0,
    CTR_COUNT        NUMBER(10,0)   DEFAULT 0,
    HIGH_RISK_COUNT  NUMBER(10,0)   DEFAULT 0,
    TOTAL_DETECT_AMT NUMBER(20,2),
    PRIMARY KEY (STATS_DT)
);
/
