# FastAPI Proxy Server

한국 공공데이터 API의 CORS 문제를 해결하기 위한 프록시 서버입니다.

## 로컬 실행

```bash
# 의존성 설치
pip install -r requirements.txt

# 서버 실행
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

## Railway 배포

1. [Railway.app](https://railway.app) 계정 생성
2. GitHub 저장소 연결
3. `proxy_server` 폴더를 루트로 설정
4. 자동 배포 완료

## 사용법

```
GET /proxy?url={API_URL}&serviceKey={KEY}&sigunguCd={CODE}&bjdongCd={CODE}
```

### 예시
```
https://your-railway-app.railway.app/proxy?url=https://apis.data.go.kr/1613000/ArchPmsHubService/getApAtchPklotInfo&serviceKey=YOUR_KEY&sigunguCd=11440&bjdongCd=10300
```

## 엔드포인트

- `GET /` - 서버 정보
- `GET /health` - 헬스 체크
- `GET /proxy` - API 프록시

## 환경 변수

Railway에서 자동으로 설정되는 변수:
- `PORT` - 서버 포트 (Railway에서 자동 할당)