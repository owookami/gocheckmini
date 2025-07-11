# 개발 환경 설정 가이드

## 로컬 웹 개발 시 CORS 우회 방법

Flutter 웹 개발 시 공공데이터 API의 CORS 정책으로 인한 문제를 해결하는 방법입니다.

### 방법 1: Chrome CORS 비활성화 (권장)

1. **Chrome을 완전히 종료**합니다
2. **새로운 Chrome 인스턴스를 CORS 비활성화로 실행**:

#### macOS:
```bash
open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security --disable-features=VizDisplayCompositor
```

#### Windows:
```cmd
"C:\Program Files\Google\Chrome\Application\chrome.exe" --user-data-dir="C:\temp\chrome_dev_test" --disable-web-security --disable-features=VizDisplayCompositor
```

#### Linux:
```bash
google-chrome --user-data-dir="/tmp/chrome_dev_test" --disable-web-security --disable-features=VizDisplayCompositor
```

3. **Flutter 웹 개발 서버 실행**:
```bash
flutter run -d chrome
```

### 방법 2: 로컬 프록시 서버 사용

이미 포함된 `test_proxy_server.js`를 사용:

1. **프록시 서버 실행**:
```bash
node test_proxy_server.js
```

2. **Flutter 앱에서 로컬 프록시 사용**:
코드가 자동으로 로컬 개발 환경을 감지하고 프록시를 사용합니다.

### 방법 3: Firefox 개발자 모드

Firefox에서는 개발자 도구를 통해 일시적으로 CORS를 비활성화할 수 있습니다:

1. `about:config`에서 `security.fileuri.strict_origin_policy`를 `false`로 설정
2. `privacy.file_unique_origin`을 `false`로 설정

## 주의사항

- **보안**: 위 방법들은 개발 목적으로만 사용하세요
- **프로덕션**: 배포 환경에서는 프록시 서버를 통해서만 CORS 문제를 해결할 수 있습니다
- **브라우저 데이터**: `--user-data-dir`를 사용하면 임시 프로필이 생성됩니다

## 배포 환경

배포된 환경에서는:
- 여러 CORS 프록시 서비스를 자동으로 시도
- 실패 시 다음 프록시로 자동 전환
- 타임아웃 최적화로 사용자 경험 개선