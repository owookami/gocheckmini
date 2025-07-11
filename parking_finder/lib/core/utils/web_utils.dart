import 'package:flutter/foundation.dart';

/// 웹 환경에서 CORS 문제 없이 지역 데이터를 제공하기 위한 유틸리티

/// 웹/모바일 환경별 기능 제공을 위한 유틸리티
/// CORS 문제 해결을 위해 웹에서는 로컬 데이터, 모바일에서는 API 사용
class WebUtils {
  /// 웹 환경에서 로컬 데이터를 사용할지 여부
  static bool get useLocalDataInWeb => kIsWeb;
  
  /// 웹 환경에서 API 호출을 시도할지 여부 (CORS 문제로 비활성화)
  static bool get shouldAttemptApiInWeb => false;
  
  /// 현재 환경이 웹인지 확인
  static bool get isWebEnvironment => kIsWeb;
  
  /// 현재 환경에서 지역 데이터 소스 타입 반환
  static String get dataSourceType => kIsWeb ? 'local' : 'api';
  // 사용 가능한 CORS 프록시 서비스들
  static const List<String> _corsProxies = [
    'https://cors-proxy.fringe.zone/',
    'https://api.allorigins.win/get?url=',
    'https://thingproxy.freeboard.io/fetch/',
  ];
  
  static int _currentProxyIndex = 0;
  
  /// 웹 환경에서 CORS 프록시를 사용한 URL 생성
  static String getApiUrl(String originalUrl) {
    if (!kIsWeb) {
      return originalUrl;
    }
    
    // 첫 번째 프록시 사용 (cors-proxy.fringe.zone)
    final proxy = _corsProxies[_currentProxyIndex];
    String proxiedUrl;
    
    if (proxy.contains('allorigins.win/get')) {
      // allorigins.win의 get 엔드포인트는 JSON으로 래핑됨
      proxiedUrl = proxy + Uri.encodeComponent(originalUrl);
    } else if (proxy.contains('fringe.zone')) {
      // fringe.zone은 단순히 URL 뒤에 붙임
      proxiedUrl = proxy + originalUrl;
    } else {
      // 기타 프록시들
      proxiedUrl = proxy + originalUrl;
    }
    
    print('🔗 원본 URL: $originalUrl');
    print('🔗 프록시 URL: $proxiedUrl');
    print('🔗 사용 중인 프록시: ${_corsProxies[_currentProxyIndex]}');
    
    return proxiedUrl;
  }
  
  /// 다음 프록시로 전환 (첫 번째 프록시 실패 시)
  static String getNextProxyUrl(String originalUrl) {
    if (!kIsWeb) {
      return originalUrl;
    }
    
    _currentProxyIndex = (_currentProxyIndex + 1) % _corsProxies.length;
    final proxy = _corsProxies[_currentProxyIndex];
    
    String proxiedUrl;
    if (proxy.contains('allorigins')) {
      proxiedUrl = proxy + Uri.encodeComponent(originalUrl);
    } else {
      proxiedUrl = proxy + originalUrl;
    }
    
    print('🔄 프록시 전환: ${_corsProxies[_currentProxyIndex]}');
    print('🔗 새 프록시 URL: $proxiedUrl');
    
    return proxiedUrl;
  }
  
  /// 프록시 인덱스 리셋
  static void resetProxy() {
    _currentProxyIndex = 0;
  }
  
  /// GitHub Pages 배포 환경인지 확인
  static bool get isGitHubPages {
    if (!kIsWeb) return false;
    
    try {
      return Uri.base.host.contains('github.io');
    } catch (e) {
      return false;
    }
  }
  
  /// 환경별 안내 메시지 생성
  static String getEnvironmentMessage() {
    if (kIsWeb) {
      return '웹 환경에서는 로컬 지역 데이터를 사용합니다.';
    } else {
      return '모바일 환경에서는 실시간 공공 API를 사용합니다.';
    }
  }
}