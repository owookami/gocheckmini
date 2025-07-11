import 'package:flutter/foundation.dart';

/// 웹 환경에서 CORS 문제 해결을 위한 유틸리티
class WebUtils {
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
  
  /// 현재 환경이 웹인지 확인
  static bool get isWebEnvironment => kIsWeb;
}