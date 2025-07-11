# Render에 FastAPI 프록시 서버 배포하기

Render는 Railway보다 더 관대한 무료 플랜을 제공합니다.

## Render 무료 플랜 장점
- ✅ **750시간/월** (Railway는 30일 체험만)
- ✅ **무료 지속**: 월별 갱신
- ✅ **자동 슬립**: 15분 비활성화 시 (콜드 스타트 ~30초)
- ✅ **GitHub 연동**: 자동 배포
- ✅ **HTTPS**: 무료 SSL 인증서

## 1단계: Render 계정 생성

1. [Render.com](https://render.com) 방문
2. GitHub 계정으로 로그인
3. 무료 계정 생성

## 2단계: 새 웹 서비스 생성

1. 대시보드에서 "New +" → "Web Service" 클릭
2. GitHub 저장소 연결
3. 이 저장소 (`gocheckmini`) 선택

## 3단계: 배포 설정

### 기본 설정:
- **Name**: `parking-proxy` (또는 원하는 이름)
- **Runtime**: `Python 3`
- **Root Directory**: `parking_finder/proxy_server`
- **Build Command**: `pip install -r requirements.txt`
- **Start Command**: `uvicorn main:app --host 0.0.0.0 --port $PORT`

### 환경 설정:
- **Plan**: `Free` 선택
- **Auto-Deploy**: `Yes` (GitHub 푸시 시 자동 배포)

## 4단계: 배포 완료 후

1. **서비스 URL 확인**: 
   - 예: `https://parking-proxy-xyz.onrender.com`

2. **테스트**:
   ```
   https://parking-proxy-xyz.onrender.com/health
   ```

3. **Flutter 앱 업데이트**:
   ```dart
   // parking_search_service.dart에서
   const String proxyBaseUrl = 'https://parking-proxy-xyz.onrender.com';
   ```

## 5단계: 도메인 업데이트

parking_search_service.dart에서 Render URL로 변경:

```dart
// FastAPI 프록시 서버 URL (Render 배포 후)
const String proxyBaseUrl = 'https://YOUR-RENDER-URL.onrender.com';
```

## Render 특징

### 장점:
- ✅ 진짜 무료 (30일 제한 없음)
- ✅ 월 750시간 제공
- ✅ 자동 HTTPS
- ✅ GitHub 연동 배포

### 단점:
- ⚠️ 콜드 스타트 지연 (~30초)
- ⚠️ 15분 비활성화 시 슬립

## 콜드 스타트 해결

앱에서 첫 요청이 느릴 수 있으므로:

1. **로딩 표시**: "서버 시작 중..." 메시지
2. **재시도 로직**: 실패 시 한 번 더 시도
3. **예열 요청**: 주기적으로 health check 호출

이렇게 하면 안정적으로 무료로 사용할 수 있습니다!