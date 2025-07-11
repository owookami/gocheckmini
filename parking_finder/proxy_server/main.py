from fastapi import FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
import httpx
import logging
from typing import Optional

# 로깅 설정
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="Parking API Proxy Server",
    description="CORS 프록시 서버 for 한국 공공데이터 API",
    version="1.0.0"
)

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 프로덕션에서는 특정 도메인으로 제한
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {
        "message": "Parking API Proxy Server",
        "status": "healthy",
        "endpoints": {
            "proxy": "/proxy",
            "health": "/health"
        }
    }

@app.get("/health")
async def health_check():
    return {"status": "healthy", "service": "parking-api-proxy"}

@app.get("/proxy")
async def proxy_api(
    url: str = Query(..., description="Target API URL"),
    service_key: Optional[str] = Query(None, alias="serviceKey"),
    sigungu_cd: Optional[str] = Query(None, alias="sigunguCd"),
    bjdong_cd: Optional[str] = Query(None, alias="bjdongCd"),
    page_no: Optional[int] = Query(1, alias="pageNo"),
    num_of_rows: Optional[int] = Query(50, alias="numOfRows"),
    type_param: Optional[str] = Query("json", alias="_type")
):
    """
    공공데이터 API 프록시 엔드포인트
    
    Args:
        url: 대상 API URL
        service_key: API 서비스 키
        sigungu_cd: 시군구 코드
        bjdong_cd: 법정동 코드
        page_no: 페이지 번호
        num_of_rows: 페이지당 항목 수
        type_param: 응답 타입 (json)
    """
    try:
        logger.info(f"프록시 요청: {url}")
        
        # 쿼리 파라미터 구성
        params = {}
        if service_key:
            params["serviceKey"] = service_key
        if sigungu_cd:
            params["sigunguCd"] = sigungu_cd
        if bjdong_cd:
            params["bjdongCd"] = bjdong_cd
        if page_no:
            params["pageNo"] = page_no
        if num_of_rows:
            params["numOfRows"] = num_of_rows
        if type_param:
            params["_type"] = type_param
            
        logger.info(f"요청 파라미터: {params}")
        
        # HTTP 클라이언트로 요청
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(
                url,
                params=params,
                headers={
                    "User-Agent": "ParkingFinderProxy/1.0",
                    "Accept": "application/json, application/xml, text/plain, */*",
                }
            )
            
        logger.info(f"응답 상태코드: {response.status_code}")
        
        if response.status_code == 200:
            # Content-Type 확인
            content_type = response.headers.get("content-type", "")
            
            if "application/json" in content_type:
                return response.json()
            elif "application/xml" in content_type or "text/xml" in content_type:
                # XML 응답도 그대로 반환 (클라이언트에서 처리)
                return {"xml_content": response.text, "content_type": "xml"}
            else:
                # 텍스트 응답
                try:
                    # JSON 파싱 시도
                    return response.json()
                except:
                    return {"text_content": response.text, "content_type": "text"}
        else:
            logger.error(f"API 호출 실패: {response.status_code} - {response.text}")
            raise HTTPException(
                status_code=response.status_code,
                detail=f"API 호출 실패: {response.text}"
            )
            
    except httpx.TimeoutException:
        logger.error("API 호출 타임아웃")
        raise HTTPException(status_code=408, detail="API 호출 타임아웃")
    except httpx.RequestError as e:
        logger.error(f"네트워크 오류: {e}")
        raise HTTPException(status_code=502, detail=f"네트워크 오류: {str(e)}")
    except Exception as e:
        logger.error(f"예상치 못한 오류: {e}")
        raise HTTPException(status_code=500, detail=f"서버 오류: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)