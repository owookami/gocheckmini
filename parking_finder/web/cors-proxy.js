// CORS 프록시 설정
// 공공데이터 API 호출 시 CORS 에러를 해결하기 위한 프록시 설정

const CORS_PROXY_URL = 'https://cors-anywhere.herokuapp.com/';
const ALLORIGINS_PROXY_URL = 'https://api.allorigins.win/raw?url=';

// 환경에 따른 API URL 생성
function getProxiedUrl(originalUrl) {
  // GitHub Pages에서는 프록시 사용
  if (window.location.hostname.includes('github.io')) {
    return ALLORIGINS_PROXY_URL + encodeURIComponent(originalUrl);
  }
  
  // 로컬 개발환경에서는 원본 URL 사용
  return originalUrl;
}

window.getProxiedUrl = getProxiedUrl;