# Vercel Functions 배포 가이드

## 개요
이 프로젝트는 Flutter 웹 앱에서 한국 공공데이터 API CORS 문제를 해결하기 위해 Vercel Functions를 사용합니다.

## 배포 단계

### 1. Vercel 계정 및 CLI 설정
```bash
# Vercel CLI 설치
npm i -g vercel

# Vercel 로그인
vercel login
```

### 2. 프로젝트 배포
```bash
# 프로젝트 루트에서 실행
vercel

# 첫 배포 시 설정:
# - Set up and deploy? [Y/n] y
# - Which scope? [your-username]
# - Link to existing project? [y/N] n
# - What's your project's name? parking-finder-proxy
# - In which directory is your code located? ./
```

### 3. 환경 변수 설정 (필요시)
```bash
# Vercel 대시보드에서 설정하거나 CLI로:
vercel env add [변수명]
```

### 4. Flutter 앱에서 프록시 URL 업데이트
배포 완료 후 받은 Vercel URL을 `parking_search_service.dart`에서 업데이트:

```dart
// GitHub Pages 배포 환경
proxyBaseUrl = 'https://your-vercel-app.vercel.app';
```

## API 엔드포인트

### `/api/parking-proxy`
- **메서드**: GET
- **파라미터**: 
  - `url`: 프록시할 원본 API URL (URL 인코딩 필요)
  - 기타 쿼리 파라미터들은 그대로 전달

### 사용 예시
```
GET https://your-vercel-app.vercel.app/api/parking-proxy?url=https%3A//apis.data.go.kr/1613000/ArchPmsHubService/getApPklotInfo&serviceKey=YOUR_API_KEY&sigunguCd=11500&bjdongCd=10300
```

## 로컬 개발

```bash
# 로컬 개발 서버 시작
vercel dev

# http://localhost:3000에서 접근 가능
```

## 주의사항

1. **API 키 보안**: API 키는 클라이언트 사이드에서 전달되므로 공개됩니다. 프로덕션 환경에서는 서버 사이드에서 API 키를 관리하는 것을 권장합니다.

2. **Rate Limiting**: 공공데이터 API의 사용량 제한을 준수해야 합니다.

3. **CORS 헤더**: 프록시 함수는 모든 도메인에서의 접근을 허용합니다 (`Access-Control-Allow-Origin: *`). 필요시 특정 도메인으로 제한할 수 있습니다.

## 문제 해결

### Vercel 함수 로그 확인
```bash
vercel logs [deployment-url]
```

### 로컬 디버깅
```bash
vercel dev --debug
```