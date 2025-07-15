import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';
import 'dart:html' as html;

/// 웹 전용 스트리트 뷰 서비스
class WebStreetViewService {
  static final Logger _logger = Logger();

  /// 웹에서 주소를 기준으로 스트리트 뷰 열기
  static Future<bool> openStreetViewByAddress(String address) async {
    print('🔍 openStreetViewByAddress 시작');
    print('📍 주소: $address');
    
    if (!kIsWeb) {
      print('❌ 웹 환경이 아님');
      _logger.w('WebStreetViewService는 웹 환경에서만 사용 가능합니다.');
      return false;
    }

    try {
      // Google Maps 스트리트 뷰 URL 생성 (한글 지원)
      final encodedAddress = Uri.encodeComponent(address);
      final streetViewUrl = 'https://www.google.com/maps/search/$encodedAddress?hl=ko&t=k&layer=c';
      
      print('🌐 생성된 URL: $streetViewUrl');
      _logger.d('스트리트 뷰 URL: $streetViewUrl');
      
      print('🚀 두 가지 방법으로 URL 열기 시도...');
      
      // 방법 1: dart:html 직접 사용
      try {
        print('🌐 방법 1: dart:html window.open 시도');
        html.window.open(streetViewUrl, '_blank');
        print('✅ dart:html window.open 성공');
        _logger.i('✅ 스트리트 뷰 열기 성공: $address');
        return true;
      } catch (htmlError) {
        print('❌ dart:html 실패: $htmlError');
      }
      
      // 방법 2: url_launcher 사용
      try {
        print('📱 방법 2: url_launcher 시도');
        final uri = Uri.parse(streetViewUrl);
        final result = await launchUrl(
          uri,
          webOnlyWindowName: '_blank',
          mode: LaunchMode.platformDefault,
        );
        print('📋 launchUrl 결과: $result');
        
        if (result) {
          print('✅ url_launcher 성공');
          _logger.i('✅ 스트리트 뷰 열기 성공: $address');
        } else {
          print('❌ url_launcher 실패');
          _logger.e('❌ 스트리트 뷰 열기 실패: $address');
        }
        
        return result;
      } catch (launcherError) {
        print('❌ url_launcher 실패: $launcherError');
        _logger.e('❌ url_launcher 예외: $launcherError');
        return false;
      }
    } catch (e, stackTrace) {
      print('❌ 스트리트 뷰 열기 중 예외 발생');
      print('❌ 에러: $e');
      print('❌ 스택트레이스: $stackTrace');
      _logger.e('❌ 스트리트 뷰 열기 중 오류 발생: $e');
      return false;
    }
  }

  /// 웹에서 좌표를 기준으로 스트리트 뷰 열기
  static Future<bool> openStreetViewByCoordinates(double latitude, double longitude) async {
    print('🔍 openStreetViewByCoordinates 시작');
    print('📍 좌표: lat=$latitude, lng=$longitude');
    
    if (!kIsWeb) {
      print('❌ 웹 환경이 아님');
      _logger.w('WebStreetViewService는 웹 환경에서만 사용 가능합니다.');
      return false;
    }

    try {
      // Google Maps 스트리트 뷰 URL 생성 (한글 지원)
      final streetViewUrl = 'https://www.google.com/maps/@$latitude,$longitude,3a,75y,90t/data=!3m6!1e1!3m4!1s0x0:0x0!2e0!7i13312!8i6656!5m1!1e2&hl=ko';
      
      print('🌐 생성된 URL: $streetViewUrl');
      _logger.d('스트리트 뷰 URL: $streetViewUrl');
      
      print('🚀 두 가지 방법으로 URL 열기 시도...');
      
      // 방법 1: dart:html 직접 사용
      try {
        print('🌐 방법 1: dart:html window.open 시도');
        html.window.open(streetViewUrl, '_blank');
        print('✅ dart:html window.open 성공');
        _logger.i('✅ 스트리트 뷰 열기 성공: $latitude, $longitude');
        return true;
      } catch (htmlError) {
        print('❌ dart:html 실패: $htmlError');
      }
      
      // 방법 2: url_launcher 사용
      try {
        print('📱 방법 2: url_launcher 시도');
        final uri = Uri.parse(streetViewUrl);
        final result = await launchUrl(
          uri,
          webOnlyWindowName: '_blank',
          mode: LaunchMode.platformDefault,
        );
        print('📋 launchUrl 결과: $result');
        
        if (result) {
          print('✅ url_launcher 성공');
          _logger.i('✅ 스트리트 뷰 열기 성공: $latitude, $longitude');
        } else {
          print('❌ url_launcher 실패');
          _logger.e('❌ 스트리트 뷰 열기 실패: $latitude, $longitude');
        }
        
        return result;
      } catch (launcherError) {
        print('❌ url_launcher 실패: $launcherError');
        _logger.e('❌ url_launcher 예외: $launcherError');
        return false;
      }
    } catch (e, stackTrace) {
      print('❌ 스트리트 뷰 열기 중 예외 발생');
      print('❌ 에러: $e');
      print('❌ 스택트레이스: $stackTrace');
      _logger.e('❌ 스트리트 뷰 열기 중 오류 발생: $e');
      return false;
    }
  }

  /// 웹에서 주차장 정보를 기준으로 스트리트 뷰 열기
  static Future<bool> openStreetViewForParkingLot({
    required String parkingLotName,
    required String address,
    double? latitude,
    double? longitude,
  }) async {
    // 상세 디버깅 로그
    print('🔍 WebStreetViewService.openStreetViewForParkingLot 시작');
    print('📍 주차장명: $parkingLotName');
    print('📍 주소: $address');
    print('📍 좌표: lat=$latitude, lng=$longitude');
    print('📍 웹 환경 여부: $kIsWeb');
    
    if (!kIsWeb) {
      print('❌ 웹 환경이 아님');
      _logger.w('WebStreetViewService는 웹 환경에서만 사용 가능합니다.');
      return false;
    }

    try {
      _logger.i('🅿️ 주차장 스트리트 뷰 열기: $parkingLotName');
      
      // 좌표가 있으면 좌표 우선 사용
      if (latitude != null && longitude != null) {
        print('🗺️ 좌표 기반으로 스트리트 뷰 열기 시도');
        _logger.d('좌표 기반으로 스트리트 뷰 열기');
        final result = await openStreetViewByCoordinates(latitude, longitude);
        print('✅ 좌표 기반 스트리트 뷰 결과: $result');
        return result;
      } 
      // 좌표가 없으면 주소로 검색
      else {
        print('🏠 주소 기반으로 스트리트 뷰 열기 시도');
        _logger.d('주소 기반으로 스트리트 뷰 열기');
        final result = await openStreetViewByAddress(address);
        print('✅ 주소 기반 스트리트 뷰 결과: $result');
        return result;
      }
    } catch (e, stackTrace) {
      print('❌ 주차장 스트리트 뷰 열기 실패');
      print('❌ 에러: $e');
      print('❌ 스택트레이스: $stackTrace');
      _logger.e('❌ 주차장 스트리트 뷰 열기 실패: $e');
      return false;
    }
  }

  /// 웹에서 일반 Google Maps 열기 (스트리트 뷰 대안)
  static Future<bool> openGoogleMaps({
    required String address,
    double? latitude,
    double? longitude,
  }) async {
    if (!kIsWeb) {
      _logger.w('WebStreetViewService는 웹 환경에서만 사용 가능합니다.');
      return false;
    }

    try {
      String mapsUrl;
      
      if (latitude != null && longitude != null) {
        mapsUrl = 'https://www.google.com/maps/place/$latitude,$longitude?hl=ko';
      } else {
        final encodedAddress = Uri.encodeComponent(address);
        mapsUrl = 'https://www.google.com/maps/search/$encodedAddress?hl=ko';
      }
      
      _logger.d('Google Maps URL: $mapsUrl');
      
      final uri = Uri.parse(mapsUrl);
      final result = await launchUrl(
        uri,
        webOnlyWindowName: '_blank',
        mode: LaunchMode.platformDefault,
      );
      
      if (result) {
        _logger.i('✅ Google Maps 열기 성공');
      } else {
        _logger.e('❌ Google Maps 열기 실패');
      }
      
      return result;
    } catch (e) {
      _logger.e('❌ Google Maps 열기 중 오류 발생: $e');
      return false;
    }
  }
}