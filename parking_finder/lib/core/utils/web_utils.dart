import 'package:flutter/foundation.dart';

/// 웹 환경에서 CORS 문제를 해결하기 위한 유틸리티
class WebUtils {
  // 사용 가능한 CORS 프록시 서비스들
  static const List<String> _corsProxies = [
    'https://api.allorigins.win/raw?url=',
    'https://cors-anywhere.herokuapp.com/',
    'https://thingproxy.freeboard.io/fetch/',
  ];
  
  static int _currentProxyIndex = 0;
  
  /// 웹 환경에서 CORS 프록시를 사용한 URL 생성
  static String getApiUrl(String originalUrl) {
    if (!kIsWeb) {
      return originalUrl;
    }
    
    // 첫 번째 프록시 사용 (allorigins가 가장 안정적)
    final proxy = _corsProxies[0];
    final proxiedUrl = proxy + Uri.encodeComponent(originalUrl);
    
    print('🔗 원본 URL: $originalUrl');
    print('🔗 프록시 URL: $proxiedUrl');
    
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
}