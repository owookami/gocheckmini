/// Environment configuration using compile-time constants
/// 
/// This class provides environment variables through compile-time constants
/// using --dart-define flags. This approach is better for CI/CD as it doesn't
/// require .env files to be present during build.
/// 
/// Usage in build command:
/// flutter build web --dart-define=API_KEY=your_key --dart-define=PUBLIC_DATA_API_KEY=your_key
class EnvConfig {
  /// 공공데이터 포털 API 키
  static const String publicDataApiKey = String.fromEnvironment(
    'PUBLIC_DATA_API_KEY',
    defaultValue: 'your_api_key_here',
  );

  /// 건축HUB API 키 (현재는 공공데이터 API 키와 동일)
  static const String architectureHubApiKey = String.fromEnvironment(
    'ARCHITECTURE_HUB_API_KEY',
    defaultValue: 'your_api_key_here',
  );

  /// 표준 지역 코드 API 키
  static const String standardRegionApiKey = String.fromEnvironment(
    'STANDARD_REGION_API_KEY',
    defaultValue: 'Ucr8SdMuzgu0G/u9nDmIjIdkh/W8gU181DC6MBXioK11bJbW8OvTrTfVWetBY+kqDeUldK9UxiPlnezZqFZn+w==',
  );

  /// 네이버 지도 Client ID
  static const String naverMapClientId = String.fromEnvironment(
    'NAVER_MAP_CLIENT_ID',
    defaultValue: 'YOUR_NAVER_MAP_CLIENT_ID',
  );

  /// 공공데이터 API URL
  static const String publicDataApiUrl = String.fromEnvironment(
    'PUBLIC_DATA_API_URL',
    defaultValue: 'https://apis.data.go.kr/1613000/ArchHubService',
  );

  /// 디버그 모드에서 환경 변수 확인
  static void printConfig() {
    print('=== Environment Configuration ===');
    print('PUBLIC_DATA_API_KEY: ${publicDataApiKey.isNotEmpty ? "Set (${publicDataApiKey.length} chars)" : "Not set"}');
    print('ARCHITECTURE_HUB_API_KEY: ${architectureHubApiKey.isNotEmpty ? "Set (${architectureHubApiKey.length} chars)" : "Not set"}');
    print('STANDARD_REGION_API_KEY: ${standardRegionApiKey.isNotEmpty ? "Set (${standardRegionApiKey.length} chars)" : "Not set"}');
    print('NAVER_MAP_CLIENT_ID: ${naverMapClientId.isNotEmpty ? "Set" : "Not set"}');
    print('PUBLIC_DATA_API_URL: $publicDataApiUrl');
    print('===============================');
  }
}