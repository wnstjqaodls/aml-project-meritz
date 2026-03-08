# AML Project Photo Analysis
**Source:** N:\개인\아이폰13pro_23.01~26.01\ → D:\dev\workspace\aml-project-meritz\photos\raw\
**Total Photos:** 117 JPG/PNG + 2 HEIC (unreadable)
**AML-Related Found:** 19 (confirmed + likely)
**Analysis Date:** 2026-03-08

---

## 1. Key System Intelligence Summary

### Production System
| Item | Value |
|------|-------|
| System Name | AMLXpress7 / RBAXpress V7 |
| Vendor | GTONE (gtone.co.kr) |
| Client | Meritz Securities (메리츠증권) |
| Production URL | `aml.lmeritz.com/indexSso2.jsp` |
| Admin Console | `172.17.172.243:7700/lena/server/serverMain` |
| Admin URL (License) | `172.17.172.243:7700/lena/admin/user/adminMain` |

### Dev Server (daaml11)
| Item | Value |
|------|-------|
| Hostname | daaml11 |
| IP Address | **172.17.172.243** |
| OS | RHEL 9 (kernel 5.14.0-570.17.1-el9-6-x86_64, amd64) |
| Java | OpenJDK 1.8.0_452 (Red Hat, Inc.) |
| Timezone | Asia/Seoul |
| App Base Path | `/mtsw/lenawax/1.3/servers/RBA` |
| JSP Port | 7501 (`/index5so2.jsp`, `/sao/request_service.jsp`) |
| LENA Port | 7700 |
| SVN Version | subversion 1.14.1-5.e19_0 (x86_64) |

### Server Nodes (LENA Dashboard)
| Node Name | Type | Status |
|-----------|------|--------|
| daaml111_was | Web Application Server (Backend) | Active |
| daaml111_web | Web Frontend Server | Active |
| RBA | Risk-Based Analysis server | Running |
| RBA_SE | RBA Secondary/Extended | Running |
| test_8000 | Test instance | Running |

### Trial License
| Item | Value |
|------|-------|
| License Type | Trial System (UNLIMITED cores/instances) |
| Period | 2025-11-04 ~ **2026-01-04** (EXPIRED as of analysis date) |
| Nodes | daam111_web, daam111_was |
| Covered Modules | WLF, RBA, 열람권 라이센스 |

### Additional IPs Found
| IP | Context |
|----|---------|
| 172.17.118.171 | Meritz 자금세탁 시스템 DB admin interface |
| 172.17.172.243 | Dev/staging AML WAS server (daaml11) |

### Authentication
| Item | Value |
|------|-------|
| OTP System | HIWARE MOBILEQTP (하이웨어 모바일 OTP) |
| Site ID | HIWOTP |
| Secret Key #1 (P20251020) | ZARYGAAD2KJ6NH76 |
| Secret Key #2 (P20251029) | PIYY6AAG56I6X4MY |
| Registration | QR Code or manual entry |
| External Security Portal | `https://security.meritz.com:8443/svc/req/outsider-in` |

---

## 2. System Architecture (from P20251020_173448481)

Architecture diagram photo shows full AML/RBAXpress V7 design:

```
Data Sources
    ↓
KYC (Know Your Customer)
    ↓
CDD / EDD (Customer/Enhanced Due Diligence)
    ↓
WL (Watchlist / 화이트리스트) ←→ Watchlist Data Management
    ↓
TMS (Transaction Management System)
    ↓
RBA (Risk-Based Approach / Authentication)
    ↓
자금세탁방지 솔루션 (AML Solution Engine)
    ↓
STR / CTR 구축 (Suspicious Transaction / Currency Transaction Reports)
    ↓
보고시스템 (Reporting System)
```

**All confirmed modules visible in navigation menu (aml.lmeritz.com):**
- STR | CTR | KYC (top tabs)
- RBA, KYC, Scoring, ALERT 관리, CASE Management, REPORT, AML 관리 (left nav)

---

## 3. AML-Related Photos — Detailed

### P20251020_173448481 ⭐ CRITICAL
**Type:** System Architecture Diagram
**Date:** 2025-10-20 17:34
**Content:** AML/RBAXpress V7 구성도 — full component diagram, GTONE vendor, Meritz Securities client, all module relationships visible
**Value:** Complete system design reference

---

### P20251020_133511329
**Type:** Meritz Securities Security Portal Sign
**Date:** 2025-10-20 13:35
**Content:** Meritz Securities (메리츠증권) building/system sign. URL: `https://security.meritz.com:8443/svc/req/outsider-in`
**Value:** External security portal URL (outsider access endpoint)

---

### P20251020_175311737 ⚠️ CREDENTIALS
**Type:** OTP Authentication Setup Document
**Date:** 2025-10-20 17:53
**Content:** HIWARE MOBILEQTP setup, Site ID: HIWOTP, Secret Key: **ZARYGAAD2KJ6NH76**, QR code and manual registration methods
**Value:** Admin authentication credentials (OTP seed)

---

### P20251028_174830761
**Type:** Windows Task Manager (Dev Machine)
**Date:** 2025-10-28 17:48
**Content:** Intel i3-5005U @ 2.00GHz, 27GB RAM (14GB used = 52%), 93 processes, 1,235 threads, SSD
**Value:** Dev workstation specs for AML development

---

### P20251103_151312718
**Type:** PowerPoint Presentation
**Date:** 2025-11-03 15:13
**Content:** "Digital 기반 AML 내부통제 관리체계 고도화 프로젝트" — Shinhan Bank header. Word docs (2023-06, 2023-09) visible in background File Explorer
**Value:** AML project scope reference (Shinhan Bank comparison/template)

---

### P20251104_103608628 (Likely)
**Type:** Spreadsheet
**Date:** 2025-11-04 10:36
**Content:** Multi-column tabular data, date "2025.11.4. 목요일" visible, structured monitoring data
**Value:** Possible transaction monitoring or RA data

---

### P20251104_190814626 (Possible)
**Type:** Monitor with SQL Code
**Date:** 2025-11-04 19:08
**Content:** SQL table/index creation statements, `TABLESPACE ARDYA_TS0`, Oracle DDL syntax, Korean UI on right panel
**Value:** DB schema reference (possibly AML schema)

---

### P20251105_104530000
**Type:** IFC Seoul Visitor Registration
**Date:** 2025-11-05 10:45
**Content:** Visitor log — Meritz Securities Compliance dept, visitor: 김준설 (Kim Junseol), host: 성기영 (Seong Ki Yeong)
**Value:** Personnel/org reference (Compliance dept contact)

---

### P20251111_151642306 ⭐ CRITICAL
**Type:** AMLXpress System UI Screenshot
**Date:** 2025-11-11 15:16
**Content:**
- URL: `aml.lmeritz.com/indexSso2.jsp`
- System: AMLXpress for Anti-Money Laundering (Meritz)
- Left nav: RBA, KYC, Scoring, ALERT 관리, CASE Management, REPORT, AML 관리
- Top tabs: STR | CTR | KYC
- Main content: WatchList update history (serial 10~22, dates 20190401~20200102)
- Section: 공시사항 (Disclosure/Notice board)

**Value:** Production UI layout, navigation structure, WatchList module data format

---

### P20251111_174339581 ⭐ INFRASTRUCTURE
**Type:** SSH Terminal Session
**Date:** 2025-11-11 09:37 KST
**Content:**
```
Hostname: daaml11
IP: 172.17.172.243
Command: yum info subversion
Output: subversion-1.14.1-5.e19_0.x86_64
        Repository: appstream
        Last metadata expiration: 1:23:23 ago
        Timestamp: Tue 11 Nov 2025 09:37:19 AM KST
```
**Value:** Dev server hostname, IP, OS type (RHEL 9), SVN version

---

### P20251119_093450890 ⭐ INFRASTRUCTURE
**Type:** DB Admin Interface
**Date:** 2025-11-19 09:34
**Content:**
- System: Meritz 자금세탁 시스템 (Anti-Money Laundering System)
- UI: Database treeview/administration console
- Error: MaxClient error code **0114563490**
- Server IP: **172.17.118.171**

**Value:** DB admin server IP, error code for connection troubleshooting

---

### P20251119_094253072 (Likely)
**Type:** Structured Data Table
**Date:** 2025-11-19 09:42
**Content:** Rotated document photo, tabular format, "Mind" brand reference, Korean column headers
**Value:** Possible AML monitoring/reporting table

---

### P20251125_140041963 ⭐ SOURCE
**Type:** IDE Project File Tree
**Date:** 2025-11-25 14:00
**Content:**
- IDE: VS Code or similar
- Directory structure: STR1/, STR2/, STR3/ subdirectories
- File types: .sql, .xml configuration files
- System: STR module development environment

**Value:** STR module directory structure, confirms SQL+XML config architecture

---

### P20251127_153830775 ⭐ INFRASTRUCTURE
**Type:** LENA Admin Dashboard
**Date:** 2025-11-27 15:38
**Content:**
- URL: `172.17.172.243:7700/lena/server/server/serverMain`
- Browser tabs: "LENA-SSO(DEV)Servers", "LENA-AMLDevServers", "AMLXpress"
- Left panel: AML folder → daaml11_was, daaml11_web
- Server list: RBA, RBA_SE, test_8000 (all on 172.17.172.243)
- Environment: DEV

**Value:** Full server topology, LENA admin URLs, server naming convention

---

### P20251201_092735697
**Type:** LENA System Login Screen
**Date:** 2025-12-01 09:27
**Content:** LENA login page, "Enter User Id" / "Enter Password" fields, Red "Login" button
**Value:** Confirms LENA admin portal login UI

---

### P20251202_131858169 ⭐ INFRASTRUCTURE
**Type:** LENA Server Properties Panel
**Date:** 2025-12-02 13:18
**Content:**
```
Browser tab: http://AMLXpress
Server: RBA
catalina.base: /mtsw/lenawax/1.3/servers/RBA
catalina.home: (Tomcat)
java.version: 1.8.0_452
java.vendor: Red Hat, Inc.
os.name: Linux
os.version: 5.14.0-570.17.1-el9-6-x86_64
os.arch: amd64
user.timezone: Asia/Seoul
user.language: en
```
**Value:** Definitive server environment details (Java, OS, paths)

---

### P20251217_142102987 ⭐ SOURCE
**Type:** Code Editor — JSP Code
**Date:** 2025-12-17 14:21
**Content:**
- Browser tab: "daam11 [172.17.172.243]"
- Server: 172.17.172.243:**7501**
- File: `index5so2.jsp` (main entry)
- Form name: `emlfirm`
- Target: `/sao/request_service.jsp` (SAO module)
- Encoding: **EUC-KR**
- DOCTYPE: HTML 4.01 Transitional
- RequestDispatcher: forward to /sao/request_service.jsp

**Value:** JSP entry point filename, SAO module path, form name, character encoding

---

### P20251217_142410036 ⭐ SOURCE
**Type:** Code Editor — Java Session Code
**Date:** 2025-12-17 14:24
**Content:**
- Same server tab: "daam11 [172.17.172.243]"
- Code: `request.getSession()`, `getAttribute("USER_ID")`, `setAttribute()`
- Pattern: Session-based user authentication
- `System.out.println()` for server-side logging
- Request dispatcher forwarding

**Value:** Session attribute key name ("USER_ID"), auth pattern

---

### P20260106_112423688 ⭐ CRITICAL
**Type:** AMLXpress7 Admin Dashboard
**Date:** 2026-01-06 11:24
**Content:**
- URL: `172.17.172.243:7700/lena/server/serverMain`
- System: AMLXpress7 (메리츠증권)
- WAS List showing RBA server (Active, EN-9 engine, HTTP port 7700)
- **License expiration alert:** "License will be expired in a few days. The server will be stopped."
- Browser tabs: "AMLXpress", "인사정성 관리", "AML 운영(TQ-BD)", "AML 자부(TQ-BD)", "메리츠증권", "Welcome to HIWARE", "LENA-AML(DEY) 로...", "ASIS 타도중(Admin...)"
- Nav tabs: DASHBOARD, SERVER, CLUSTER, RESOURCE, DIAGNOSTICS, TOPOLOGY, ADMIN
- Left panel: AML → daam111_was, RBA, daam111_web

**Value:** Full admin UI structure, browser tab inventory showing integrated systems, license status

---

### P20260106_133016247 ⭐ CRITICAL
**Type:** AMLXpress7 Trial License Management
**Date:** 2026-01-06 13:30
**Content:**
- URL: `172.17.172.243:7700/lena/admin/user/adminMain`
- License Type: Trial System
- **Node 1: daam111_web** — 2025/11/04 ~ 2026/01/04, UNLIMITED cores/instances, Standalone
- **Node 2: daam111_was** — 2025/11/04 ~ 2026/01/04, UNLIMITED cores/instances, Standalone
- License scope: WLF/RBA 열람권
- Admin buttons: 시스템정보 확인, 설정내용 확인, 시간정보 확인, 업로드

**Value:** Exact license dates, node names, covered module list, admin action endpoints

---

## 4. Integrated System Findings for RE

### LENA Platform
LENA = 미들웨어 관리 플랫폼 (LG CNS product)
- LG CNS contacts visible: Sangyeon Hwang, KwangWoon Hwang (Solution Development x2 Team)
- Manages Tomcat WAS instances (daaml111_was, daaml111_web)
- Admin at `172.17.172.243:7700/lena/`
- LENA-SSO integration

### Integrated Systems (from browser tabs in P20260106_112423688)
| System | Context |
|--------|---------|
| AMLXpress | Core AML (multiple tabs) |
| HIWARE | OTP/SSO system (admin auth) |
| ASIS | Role/access management ("Admin") |
| 인사정성 관리 | HR/Personnel Management |
| AML 운영(TQ-BD) | AML Operations board |
| AML 자부(TQ-BD) | AML (자금부?) board |
| LENA-AML(DEY) | LENA AML dev environment |

### JSP Entry Flow (reconstructed)
```
Browser → aml.lmeritz.com/indexSso2.jsp
       → LENA SSO authentication (HIWARE OTP)
       → 172.17.172.243:7501/index5so2.jsp (internal)
       → form[emlfirm] POST → /sao/request_service.jsp
       → session[USER_ID] lookup → module routing
```

---

## 5. Non-AML Photos Summary

| Category | Count | Date Range |
|----------|-------|------------|
| Personal/social events | ~30 | Oct 2025 – Feb 2026 |
| Brazilian Jiu Jitsu (BJJ) training | ~8 | Dec 2025 |
| Home lab / computer hardware build | ~12 | Dec 2025 – Jan 2026 |
| Pet (dog) photos | 3 | Oct 2025 |
| Food / restaurant | ~5 | Various |
| Shopping apps / e-commerce | 2 | Dec 2025 |
| Personal devices (laptop, OTP, router) | ~8 | Nov 2025 |
| Outdoor / travel | ~6 | Jan – Feb 2026 |
| Windows BSOD | 1 | Dec 2025 |
| GPU/hardware unboxing (ASUS RX 9070 X) | 1 | Jan 2026 |

---

## 6. HEIC Files (Unanalyzed)
- `P20260113_091700514_*.HEIC` — iPhone HEIC format, cannot be read by tools
- `P20260113_132435288_*.HEIC` — iPhone HEIC format, cannot be read by tools

These are from 2026-01-13. Content unknown. May require conversion: `magick convert file.heic file.jpg`
