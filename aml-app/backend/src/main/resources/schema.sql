-- AMLXpress7 Database Schema (H2 compatible, original Oracle naming)
-- Table names and column names match production AMLXpress7 Oracle DB

-- ============================================================
-- NIC92B: Common Code
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC92B (
    CD       VARCHAR(20)  NOT NULL,
    CNTNT    VARCHAR(50)  NOT NULL,
    CD_NM    VARCHAR(100),
    ORD_NO   INT          DEFAULT 0,
    USE_CCD  CHAR(1)      DEFAULT 'Y',
    PRIMARY KEY (CD, CNTNT)
);

-- ============================================================
-- C_USER: User
-- ============================================================
CREATE TABLE IF NOT EXISTS C_USER (
    USER_ID   VARCHAR(20)  PRIMARY KEY,
    USER_NM   VARCHAR(50)  NOT NULL,
    DEPT_CD   VARCHAR(20),
    EMAIL     VARCHAR(100),
    PWD       VARCHAR(256),
    ROLE_ID   VARCHAR(20)  DEFAULT 'ANALYST',
    USE_CCD   CHAR(1)      DEFAULT 'Y',
    REG_DT    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- NIC41B: Department/Branch
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC41B (
    DPRT_CD         VARCHAR(10)  PRIMARY KEY,
    DPRT_NM         VARCHAR(100),
    HG_RNK_DPRT_CD  VARCHAR(10),
    USE_CCD         CHAR(1)      DEFAULT 'Y'
);

-- ============================================================
-- NIC01B: Customer Master
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC01B (
    RNMCNO        VARCHAR(20)   PRIMARY KEY,
    INDV_CORP_CCD CHAR(1),
    CS_TYP_CD     VARCHAR(10),
    CS_NM         VARCHAR(100),
    LG_AMT_ASTS_F CHAR(1)       DEFAULT 'N',
    BRTH_DT       VARCHAR(8),
    NAT_CD        VARCHAR(5)    DEFAULT 'KR',
    ADDR          VARCHAR(200),
    TEL_NO        VARCHAR(20),
    EMAIL         VARCHAR(100),
    ACNT_OPNG_DT  VARCHAR(8),
    KYC_STS_CCD   VARCHAR(10)   DEFAULT 'PEND',
    EDD_F         CHAR(1)       DEFAULT 'N',
    RSK_GRD_CD    VARCHAR(5),
    RSK_SCR       DECIMAL(10,2),
    USE_CCD       CHAR(1)       DEFAULT 'Y',
    REG_ID        VARCHAR(20),
    REG_DT        TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    UPD_ID        VARCHAR(20),
    UPD_DT        TIMESTAMP
);

-- ============================================================
-- NIC17B: Account
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC17B (
    GNL_AC_NO   VARCHAR(30)  PRIMARY KEY,
    RNMCNO      VARCHAR(20),
    AC_TYP_CCD  VARCHAR(10),
    OPNG_DT     VARCHAR(8),
    USE_CCD     CHAR(1)      DEFAULT 'Y',
    REG_DT      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- NIC35B: Customer Risk
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC35B (
    RNMCNO          VARCHAR(20)  PRIMARY KEY,
    RSK_GRD_CD      VARCHAR(5),
    LST_RSK_EAL_SOR VARCHAR(8)
);

-- ============================================================
-- NIC19B_FACTIVA_UA: Watchlist
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC19B_FACTIVA_UA (
    WLF_UNIQ_NO          BIGINT       AUTO_INCREMENT PRIMARY KEY,
    WLF_FLNM_CNTT        VARCHAR(200),
    WLF_FIRST_NAME_CNTT  VARCHAR(100),
    WLF_MIDDLE_NAME_CNTT VARCHAR(100),
    WLF_LAST_NAME_CNTT   VARCHAR(100),
    WLF_NTNT_CNTT        VARCHAR(5),
    SPLM_DATE            VARCHAR(8),
    SANCTION_TP          VARCHAR(50),
    LIST_DT              VARCHAR(8),
    USE_CCD              CHAR(1)      DEFAULT 'Y',
    REG_DT               TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- WL_SCREEN_RSLT: Watchlist Screening Result
-- ============================================================
CREATE TABLE IF NOT EXISTS WL_SCREEN_RSLT (
    SCREEN_ID    BIGINT       AUTO_INCREMENT PRIMARY KEY,
    RNMCNO       VARCHAR(20),
    WLF_UNIQ_NO  BIGINT,
    MATCH_SCR    DECIMAL(5,2),
    MATCH_ST_CCD VARCHAR(20)  DEFAULT 'PENDING',
    SCREEN_DT    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    REVIEW_ID    VARCHAR(20),
    REVIEW_DT    TIMESTAMP,
    REMARK       VARCHAR(1000),
    REG_ID       VARCHAR(20),
    REG_DT       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    UPD_ID       VARCHAR(20),
    UPD_DT       TIMESTAMP
);

-- ============================================================
-- NIC66B: STR/CTR Case Main
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC66B (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR(30)  NOT NULL,
    SSPS_TYP_CD     VARCHAR(20),
    SSPS_DL_CRT_CCD VARCHAR(5),
    RPR_PRGRS_CCD   VARCHAR(5),
    DL_P_RNMCNO     VARCHAR(20),
    RSK_MRK         DECIMAL(5,2),
    RSK_GRD_CD      VARCHAR(5),
    OK_CCD          CHAR(1)      DEFAULT '0',
    INST_ID         VARCHAR(50),
    SCNR_MRK        DECIMAL(5,2),
    AI_RESULT       VARCHAR(100),
    FIU_RPT_NO      VARCHAR(50),
    FIU_RPT_DT      VARCHAR(8),
    REG_ID          VARCHAR(20),
    REG_DT          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    UPD_ID          VARCHAR(20),
    UPD_DT          TIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID)
);

-- ============================================================
-- NIC67B: STR Report Content
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC67B (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR(30)  NOT NULL,
    RPR_RSN_CNTNT   VARCHAR(4000),
    ITEM_CNTNT1     VARCHAR(2000),
    ITEM_CNTNT2     VARCHAR(2000),
    ITEM_CNTNT3     VARCHAR(2000),
    ITEM_CNTNT4     VARCHAR(2000),
    ITEM_CNTNT5     VARCHAR(2000),
    ITEM_CNTNT6     VARCHAR(2000),
    DOBT_DL_GRD_CD  VARCHAR(5),
    REG_ID          VARCHAR(20),
    REG_DT          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    UPD_ID          VARCHAR(20),
    UPD_DT          TIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID)
);

-- ============================================================
-- NIC68B: Case Documents
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC68B (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR(30)  NOT NULL,
    SEQ_NO          INT          NOT NULL,
    DOC_NM          VARCHAR(200),
    DOC_TP_CCD      VARCHAR(10),
    FILE_PATH       VARCHAR(500),
    REG_ID          VARCHAR(20),
    REG_DT          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);

-- ============================================================
-- NIC70B: Transaction Party Basic
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC70B (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    DL_P_RNMCNO     VARCHAR(20)  NOT NULL,
    DL_P_NM         VARCHAR(100),
    DL_P_RNM_NO_CCD CHAR(1),
    INDV_CORP_CCD   CHAR(1),
    PRIMARY KEY (SSPS_DL_CRT_DT, DL_P_RNMCNO)
);

-- ============================================================
-- NIC73B: Transaction List
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC73B (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR(30)  NOT NULL,
    SEQ_NO          INT          NOT NULL,
    MN_DL_BRN_CD    VARCHAR(10),
    MN_DL_BRN_NM    VARCHAR(100),
    DL_DT           VARCHAR(8),
    DL_TM           VARCHAR(6),
    DL_AMT          DECIMAL(20,2),
    DL_TYP_CCD      VARCHAR(10),
    DL_CCY          VARCHAR(5)   DEFAULT 'KRW',
    CNTRP_AC_NO     VARCHAR(30),
    CNTRP_NM        VARCHAR(100),
    CNTRP_BNK_CD    VARCHAR(20),
    CHNL_CCD        VARCHAR(20),
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);

-- ============================================================
-- NIC75B: Account Transaction Amount
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC75B (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR(30)  NOT NULL,
    GNL_AC_NO       VARCHAR(30)  NOT NULL,
    DL_AMT          DECIMAL(20,2),
    DL_CCY          VARCHAR(5)   DEFAULT 'KRW',
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, GNL_AC_NO)
);

-- ============================================================
-- NIC78B: Transaction Party Detail
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC78B (
    SSPS_DL_CRT_DT   VARCHAR(8)   NOT NULL,
    DL_P_RNMCNO      VARCHAR(20)  NOT NULL,
    DL_P_BRTDY       VARCHAR(8),
    DL_P_SEX_CD      CHAR(1),
    OCPTN_CCD        VARCHAR(10),
    DL_P_HSE_ADDR    VARCHAR(200),
    DL_P_MBL_TEL_NO  VARCHAR(20),
    WP_NM            VARCHAR(100),
    RNM_CMBNTN_NO    VARCHAR(20),
    PRIMARY KEY (SSPS_DL_CRT_DT, DL_P_RNMCNO)
);

-- ============================================================
-- NIC64B: File Attachment
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC64B (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR(30)  NOT NULL,
    SEQ_NO          INT          NOT NULL,
    FILE_NM         VARCHAR(200),
    FILE_PATH       VARCHAR(500),
    FILE_SZ         BIGINT,
    REG_ID          VARCHAR(20),
    REG_DT          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);

-- ============================================================
-- NIC80B_LOG: Process Log
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC80B_LOG (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR(30)  NOT NULL,
    SEQ_NO          INT          NOT NULL,
    PROC_FALG       CHAR(1)      DEFAULT '0',
    PROC_MSG        VARCHAR(1000),
    PROC_DT         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);

-- ============================================================
-- NIC86B: Reporting Institution
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC86B (
    SEQ_NO              INT         NOT NULL PRIMARY KEY,
    RPR_OGN_NM          VARCHAR(100),
    RPR_RSPSB_P_NM      VARCHAR(50),
    RPR_CHRG_P_NM       VARCHAR(50),
    RPR_CHRG_P_TEL_NO   VARCHAR(20),
    USE_CCD             CHAR(1)     DEFAULT 'Y'
);

-- ============================================================
-- NIC89B: Consultation History
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC89B (
    SSPS_DL_CRT_DT  VARCHAR(8)   NOT NULL,
    SSPS_DL_ID      VARCHAR(30)  NOT NULL,
    SEQ_NO          INT          NOT NULL,
    MN_DL_BRN_CD    VARCHAR(10),
    CNSLT_CNTNT     VARCHAR(4000),
    REG_ID          VARCHAR(20),
    REG_DT          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO)
);

-- ============================================================
-- NIC58B: Rule Approval Status
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC58B (
    RULE_ID          VARCHAR(50)  NOT NULL,
    INST_ID          VARCHAR(50)  NOT NULL,
    SN_PRGRS_CCD     VARCHAR(10),
    RULE_UPD_MAJ_VER INT,
    RULE_UPD_MIN_VER INT,
    RULE_LST_MAJ_VER INT,
    RULE_LST_MIN_VER INT,
    SN_REQ_DY_TM     VARCHAR(14),
    SN_REQ_CMNT      VARCHAR(1000),
    SN_REQ_P_ENO     VARCHAR(20),
    PRIMARY KEY (RULE_ID, INST_ID)
);

-- ============================================================
-- KYC_CUST: KYC Customer Verification
-- ============================================================
CREATE TABLE IF NOT EXISTS KYC_CUST (
    KYC_ID         BIGINT       AUTO_INCREMENT PRIMARY KEY,
    RNMCNO         VARCHAR(20)  NOT NULL,
    KYC_TP_CCD     VARCHAR(20),
    KYC_STS_CCD    VARCHAR(20)  DEFAULT 'IN_PROGRESS',
    ID_TP_CCD      VARCHAR(20),
    ID_NO          VARCHAR(50),
    ID_EXPIRE_DT   VARCHAR(8),
    PURPOSE_CCD    VARCHAR(20),
    FUND_SRC_CCD   VARCHAR(20),
    PEP_F          CHAR(1)      DEFAULT 'N',
    BENEFICIAL_F   CHAR(1)      DEFAULT 'N',
    KYC_DT         VARCHAR(8),
    NEXT_KYC_DT    VARCHAR(8),
    REMARK         VARCHAR(1000),
    REG_ID         VARCHAR(20),
    REG_DT         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    UPD_ID         VARCHAR(20),
    UPD_DT         TIMESTAMP
);

-- ============================================================
-- TMS_APPL: Scenario Application List
-- ============================================================
CREATE TABLE IF NOT EXISTS TMS_APPL (
    SCNR_ID    VARCHAR(20)  PRIMARY KEY,
    SCNR_NM    VARCHAR(100) NOT NULL,
    SCNR_CCD   VARCHAR(5),
    BZDM_CD    VARCHAR(20),
    LST_APP_NO VARCHAR(20),
    USE_CCD    CHAR(1)      DEFAULT 'Y',
    REG_ID     VARCHAR(20),
    REG_DT     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    UPD_ID     VARCHAR(20),
    UPD_DT     TIMESTAMP
);

-- ============================================================
-- TMS_REQ: Scenario Request/Standard
-- ============================================================
CREATE TABLE IF NOT EXISTS TMS_REQ (
    SCNR_ID    VARCHAR(20)  PRIMARY KEY,
    SCNR_NM    VARCHAR(100) NOT NULL,
    SCNR_CCD   VARCHAR(5),
    PERIOD_DAY INT          DEFAULT 1,
    USE_CCD    CHAR(1)      DEFAULT 'Y',
    REG_ID     VARCHAR(20),
    REG_DT     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TMS_SET_VAL: Scenario Threshold Settings
-- ============================================================
CREATE TABLE IF NOT EXISTS TMS_SET_VAL (
    SCNR_ID    VARCHAR(20)  NOT NULL,
    CS_CCD     VARCHAR(10)  NOT NULL,
    SET_VAL_CD VARCHAR(50)  NOT NULL,
    SET_VAL    VARCHAR(200),
    REG_ID     VARCHAR(20),
    REG_DTTM   VARCHAR(14),
    UPD_ID     VARCHAR(20),
    UPD_DTTM   VARCHAR(14),
    PRIMARY KEY (SCNR_ID, CS_CCD, SET_VAL_CD)
);

-- ============================================================
-- TMS_SET_VAL_APP: Setting Value Approval Request
-- ============================================================
CREATE TABLE IF NOT EXISTS TMS_SET_VAL_APP (
    APP_NO      VARCHAR(20)  PRIMARY KEY,
    SCNR_ID     VARCHAR(20),
    APP_STS_CCD VARCHAR(5)   DEFAULT 'N',
    REQ_DT      VARCHAR(8),
    REQ_ID      VARCHAR(20),
    REG_DT      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TMS_SET_VAL_APP_DTL: Approval Request Detail
-- ============================================================
CREATE TABLE IF NOT EXISTS TMS_SET_VAL_APP_DTL (
    APP_NO      VARCHAR(20)  NOT NULL,
    CS_CCD      VARCHAR(10)  NOT NULL,
    SET_VAL_CD  VARCHAR(50)  NOT NULL,
    SET_VAL_NM  VARCHAR(100),
    SET_VAL     VARCHAR(200),
    PREV_VAL    VARCHAR(200),
    PRIMARY KEY (APP_NO, CS_CCD, SET_VAL_CD)
);

-- ============================================================
-- AML_APPR: Approval
-- ============================================================
CREATE TABLE IF NOT EXISTS AML_APPR (
    APP_NO          VARCHAR(20)  NOT NULL,
    GYLJ_LINE_G_C   VARCHAR(10)  NOT NULL,
    NUM_SQ          INT,
    APP_DT          VARCHAR(8),
    SNO             INT,
    SN_CCD          VARCHAR(5),
    APPR_ROLE_ID    VARCHAR(20),
    TARGET_ROLE_ID  VARCHAR(20),
    RSN_CNTNT       VARCHAR(4000),
    HNDL_DY_TM      TIMESTAMP,
    HNDL_P_ENO      VARCHAR(20),
    WLR_SQ          INT,
    REG_DT          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRV_APP_NO      VARCHAR(20),
    PRIMARY KEY (APP_NO, GYLJ_LINE_G_C)
);

-- ============================================================
-- AML_APPR_HIST: Approval History
-- ============================================================
CREATE TABLE IF NOT EXISTS AML_APPR_HIST (
    APP_NO          VARCHAR(20)  NOT NULL,
    GYLJ_LINE_G_C   VARCHAR(10)  NOT NULL,
    NUM_SQ          INT          NOT NULL,
    APP_DT          VARCHAR(8),
    SNO             INT,
    SN_CCD          VARCHAR(5),
    BRN_CD          VARCHAR(10),
    APPR_ROLE_ID    VARCHAR(20),
    TARGET_ROLE_ID  VARCHAR(20),
    RSN_CNTNT       VARCHAR(4000),
    HNDL_DY_TM      TIMESTAMP,
    HNDL_P_ENO      VARCHAR(20),
    PRIMARY KEY (APP_NO, GYLJ_LINE_G_C, NUM_SQ)
);

-- ============================================================
-- RA_ITEM: Risk Assessment Item
-- ============================================================
CREATE TABLE IF NOT EXISTS RA_ITEM (
    RA_ITEM_CD VARCHAR(20)  PRIMARY KEY,
    RA_ITEM_NM VARCHAR(100) NOT NULL,
    RA_ITEM_TP VARCHAR(20),
    MAX_SCR    DECIMAL(10,2),
    WGHT       DECIMAL(5,2),
    USE_CCD    CHAR(1)      DEFAULT 'Y',
    ORD_NO     INT,
    REG_DT     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- RA_GRD_STD: RA Grade Standard
-- ============================================================
CREATE TABLE IF NOT EXISTS RA_GRD_STD (
    RA_GRD      VARCHAR(5)   PRIMARY KEY,
    GRD_SCR_MIN DECIMAL(10,2),
    GRD_SCR_MAX DECIMAL(10,2),
    GRD_NM      VARCHAR(50)
);

-- ============================================================
-- RA_RESULT: Customer Risk Assessment Result
-- ============================================================
CREATE TABLE IF NOT EXISTS RA_RESULT (
    RA_ID        BIGINT       AUTO_INCREMENT PRIMARY KEY,
    RNMCNO       VARCHAR(20)  NOT NULL,
    EVAL_DT      VARCHAR(8),
    RA_GRD       VARCHAR(5),
    RA_SCR       DECIMAL(10,2),
    EDD_F        CHAR(1)      DEFAULT 'N',
    NEXT_EVAL_DT VARCHAR(8),
    REMARK       VARCHAR(1000),
    REG_ID       VARCHAR(20),
    REG_DT       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    UPD_ID       VARCHAR(20),
    UPD_DT       TIMESTAMP
);

-- ============================================================
-- RA_RESULT_DTL: RA Result Detail
-- ============================================================
CREATE TABLE IF NOT EXISTS RA_RESULT_DTL (
    RA_DTL_ID    BIGINT       AUTO_INCREMENT PRIMARY KEY,
    RA_ID        BIGINT       NOT NULL,
    RA_ITEM_CD   VARCHAR(20),
    ITEM_VAL     VARCHAR(100),
    ITEM_SCR     DECIMAL(10,2),
    ITEM_WGHT    DECIMAL(5,2),
    ITEM_LST_SCR DECIMAL(10,2),
    REG_DT       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TMS_STATS_DAILY: Daily Statistics Snapshot (app-internal)
-- ============================================================
CREATE TABLE IF NOT EXISTS TMS_STATS_DAILY (
    STATS_DT         VARCHAR(8) NOT NULL,
    TOTAL_ALERTS     INT DEFAULT 0,
    NEW_ALERTS       INT DEFAULT 0,
    REVIEW_ALERTS    INT DEFAULT 0,
    CLOSED_ALERTS    INT DEFAULT 0,
    STR_COUNT        INT DEFAULT 0,
    CTR_COUNT        INT DEFAULT 0,
    HIGH_RISK_COUNT  INT DEFAULT 0,
    TOTAL_DETECT_AMT DECIMAL(20,2),
    PRIMARY KEY (STATS_DT)
);
