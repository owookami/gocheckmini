/// 앱에서 사용되는 상수들을 정의하는 클래스
class AppConstants {
  /// API 관련 상수
  static const String apiBaseUrl =
      'https://apis.data.go.kr/1613000/ArchPmsHubService';
  static const int apiTimeout = 30000; // 30초
  static const int maxRetryCount = 3;

  /// 페이징 관련 상수
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  /// 데이터베이스 관련 상수
  static const String databaseName = 'parking_finder.db';
  static const int databaseVersion = 1;

  /// 앱 정보
  static const String appName = 'ParkingFinder';
  static const String appVersion = '1.0.0';

  /// 테이블명
  static const String provincesTable = 'provinces';
  static const String sigungusTable = 'sigungus';
  static const String bjdongsTable = 'bjdongs';
}
