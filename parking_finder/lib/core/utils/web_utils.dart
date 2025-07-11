import 'package:flutter/foundation.dart';
import 'dart:js' as js;

/// 웹 환경에서 CORS 문제를 해결하기 위한 유틸리티
class WebUtils {
  /// 웹 환경에서 CORS 프록시를 사용한 URL 생성
  static String getApiUrl(String originalUrl) {
    if (kIsWeb) {
      try {
        // JavaScript의 getProxiedUrl 함수 호출
        if (js.context.hasProperty('getProxiedUrl')) {
          return js.context.callMethod('getProxiedUrl', [originalUrl]);
        }
      } catch (e) {
        print('프록시 URL 생성 실패: $e');
      }
    }
    
    // 웹이 아니거나 프록시 설정이 없으면 원본 URL 사용
    return originalUrl;
  }
  
  /// GitHub Pages 배포 환경인지 확인
  static bool get isGitHubPages {
    if (!kIsWeb) return false;
    
    try {
      final hostname = js.context['location']['hostname'];
      return hostname.toString().contains('github.io');
    } catch (e) {
      return false;
    }
  }
}