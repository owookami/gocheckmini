# 건축인허가 주차장 조회 앱 PRD
**Product Requirements Document for Cursor AI Task Master MCP**

---

## 📋 프로젝트 개요

### 제품명
**ParkingFinder** (건축인허가 주차장 조회 앱)

### 프로젝트 목표
공공데이터 포털의 건축HUB API를 활용하여 사용자가 지역별 주차장 정보를 손쉽게 조회할 수 있는 Flutter 모바일 앱 개발

### 핵심 가치 제안
- 복잡한 공공데이터를 직관적인 카드 UI로 제공
- 오프라인에서도 지역 선택 가능 (로컬 DB 활용)
- 건축업무 종사자 및 일반 사용자를 위한 편의성 극대화

---

## 🎯 성공 지표 및 목표

### 기능적 목표
- [ ] 2개 API 엔드포인트 완전 연동 (`getApPklotInfo`, `getApAtchPklotInfo`)
- [ ] 전국 시도/시군구/동 단위 지역 검색 100% 지원
- [ ] 검색 결과 카드 UI 렌더링 성능 최적화
- [ ] 오프라인 지역 데이터 조회 기능

### 기술적 목표
- [ ] Flutter 3.x 기반 크로스플랫폼 앱
- [ ] 깔끔한 아키텍처 (Clean Architecture + MVVM)
- [ ] 90% 이상 코드 커버리지
- [ ] Android/iOS 모두 정상 빌드 및 실행

---

## 👥 타겟 사용자

### Primary Users
1. **건축인허가 업무 담당자**
   - 허가 관련 주차장 정보 신속 조회 필요
   - 정확하고 최신 데이터 요구

2. **부동산/건설업 종사자**
   - 개발 전 주차장 현황 파악
   - 지역별 주차 인프라 분석

### Secondary Users
3. **일반 시민**
   - 거주지 주변 주차장 정보 관심
   - 간편한 검색 인터페이스 선호

---

## 🔧 기능 요구사항

### Core Features

#### 1. 메인 화면 (Home Screen)
**Task**: `TASK-001-HOME-SCREEN`
```yaml
Description: 메인 화면 UI 구현
Acceptance Criteria:
  - AppBar with title "ParkingFinder"
  - 2개 가로 버튼 (주차장조회/부설주차장조회)
  - 3단계 지역 선택 드롭다운 (시도→시군구→동)
  - 검색 실행 버튼
  - 선택 상태 시각적 피드백
Components:
  - widgets/main_menu_buttons.dart
  - widgets/region_selector.dart
  - screens/home_screen.dart
```

#### 2. 지역 선택 시스템
**Task**: `TASK-002-REGION-SELECTION`
```yaml
Description: 계층적 지역 선택 기능
Acceptance Criteria:
  - 시도 선택 시 시군구 목록 동적 업데이트
  - 시군구 선택 시 동/읍/면 목록 동적 업데이트
  - 선택 초기화 기능
  - 유효성 검증 (모든 단계 선택 필수)
Data Source: 
  - SQLite DB (regions.db)
  - 첨부 시군구코드 목록 기반
```

#### 3. API 연동 모듈
**Task**: `TASK-003-API-INTEGRATION`
```yaml
Description: 건축HUB API 연동
Endpoints:
  - getApPklotInfo (주차장 조회)
  - getApAtchPklotInfo (부설주차장 조회)
Requirements:
  - HTTP client (dio package)
  - Error handling & retry logic
  - Loading states management
  - API response parsing to Dart models
Environment Variables:
  - API_BASE_URL=https://apis.data.go.kr/1613000/ArchPmsHubService
  - API_KEY=[사용자가 발급받은 인증키]
```

#### 4. 검색 결과 화면
**Task**: `TASK-004-RESULTS-SCREEN`
```yaml
Description: 검색 결과 카드 리스트 화면
Acceptance Criteria:
  - ListView.builder로 ParkingLotCard 렌더링
  - 각 카드에 주차장명, 주소, 허가번호, 등록일 표시
  - 빈 결과 상태 처리
  - Pull-to-refresh 기능
  - 페이징 지원 (무한스크롤 또는 더보기 버튼)
Card Design:
  - Material Card with shadow
  - 8dp rounded corners
  - Hierarchical typography (16sp/14sp/12sp)
```

#### 5. 로컬 데이터베이스
**Task**: `TASK-005-LOCAL-DATABASE`
```yaml
Description: SQLite 지역 데이터 관리
Tables:
  - provinces (id, name, code)
  - sigungus (id, province_code, name, code)
  - bjdongs (id, sigungu_code, name, code, bun, ji)
Features:
  - 앱 첫 실행 시 초기 데이터 적재
  - Migration 지원
  - CRUD operations
Package: sqflite
```

### Advanced Features

#### 6. 상태 관리 (Riverpod)
**Task**: `TASK-006-STATE-MANAGEMENT`
```yaml
Description: Riverpod을 활용한 전역 상태 관리
Providers:
  - selectedMenuProvider (StateProvider<ApiMenu>)
  - selectedRegionProvider (StateProvider<Region?>)
  - selectedSigunguProvider (StateProvider<Sigungu?>)
  - selectedBjdongProvider (StateProvider<Bjdong?>)
  - parkingResultsProvider (FutureProvider<List<ParkingLot>>)
  - regionDataProvider (FutureProvider<RegionData>)
```

#### 7. 라우팅 (GoRouter)
**Task**: `TASK-007-ROUTING`
```yaml
Description: 화면 간 네비게이션 구현
Routes:
  - / (HomeScreen)
  - /results (ResultsScreen)
  - /error (ErrorScreen)
Features:
  - Type-safe routing
  - Deep linking support
  - Route parameters validation
```

---

## 🏗 기술 요구사항

### 기술 스택
```yaml
Framework: Flutter 3.16+
Language: Dart 3.2+
State Management: Riverpod 2.4+
Routing: GoRouter 12.0+
HTTP Client: dio 5.3+
Local Database: sqflite 2.3+
Environment Variables: flutter_dotenv 5.1+
```

### 프로젝트 구조
```
lib/
├── main.dart
├── app/
│   ├── router.dart
│   ├── providers.dart
│   └── theme.dart
├── features/
│   └── parking/
│       ├── data/
│       │   ├── models/
│       │   │   ├── parking_lot.dart
│       │   │   ├── region.dart
│       │   │   └── api_response.dart
│       │   ├── repositories/
│       │   │   ├── parking_repository.dart
│       │   │   └── region_repository.dart
│       │   └── datasources/
│       │       ├── parking_api_client.dart
│       │       └── region_local_datasource.dart
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── screens/
│           │   ├── home_screen.dart
│           │   ├── results_screen.dart
│           │   └── error_screen.dart
│           ├── widgets/
│           │   ├── main_menu_buttons.dart
│           │   ├── region_selector.dart
│           │   ├── parking_lot_card.dart
│           │   └── loading_indicator.dart
│           └── providers/
│               └── parking_providers.dart
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   └── app_constants.dart
│   ├── utils/
│   │   ├── helpers.dart
│   │   └── validators.dart
│   └── widgets/
│       └── custom_widgets.dart
└── database/
    ├── database_helper.dart
    └── migrations/
```

### 데이터 모델
```dart
// parking_lot.dart
class ParkingLot {
  final String pklotNm;        // 주차장명
  final String ldongAdr;       // 주소
  final String hmpgPlc;        // 허가번호
  final String atchPklotGubun; // 부설주차장구분
  final String permitYMD;      // 허가일자
  final String? totalPklot;    // 총주차대수
  
  const ParkingLot({
    required this.pklotNm,
    required this.ldongAdr,
    required this.hmpgPlc,
    required this.atchPklotGubun,
    required this.permitYMD,
    this.totalPklot,
  });
  
  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      pklotNm: json['pklotNm'] ?? '',
      ldongAdr: json['ldongAdr'] ?? '',
      hmpgPlc: json['hmpgPlc'] ?? '',
      atchPklotGubun: json['atchPklotGubun'] ?? '',
      permitYMD: json['permitYMD'] ?? '',
      totalPklot: json['totalPklot'],
    );
  }
}

// region.dart
class Region {
  final String code;
  final String name;
  
  const Region({required this.code, required this.name});
}

class Bjdong extends Region {
  final String bun;
  final String ji;
  
  const Bjdong({
    required super.code,
    required super.name,
    required this.bun,
    required this.ji,
  });
}
```

---

## 📅 개발 마일스톤

### Phase 1: 프로젝트 설정 (1-2일)
**Tasks**: `TASK-001` to `TASK-003`
- [ ] Flutter 프로젝트 초기화
- [ ] 패키지 의존성 설정
- [ ] 폴더 구조 생성
- [ ] 기본 라우팅 설정
- [ ] 환경변수 설정

### Phase 2: 데이터 레이어 (2-3일)
**Tasks**: `TASK-005`, `TASK-003`
- [ ] SQLite 데이터베이스 설계 및 구현
- [ ] 시군구코드 데이터 적재
- [ ] API 클라이언트 구현
- [ ] 데이터 모델 정의
- [ ] Repository 패턴 구현

### Phase 3: 비즈니스 로직 (2-3일)
**Tasks**: `TASK-006`
- [ ] Riverpod providers 구현
- [ ] UseCase 클래스 구현
- [ ] 상태 관리 로직
- [ ] API 호출 플로우 구현

### Phase 4: UI 구현 (3-4일)
**Tasks**: `TASK-001`, `TASK-004`
- [ ] 홈 화면 UI
- [ ] 지역 선택 위젯
- [ ] 검색 결과 화면
- [ ] 카드 컴포넌트 구현
- [ ] 로딩 및 에러 상태 처리

### Phase 5: 통합 및 테스트 (2-3일)
**Tasks**: `TASK-007`
- [ ] 전체 플로우 통합 테스트
- [ ] 단위 테스트 작성
- [ ] 위젯 테스트 작성
- [ ] 성능 최적화
- [ ] 버그 수정

### Phase 6: 배포 준비 (1-2일)
- [ ] 앱 아이콘 및 스플래시 스크린
- [ ] Android/iOS 빌드 설정
- [ ] 릴리즈 빌드 최적화
- [ ] 문서화 완료

---

## ⚠️ 위험 요소 및 대응방안

### 기술적 위험
1. **API 응답 속도 이슈**
   - 대응: 로딩 인디케이터, timeout 설정, 재시도 로직
   
2. **대용량 데이터 처리**
   - 대응: 페이징, 가상화 리스트, 데이터 캐싱

3. **크로스플랫폼 호환성**
   - 대응: Platform-specific 코드 최소화, 철저한 테스트

### 비즈니스 위험
1. **API 정책 변경**
   - 대응: API 래퍼 계층 구현, 버전 관리
   
2. **인증키 관리**
   - 대응: 환경변수 활용, 키 순환 정책

---

## 🎨 UI/UX 가이드라인

### 디자인 원칙
- **단순성**: 복잡한 데이터를 직관적으로 표현
- **일관성**: Material Design 3.0 가이드라인 준수
- **접근성**: 고대비 색상, 적절한 텍스트 크기

### 색상 팔레트
```dart
// 메인 컬러
primary: Color(0xFF1976D2)        // 파란색
primaryVariant: Color(0xFF0D47A1)
secondary: Color(0xFF03DAC6)       // 청록색

// 상태 컬러
success: Color(0xFF4CAF50)         // 초록색
warning: Color(0xFFFF9800)         // 주황색  
error: Color(0xFFF44336)           // 빨간색

// 중성 컬러
surface: Color(0xFFFFFFFF)
background: Color(0xFFF5F5F5)
onSurface: Color(0xFF212121)
```

### Typography
```dart
// 제목
headline: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
// 부제목  
subtitle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
// 본문
body: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)
// 캡션
caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)
```

---

## 📊 성능 요구사항

### 응답 시간
- 앱 시작: < 3초
- API 응답: < 5초
- 화면 전환: < 500ms
- 지역 선택 업데이트: < 200ms

### 메모리 사용량
- 최대 힙 크기: < 100MB
- 이미지 캐시: < 50MB
- SQLite DB 크기: < 10MB

### 배터리 최적화
- 백그라운드 작업 최소화
- 불필요한 API 호출 방지
- 효율적인 상태 관리

---

## 🔄 향후 확장 계획

### v1.1 (추가 기능)
- [ ] 즐겨찾기 기능
- [ ] 검색 히스토리
- [ ] 오프라인 캐싱

### v1.2 (고도화)
- [ ] 지도 연동 (Google Maps)
- [ ] 주차장 상세 정보
- [ ] 사용자 리뷰 시스템

### v2.0 (확장)
- [ ] 웹 버전 개발
- [ ] 관리자 대시보드
- [ ] 실시간 데이터 동기화

---

## 📝 Cursor AI Task Master MCP 활용 가이드

이 PRD는 Cursor AI의 Task Master MCP와 함께 사용하도록 설계되었습니다.

### 권장 워크플로우
1. **Task 단위 개발**: 각 `TASK-XXX`를 MCP 작업으로 등록
2. **순차적 진행**: Phase별로 단계적 개발
3. **자동 코드 생성**: MCP를 통한 보일러플레이트 코드 자동화
4. **품질 관리**: 각 Task마다 Acceptance Criteria 검증

### MCP 명령어 예시
```bash
# Task 생성
/task create TASK-001-HOME-SCREEN "메인 화면 UI 구현"

# Task 진행
/task start TASK-001-HOME-SCREEN

# 코드 생성
/generate widget MainMenuButtons --type=stateless

# Task 완료
/task complete TASK-001-HOME-SCREEN
```

---

*이 문서는 개발 진행에 따라 지속적으로 업데이트됩니다.*