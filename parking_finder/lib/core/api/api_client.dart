import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'models.dart';

/// API 에러 타입
enum ApiErrorType {
  networkError,
  unauthorized,
  serverError,
  timeoutError,
  cancelError,
  parseError,
  unknownError,
}

/// API 에러 클래스
class ApiError implements Exception {
  final ApiErrorType type;
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const ApiError({
    required this.type,
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() {
    return 'ApiError(type: $type, message: $message, statusCode: $statusCode)';
  }
}

/// API 클라이언트 싱글톤 클래스
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  late final Dio _dio;
  static final Logger _logger = Logger();

  /// API 베이스 URL
  static const String _baseUrl = 'https://api.data.go.kr';

  /// API 엔드포인트
  static const String _pklotInfoEndpoint = '/getApPklotInfo';
  static const String _atchPklotInfoEndpoint = '/getApAtchPklotInfo';

  /// API 클라이언트 초기화
  void initialize() {
    final baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://api.data.go.kr';

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'ParkingFinder/1.0.0',
        },
      ),
    );

    // 인터셉터 추가
    _dio.interceptors.addAll([
      _LoggingInterceptor(),
      _ErrorHandlingInterceptor(),
    ]);

    _logger.d('API 클라이언트 초기화 완료: $baseUrl');
  }

  /// API 키 가져오기
  String _getApiKey() {
    final apiKey = dotenv.env['ARCHITECTURE_HUB_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      _logger.e('API 키가 설정되지 않았습니다. .env 파일을 확인하세요.');
      throw ApiError(
        type: ApiErrorType.unauthorized,
        message: 'API 키가 설정되지 않았습니다.',
      );
    }
    return apiKey;
  }

  /// 공통 쿼리 파라미터 생성
  Map<String, dynamic> _buildCommonParams({
    required int pageNo,
    required int numOfRows,
    String? sigunguCd,
    String? pklotNm,
  }) {
    final params = <String, dynamic>{
      'serviceKey': _getApiKey(),
      'pageNo': pageNo,
      'numOfRows': numOfRows,
      'type': 'json', // JSON 형식으로 요청
    };

    if (sigunguCd != null && sigunguCd.isNotEmpty) {
      params['sigunguCd'] = sigunguCd;
    }

    if (pklotNm != null && pklotNm.isNotEmpty) {
      params['pklotNm'] = pklotNm;
    }

    return params;
  }

  /// DioException을 ApiError로 변환
  ApiError _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(
          type: ApiErrorType.timeoutError,
          message: '요청 시간이 초과되었습니다.',
          originalError: error,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          if (statusCode >= 400 && statusCode < 500) {
            return ApiError(
              type: ApiErrorType.unauthorized,
              message: '인증 오류 또는 잘못된 요청입니다.',
              statusCode: statusCode,
              originalError: error,
            );
          } else if (statusCode >= 500) {
            return ApiError(
              type: ApiErrorType.serverError,
              message: '서버 오류가 발생했습니다.',
              statusCode: statusCode,
              originalError: error,
            );
          }
        }
        return ApiError(
          type: ApiErrorType.serverError,
          message: '서버 응답 오류가 발생했습니다.',
          statusCode: statusCode,
          originalError: error,
        );

      case DioExceptionType.cancel:
        return ApiError(
          type: ApiErrorType.cancelError,
          message: '요청이 취소되었습니다.',
          originalError: error,
        );

      case DioExceptionType.connectionError:
        return ApiError(
          type: ApiErrorType.networkError,
          message: '네트워크 연결 오류가 발생했습니다.',
          originalError: error,
        );

      default:
        return ApiError(
          type: ApiErrorType.unknownError,
          message: '알 수 없는 오류가 발생했습니다.',
          originalError: error,
        );
    }
  }

  /// 일반 주차장 정보 조회 (JSON 파싱)
  ///
  /// [pageNo] 페이지 번호 (기본값: 1)
  /// [numOfRows] 한 페이지 결과 수 (기본값: 10, 최대 1000)
  /// [sigunguCd] 시군구 코드 (선택사항)
  /// [pklotNm] 주차장명 (선택사항)
  Future<ParkingLotResponse> getParkingLots({
    int pageNo = 1,
    int numOfRows = 10,
    String? sigunguCd,
    String? pklotNm,
  }) async {
    try {
      _logger.d('일반 주차장 정보 조회 요청: pageNo=$pageNo, numOfRows=$numOfRows');

      final params = _buildCommonParams(
        pageNo: pageNo,
        numOfRows: numOfRows,
        sigunguCd: sigunguCd,
        pklotNm: pklotNm,
      );

      final response = await _dio.get(
        _pklotInfoEndpoint,
        queryParameters: params,
      );

      _logger.d('일반 주차장 정보 조회 응답: ${response.statusCode}');

      try {
        return ParkingLotResponse.fromJson(response.data);
      } catch (e) {
        _logger.e('JSON 파싱 오류: $e');
        throw ApiError(
          type: ApiErrorType.parseError,
          message: 'JSON 파싱 중 오류가 발생했습니다.',
          originalError: e,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('일반 주차장 정보 조회 중 예상치 못한 오류: $e');
      throw ApiError(
        type: ApiErrorType.unknownError,
        message: '일반 주차장 정보 조회 중 예상치 못한 오류가 발생했습니다.',
        originalError: e,
      );
    }
  }

  /// 부속 주차장 정보 조회 (JSON 파싱)
  ///
  /// [pageNo] 페이지 번호 (기본값: 1)
  /// [numOfRows] 한 페이지 결과 수 (기본값: 10, 최대 1000)
  /// [sigunguCd] 시군구 코드 (선택사항)
  /// [pklotNm] 주차장명 (선택사항)
  Future<AttachedParkingLotResponse> getAttachedParkingLots({
    int pageNo = 1,
    int numOfRows = 10,
    String? sigunguCd,
    String? pklotNm,
  }) async {
    try {
      _logger.d('부속 주차장 정보 조회 요청: pageNo=$pageNo, numOfRows=$numOfRows');

      final params = _buildCommonParams(
        pageNo: pageNo,
        numOfRows: numOfRows,
        sigunguCd: sigunguCd,
        pklotNm: pklotNm,
      );

      final response = await _dio.get(
        _atchPklotInfoEndpoint,
        queryParameters: params,
      );

      _logger.d('부속 주차장 정보 조회 응답: ${response.statusCode}');

      try {
        return AttachedParkingLotResponse.fromJson(response.data);
      } catch (e) {
        _logger.e('JSON 파싱 오류: $e');
        throw ApiError(
          type: ApiErrorType.parseError,
          message: 'JSON 파싱 중 오류가 발생했습니다.',
          originalError: e,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('부속 주차장 정보 조회 중 예상치 못한 오류: $e');
      throw ApiError(
        type: ApiErrorType.unknownError,
        message: '부속 주차장 정보 조회 중 예상치 못한 오류가 발생했습니다.',
        originalError: e,
      );
    }
  }

  /// 기존 RAW Response 메서드들 (하위 호환성)
  /// 일반 주차장 정보 조회 (Raw Response)
  Future<Response> getApPklotInfo({
    int pageNo = 1,
    int numOfRows = 10,
    String? sigunguCd,
    String? pklotNm,
  }) async {
    try {
      _logger.d('일반 주차장 정보 조회 요청: pageNo=$pageNo, numOfRows=$numOfRows');

      final params = _buildCommonParams(
        pageNo: pageNo,
        numOfRows: numOfRows,
        sigunguCd: sigunguCd,
        pklotNm: pklotNm,
      );

      final response = await _dio.get(
        _pklotInfoEndpoint,
        queryParameters: params,
      );

      _logger.d('일반 주차장 정보 조회 응답: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('일반 주차장 정보 조회 중 예상치 못한 오류: $e');
      throw ApiError(
        type: ApiErrorType.unknownError,
        message: '일반 주차장 정보 조회 중 예상치 못한 오류가 발생했습니다.',
        originalError: e,
      );
    }
  }

  /// 부설 주차장 정보 조회 (Raw Response)
  Future<Response> getApAtchPklotInfo({
    int pageNo = 1,
    int numOfRows = 10,
    String? sigunguCd,
    String? pklotNm,
  }) async {
    try {
      _logger.d('부설 주차장 정보 조회 요청: pageNo=$pageNo, numOfRows=$numOfRows');

      final params = _buildCommonParams(
        pageNo: pageNo,
        numOfRows: numOfRows,
        sigunguCd: sigunguCd,
        pklotNm: pklotNm,
      );

      final response = await _dio.get(
        _atchPklotInfoEndpoint,
        queryParameters: params,
      );

      _logger.d('부설 주차장 정보 조회 응답: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      _logger.e('부설 주차장 정보 조회 중 예상치 못한 오류: $e');
      throw ApiError(
        type: ApiErrorType.unknownError,
        message: '부설 주차장 정보 조회 중 예상치 못한 오류가 발생했습니다.',
        originalError: e,
      );
    }
  }

  /// API 클라이언트 정리
  void dispose() {
    _dio.close();
    _logger.d('API 클라이언트 정리 완료');
  }
}

/// 로깅 인터셉터
class _LoggingInterceptor extends Interceptor {
  static final Logger _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('🔵 API 요청: ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      '🟢 API 응답: ${response.statusCode} ${response.requestOptions.uri}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '🔴 API 오류: ${err.response?.statusCode} ${err.requestOptions.uri}',
    );
    _logger.e('오류 메시지: ${err.message}');
    super.onError(err, handler);
  }
}

/// 에러 처리 인터셉터
class _ErrorHandlingInterceptor extends Interceptor {
  static final Logger _logger = Logger();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 특정 에러 조건에 대한 추가 처리
    if (err.response?.statusCode == 429) {
      _logger.w('API 호출 한도 초과 - 잠시 후 다시 시도하세요.');
    }

    super.onError(err, handler);
  }
}
