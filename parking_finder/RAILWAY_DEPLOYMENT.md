# Railway에 FastAPI 프록시 서버 배포하기

## 1단계: Railway 계정 생성 및 준비

1. [Railway.app](https://railway.app)에 GitHub 계정으로 로그인
2. "New Project" 클릭
3. "Deploy from GitHub repo" 선택
4. 이 저장소 선택

## 2단계: 프로젝트 설정

1. **Root Directory 설정**:
   - Settings → Environment → Root Directory
   - `parking_finder/proxy_server` 입력

2. **환경 변수 설정** (필요한 경우):
   - Settings → Variables
   - 추가 환경 변수가 필요하면 여기에 설정

3. **도메인 설정**:
   - Settings → Domains
   - 생성된 Railway 도메인 확인 (예: `parking-proxy-production.up.railway.app`)

## 3단계: 배포 완료 후

1. **도메인 URL 복사**
2. **Flutter 앱 업데이트**:
   ```dart
   // parking_search_service.dart에서
   const String proxyBaseUrl = 'https://YOUR-RAILWAY-DOMAIN.up.railway.app';
   ```

## 4단계: 테스트

배포 완료 후 다음 URL로 테스트:
```
https://YOUR-RAILWAY-DOMAIN.up.railway.app/health
```

## Railway 무료 플랜 제한

- **실행 시간**: 월 500시간
- **메모리**: 512MB RAM
- **대역폭**: 무제한
- **프로젝트**: 3개까지

## 자동 배포

GitHub에 푸시할 때마다 자동으로 재배포됩니다.

## 로그 확인

Railway 대시보드에서 실시간 로그를 확인할 수 있습니다.