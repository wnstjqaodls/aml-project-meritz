# AML Project — Meritz Securities

메리츠증권 AML(자금세탁방지) 시스템 **AMLXpress 7.0** 리버스 엔지니어링 및 재구현 프로젝트.

## 개요

gtone의 AMLXpress 7.0을 분석하여 현대적인 기술 스택으로 재구현.
레거시 Spring MVC + JSP 구조를 Vue 3 + Spring Boot 3 구조로 마이그레이션.

## 기술 스택

| 영역 | 기술 |
|------|------|
| Backend | Spring Boot 3.2.3, Java 17, MyBatis, Lombok |
| Frontend | Vue 3, Vue Router, DevExtreme 24.1, Vite 5 |
| DB | Oracle 23c Free (Docker), H2 (로컬 테스트) |
| 인프라 | Docker Compose |

## 주요 기능 모듈

- **TMS** — 이상거래감시 (STR 혐의거래보고, CTR 고액현금거래보고, 룰셋/시뮬레이션)
- **WLF** — 워치리스트 필터링 (Apache Lucene 기반, 스코어 임계치)
- **RA** — 고객위험평가
- **KYC** — 고객확인
- **RBA** — 부점위험평가 배치
- **Link 분석** — 거래관계도 시각화

## 로컬 실행

### Oracle + Backend 전체 실행

```bash
cd aml-app
docker compose --profile full up -d
```

### Oracle만 실행 (프론트 개발 시)

```bash
docker compose up oracle -d
# 최초 기동 1~2분 소요 (healthcheck 대기)
```

### 접속 정보

| 항목 | 값 |
|------|-----|
| Oracle JDBC | `jdbc:oracle:thin:@localhost:1521/FREEPDB1` |
| DB User | `jbbank` / `jbbank` |
| Backend | `http://localhost:8080` |
| Frontend | `http://localhost:5173` (vite dev) |

### Frontend 개발 서버

```bash
cd aml-app/frontend
npm install
npm run dev
```

## 프로젝트 구조

```
aml-project-meritz/
├── aml-app/
│   ├── backend/          # Spring Boot (Java 17, MyBatis)
│   ├── frontend/         # Vue 3 + DevExtreme
│   └── docker-compose.yml
├── AML_PROJECT_ANALYSIS.md   # 시스템 분석 문서
└── 00_프로젝트_종합지식베이스.md
```

## 참고

- 원본 시스템: gtone AMLXpress 7.0
- DB 스키마 네이밍: `NIC**B` 테이블 규칙 (NIC01B 고객, NIC17B 계좌 등)
- MyBatis Mapper Namespace: `AML_00` ~ `AML_90` 모듈별 분리
