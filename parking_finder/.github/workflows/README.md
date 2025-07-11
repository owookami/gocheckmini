# GitHub Actions 설정 가이드

## GitHub Secrets 설정

GitHub Actions에서 환경 변수를 사용하기 위해 다음 Secrets를 설정해야 합니다:

1. GitHub 리포지토리 페이지로 이동
2. Settings → Secrets and variables → Actions 클릭
3. "New repository secret" 버튼 클릭
4. 다음 Secrets 추가:

### 필수 Secrets

| Secret 이름 | 설명 | 예시 값 |
|------------|------|---------|
| `PUBLIC_DATA_API_KEY` | 공공데이터 포털 API 키 | 발급받은 API 키 |
| `ARCHITECTURE_HUB_API_KEY` | 건축HUB API 키 (공공데이터 API와 동일) | 발급받은 API 키 |
| `STANDARD_REGION_API_KEY` | 표준 지역 코드 API 키 | 발급받은 API 키 또는 기본값 사용 |
| `NAVER_MAP_CLIENT_ID` | 네이버 지도 Client ID (선택) | 네이버 클라우드 플랫폼에서 발급 |

### API 키 발급 방법

1. **공공데이터 포털 API 키**
   - https://www.data.go.kr 접속
   - 회원가입 및 로그인
   - 원하는 API 활용 신청
   - 마이페이지에서 발급된 API 키 확인

2. **네이버 지도 API (선택)**
   - https://console.ncloud.com 접속
   - AI·NAVER API → Application 등록
   - Maps → Web Dynamic Map 사용 설정
   - Client ID 확인

## 로컬 개발 환경

로컬에서 개발할 때는 다음과 같이 실행:

```bash
flutter run -d chrome \
  --dart-define=PUBLIC_DATA_API_KEY=your_api_key \
  --dart-define=ARCHITECTURE_HUB_API_KEY=your_api_key \
  --dart-define=STANDARD_REGION_API_KEY=your_api_key
```

또는 `.env` 파일을 생성하여 사용할 수도 있습니다 (권장하지 않음):

```env
PUBLIC_DATA_API_KEY=your_api_key_here
ARCHITECTURE_HUB_API_KEY=your_api_key_here
STANDARD_REGION_API_KEY=your_api_key_here
NAVER_MAP_CLIENT_ID=your_client_id_here
```

## 배포 URL

성공적으로 배포되면 다음 URL에서 확인 가능:
- https://[username].github.io/gocheckmini/