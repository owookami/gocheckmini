import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';

/// 웹 전용 스트리트 뷰 서비스
class WebStreetViewService {
  static final Logger _logger = Logger();

  /// 웹에서 주소를 기준으로 스트리트 뷰 열기
  static Future<bool> openStreetViewByAddress(String address) async {
    if (!kIsWeb) {
      _logger.w('WebStreetViewService는 웹 환경에서만 사용 가능합니다.');
      return false;
    }

    try {
      // Google Maps 검색 URL 생성
      final encodedAddress = Uri.encodeComponent(address);
      final streetViewUrl = 'https://www.google.com/maps/search/$encodedAddress/@street-view';
      
      _logger.d('스트리트 뷰 URL: $streetViewUrl');
      
      final uri = Uri.parse(streetViewUrl);
      final result = await launchUrl(
        uri,
        webOnlyWindowName: '_blank',
        mode: LaunchMode.platformDefault,
      );
      
      if (result) {
        _logger.i('✅ 스트리트 뷰 열기 성공: $address');
      } else {
        _logger.e('❌ 스트리트 뷰 열기 실패: $address');
      }
      
      return result;
    } catch (e) {
      _logger.e('❌ 스트리트 뷰 열기 중 오류 발생: $e');
      return false;
    }
  }

  /// 웹에서 좌표를 기준으로 스트리트 뷰 열기
  static Future<bool> openStreetViewByCoordinates(double latitude, double longitude) async {
    if (!kIsWeb) {
      _logger.w('WebStreetViewService는 웹 환경에서만 사용 가능합니다.');
      return false;
    }

    try {
      // Google Maps 스트리트 뷰 URL 생성
      final streetViewUrl = 'https://www.google.com/maps/@$latitude,$longitude,3a,75y,90t/data=!3m6!1e1!3m4!1s0x0:0x0!2e0!7i13312!8i6656';
      
      _logger.d('스트리트 뷰 URL: $streetViewUrl');
      
      final uri = Uri.parse(streetViewUrl);
      final result = await launchUrl(
        uri,
        webOnlyWindowName: '_blank',
        mode: LaunchMode.platformDefault,
      );
      
      if (result) {
        _logger.i('✅ 스트리트 뷰 열기 성공: $latitude, $longitude');
      } else {
        _logger.e('❌ 스트리트 뷰 열기 실패: $latitude, $longitude');
      }
      
      return result;
    } catch (e) {
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
    if (!kIsWeb) {
      _logger.w('WebStreetViewService는 웹 환경에서만 사용 가능합니다.');
      return false;
    }

    try {
      _logger.i('🅿️ 주차장 스트리트 뷰 열기: $parkingLotName');
      
      // 좌표가 있으면 좌표 우선 사용
      if (latitude != null && longitude != null) {
        _logger.d('좌표 기반으로 스트리트 뷰 열기');
        return await openStreetViewByCoordinates(latitude, longitude);
      } 
      // 좌표가 없으면 주소로 검색
      else {
        _logger.d('주소 기반으로 스트리트 뷰 열기');
        return await openStreetViewByAddress(address);
      }
    } catch (e) {
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
        mapsUrl = 'https://www.google.com/maps/place/$latitude,$longitude';
      } else {
        final encodedAddress = Uri.encodeComponent(address);
        mapsUrl = 'https://www.google.com/maps/search/$encodedAddress';
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