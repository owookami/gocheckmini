# 주차장 찾기 - 건축인허가 주차장 조회 앱

공공데이터 포털의 건축HUB API를 활용한 Flutter 앱입니다.

## 🌐 웹 배포

이 앱은 GitHub Pages를 통해 웹으로 배포됩니다.

**배포 URL**: https://yourusername.github.io/gocheckmini/

### 배포 방법

1. **GitHub Pages 설정**
   - Repository Settings → Pages
   - Source: Deploy from a branch
   - Branch: `gh-pages` 선택
   - Root directory 선택

2. **자동 배포**
   - `main` 브랜치에 코드 푸시하면 자동으로 배포됩니다
   - GitHub Actions를 통해 Flutter 웹 빌드 및 배포가 자동화됩니다

3. **수동 배포**
   ```bash
   cd parking_finder
   flutter build web --release --base-href "/gocheckmini/"
   ```

## 🚀 기능

### 주요 기능
- 지역별 주차장 검색 (시도 > 시군구 > 읍면동)
- 건축물 구조 분석 기반 주차장 검색
- 일반 주차장 정보 조회
- 즐겨찾기 기능
- 구글 지도 연동 (웹에서 지원)
- 네이버 지도 연동 (모바일에서만 지원)
- 구글 스트리트 뷰 연동
- Excel 파일 내보내기

### 웹 버전 제한사항
- 네이버 지도: 모바일 전용, 웹에서는 구글 지도 사용
- 파일 저장: 웹에서는 다운로드 폴더에 저장
- 권한 요청: 웹에서는 일부 권한 요청 기능 제한

## 🛠️ 기술 스택

- **Frontend**: Flutter 3.7.2
- **상태 관리**: Riverpod 2.6.1
- **라우팅**: GoRouter 14.6.2
- **데이터베이스**: SQLite (sqflite / sqflite_common_ffi)
- **지도**: Google Maps Flutter, Flutter Naver Map
- **HTTP 클라이언트**: Dio 5.3.2
- **UI 컴포넌트**: Material Design 3

## 📱 지원 플랫폼

- ✅ Android
- ✅ iOS  
- ✅ Web (GitHub Pages)
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔧 개발 환경 설정

### 1. 필수 요구사항
- Flutter SDK 3.7.2+
- Dart SDK 3.0.0+
- Android Studio / VS Code
- Git

### 2. 프로젝트 설정
```bash
# 프로젝트 클론
git clone https://github.com/yourusername/gocheckmini.git
cd gocheckmini/parking_finder

# 종속성 설치
flutter pub get

# 코드 생성
flutter pub run build_runner build --delete-conflicting-outputs

# 앱 실행
flutter run
```

### 3. 환경 변수 설정
`.env` 파일을 생성하고 다음 API 키들을 설정하세요:

```env
# 공공데이터 포털 API 키
ARCHITECTURE_HUB_API_KEY=your_api_key_here
API_KEY=your_api_key_here
STANDARD_REGION_API_KEY=your_api_key_here

# 네이버 지도 API 키 (모바일 전용)
NAVER_MAP_CLIENT_ID=your_naver_map_client_id

# 구글 맵 API 키
GOOGLE_MAPS_API_KEY=your_google_maps_api_key
```

### 4. API 키 발급 방법

#### 공공데이터 포털 API
1. [공공데이터 포털](https://www.data.go.kr/) 회원가입
2. 건축HUB API 신청
3. API 키 발급받기

#### 네이버 지도 API (모바일 전용)
1. [네이버 클라우드 플랫폼](https://www.ncloud.com/) 가입
2. Maps API 신청
3. Client ID 발급받기

#### 구글 맵 API
1. [Google Cloud Console](https://console.cloud.google.com/) 접속
2. 새 프로젝트 생성
3. Maps JavaScript API 활성화
4. API 키 생성

## 🧪 테스트

```bash
# 단위 테스트 실행
flutter test

# 통합 테스트 실행
flutter test integration_test/
```

## 📦 빌드

### 모바일 빌드
```bash
# Android APK
flutter build apk --release

# iOS IPA
flutter build ios --release

# Android App Bundle
flutter build appbundle --release
```

### 웹 빌드
```bash
# 로컬 웹 빌드
flutter build web --release

# GitHub Pages용 빌드
flutter build web --release --base-href "/gocheckmini/"
```

## 🗂️ 프로젝트 구조

```
parking_finder/
├── lib/
│   ├── app/                    # 앱 전역 설정
│   ├── core/                   # 코어 기능
│   │   ├── api/               # API 클라이언트
│   │   ├── config/            # 앱 설정
│   │   ├── constants/         # 상수
│   │   ├── database/          # 데이터베이스
│   │   └── utils/             # 유틸리티
│   ├── features/              # 기능별 모듈
│   │   ├── parking/          # 주차장 관련 기능
│   │   └── splash/           # 스플래시 화면
│   └── main.dart              # 앱 진입점
├── test/                      # 테스트 파일
├── assets/                    # 리소스 파일
├── web/                       # 웹 전용 파일
└── pubspec.yaml              # 종속성 설정
```

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 문의

프로젝트에 대한 질문이나 제안사항이 있으시면 Issue를 생성해 주세요.

---

**주의사항**: 이 앱은 공공데이터 포털의 API를 사용하므로, 상용 사용 시 해당 기관의 이용약관을 확인하시기 바랍니다. 