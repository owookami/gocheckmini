/// 앱의 환경변수와 설정을 관리하는 클래스
class AppConfig {
  /// API 관련 설정
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://apis.data.go.kr/1613000/ArchPmsHubService',
  );

  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );

  /// 앱 설정
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'ParkingFinder',
  );

  static const String appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '1.0.0',
  );

  static const bool debugMode = bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: false,
  );

  /// 데이터베이스 설정
  static const String databaseName = String.fromEnvironment(
    'DATABASE_NAME',
    defaultValue: 'parking_finder.db',
  );

  static const int databaseVersion = int.fromEnvironment(
    'DATABASE_VERSION',
    defaultValue: 1,
  );

  /// API 설정
  static const int apiTimeout = int.fromEnvironment(
    'API_TIMEOUT',
    defaultValue: 30000,
  );

  static const int maxRetryCount = int.fromEnvironment(
    'MAX_RETRY_COUNT',
    defaultValue: 3,
  );

  static const int defaultPageSize = int.fromEnvironment(
    'DEFAULT_PAGE_SIZE',
    defaultValue: 20,
  );

  static const int maxPageSize = int.fromEnvironment(
    'MAX_PAGE_SIZE',
    defaultValue: 100,
  );
}
