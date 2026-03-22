-- AMLXpress7 Database Schema (H2 compatible, production Oracle naming)
-- Reverse-engineered from DDL.txt, XML mappers, and Java source analysis

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
-- NIC19B_FACTIVA_UA: Watchlist (20 columns from WLFLoaderTest.java)
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC19B_FACTIVA_UA (
    WLF_UNIQ_NO            BIGINT        AUTO_INCREMENT PRIMARY KEY,
    WLF_ISTU_CLS_CNTT      VARCHAR(50),   -- category: SIE/UN/RCA/SIP/KFSC/W180/UN-FINCEN/EURO/FATF/KFIU/PEPs/ETC/OFAC
    WLF_FLNM_CNTT          VARCHAR(200),  -- full name
    WLF_RLNM_CNTT          VARCHAR(200),  -- real name
    WLF_FCNM_CNTT          VARCHAR(200),  -- foreign name
    WLF_RSPS_CNTT          VARCHAR(200),  -- response content (e.g. "See previous Roles", "Deceased")
    WLF_NTNT_CNTT          VARCHAR(10),   -- nationality code
    WLF_ADDR_CNTT          VARCHAR(500),  -- address
    WLF_RGNO_CNTT          VARCHAR(30),   -- registration number
    WLF_POB_CNTT           VARCHAR(20),   -- date of birth (yyyyMMdd)
    WLF_BRTH_NTNL_CNTT     VARCHAR(100),  -- birth nationality
    WLF_BRTH_CITY_CNTT     VARCHAR(100),  -- birth city
    WLF_SPLM_INFO_CNTT     VARCHAR(500),  -- supplementary information
    FLXB_YN                CHAR(1)        DEFAULT 'N',  -- flexible flag
    SPLM_DATE              VARCHAR(8),    -- supplement date (yyyyMMdd)
    DEL_DATE               VARCHAR(8),    -- deletion date (yyyyMMdd)
    MNPL_YMDH              TIMESTAMP,     -- manipulation datetime
    WLF_FIRST_NAME_CNTT    VARCHAR(100),  -- first name
    WLF_MIDDLE_NAME_CNTT   VARCHAR(100),  -- middle name
    WLF_LAST_NAME_CNTT     VARCHAR(100)   -- last name
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
-- NIC93B_LOG: Batch Job Log (referenced in AML_00.xml)
-- ============================================================
CREATE TABLE IF NOT EXISTS NIC93B_LOG (
    JOB_DT     VARCHAR(14) NOT NULL,  -- yyyyMMddHHmmss
    JOB_ID     VARCHAR(10) NOT NULL,  -- e.g. B70001, B70002
    JOB_ST_CD  CHAR(1)     DEFAULT '0',  -- 0=start, 1=complete, 9=error
    JOB_MSG    VARCHAR(1000),
    JOB_CNT    INT         DEFAULT 0,
    REG_DT     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (JOB_DT, JOB_ID)
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
-- RA_ITEM: Risk Assessment Item Master
-- Based on actual SSQ.RA_ITEM DDL.txt columns
-- ============================================================
CREATE TABLE IF NOT EXISTS RA_ITEM (
    RA_ITEM_CD    VARCHAR(10)   PRIMARY KEY,
    LST_APP_NO    VARCHAR(10),
    RA_ITEM_NM    VARCHAR(100),
    RA_MDL_GBN_CD VARCHAR(10)   NOT NULL,  -- Risk model type code (A040: INDI/CORP/FORE/ETC)
    REFF_COMN_CD  VARCHAR(4),              -- Reference common code
    MISS_VAL_SCR  DECIMAL(9,2)  DEFAULT 0, -- Missing value score
    INTV_VAL_YN   CHAR(1)       DEFAULT 'N', -- Interval value flag
    USE_YN        CHAR(1)       DEFAULT 'Y',
    SRT_SQ        INT,
    REG_ID        VARCHAR(20),
    REG_DT        TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    UPD_ID        VARCHAR(20),
    UPD_DT        TIMESTAMP
);

-- ============================================================
-- RA_ITEM_WGHT: RA Item Weight Management (separate from RA_ITEM)
-- ============================================================
CREATE TABLE IF NOT EXISTS RA_ITEM_WGHT (
    RA_ITEM_CD    VARCHAR(10)  NOT NULL,
    RA_MDL_GBN_CD VARCHAR(10)  NOT NULL,  -- INDI=individual, CORP=corporate
    WGHT          DECIMAL(5,2) DEFAULT 0,
    MAX_SCR       DECIMAL(9,2) DEFAULT 0,
    LST_APP_NO    VARCHAR(10),
    APP_DT        VARCHAR(8),
    SN_CCD        CHAR(1)      DEFAULT 'N',  -- approval status
    USE_YN        CHAR(1)      DEFAULT 'Y',
    REG_DT        TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (RA_ITEM_CD, RA_MDL_GBN_CD)
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
    RA_ITEM_CD   VARCHAR(10),
    ITEM_VAL     VARCHAR(100),
    ITEM_SCR     DECIMAL(10,2),
    ITEM_WGHT    DECIMAL(5,2),
    ITEM_LST_SCR DECIMAL(10,2),
    REG_DT       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- RA_RISK_FACTOR: ML/TF Risk Factor Master
-- ============================================================
CREATE TABLE IF NOT EXISTS RA_RISK_FACTOR (
    RISK_CATG1_C      VARCHAR(10)   NOT NULL,  -- Risk category Lv1
    RISK_CATG2_C      VARCHAR(10)   NOT NULL,  -- Risk category Lv2
    RISK_ELMT_C       VARCHAR(10)   NOT NULL,  -- Risk element code
    RISK_ELMT_NM      VARCHAR(400)  NOT NULL,  -- Risk element name
    RISK_INDI         CHAR(1),                 -- Apply to individual
    RISK_CORP         CHAR(1),                 -- Apply to corporate
    RISK_VAL_ITEM     VARCHAR(100),            -- Assessment item
    RISK_VAL_CAL_STD  VARCHAR(100),            -- Assessment standard
    RISK_APPL_YN      CHAR(1)       DEFAULT 'Y',
    RISK_APPL_MODEL_I CHAR(1)       DEFAULT 'N',  -- Apply individual model
    RISK_APPL_MODEL_B CHAR(1)       DEFAULT 'N',  -- Apply corporate model
    RISK_HRSK_YN      CHAR(1)       DEFAULT 'N',  -- Mandatory EDD flag
    RISK_SCR          DECIMAL(6,4),
    RISK_RSN_DESC     VARCHAR(4000),
    RISK_RMRK         VARCHAR(4000),
    RISK_REG_DT       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    RISK_REG_ID       VARCHAR(20),
    RISK_UPD_DT       TIMESTAMP,
    RISK_UPD_ID       VARCHAR(20),
    PRIMARY KEY (RISK_CATG1_C, RISK_CATG2_C, RISK_ELMT_C)
);

-- ============================================================
-- RA_ITEM_NTN: Country Risk Score Master
-- ============================================================
CREATE TABLE IF NOT EXISTS RA_ITEM_NTN (
    RA_ITEM_CD         VARCHAR(10)  NOT NULL,
    RA_ITEM_CODE       VARCHAR(100) NOT NULL,  -- country code (ISO-2)
    RA_ITEM_NTN_CD     VARCHAR(100),           -- country name
    RA_ITEM_NM         VARCHAR(200),
    ABS_HRSK_YN        CHAR(1)      DEFAULT 'N',  -- mandatory high-risk flag
    RA_ITEM_SCR        DECIMAL(4,2),
    FATF_BLACK_LIST_YN CHAR(1)      DEFAULT 'N',
    FATF_GREY_LIST_YN  CHAR(1)      DEFAULT 'N',
    FINCEN_LIST_YN     CHAR(1)      DEFAULT 'N',
    UN_SANTIONS_YN     CHAR(1)      DEFAULT 'N',
    OFAC_SANTIONS_YN   CHAR(1)      DEFAULT 'N',
    OECD_YN            CHAR(1)      DEFAULT 'N',
    EU_SANTIONS_YN     CHAR(1)      DEFAULT 'N',
    EU_HRT_YN          CHAR(1)      DEFAULT 'N',
    TICPI_CPI_IDX      DECIMAL(4,2),
    BASEL_RIK_IDX      DECIMAL(4,2),
    HNDL_DY_TM         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (RA_ITEM_CD, RA_ITEM_CODE)
);

-- ============================================================
-- SRBA_SCHD: RBA Evaluation Schedule (batch schedule)
-- ============================================================
CREATE TABLE IF NOT EXISTS SRBA_SCHD (
    BAS_YYMM        VARCHAR(6)   PRIMARY KEY,  -- base year-month (yyyyMM)
    VALT_TRN        VARCHAR(2),                -- evaluation round
    ING_STEP        VARCHAR(5)   DEFAULT '00', -- progress step
    TGT_TRN_SDT     VARCHAR(8),                -- target period start date
    TGT_TRN_EDT     VARCHAR(8),                -- target period end date
    APPR_DT         VARCHAR(8),                -- approval date
    SCHD_CMPLT_DT   VARCHAR(8),                -- schedule completion date
    USE_YN          CHAR(1)      DEFAULT 'Y',
    REG_ID          VARCHAR(20),
    REG_DT          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TMS_STATS_DAILY: Daily Statistics Snapshot (app-internal)
-- ============================================================
CREATE TABLE IF NOT EXISTS TMS_STATS_DAILY (
    STATS_DT         VARCHAR(8)   NOT NULL,
    TOTAL_ALERTS     INT          DEFAULT 0,
    NEW_ALERTS       INT          DEFAULT 0,
    REVIEW_ALERTS    INT          DEFAULT 0,
    CLOSED_ALERTS    INT          DEFAULT 0,
    STR_COUNT        INT          DEFAULT 0,
    CTR_COUNT        INT          DEFAULT 0,
    HIGH_RISK_COUNT  INT          DEFAULT 0,
    TOTAL_DETECT_AMT DECIMAL(20,2),
    PRIMARY KEY (STATS_DT)
);
