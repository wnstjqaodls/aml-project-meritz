-- AMLXpress7 Sample Data (Oracle compatible)
-- Converted from data.sql: CURRENT_TIMESTAMP -> SYSTIMESTAMP
-- GENERATED ALWAYS AS IDENTITY columns (WLF_UNIQ_NO, SCREEN_ID, KYC_ID, RA_ID, RA_DTL_ID)
-- are excluded from INSERT column lists so Oracle generates them automatically.

-- ============================================================
-- NIC92B: Common Codes
-- ============================================================
-- STR/CTR case progress status (RPR_PRGRS_CCD, code A029)
INSERT INTO NIC92B VALUES ('A029', '9',  'Pending Review',  1, 'Y');
INSERT INTO NIC92B VALUES ('A029', '97', 'Under Review',    2, 'Y');
INSERT INTO NIC92B VALUES ('A029', '98', 'Completed',       3, 'Y');
INSERT INTO NIC92B VALUES ('A029', '99', 'Cancelled',       4, 'Y');
INSERT INTO NIC92B VALUES ('A029', '10', 'Submitted FIU',   5, 'Y');
-- Risk grade (A004)
INSERT INTO NIC92B VALUES ('A004', 'H',  'High Risk',       1, 'Y');
INSERT INTO NIC92B VALUES ('A004', 'M',  'Medium Risk',     2, 'Y');
INSERT INTO NIC92B VALUES ('A004', 'L',  'Low Risk',        3, 'Y');
-- Case type (A101)
INSERT INTO NIC92B VALUES ('A101', 'STR','STR Case',        1, 'Y');
INSERT INTO NIC92B VALUES ('A101', 'CTR','CTR Case',        2, 'Y');
INSERT INTO NIC92B VALUES ('A101', 'KYC','KYC Case',        3, 'Y');
INSERT INTO NIC92B VALUES ('A101', 'CAC','CAC Case',        4, 'Y');
-- Approval status (A038): SN_CCD in AML_APPR
INSERT INTO NIC92B VALUES ('A038', 'N',  'Pending',         1, 'Y');
INSERT INTO NIC92B VALUES ('A038', 'E',  'Completed',       2, 'Y');
INSERT INTO NIC92B VALUES ('A038', 'R',  'Rejected',        3, 'Y');
-- TMS approval process (S041)
INSERT INTO NIC92B VALUES ('S041', '1',  'Requested',       1, 'Y');
INSERT INTO NIC92B VALUES ('S041', '2',  'Approved',        2, 'Y');
INSERT INTO NIC92B VALUES ('S041', '3',  'Rejected',        3, 'Y');
INSERT INTO NIC92B VALUES ('S041', '9',  'Cancelled',       4, 'Y');
-- ID type (M002)
INSERT INTO NIC92B VALUES ('M002', '1',  'Resident No.',    1, 'Y');
INSERT INTO NIC92B VALUES ('M002', '2',  'Business No.',    2, 'Y');
INSERT INTO NIC92B VALUES ('M002', '3',  'Passport',        3, 'Y');
-- Individual/Corporate (M012)
INSERT INTO NIC92B VALUES ('M012', '1',  'Individual',      1, 'Y');
INSERT INTO NIC92B VALUES ('M012', '2',  'Corporate',       2, 'Y');
-- RA model type (A040) - used in RA_ITEM.RA_MDL_GBN_CD
INSERT INTO NIC92B VALUES ('A040', 'INDI', 'Individual Model',  1, 'Y');
INSERT INTO NIC92B VALUES ('A040', 'CORP', 'Corporate Model',   2, 'Y');
INSERT INTO NIC92B VALUES ('A040', 'FORE', 'Foreign Model',     3, 'Y');
INSERT INTO NIC92B VALUES ('A040', 'ETC',  'Other Model',       4, 'Y');
-- Customer type
INSERT INTO NIC92B VALUES ('CUST_TP', 'IND',  'Individual',  1, 'Y');
INSERT INTO NIC92B VALUES ('CUST_TP', 'CORP', 'Corporate',   2, 'Y');
INSERT INTO NIC92B VALUES ('CUST_TP', 'FORE', 'Foreign',     3, 'Y');
-- Risk grade (app internal)
INSERT INTO NIC92B VALUES ('RISK_GRD', 'H', 'High Risk',    1, 'Y');
INSERT INTO NIC92B VALUES ('RISK_GRD', 'M', 'Medium Risk',  2, 'Y');
INSERT INTO NIC92B VALUES ('RISK_GRD', 'L', 'Low Risk',     3, 'Y');
-- Alert status
INSERT INTO NIC92B VALUES ('ALERT_ST', 'NEW',       'New',        1, 'Y');
INSERT INTO NIC92B VALUES ('ALERT_ST', 'REVIEW',    'Reviewing',  2, 'Y');
INSERT INTO NIC92B VALUES ('ALERT_ST', 'CLOSED',    'Closed',     3, 'Y');
INSERT INTO NIC92B VALUES ('ALERT_ST', 'ESCALATED', 'Escalated',  4, 'Y');
-- Case type (app internal)
INSERT INTO NIC92B VALUES ('CASE_TP', 'STR', 'STR Case',    1, 'Y');
INSERT INTO NIC92B VALUES ('CASE_TP', 'CTR', 'CTR Case',    2, 'Y');
INSERT INTO NIC92B VALUES ('CASE_TP', 'ETC', 'Other',       3, 'Y');
-- Case status (app internal)
INSERT INTO NIC92B VALUES ('CASE_ST', 'OPEN',    'Open',     1, 'Y');
INSERT INTO NIC92B VALUES ('CASE_ST', 'REVIEW',  'Review',   2, 'Y');
INSERT INTO NIC92B VALUES ('CASE_ST', 'CLOSED',  'Closed',   3, 'Y');
INSERT INTO NIC92B VALUES ('CASE_ST', 'PENDING', 'Pending',  4, 'Y');
-- KYC status
INSERT INTO NIC92B VALUES ('KYC_ST', 'PENDING',     'Pending',     1, 'Y');
INSERT INTO NIC92B VALUES ('KYC_ST', 'IN_PROGRESS', 'In Progress', 2, 'Y');
INSERT INTO NIC92B VALUES ('KYC_ST', 'COMPLETE',    'Completed',   3, 'Y');
INSERT INTO NIC92B VALUES ('KYC_ST', 'EXPIRED',     'Expired',     4, 'Y');
INSERT INTO NIC92B VALUES ('KYC_ST', 'REJECTED',    'Rejected',    5, 'Y');
-- Channel
INSERT INTO NIC92B VALUES ('CHNL', 'BRANCH', 'Branch',  1, 'Y');
INSERT INTO NIC92B VALUES ('CHNL', 'ONLINE', 'Online',  2, 'Y');
INSERT INTO NIC92B VALUES ('CHNL', 'MOBILE', 'Mobile',  3, 'Y');
INSERT INTO NIC92B VALUES ('CHNL', 'ATM',    'ATM',     4, 'Y');
-- STR status
INSERT INTO NIC92B VALUES ('STR_ST', 'DRAFT',     'Draft',      1, 'Y');
INSERT INTO NIC92B VALUES ('STR_ST', 'REVIEW',    'Review',     2, 'Y');
INSERT INTO NIC92B VALUES ('STR_ST', 'APPROVED',  'Approved',   3, 'Y');
INSERT INTO NIC92B VALUES ('STR_ST', 'SUBMITTED', 'Submitted',  4, 'Y');
INSERT INTO NIC92B VALUES ('STR_ST', 'REJECTED',  'Rejected',   5, 'Y');
-- CTR status
INSERT INTO NIC92B VALUES ('CTR_ST', 'PENDING',   'Pending',    1, 'Y');
INSERT INTO NIC92B VALUES ('CTR_ST', 'APPROVED',  'Approved',   2, 'Y');
INSERT INTO NIC92B VALUES ('CTR_ST', 'SUBMITTED', 'Submitted',  3, 'Y');
-- Watchlist type
INSERT INTO NIC92B VALUES ('WL_TP', 'SDN', 'SDN List',       1, 'Y');
INSERT INTO NIC92B VALUES ('WL_TP', 'PEP', 'PEP',            2, 'Y');
INSERT INTO NIC92B VALUES ('WL_TP', 'UN',  'UN Sanction',    3, 'Y');
INSERT INTO NIC92B VALUES ('WL_TP', 'EU',  'EU Sanction',    4, 'Y');
-- Watchlist source
INSERT INTO NIC92B VALUES ('WL_SRC', 'OFAC',     'OFAC',      1, 'Y');
INSERT INTO NIC92B VALUES ('WL_SRC', 'UN',       'UN',        2, 'Y');
INSERT INTO NIC92B VALUES ('WL_SRC', 'EU',       'EU',        3, 'Y');
INSERT INTO NIC92B VALUES ('WL_SRC', 'DOMESTIC', 'Domestic',  4, 'Y');
-- WLF category codes (WLF_ISTU_CLS_CNTT in NIC19B_FACTIVA_UA)
INSERT INTO NIC92B VALUES ('WLF_CLS', 'SIE',      'SIE',            1, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'UN',       'UN Sanction',    2, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'RCA',      'RCA',            3, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'SIP',      'SIP',            4, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'KFSC',     'KFSC',           5, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'W180',     'W180',           6, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'UN-FINCEN','UN-FINCEN',      7, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'EURO',     'EU Sanction',    8, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'FATF',     'FATF',           9, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'KFIU',     'KFIU',          10, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'PEPs',     'PEPs',          11, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'ETC',      'Other',         12, 'Y');
INSERT INTO NIC92B VALUES ('WLF_CLS', 'OFAC',     'OFAC',          13, 'Y');
-- Match status
INSERT INTO NIC92B VALUES ('MATCH_ST', 'PENDING',    'Pending Review', 1, 'Y');
INSERT INTO NIC92B VALUES ('MATCH_ST', 'TRUE_MATCH', 'True Match',     2, 'Y');
INSERT INTO NIC92B VALUES ('MATCH_ST', 'FALSE_MATCH','False Match',    3, 'Y');
-- Priority
INSERT INTO NIC92B VALUES ('PRIORITY', 'HIGH',   'High',    1, 'Y');
INSERT INTO NIC92B VALUES ('PRIORITY', 'NORMAL', 'Normal',  2, 'Y');
INSERT INTO NIC92B VALUES ('PRIORITY', 'LOW',    'Low',     3, 'Y');
-- Transaction type
INSERT INTO NIC92B VALUES ('TRXN_TP', 'DEPOSIT',  'Deposit',   1, 'Y');
INSERT INTO NIC92B VALUES ('TRXN_TP', 'WITHDRAW', 'Withdraw',  2, 'Y');
INSERT INTO NIC92B VALUES ('TRXN_TP', 'TRANSFER', 'Transfer',  3, 'Y');
INSERT INTO NIC92B VALUES ('TRXN_TP', 'EXCHANGE', 'Exchange',  4, 'Y');
-- Rule type
INSERT INTO NIC92B VALUES ('RULE_TP', 'AMOUNT',  'Amount Based',  1, 'Y');
INSERT INTO NIC92B VALUES ('RULE_TP', 'COUNT',   'Count Based',   2, 'Y');
INSERT INTO NIC92B VALUES ('RULE_TP', 'PATTERN', 'Pattern Based', 3, 'Y');
-- ID type (KYC)
INSERT INTO NIC92B VALUES ('ID_TP', 'RRN',      'Resident No.',      1, 'Y');
INSERT INTO NIC92B VALUES ('ID_TP', 'PASSPORT', 'Passport',          2, 'Y');
INSERT INTO NIC92B VALUES ('ID_TP', 'DRIVER',   'Driver License',    3, 'Y');
INSERT INTO NIC92B VALUES ('ID_TP', 'BRN',      'Business Reg. No.', 4, 'Y');
-- Fund source
INSERT INTO NIC92B VALUES ('FUND_SRC', 'SALARY',   'Salary',     1, 'Y');
INSERT INTO NIC92B VALUES ('FUND_SRC', 'BUSINESS', 'Business',   2, 'Y');
INSERT INTO NIC92B VALUES ('FUND_SRC', 'INVEST',   'Investment', 3, 'Y');
INSERT INTO NIC92B VALUES ('FUND_SRC', 'INHERIT',  'Inheritance',4, 'Y');
INSERT INTO NIC92B VALUES ('FUND_SRC', 'OTHER',    'Other',      5, 'Y');
-- Close reason
INSERT INTO NIC92B VALUES ('CLOSE_RSN', 'NORMAL',    'Normal Transaction', 1, 'Y');
INSERT INTO NIC92B VALUES ('CLOSE_RSN', 'STR_FILED', 'STR Filed',          2, 'Y');
INSERT INTO NIC92B VALUES ('CLOSE_RSN', 'NO_ISSUE',  'No Issue',           3, 'Y');
-- RBA schedule progress step
INSERT INTO NIC92B VALUES ('RBA_STEP', '00', 'Not Started',   1, 'Y');
INSERT INTO NIC92B VALUES ('RBA_STEP', '10', 'Data Extract',  2, 'Y');
INSERT INTO NIC92B VALUES ('RBA_STEP', '20', 'Scoring',       3, 'Y');
INSERT INTO NIC92B VALUES ('RBA_STEP', '50', 'Pending Appr',  4, 'Y');
INSERT INTO NIC92B VALUES ('RBA_STEP', '99', 'Completed',     5, 'Y');

-- ============================================================
-- C_USER: Users
-- ============================================================
INSERT INTO C_USER (USER_ID, USER_NM, DEPT_CD, EMAIL, PWD, ROLE_ID, USE_CCD) VALUES
  ('admin',    'Admin',       'SYS', 'admin@aml.com',    '1',        'ADMIN',   'Y');
INSERT INTO C_USER (USER_ID, USER_NM, DEPT_CD, EMAIL, PWD, ROLE_ID, USE_CCD) VALUES
  ('analyst1', 'Analyst One', 'TMS', 'a1@aml.com',       'password', 'ANALYST', 'Y');
INSERT INTO C_USER (USER_ID, USER_NM, DEPT_CD, EMAIL, PWD, ROLE_ID, USE_CCD) VALUES
  ('analyst2', 'Analyst Two', 'TMS', 'a2@aml.com',       'password', 'ANALYST', 'Y');
INSERT INTO C_USER (USER_ID, USER_NM, DEPT_CD, EMAIL, PWD, ROLE_ID, USE_CCD) VALUES
  ('manager1', 'Manager One', 'AML', 'mgr1@aml.com',     'password', 'MANAGER', 'Y');
INSERT INTO C_USER (USER_ID, USER_NM, DEPT_CD, EMAIL, PWD, ROLE_ID, USE_CCD) VALUES
  ('manager2', 'Manager Two', 'AML', 'mgr2@aml.com',     'password', 'MANAGER', 'Y');

-- ============================================================
-- NIC41B: Departments
-- ============================================================
INSERT INTO NIC41B VALUES ('TMS',  'TMS Dept',    'AML',  'Y');
INSERT INTO NIC41B VALUES ('AML',  'AML Dept',    'COMP', 'Y');
INSERT INTO NIC41B VALUES ('COMP', 'Compliance',  NULL,   'Y');
INSERT INTO NIC41B VALUES ('SYS',  'System Mgmt', 'COMP', 'Y');

-- ============================================================
-- NIC01B: Customers
-- ============================================================
INSERT INTO NIC01B (RNMCNO, INDV_CORP_CCD, CS_TYP_CD, CS_NM, LG_AMT_ASTS_F, BRTH_DT, NAT_CD, RSK_GRD_CD, RSK_SCR, USE_CCD, REG_ID)
  VALUES ('8001011234567', '1', 'IND',  'Kim Cheolsu',  'N', '19800101', 'KR', 'M', 45.50, 'Y', 'admin');
INSERT INTO NIC01B (RNMCNO, INDV_CORP_CCD, CS_TYP_CD, CS_NM, LG_AMT_ASTS_F, BRTH_DT, NAT_CD, RSK_GRD_CD, RSK_SCR, USE_CCD, REG_ID)
  VALUES ('7512155678901', '1', 'IND',  'Lee Younghee', 'N', '19751215', 'KR', 'L', 25.00, 'Y', 'admin');
INSERT INTO NIC01B (RNMCNO, INDV_CORP_CCD, CS_TYP_CD, CS_NM, LG_AMT_ASTS_F, BRTH_DT, NAT_CD, RSK_GRD_CD, RSK_SCR, USE_CCD, REG_ID)
  VALUES ('6509201122334', '1', 'IND',  'Park Jisu',    'Y', '19650920', 'KR', 'H', 78.30, 'Y', 'admin');
INSERT INTO NIC01B (RNMCNO, INDV_CORP_CCD, CS_TYP_CD, CS_NM, LG_AMT_ASTS_F, BRTH_DT, NAT_CD, RSK_GRD_CD, RSK_SCR, USE_CCD, REG_ID)
  VALUES ('1234567890',    '2', 'CORP', 'ABC Corp',     'Y', NULL,       'KR', 'M', 55.00, 'Y', 'admin');
INSERT INTO NIC01B (RNMCNO, INDV_CORP_CCD, CS_TYP_CD, CS_NM, LG_AMT_ASTS_F, BRTH_DT, NAT_CD, RSK_GRD_CD, RSK_SCR, USE_CCD, REG_ID)
  VALUES ('9876543210',    '2', 'CORP', 'XYZ Trade',    'N', NULL,       'KR', 'L', 18.00, 'Y', 'admin');
INSERT INTO NIC01B (RNMCNO, INDV_CORP_CCD, CS_TYP_CD, CS_NM, LG_AMT_ASTS_F, BRTH_DT, NAT_CD, RSK_GRD_CD, RSK_SCR, USE_CCD, REG_ID)
  VALUES ('7809201357901', '1', 'FORE', 'ZHANG WEI',    'Y', '19780920', 'CN', 'H', 82.00, 'Y', 'admin');
INSERT INTO NIC01B (RNMCNO, INDV_CORP_CCD, CS_TYP_CD, CS_NM, LG_AMT_ASTS_F, BRTH_DT, NAT_CD, RSK_GRD_CD, RSK_SCR, USE_CCD, REG_ID)
  VALUES ('7205141234567', '1', 'FORE', 'IVAN PETROV',  'Y', '19720514', 'RU', 'H', 90.00, 'Y', 'admin');

-- ============================================================
-- NIC35B: Customer Risk
-- ============================================================
INSERT INTO NIC35B VALUES ('8001011234567', 'M', '20250101');
INSERT INTO NIC35B VALUES ('7512155678901', 'L', '20250101');
INSERT INTO NIC35B VALUES ('6509201122334', 'H', '20250115');
INSERT INTO NIC35B VALUES ('1234567890',    'M', '20250201');
INSERT INTO NIC35B VALUES ('9876543210',    'L', '20250201');
INSERT INTO NIC35B VALUES ('7809201357901', 'H', '20250101');
INSERT INTO NIC35B VALUES ('7205141234567', 'H', '20250201');

-- ============================================================
-- NIC17B: Accounts
-- ============================================================
INSERT INTO NIC17B VALUES ('1001-001-123456', '8001011234567', 'SAV', '20200101', 'Y', SYSTIMESTAMP);
INSERT INTO NIC17B VALUES ('1001-002-234567', '7512155678901', 'CHK', '20190601', 'Y', SYSTIMESTAMP);
INSERT INTO NIC17B VALUES ('1001-003-345678', '6509201122334', 'SAV', '20180301', 'Y', SYSTIMESTAMP);
INSERT INTO NIC17B VALUES ('2002-001-456789', '1234567890',    'BIZ', '20150101', 'Y', SYSTIMESTAMP);
INSERT INTO NIC17B VALUES ('2002-002-567890', '9876543210',    'BIZ', '20160501', 'Y', SYSTIMESTAMP);
INSERT INTO NIC17B VALUES ('1001-004-456789', '7809201357901', 'SAV', '20220115', 'Y', SYSTIMESTAMP);
INSERT INTO NIC17B VALUES ('1001-005-567890', '7205141234567', 'SAV', '20230201', 'Y', SYSTIMESTAMP);

-- ============================================================
-- NIC19B_FACTIVA_UA: Watchlist Entries
-- WLF_UNIQ_NO is GENERATED ALWAYS AS IDENTITY - omitted from INSERT
-- ============================================================
INSERT INTO NIC19B_FACTIVA_UA
  (WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, WLF_FCNM_CNTT,
   WLF_FIRST_NAME_CNTT, WLF_MIDDLE_NAME_CNTT, WLF_LAST_NAME_CNTT,
   WLF_NTNT_CNTT, WLF_POB_CNTT, SPLM_DATE, FLXB_YN, MNPL_YMDH)
VALUES
  ('UN', 'Kim Jong Un', 'Kim Jong Un', 'Kim Jong Un',
   'Jong Un', '', 'Kim',
   'KP', '19840108', '20251124', 'N', SYSTIMESTAMP);

INSERT INTO NIC19B_FACTIVA_UA
  (WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, WLF_FCNM_CNTT,
   WLF_FIRST_NAME_CNTT, WLF_MIDDLE_NAME_CNTT, WLF_LAST_NAME_CNTT,
   WLF_NTNT_CNTT, WLF_POB_CNTT, SPLM_DATE, FLXB_YN, MNPL_YMDH)
VALUES
  ('OFAC', 'Al-Qaida Network', 'Al-Qaida', 'Al-Qaida',
   'Al', '', 'Qaida',
   'AF', '19980101', '20251124', 'N', SYSTIMESTAMP);

INSERT INTO NIC19B_FACTIVA_UA
  (WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, WLF_FCNM_CNTT,
   WLF_FIRST_NAME_CNTT, WLF_MIDDLE_NAME_CNTT, WLF_LAST_NAME_CNTT,
   WLF_NTNT_CNTT, WLF_POB_CNTT, SPLM_DATE, FLXB_YN, MNPL_YMDH)
VALUES
  ('FATF', 'Suspicious Individual', '', 'Suspicious Individual',
   'Suspicious', '', 'Individual',
   'IR', '19750515', '20251124', 'N', SYSTIMESTAMP);

INSERT INTO NIC19B_FACTIVA_UA
  (WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, WLF_FCNM_CNTT,
   WLF_FIRST_NAME_CNTT, WLF_MIDDLE_NAME_CNTT, WLF_LAST_NAME_CNTT,
   WLF_NTNT_CNTT, WLF_POB_CNTT, SPLM_DATE, FLXB_YN, MNPL_YMDH)
VALUES
  ('PEPs', 'Lee Myung Park', 'Lee Myung Park', 'Lee Myung Park',
   'Myung', '', 'Park',
   'KR', '19601001', '20251124', 'N', SYSTIMESTAMP);

INSERT INTO NIC19B_FACTIVA_UA
  (WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, WLF_FCNM_CNTT,
   WLF_FIRST_NAME_CNTT, WLF_MIDDLE_NAME_CNTT, WLF_LAST_NAME_CNTT,
   WLF_NTNT_CNTT, WLF_POB_CNTT, SPLM_DATE, FLXB_YN, MNPL_YMDH)
VALUES
  ('KFIU', 'Jung Min Kim', 'Jung Min Kim', 'Jung Min Kim',
   'Min', 'Jung', 'Kim',
   'KR', '19851215', '20251124', 'N', SYSTIMESTAMP);

INSERT INTO NIC19B_FACTIVA_UA
  (WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, WLF_FCNM_CNTT,
   WLF_FIRST_NAME_CNTT, WLF_MIDDLE_NAME_CNTT, WLF_LAST_NAME_CNTT,
   WLF_NTNT_CNTT, WLF_POB_CNTT, SPLM_DATE, FLXB_YN, MNPL_YMDH,
   WLF_RSPS_CNTT)
VALUES
  ('OFAC', 'ZHANG WEI', 'ZHANG WEI', 'ZHANG WEI',
   'WEI', '', 'ZHANG',
   'CN', '19781001', '20201110', 'N', SYSTIMESTAMP,
   'See previous Roles');

INSERT INTO NIC19B_FACTIVA_UA
  (WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, WLF_FCNM_CNTT,
   WLF_FIRST_NAME_CNTT, WLF_MIDDLE_NAME_CNTT, WLF_LAST_NAME_CNTT,
   WLF_NTNT_CNTT, WLF_POB_CNTT, SPLM_DATE, FLXB_YN, MNPL_YMDH,
   WLF_RSPS_CNTT)
VALUES
  ('EURO', 'IVAN PETROV', 'IVAN PETROV', 'IVAN PETROV',
   'IVAN', '', 'PETROV',
   'RU', '19720514', '20220301', 'N', SYSTIMESTAMP,
   'Deceased');

INSERT INTO NIC19B_FACTIVA_UA
  (WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, WLF_FCNM_CNTT,
   WLF_FIRST_NAME_CNTT, WLF_MIDDLE_NAME_CNTT, WLF_LAST_NAME_CNTT,
   WLF_NTNT_CNTT, WLF_POB_CNTT, SPLM_DATE, FLXB_YN, MNPL_YMDH)
VALUES
  ('UN', 'CHOE RYONG HAE', 'CHOE RYONG HAE', 'CHOE RYONG HAE',
   'RYONG HAE', '', 'CHOE',
   'KP', '19500912', '20160630', 'N', SYSTIMESTAMP);

-- ============================================================
-- NIC70B: Transaction Party Basic
-- ============================================================
INSERT INTO NIC70B VALUES ('20250101', '8001011234567', 'Kim Cheolsu',  '1', '1');
INSERT INTO NIC70B VALUES ('20250115', '6509201122334', 'Park Jisu',    '1', '1');
INSERT INTO NIC70B VALUES ('20250201', '1234567890',    'ABC Corp',     '2', '2');
INSERT INTO NIC70B VALUES ('20250210', '7512155678901', 'Lee Younghee', '1', '1');
INSERT INTO NIC70B VALUES ('20250301', '9876543210',    'XYZ Trade',    '2', '2');
INSERT INTO NIC70B VALUES ('20250110', '7809201357901', 'ZHANG WEI',   '1', '1');
INSERT INTO NIC70B VALUES ('20250125', '7205141234567', 'IVAN PETROV',  '1', '1');

-- ============================================================
-- NIC66B: STR/CTR Cases (historical)
-- ============================================================
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20250101', 'STR20250101001', 'STR001', 'STR', '9',  '8001011234567', 72.5, 'H', '0', 85.0, 'admin');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20250115', 'STR20250115001', 'STR002', 'STR', '97', '6509201122334', 88.0, 'H', '1', 91.0, 'admin');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20250201', 'CTR20250201001', 'CTR001', 'CTR', '9',  '1234567890',   60.0, 'M', '0', 70.0, 'admin');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20250210', 'STR20250210001', 'STR003', 'STR', '98', '7512155678901', 45.0, 'M', '1', 55.0, 'admin');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20250301', 'CTR20250301001', 'CTR002', 'CTR', '99', '9876543210',   30.0, 'L', '1', 40.0, 'admin');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20250110', 'STR20250110001', 'STR003', 'STR', '9',  '7809201357901', 85.0, 'H', '0', 88.0, 'admin');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20250125', 'STR20250125001', 'STR001', 'STR', '9',  '7205141234567', 90.0, 'H', '0', 92.0, 'admin');

-- ============================================================
-- NIC75B: Account Transaction Amounts (historical)
-- ============================================================
INSERT INTO NIC75B VALUES ('20250101', 'STR20250101001', '1001-001-123456', 15000000, 'KRW');
INSERT INTO NIC75B VALUES ('20250115', 'STR20250115001', '1001-003-345678', 50000000, 'KRW');
INSERT INTO NIC75B VALUES ('20250201', 'CTR20250201001', '2002-001-456789', 20000000, 'KRW');
INSERT INTO NIC75B VALUES ('20250210', 'STR20250210001', '1001-002-234567', 8000000,  'KRW');
INSERT INTO NIC75B VALUES ('20250301', 'CTR20250301001', '2002-002-567890', 12000000, 'KRW');
INSERT INTO NIC75B VALUES ('20250110', 'STR20250110001', '1001-004-456789', 28200000, 'KRW');
INSERT INTO NIC75B VALUES ('20250125', 'STR20250125001', '1001-005-567890', 12000000, 'KRW');

-- ============================================================
-- NIC73B: Transaction List (historical)
-- ============================================================
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_AMT, DL_TYP_CCD, DL_CCY)
  VALUES ('20250101', 'STR20250101001', 1, 'BR001', 'Seoul Branch',   '20250101', 15000000, 'W', 'KRW');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_AMT, DL_TYP_CCD, DL_CCY)
  VALUES ('20250115', 'STR20250115001', 1, 'BR002', 'Gangnam Branch', '20250115', 50000000, 'W', 'KRW');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_AMT, DL_TYP_CCD, DL_CCY)
  VALUES ('20250201', 'CTR20250201001', 1, 'BR001', 'Seoul Branch',   '20250201', 20000000, 'W', 'KRW');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_AMT, DL_TYP_CCD, DL_CCY)
  VALUES ('20250110', 'STR20250110001', 1, 'BR003', 'Gangbuk Branch', '20250110',  9800000, 'W', 'KRW');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_AMT, DL_TYP_CCD, DL_CCY)
  VALUES ('20250110', 'STR20250110001', 2, 'BR003', 'Gangbuk Branch', '20250111',  8900000, 'W', 'KRW');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_AMT, DL_TYP_CCD, DL_CCY)
  VALUES ('20250110', 'STR20250110001', 3, 'BR003', 'Gangbuk Branch', '20250112',  9500000, 'W', 'KRW');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_AMT, DL_TYP_CCD, DL_CCY)
  VALUES ('20250125', 'STR20250125001', 1, 'BR006', 'Itaewon Branch', '20250125', 12000000, 'W', 'KRW');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_AMT, DL_TYP_CCD, DL_CCY)
  VALUES ('20250125', 'STR20250125001', 2, 'BR006', 'Itaewon Branch', '20250125', 11500000, 'W', 'KRW');

-- ============================================================
-- NIC67B: STR Report Content (historical)
-- ============================================================
INSERT INTO NIC67B (SSPS_DL_CRT_DT, SSPS_DL_ID, RPR_RSN_CNTNT, DOBT_DL_GRD_CD, REG_ID)
  VALUES ('20250101', 'STR20250101001', 'Frequent large cash deposits exceeding normal pattern', 'H', 'admin');
INSERT INTO NIC67B (SSPS_DL_CRT_DT, SSPS_DL_ID, RPR_RSN_CNTNT, DOBT_DL_GRD_CD, REG_ID)
  VALUES ('20250115', 'STR20250115001', 'Structuring detected: multiple transactions below threshold within 7 days', 'H', 'admin');
INSERT INTO NIC67B (SSPS_DL_CRT_DT, SSPS_DL_ID, RPR_RSN_CNTNT, DOBT_DL_GRD_CD, REG_ID)
  VALUES ('20250110', 'STR20250110001', 'Possible structuring transactions - three deposits below 10M threshold', 'H', 'analyst1');
INSERT INTO NIC67B (SSPS_DL_CRT_DT, SSPS_DL_ID, RPR_RSN_CNTNT, DOBT_DL_GRD_CD, REG_ID)
  VALUES ('20250125', 'STR20250125001', 'OFAC/EU sanctioned individual - large cash in and same-day withdrawal', 'H', 'analyst2');

-- ============================================================
-- NIC86B: Reporting Institution
-- ============================================================
INSERT INTO NIC86B VALUES (1, 'Meritz Securities AML', 'Compliance Manager', 'TMS Analyst', '02-1234-5678', 'Y');

-- ============================================================
-- NIC58B: Rule Approval Status
-- ============================================================
INSERT INTO NIC58B (RULE_ID, INST_ID, SN_PRGRS_CCD, RULE_UPD_MAJ_VER, RULE_UPD_MIN_VER)
  VALUES ('STR001', 'INST001', '2', 1, 1);
INSERT INTO NIC58B (RULE_ID, INST_ID, SN_PRGRS_CCD, RULE_UPD_MAJ_VER, RULE_UPD_MIN_VER)
  VALUES ('STR002', 'INST001', '1', 1, 0);

-- ============================================================
-- TMS_APPL: Scenario Application List
-- ============================================================
INSERT INTO TMS_APPL (SCNR_ID, SCNR_NM, SCNR_CCD, BZDM_CD, USE_CCD, REG_ID)
  VALUES ('STR001', 'Large Cash Deposit STR', 'STR', 'AML', 'Y', 'admin');
INSERT INTO TMS_APPL (SCNR_ID, SCNR_NM, SCNR_CCD, BZDM_CD, USE_CCD, REG_ID)
  VALUES ('STR002', 'Structuring Detection',  'STR', 'AML', 'Y', 'admin');
INSERT INTO TMS_APPL (SCNR_ID, SCNR_NM, SCNR_CCD, BZDM_CD, USE_CCD, REG_ID)
  VALUES ('STR003', 'Round Amount Transfer',  'STR', 'AML', 'Y', 'admin');
INSERT INTO TMS_APPL (SCNR_ID, SCNR_NM, SCNR_CCD, BZDM_CD, USE_CCD, REG_ID)
  VALUES ('STR004', 'Cross-Border High Risk', 'STR', 'AML', 'Y', 'admin');
INSERT INTO TMS_APPL (SCNR_ID, SCNR_NM, SCNR_CCD, BZDM_CD, USE_CCD, REG_ID)
  VALUES ('STR005', 'Dormant Account Active', 'STR', 'AML', 'Y', 'admin');
INSERT INTO TMS_APPL (SCNR_ID, SCNR_NM, SCNR_CCD, BZDM_CD, USE_CCD, REG_ID)
  VALUES ('CTR001', 'Cash Over 10M KRW',      'CTR', 'AML', 'Y', 'admin');
INSERT INTO TMS_APPL (SCNR_ID, SCNR_NM, SCNR_CCD, BZDM_CD, USE_CCD, REG_ID)
  VALUES ('CTR002', 'Daily CTR Aggregation',  'CTR', 'AML', 'Y', 'admin');

-- ============================================================
-- TMS_REQ: Scenario Request/Standard
-- ============================================================
INSERT INTO TMS_REQ (SCNR_ID, SCNR_NM, SCNR_CCD, PERIOD_DAY, USE_CCD, REG_ID)
  VALUES ('STR001', 'Large Cash Deposit STR', 'STR', 1,   'Y', 'admin');
INSERT INTO TMS_REQ (SCNR_ID, SCNR_NM, SCNR_CCD, PERIOD_DAY, USE_CCD, REG_ID)
  VALUES ('STR002', 'Structuring Detection',  'STR', 7,   'Y', 'admin');
INSERT INTO TMS_REQ (SCNR_ID, SCNR_NM, SCNR_CCD, PERIOD_DAY, USE_CCD, REG_ID)
  VALUES ('STR003', 'Round Amount Transfer',  'STR', 30,  'Y', 'admin');
INSERT INTO TMS_REQ (SCNR_ID, SCNR_NM, SCNR_CCD, PERIOD_DAY, USE_CCD, REG_ID)
  VALUES ('STR004', 'Cross-Border High Risk', 'STR', 90,  'Y', 'admin');
INSERT INTO TMS_REQ (SCNR_ID, SCNR_NM, SCNR_CCD, PERIOD_DAY, USE_CCD, REG_ID)
  VALUES ('STR005', 'Dormant Account Active', 'STR', 365, 'Y', 'admin');
INSERT INTO TMS_REQ (SCNR_ID, SCNR_NM, SCNR_CCD, PERIOD_DAY, USE_CCD, REG_ID)
  VALUES ('CTR001', 'Cash Over 10M KRW',      'CTR', 1,   'Y', 'admin');
INSERT INTO TMS_REQ (SCNR_ID, SCNR_NM, SCNR_CCD, PERIOD_DAY, USE_CCD, REG_ID)
  VALUES ('CTR002', 'Daily CTR Aggregation',  'CTR', 1,   'Y', 'admin');

-- ============================================================
-- TMS_SET_VAL: Scenario Threshold Values
-- ============================================================
INSERT INTO TMS_SET_VAL VALUES ('STR001', 'ALL', 'THRESHOLD_AMT', '10000000', 'admin', '20250101000000', NULL, NULL);
INSERT INTO TMS_SET_VAL VALUES ('STR001', 'ALL', 'PERIOD_DAY',    '1',        'admin', '20250101000000', NULL, NULL);
INSERT INTO TMS_SET_VAL VALUES ('STR002', 'ALL', 'THRESHOLD_AMT', '5000000',  'admin', '20250101000000', NULL, NULL);
INSERT INTO TMS_SET_VAL VALUES ('STR002', 'ALL', 'THRESHOLD_CNT', '3',        'admin', '20250101000000', NULL, NULL);
INSERT INTO TMS_SET_VAL VALUES ('STR002', 'ALL', 'PERIOD_DAY',    '7',        'admin', '20250101000000', NULL, NULL);
INSERT INTO TMS_SET_VAL VALUES ('STR003', 'ALL', 'THRESHOLD_AMT', '1000000',  'admin', '20250101000000', NULL, NULL);
INSERT INTO TMS_SET_VAL VALUES ('CTR001', 'ALL', 'THRESHOLD_AMT', '10000000', 'admin', '20250101000000', NULL, NULL);
INSERT INTO TMS_SET_VAL VALUES ('CTR002', 'ALL', 'THRESHOLD_AMT', '10000000', 'admin', '20250101000000', NULL, NULL);
INSERT INTO TMS_SET_VAL VALUES ('CTR002', 'ALL', 'PERIOD_DAY',    '1',        'admin', '20250101000000', NULL, NULL);

-- ============================================================
-- TMS_SET_VAL_APP: Approval Requests
-- ============================================================
INSERT INTO TMS_SET_VAL_APP VALUES ('APP2025001', 'STR001', 'E', '20250110', 'analyst1', SYSTIMESTAMP);
INSERT INTO TMS_SET_VAL_APP VALUES ('APP2025002', 'STR002', 'N', '20250205', 'analyst2', SYSTIMESTAMP);
INSERT INTO TMS_SET_VAL_APP VALUES ('APP2025003', 'CTR001', 'N', '20250301', 'analyst1', SYSTIMESTAMP);

-- ============================================================
-- TMS_SET_VAL_APP_DTL: Approval Request Details
-- ============================================================
INSERT INTO TMS_SET_VAL_APP_DTL VALUES ('APP2025001', 'ALL', 'THRESHOLD_AMT', 'Threshold Amount', '12000000', '10000000');
INSERT INTO TMS_SET_VAL_APP_DTL VALUES ('APP2025002', 'ALL', 'THRESHOLD_AMT', 'Threshold Amount', '8000000',  '5000000');
INSERT INTO TMS_SET_VAL_APP_DTL VALUES ('APP2025002', 'ALL', 'THRESHOLD_CNT', 'Threshold Count',  '5',        '3');
INSERT INTO TMS_SET_VAL_APP_DTL VALUES ('APP2025003', 'ALL', 'THRESHOLD_AMT', 'Threshold Amount', '15000000', '10000000');

-- ============================================================
-- AML_APPR: Approvals (historical)
-- ============================================================
INSERT INTO AML_APPR (APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD, APPR_ROLE_ID, TARGET_ROLE_ID, RSN_CNTNT, HNDL_DY_TM, HNDL_P_ENO, REG_DT)
  VALUES ('APP2025001', 'TMS1', 1, '20250110', 1, 'E', 'ANALYST', 'MANAGER', 'Threshold adjustment approved', SYSTIMESTAMP, 'analyst1', SYSTIMESTAMP);
INSERT INTO AML_APPR (APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD, APPR_ROLE_ID, TARGET_ROLE_ID, RSN_CNTNT, HNDL_DY_TM, HNDL_P_ENO, REG_DT)
  VALUES ('APP2025002', 'TMS1', 1, '20250205', 1, 'N', 'ANALYST', 'MANAGER', 'Structuring threshold review', SYSTIMESTAMP, 'analyst2', SYSTIMESTAMP);
INSERT INTO AML_APPR (APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD, APPR_ROLE_ID, TARGET_ROLE_ID, RSN_CNTNT, HNDL_DY_TM, HNDL_P_ENO, REG_DT)
  VALUES ('APP2025003', 'TMS2', 1, '20250301', 1, 'N', 'ANALYST', 'MANAGER', 'CTR threshold revision', SYSTIMESTAMP, 'analyst1', SYSTIMESTAMP);

-- ============================================================
-- KYC_CUST: KYC Records
-- KYC_ID is GENERATED ALWAYS AS IDENTITY - omitted from INSERT
-- ============================================================
INSERT INTO KYC_CUST (RNMCNO, KYC_TP_CCD, KYC_STS_CCD, ID_TP_CCD, PEP_F, BENEFICIAL_F, KYC_DT, NEXT_KYC_DT, REG_ID)
  VALUES ('8001011234567', 'INITIAL',  'COMPLETE',     'RRN',      'N', 'N', '20250101', '20260101', 'analyst1');
INSERT INTO KYC_CUST (RNMCNO, KYC_TP_CCD, KYC_STS_CCD, ID_TP_CCD, PEP_F, BENEFICIAL_F, KYC_DT, NEXT_KYC_DT, REG_ID)
  VALUES ('7512155678901', 'INITIAL',  'COMPLETE',     'RRN',      'N', 'N', '20250101', '20270101', 'analyst1');
INSERT INTO KYC_CUST (RNMCNO, KYC_TP_CCD, KYC_STS_CCD, ID_TP_CCD, PEP_F, BENEFICIAL_F, KYC_DT, NEXT_KYC_DT, REG_ID)
  VALUES ('6509201122334', 'EDD',      'IN_PROGRESS',  'RRN',      'N', 'N', '20250115', '20251115', 'analyst2');
INSERT INTO KYC_CUST (RNMCNO, KYC_TP_CCD, KYC_STS_CCD, ID_TP_CCD, PEP_F, BENEFICIAL_F, KYC_DT, NEXT_KYC_DT, REG_ID)
  VALUES ('7809201357901', 'INITIAL',  'COMPLETE',     'PASSPORT', 'N', 'Y', '20250101', '20260101', 'analyst2');
INSERT INTO KYC_CUST (RNMCNO, KYC_TP_CCD, KYC_STS_CCD, ID_TP_CCD, PEP_F, BENEFICIAL_F, KYC_DT, NEXT_KYC_DT, REMARK, REG_ID)
  VALUES ('7205141234567', 'INITIAL',  'IN_PROGRESS',  'PASSPORT', 'Y', 'Y', NULL,       NULL,       'EDD in progress - PEP and OFAC/EU sanction list match', 'analyst2');

-- ============================================================
-- RA_GRD_STD: Grade Standards
-- ============================================================
INSERT INTO RA_GRD_STD VALUES ('H', 70.00, 100.00, 'High Risk');
INSERT INTO RA_GRD_STD VALUES ('M', 40.00,  69.99, 'Medium Risk');
INSERT INTO RA_GRD_STD VALUES ('L',  0.00,  39.99, 'Low Risk');

-- ============================================================
-- RA_ITEM: Risk Assessment Items
-- ============================================================
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('I001', 'Country Risk',           'INDI', NULL,   10.00, 'N', 'Y', 1, 'admin');
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('I002', 'Occupation Risk',         'INDI', NULL,   10.00, 'Y', 'Y', 2, 'admin');
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('I003', 'Transaction Risk',        'INDI', NULL,   10.00, 'Y', 'Y', 3, 'admin');
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('I004', 'PEP Status',              'INDI', NULL,    0.00, 'N', 'Y', 4, 'admin');
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('I005', 'Beneficial Owner',        'INDI', NULL,    0.00, 'N', 'Y', 5, 'admin');
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('I006', 'Customer Type',           'INDI', NULL,    5.00, 'N', 'Y', 6, 'admin');
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('C001', 'Industry Risk',           'CORP', NULL,   10.00, 'N', 'Y', 1, 'admin');
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('C002', 'Corporate Country Risk',  'CORP', NULL,   10.00, 'N', 'Y', 2, 'admin');
INSERT INTO RA_ITEM (RA_ITEM_CD, RA_ITEM_NM, RA_MDL_GBN_CD, REFF_COMN_CD, MISS_VAL_SCR, INTV_VAL_YN, USE_YN, SRT_SQ, REG_ID)
  VALUES ('C003', 'Transaction Risk',        'CORP', NULL,   10.00, 'Y', 'Y', 3, 'admin');

-- ============================================================
-- RA_ITEM_WGHT: RA Item Weights
-- ============================================================
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('I001', 'INDI', 25.00, 30.00, 'E', 'Y');
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('I002', 'INDI', 20.00, 20.00, 'E', 'Y');
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('I003', 'INDI', 25.00, 25.00, 'E', 'Y');
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('I004', 'INDI', 15.00, 30.00, 'E', 'Y');
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('I005', 'INDI', 10.00, 20.00, 'E', 'Y');
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('I006', 'INDI',  5.00, 20.00, 'E', 'Y');
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('C001', 'CORP', 35.00, 30.00, 'E', 'Y');
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('C002', 'CORP', 35.00, 30.00, 'E', 'Y');
INSERT INTO RA_ITEM_WGHT (RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, SN_CCD, USE_YN)
  VALUES ('C003', 'CORP', 30.00, 25.00, 'E', 'Y');

-- ============================================================
-- RA_RISK_FACTOR: ML/TF Risk Factors
-- ============================================================
INSERT INTO RA_RISK_FACTOR
  (RISK_CATG1_C, RISK_CATG2_C, RISK_ELMT_C, RISK_ELMT_NM, RISK_INDI, RISK_CORP,
   RISK_APPL_YN, RISK_APPL_MODEL_I, RISK_APPL_MODEL_B, RISK_HRSK_YN, RISK_SCR, RISK_REG_ID)
VALUES
  ('C01', 'C01_01', 'C01_01_01', 'Non-resident (Foreigner)', 'Y', 'N', 'Y', 'Y', 'N', 'N', 0.3000, 'admin');
INSERT INTO RA_RISK_FACTOR
  (RISK_CATG1_C, RISK_CATG2_C, RISK_ELMT_C, RISK_ELMT_NM, RISK_INDI, RISK_CORP,
   RISK_APPL_YN, RISK_APPL_MODEL_I, RISK_APPL_MODEL_B, RISK_HRSK_YN, RISK_SCR, RISK_REG_ID)
VALUES
  ('C01', 'C01_01', 'C01_01_02', 'UN/FATF High-Risk Country Nationality', 'Y', 'N', 'Y', 'Y', 'N', 'Y', 1.0000, 'admin');
INSERT INTO RA_RISK_FACTOR
  (RISK_CATG1_C, RISK_CATG2_C, RISK_ELMT_C, RISK_ELMT_NM, RISK_INDI, RISK_CORP,
   RISK_APPL_YN, RISK_APPL_MODEL_I, RISK_APPL_MODEL_B, RISK_HRSK_YN, RISK_SCR, RISK_REG_ID)
VALUES
  ('C01', 'C01_02', 'C01_02_01', 'Politically Exposed Person (PEP)', 'Y', 'N', 'Y', 'Y', 'N', 'Y', 1.0000, 'admin');
INSERT INTO RA_RISK_FACTOR
  (RISK_CATG1_C, RISK_CATG2_C, RISK_ELMT_C, RISK_ELMT_NM, RISK_INDI, RISK_CORP,
   RISK_APPL_YN, RISK_APPL_MODEL_I, RISK_APPL_MODEL_B, RISK_HRSK_YN, RISK_SCR, RISK_REG_ID)
VALUES
  ('C02', 'C02_01', 'C02_01_01', 'Frequent Cash Transactions', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', 0.5000, 'admin');
INSERT INTO RA_RISK_FACTOR
  (RISK_CATG1_C, RISK_CATG2_C, RISK_ELMT_C, RISK_ELMT_NM, RISK_INDI, RISK_CORP,
   RISK_APPL_YN, RISK_APPL_MODEL_I, RISK_APPL_MODEL_B, RISK_HRSK_YN, RISK_SCR, RISK_REG_ID)
VALUES
  ('C02', 'C02_01', 'C02_01_02', 'Large One-time Transaction', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', 0.4000, 'admin');
INSERT INTO RA_RISK_FACTOR
  (RISK_CATG1_C, RISK_CATG2_C, RISK_ELMT_C, RISK_ELMT_NM, RISK_INDI, RISK_CORP,
   RISK_APPL_YN, RISK_APPL_MODEL_I, RISK_APPL_MODEL_B, RISK_HRSK_YN, RISK_SCR, RISK_REG_ID)
VALUES
  ('C03', 'C03_01', 'C03_01_01', 'Complex Corporate Structure', 'N', 'Y', 'Y', 'N', 'Y', 'N', 0.3000, 'admin');

-- ============================================================
-- RA_ITEM_NTN: Country Risk Scores
-- ============================================================
INSERT INTO RA_ITEM_NTN
  (RA_ITEM_CD, RA_ITEM_CODE, RA_ITEM_NTN_CD, RA_ITEM_NM, ABS_HRSK_YN, RA_ITEM_SCR,
   FATF_BLACK_LIST_YN, FATF_GREY_LIST_YN, UN_SANTIONS_YN, OFAC_SANTIONS_YN, OECD_YN)
VALUES ('I001', 'KR', 'Korea', 'Republic of Korea', 'N', 1.00, 'N', 'N', 'N', 'N', 'Y');
INSERT INTO RA_ITEM_NTN
  (RA_ITEM_CD, RA_ITEM_CODE, RA_ITEM_NTN_CD, RA_ITEM_NM, ABS_HRSK_YN, RA_ITEM_SCR,
   FATF_BLACK_LIST_YN, FATF_GREY_LIST_YN, UN_SANTIONS_YN, OFAC_SANTIONS_YN, OECD_YN)
VALUES ('I001', 'KP', 'North Korea', 'Democratic People Republic of Korea', 'Y', 4.00, 'Y', 'N', 'Y', 'Y', 'N');
INSERT INTO RA_ITEM_NTN
  (RA_ITEM_CD, RA_ITEM_CODE, RA_ITEM_NTN_CD, RA_ITEM_NM, ABS_HRSK_YN, RA_ITEM_SCR,
   FATF_BLACK_LIST_YN, FATF_GREY_LIST_YN, UN_SANTIONS_YN, OFAC_SANTIONS_YN, OECD_YN)
VALUES ('I001', 'IR', 'Iran', 'Islamic Republic of Iran', 'Y', 4.00, 'Y', 'N', 'Y', 'Y', 'N');
INSERT INTO RA_ITEM_NTN
  (RA_ITEM_CD, RA_ITEM_CODE, RA_ITEM_NTN_CD, RA_ITEM_NM, ABS_HRSK_YN, RA_ITEM_SCR,
   FATF_BLACK_LIST_YN, FATF_GREY_LIST_YN, UN_SANTIONS_YN, OFAC_SANTIONS_YN, EU_SANTIONS_YN)
VALUES ('I001', 'RU', 'Russia', 'Russian Federation', 'N', 3.00, 'N', 'N', 'N', 'Y', 'Y');
INSERT INTO RA_ITEM_NTN
  (RA_ITEM_CD, RA_ITEM_CODE, RA_ITEM_NTN_CD, RA_ITEM_NM, ABS_HRSK_YN, RA_ITEM_SCR,
   FATF_GREY_LIST_YN, OECD_YN)
VALUES ('I001', 'CN', 'China', 'People Republic of China', 'N', 2.00, 'N', 'N');
INSERT INTO RA_ITEM_NTN
  (RA_ITEM_CD, RA_ITEM_CODE, RA_ITEM_NTN_CD, RA_ITEM_NM, ABS_HRSK_YN, RA_ITEM_SCR,
   FATF_BLACK_LIST_YN, FATF_GREY_LIST_YN, OECD_YN)
VALUES ('I001', 'AF', 'Afghanistan', 'Islamic Emirate of Afghanistan', 'Y', 4.00, 'Y', 'N', 'N');
INSERT INTO RA_ITEM_NTN
  (RA_ITEM_CD, RA_ITEM_CODE, RA_ITEM_NTN_CD, RA_ITEM_NM, ABS_HRSK_YN, RA_ITEM_SCR,
   FATF_GREY_LIST_YN, OECD_YN)
VALUES ('I001', 'US', 'United States', 'United States of America', 'N', 1.00, 'N', 'Y');

-- ============================================================
-- SRBA_SCHD: RBA Evaluation Schedule
-- ============================================================
INSERT INTO SRBA_SCHD
  (BAS_YYMM, VALT_TRN, ING_STEP, TGT_TRN_SDT, TGT_TRN_EDT, APPR_DT, SCHD_CMPLT_DT, USE_YN, REG_ID, REG_DT)
VALUES
  ('202501', '01', '99', '20250101', '20250331', '20250415', '20250430', 'Y', 'admin', SYSTIMESTAMP);
INSERT INTO SRBA_SCHD
  (BAS_YYMM, VALT_TRN, ING_STEP, TGT_TRN_SDT, TGT_TRN_EDT, APPR_DT, SCHD_CMPLT_DT, USE_YN, REG_ID, REG_DT)
VALUES
  ('202502', '01', '20', '20250401', '20250630', NULL, NULL, 'Y', 'admin', SYSTIMESTAMP);
INSERT INTO SRBA_SCHD
  (BAS_YYMM, VALT_TRN, ING_STEP, TGT_TRN_SDT, TGT_TRN_EDT, USE_YN, REG_ID, REG_DT)
VALUES
  ('202503', '01', '00', '20250701', '20250930', 'Y', 'admin', SYSTIMESTAMP);

-- ============================================================
-- RA_RESULT: RA Results
-- RA_ID is GENERATED ALWAYS AS IDENTITY - omitted from INSERT
-- ============================================================
INSERT INTO RA_RESULT (RNMCNO, EVAL_DT, RA_GRD, RA_SCR, EDD_F, NEXT_EVAL_DT, REG_ID)
  VALUES ('8001011234567', '20250101', 'M', 45.50, 'N', '20260101', 'admin');
INSERT INTO RA_RESULT (RNMCNO, EVAL_DT, RA_GRD, RA_SCR, EDD_F, NEXT_EVAL_DT, REG_ID)
  VALUES ('6509201122334', '20250115', 'H', 78.30, 'Y', '20251015', 'admin');
INSERT INTO RA_RESULT (RNMCNO, EVAL_DT, RA_GRD, RA_SCR, EDD_F, NEXT_EVAL_DT, REG_ID)
  VALUES ('7512155678901', '20250101', 'L', 25.00, 'N', '20270101', 'admin');
INSERT INTO RA_RESULT (RNMCNO, EVAL_DT, RA_GRD, RA_SCR, EDD_F, NEXT_EVAL_DT, REG_ID)
  VALUES ('7809201357901', '20250101', 'H', 82.00, 'Y', '20260101', 'admin');

-- ============================================================
-- TMS_STATS_DAILY: Daily Statistics
-- ============================================================
INSERT INTO TMS_STATS_DAILY VALUES ('20250101', 12, 3, 5, 4, 2, 1, 3, 45000000);
INSERT INTO TMS_STATS_DAILY VALUES ('20250102',  8, 2, 3, 3, 1, 2, 2, 28000000);
INSERT INTO TMS_STATS_DAILY VALUES ('20250103', 15, 5, 6, 4, 3, 1, 4, 67000000);
INSERT INTO TMS_STATS_DAILY VALUES ('20250106', 10, 4, 4, 2, 2, 0, 2, 38000000);
INSERT INTO TMS_STATS_DAILY VALUES ('20250107',  7, 2, 2, 3, 1, 1, 1, 22000000);

-- ============================================================
-- NIC70B: Today's (20260308) party records
-- ============================================================
INSERT INTO NIC70B VALUES ('20260308', '8001011234567', 'Kim Cheolsu',  '1', '1');
INSERT INTO NIC70B VALUES ('20260308', '6509201122334', 'Park Jisu',    '1', '1');
INSERT INTO NIC70B VALUES ('20260308', '1234567890',    'ABC Corp',     '2', '2');
INSERT INTO NIC70B VALUES ('20260308', '7809201357901', 'ZHANG WEI',   '1', '1');
INSERT INTO NIC70B VALUES ('20260308', '7512155678901', 'Lee Younghee', '1', '1');
INSERT INTO NIC70B VALUES ('20260308', '9876543210',    'XYZ Trade',    '2', '2');
INSERT INTO NIC70B VALUES ('20260308', '7205141234567', 'IVAN PETROV',  '1', '1');

-- NIC78B: Party detail for today
INSERT INTO NIC78B VALUES ('20260308', '8001011234567', '19800101', 'M', 'TECH', '123 Seoul St',       '010-1234-5678', 'Tech Corp',        NULL);
INSERT INTO NIC78B VALUES ('20260308', '6509201122334', '19650920', 'M', 'MGMT', '456 Busan Ave',      '010-9876-5432', 'Park Group',       NULL);
INSERT INTO NIC78B VALUES ('20260308', '7809201357901', '19780920', 'M', 'TRAD', '789 Incheon Rd',     '010-5555-1234', 'Zhangwei Trading', NULL);
INSERT INTO NIC78B VALUES ('20260308', '7512155678901', '19751215', 'F', 'SERY', '321 Daejeon Blvd',   '010-3333-7777', 'Lee Financial',    NULL);

-- ============================================================
-- NIC66B: Today's (20260308) STR cases
-- ============================================================
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20260308', 'STR20260308001', 'STR001', 'STR', '9',  '8001011234567', 75.0, 'H', '0', 82.0, 'analyst1');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20260308', 'STR20260308002', 'STR002', 'STR', '97', '6509201122334', 89.5, 'H', '1', 93.0, 'analyst2');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID, INST_ID)
  VALUES ('20260308', 'STR20260308003', 'STR003', 'STR', '98', '7809201357901', 91.0, 'H', '1', 95.0, 'analyst1', 'STR202603080001');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID, FIU_RPT_NO, FIU_RPT_DT)
  VALUES ('20260308', 'STR20260308004', 'STR004', 'STR', '10', '7512155678901', 88.0, 'H', '1', 90.5, 'analyst2', 'FIU2026030800001', '20260308');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20260308', 'STR20260308005', 'STR002', 'STR', '9',  '7205141234567', 92.0, 'H', '0', 96.0, 'analyst1');

-- NIC66B: Today's (20260308) CTR cases
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20260308', 'CTR20260308001', 'CTR001', 'CTR', '9',  '1234567890',   62.0, 'M', '0', 71.0, 'analyst1');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID, FIU_RPT_NO, FIU_RPT_DT)
  VALUES ('20260308', 'CTR20260308002', 'CTR002', 'CTR', '10', '9876543210',   35.0, 'L', '1', 45.0, 'analyst2', 'FIU2026030800002', '20260308');
INSERT INTO NIC66B (SSPS_DL_CRT_DT, SSPS_DL_ID, SSPS_TYP_CD, SSPS_DL_CRT_CCD, RPR_PRGRS_CCD, DL_P_RNMCNO, RSK_MRK, RSK_GRD_CD, OK_CCD, SCNR_MRK, REG_ID)
  VALUES ('20260308', 'CTR20260308003', 'CTR001', 'CTR', '9',  '8001011234567', 70.0, 'M', '0', 75.0, 'analyst1');

-- ============================================================
-- NIC73B: Transactions for today's cases
-- ============================================================
-- STR001: 2 transactions
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308001', 1, 'BR001', 'Seoul Branch',   '20260307', '143022', 12000000, 'W', 'KRW', 'Unknown Counterparty', 'BRANCH');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308001', 2, 'BR001', 'Seoul Branch',   '20260308', '091530',  9500000, 'W', 'KRW', 'Unknown Counterparty', 'BRANCH');
-- STR002: 3 transactions (structuring pattern)
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308002', 1, 'BR002', 'Gangnam Branch', '20260306', '101500',  9800000, 'W', 'KRW', 'Shell Corp A', 'BRANCH');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308002', 2, 'BR002', 'Gangnam Branch', '20260307', '133000',  9700000, 'W', 'KRW', 'Shell Corp A', 'BRANCH');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308002', 3, 'BR002', 'Gangnam Branch', '20260308', '085800',  9600000, 'W', 'KRW', 'Shell Corp A', 'BRANCH');
-- STR003: 2 transactions
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308003', 1, 'BR003', 'Gangbuk Branch', '20260307', '164500', 45000000, 'T', 'KRW', 'Overseas Wire', 'BRANCH');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308003', 2, 'BR003', 'Gangbuk Branch', '20260308', '102200', 30000000, 'T', 'KRW', 'Overseas Wire', 'BRANCH');
-- STR004: 2 transactions (FIU submitted)
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308004', 1, 'BR004', 'Seocho Branch',  '20260305', '091000', 18000000, 'W', 'KRW', 'Anon Account', 'ONLINE');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308004', 2, 'BR004', 'Seocho Branch',  '20260306', '153000', 17500000, 'W', 'KRW', 'Anon Account', 'ONLINE');
-- STR005: 2 transactions
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308005', 1, 'BR005', 'Mapo Branch',    '20260308', '080000', 25000000, 'W', 'KRW', 'Sanctioned Entity', 'BRANCH');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'STR20260308005', 2, 'BR005', 'Mapo Branch',    '20260308', '110000', 22000000, 'W', 'KRW', 'Sanctioned Entity', 'BRANCH');
-- CTR001: 2 transactions
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'CTR20260308001', 1, 'BR001', 'Seoul Branch',   '20260308', '092000', 10500000, 'W', 'KRW', NULL, 'BRANCH');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'CTR20260308001', 2, 'BR001', 'Seoul Branch',   '20260308', '144500', 11000000, 'W', 'KRW', NULL, 'BRANCH');
-- CTR002: 1 transaction (FIU submitted)
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'CTR20260308002', 1, 'BR002', 'Gangnam Branch', '20260308', '111500', 13000000, 'W', 'KRW', NULL, 'BRANCH');
-- CTR003: 2 transactions
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'CTR20260308003', 1, 'BR001', 'Seoul Branch',   '20260308', '095500', 15000000, 'W', 'KRW', NULL, 'BRANCH');
INSERT INTO NIC73B (SSPS_DL_CRT_DT, SSPS_DL_ID, SEQ_NO, MN_DL_BRN_CD, MN_DL_BRN_NM, DL_DT, DL_TM, DL_AMT, DL_TYP_CCD, DL_CCY, CNTRP_NM, CHNL_CCD)
  VALUES ('20260308', 'CTR20260308003', 2, 'BR001', 'Seoul Branch',   '20260308', '153000', 10200000, 'W', 'KRW', NULL, 'BRANCH');

-- ============================================================
-- NIC75B: Account amounts for today's cases
-- ============================================================
INSERT INTO NIC75B VALUES ('20260308', 'STR20260308001', '1001-001-123456', 21500000, 'KRW');
INSERT INTO NIC75B VALUES ('20260308', 'STR20260308002', '1001-003-345678', 29100000, 'KRW');
INSERT INTO NIC75B VALUES ('20260308', 'STR20260308003', '1001-004-456789', 75000000, 'KRW');
INSERT INTO NIC75B VALUES ('20260308', 'STR20260308004', '1001-002-234567', 35500000, 'KRW');
INSERT INTO NIC75B VALUES ('20260308', 'STR20260308005', '1001-005-567890', 47000000, 'KRW');
INSERT INTO NIC75B VALUES ('20260308', 'CTR20260308001', '2002-001-456789', 21500000, 'KRW');
INSERT INTO NIC75B VALUES ('20260308', 'CTR20260308002', '2002-002-567890', 13000000, 'KRW');
INSERT INTO NIC75B VALUES ('20260308', 'CTR20260308003', '1001-001-123456', 25200000, 'KRW');

-- ============================================================
-- NIC67B: STR reports for today's cases
-- ============================================================
INSERT INTO NIC67B (SSPS_DL_CRT_DT, SSPS_DL_ID, RPR_RSN_CNTNT, ITEM_CNTNT1, ITEM_CNTNT2, ITEM_CNTNT3, DOBT_DL_GRD_CD, REG_ID)
  VALUES ('20260308', 'STR20260308002',
          'Structuring pattern detected: three deposits of approx 9.8M KRW each within 3 days, all below 10M reporting threshold.',
          'Customer conducted 3 cash deposits within 72 hours',
          'Each transaction below 10M CTR threshold: 9.8M, 9.7M, 9.6M KRW',
          'Pattern consistent with smurfing/structuring to avoid reporting obligations',
          'H', 'analyst2');
INSERT INTO NIC67B (SSPS_DL_CRT_DT, SSPS_DL_ID, RPR_RSN_CNTNT, ITEM_CNTNT1, ITEM_CNTNT2, ITEM_CNTNT3, ITEM_CNTNT4, DOBT_DL_GRD_CD, REG_ID)
  VALUES ('20260308', 'STR20260308003',
          'OFAC/UN sanctioned individual (ZHANG WEI) conducted large cross-border wire transfers totaling 75M KRW.',
          'Customer is on OFAC and UN sanction lists since 2020',
          'Two large international wire transfers: 45M and 30M KRW',
          'Counterparty is unidentified overseas entity',
          'No legitimate business purpose established for transfers',
          'H', 'analyst1');
INSERT INTO NIC67B (SSPS_DL_CRT_DT, SSPS_DL_ID, RPR_RSN_CNTNT, ITEM_CNTNT1, ITEM_CNTNT2, ITEM_CNTNT3, ITEM_CNTNT4, ITEM_CNTNT5, DOBT_DL_GRD_CD, REG_ID)
  VALUES ('20260308', 'STR20260308004',
          'Dormant account reactivated with large deposits. PEP customer with no documented source of funds.',
          'Account dormant for 18 months, reactivated 20260305',
          'Two large cash deposits within 2 days: 18M and 17.5M KRW',
          'Customer is classified as PEP (Politically Exposed Person)',
          'No supporting documentation for source of funds',
          'Deposits withdrawn same day via online channel',
          'H', 'analyst2');

-- ============================================================
-- AML_APPR: Approval records for today's STR cases
-- ============================================================
INSERT INTO AML_APPR (APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD, APPR_ROLE_ID, TARGET_ROLE_ID, RSN_CNTNT, HNDL_DY_TM, HNDL_P_ENO, REG_DT)
  VALUES ('STR202603080001', 'TMS1', 1, '20260308', 1, 'E', 'ANALYST', 'MANAGER',
          'Approved: ZHANG WEI confirmed on OFAC list. STR warranted.',
          SYSTIMESTAMP, 'manager1', SYSTIMESTAMP);
INSERT INTO AML_APPR (APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD, APPR_ROLE_ID, TARGET_ROLE_ID, RSN_CNTNT, HNDL_DY_TM, HNDL_P_ENO, REG_DT)
  VALUES ('STR202603080002', 'TMS1', 1, '20260308', 1, 'N', 'ANALYST', 'MANAGER',
          'Structuring pattern STR submitted for manager review.',
          SYSTIMESTAMP, 'analyst2', SYSTIMESTAMP);

-- AML_APPR_HIST: Approval history
INSERT INTO AML_APPR_HIST (APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD, APPR_ROLE_ID, RSN_CNTNT, HNDL_DY_TM, HNDL_P_ENO)
  VALUES ('STR202603080001', 'TMS1', 1, '20260308', 1, 'N', 'ANALYST',
          'STR report submitted for approval. Sanctions match confirmed.',
          SYSTIMESTAMP, 'analyst1');
INSERT INTO AML_APPR_HIST (APP_NO, GYLJ_LINE_G_C, NUM_SQ, APP_DT, SNO, SN_CCD, APPR_ROLE_ID, RSN_CNTNT, HNDL_DY_TM, HNDL_P_ENO)
  VALUES ('STR202603080001', 'TMS1', 2, '20260308', 2, 'E', 'MANAGER',
          'Approved: Verified OFAC match. Proceeding with FIU submission.',
          SYSTIMESTAMP, 'manager1');

-- TMS_SET_VAL_APP: Approval requests for today's cases
INSERT INTO TMS_SET_VAL_APP VALUES ('STR202603080001', 'STR003', 'E', '20260308', 'analyst1', SYSTIMESTAMP);
INSERT INTO TMS_SET_VAL_APP VALUES ('STR202603080002', 'STR002', 'N', '20260308', 'analyst2', SYSTIMESTAMP);
