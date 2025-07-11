import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../../../../core/config/env_config.dart';
import '../../../../core/utils/web_utils.dart';
import '../models/standard_region_model.dart';

/// 행정안전부 표준 지역 코드 서비스
class StandardRegionService {
  static const String _baseUrl = 'https://apis.data.go.kr';
  static const String _endpoint = '/1741000/StanReginCd/getStanReginCdList';

  late final Dio _dio;
  final Logger _logger = Logger();

  StandardRegionService() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    // API 응답 형식을 자동으로 처리하기 위해 plain으로 설정
    _dio.options.responseType = ResponseType.plain;

    // 쿼리 파라미터 인코딩 설정
    _dio.options.listFormat = ListFormat.multiCompatible;

    // 웹 환경에서는 User-Agent 헤더 제거 (CORS 문제 방지)
    if (kIsWeb) {
      _dio.options.headers = {};
    } else {
      _dio.options.headers = {'User-Agent': 'ParkingFinderApp/1.0'};
    }

    // 로깅 인터셉터 추가
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        logPrint: (object) => _logger.d(object),
      ),
    );
  }

  /// API 키 가져오기
  String get _apiKey {
    final key = EnvConfig.standardRegionApiKey;
    if (key.isEmpty || key == 'your_api_key_here') {
      _logger.w('⚠️ STANDARD_REGION_API_KEY가 설정되지 않음');
    } else {
      _logger.d('✅ API 키 로드 성공');
    }
    // 원본 키 그대로 반환 (Dio가 자동으로 인코딩)
    return key;
  }

  /// 쿼리 파라미터를 URL에 포함시키는 헬퍼 메서드
  String _buildUrlWithParams(String baseUrl, Map<String, dynamic> params) {
    final uri = Uri.parse(baseUrl);
    final newUri = uri.replace(queryParameters: {
      ...uri.queryParameters,
      ...params.map((key, value) => MapEntry(key, value.toString()))
    });
    return newUri.toString();
  }

  /// 웹 환경에서 API 호출을 위한 헬퍼 메서드
  Future<Response> _makeApiCall(Map<String, dynamic> queryParameters) async {
    if (kIsWeb) {
      // 웹 환경: 프록시를 통해 호출하고 쿼리 파라미터를 URL에 포함
      final fullUrl = _buildUrlWithParams('$_baseUrl$_endpoint', queryParameters);
      final proxiedUrl = WebUtils.getApiUrl(fullUrl);
      
      _logger.d('🔍 프록시 URL: $proxiedUrl');
      
      return await _dio.get(
        proxiedUrl,
        options: Options(
          headers: {}, // 웹에서는 헤더 제거
        ),
      );
    } else {
      // 모바일 환경: 일반적인 호출
      _logger.d('🔍 요청 URL: $_baseUrl$_endpoint');
      _logger.d('🔍 요청 파라미터: $queryParameters');
      
      return await _dio.get(
        _endpoint,
        queryParameters: queryParameters,
      );
    }
  }

  /// 시도 목록 조회 (최상위 지역)
  Future<List<StandardRegion>> getSidoList() async {
    _logger.i('📍 시도 목록 조회 요청');

    try {
      // 요청 파라미터 준비
      final queryParameters = {
        'serviceKey': _apiKey,
        'type': 'json',
        'numOfRows': '50',
        'pageNo': '1',
        'umd_cd': '000', // 읍면동 코드가 000인 것들 (시도/시군구만)
        'sgg_cd': '000', // 시군구 코드가 000인 것들 (시도만)
      };

      // API 호출 (웹/모바일 환경에 따라 다른 방식 사용)
      final response = await _makeApiCall(queryParameters);

      _logger.d('✅ API 응답 수신: ${response.statusCode}');
      if (!kIsWeb) {
        _logger.d('📊 응답 헤더: ${response.headers}');
      }

      if (response.statusCode == 200) {
        final responseData = response.data as String;
        _logger.d('📊 응답 데이터 타입: ${responseData.runtimeType}');
        _logger.d(
          '📊 응답 내용 (처음 500자): ${responseData.length > 500 ? responseData.substring(0, 500) : responseData}',
        );

        // XML 오류 응답 체크
        if (responseData.contains('<OpenAPI_ServiceResponse>')) {
          _logger.e('❌ API 오류 응답: $responseData');

          // XML 오류 메시지 파싱
          if (responseData.contains('SERVICE ERROR')) {
            throw Exception('API 서비스 오류: 인증 또는 요청 파라미터에 문제가 있습니다.');
          } else if (responseData.contains('HTTP ROUTING ERROR')) {
            throw Exception('API 라우팅 오류: 요청 URL 또는 파라미터에 문제가 있습니다.');
          } else {
            throw Exception('알 수 없는 API 오류가 발생했습니다.');
          }
        }

        // JSON 파싱 시도
        Map<String, dynamic> data;
        try {
          data = jsonDecode(responseData) as Map<String, dynamic>;
        } catch (e) {
          _logger.e('❌ JSON 파싱 실패: $e');
          _logger.e('❌ 응답 내용: $responseData');
          throw Exception('JSON 파싱에 실패했습니다. 응답이 올바른 JSON 형식이 아닙니다.');
        }

        _logger.d('📊 응답 데이터 키들: ${data.keys}');

        // 응답 구조를 안전하게 파싱
        try {
          // 먼저 StanReginCd가 있는지 확인
          if (data.containsKey('StanReginCd')) {
            final stanReginCd = data['StanReginCd'];
            _logger.d('🔍 StanReginCd 타입: ${stanReginCd.runtimeType}');

            if (stanReginCd is List) {
              _logger.d('🔍 StanReginCd 길이: ${stanReginCd.length}');

              if (stanReginCd.length > 1) {
                final rowData = stanReginCd[1];
                _logger.d('🔍 rowData 타입: ${rowData.runtimeType}');
                _logger.d(
                  '🔍 rowData 키들: ${rowData is Map ? rowData.keys : 'Not a Map'}',
                );

                if (rowData is Map && rowData.containsKey('row')) {
                  final rows = rowData['row'];
                  _logger.d('🔍 rows 타입: ${rows.runtimeType}');

                  if (rows is List) {
                    _logger.d('🔍 rows 길이: ${rows.length}');

                    // 첫 번째 항목으로 파싱 테스트
                    if (rows.isNotEmpty) {
                      final firstRow = rows.first;
                      _logger.d('🔍 첫 번째 행: $firstRow');
                      _logger.d('🔍 첫 번째 행 타입: ${firstRow.runtimeType}');

                      try {
                        final testRegion = StandardRegion.fromJson(
                          firstRow as Map<String, dynamic>,
                        );
                        _logger.d('✅ 파싱 테스트 성공: ${testRegion.locataddNm}');
                      } catch (parseError) {
                        _logger.e('❌ 파싱 테스트 실패: $parseError');
                        return [];
                      }
                    }

                    // 모든 항목 파싱
                    final regions = <StandardRegion>[];
                    for (final row in rows) {
                      try {
                        final region = StandardRegion.fromJson(
                          row as Map<String, dynamic>,
                        );
                        if (region.type == RegionType.sido) {
                          regions.add(region);
                        }
                      } catch (e) {
                        _logger.w('⚠️ 개별 항목 파싱 실패: $e, 데이터: $row');
                        continue;
                      }
                    }

                    _logger.i('✅ 시도 ${regions.length}개 조회 완료');
                    return regions;
                  }
                }
              }
            }
          }

          _logger.w('⚠️ 응답 구조가 예상과 다름');
          return [];
        } catch (parseError) {
          _logger.e('❌ 응답 파싱 오류: $parseError');
          return [];
        }
      }

      _logger.w('⚠️ 응답 실패: ${response.statusCode}');
      return [];
    } catch (e) {
      _logger.e('❌ 시도 목록 조회 실패: $e');
      rethrow;
    }
  }

  /// 특정 시도의 시군구 목록 조회
  Future<List<StandardRegion>> getSigunguList(String sidoCode) async {
    _logger.i('📍 시군구 목록 조회 요청: $sidoCode');

    try {
      // 요청 파라미터 준비
      final queryParameters = {
        'serviceKey': _apiKey,
        'type': 'json',
        'numOfRows': '100',
        'pageNo': '1',
        'sido_cd': sidoCode,
        'umd_cd': '000', // 읍면동 코드가 000인 것들 (시군구까지만)
      };

      // API 호출 (웹/모바일 환경에 따라 다른 방식 사용)
      final response = await _makeApiCall(queryParameters);

      _logger.d('✅ API 응답 수신: ${response.statusCode}');
      if (!kIsWeb) {
        _logger.d('📊 응답 헤더: ${response.headers}');
      }

      if (response.statusCode == 200) {
        final responseData = response.data as String;
        _logger.d('📊 응답 데이터 타입: ${responseData.runtimeType}');
        _logger.d(
          '📊 응답 내용 (처음 500자): ${responseData.length > 500 ? responseData.substring(0, 500) : responseData}',
        );

        // XML 오류 응답 체크
        if (responseData.contains('<OpenAPI_ServiceResponse>')) {
          _logger.e('❌ API 오류 응답: $responseData');

          // XML 오류 메시지 파싱
          if (responseData.contains('SERVICE ERROR')) {
            throw Exception('API 서비스 오류: 인증 또는 요청 파라미터에 문제가 있습니다.');
          } else if (responseData.contains('HTTP ROUTING ERROR')) {
            throw Exception('API 라우팅 오류: 요청 URL 또는 파라미터에 문제가 있습니다.');
          } else {
            throw Exception('알 수 없는 API 오류가 발생했습니다.');
          }
        }

        // JSON 파싱 시도
        Map<String, dynamic> data;
        try {
          data = jsonDecode(responseData) as Map<String, dynamic>;
        } catch (e) {
          _logger.e('❌ JSON 파싱 실패: $e');
          _logger.e('❌ 응답 내용: $responseData');
          throw Exception('JSON 파싱에 실패했습니다. 응답이 올바른 JSON 형식이 아닙니다.');
        }

        _logger.d('📊 응답 데이터 키들: ${data.keys}');

        // 응답 구조를 안전하게 파싱
        try {
          // 먼저 StanReginCd가 있는지 확인
          if (data.containsKey('StanReginCd')) {
            final stanReginCd = data['StanReginCd'];
            _logger.d('🔍 StanReginCd 타입: ${stanReginCd.runtimeType}');

            if (stanReginCd is List) {
              _logger.d('🔍 StanReginCd 길이: ${stanReginCd.length}');

              if (stanReginCd.length > 1) {
                final rowData = stanReginCd[1];
                _logger.d('🔍 rowData 타입: ${rowData.runtimeType}');
                _logger.d(
                  '🔍 rowData 키들: ${rowData is Map ? rowData.keys : 'Not a Map'}',
                );

                if (rowData is Map && rowData.containsKey('row')) {
                  final rows = rowData['row'];
                  _logger.d('🔍 rows 타입: ${rows.runtimeType}');

                  if (rows is List) {
                    _logger.d('🔍 rows 길이: ${rows.length}');

                    // 첫 번째 항목으로 파싱 테스트
                    if (rows.isNotEmpty) {
                      final firstRow = rows.first;
                      _logger.d('🔍 첫 번째 행: $firstRow');
                      _logger.d('🔍 첫 번째 행 타입: ${firstRow.runtimeType}');

                      try {
                        final testRegion = StandardRegion.fromJson(
                          firstRow as Map<String, dynamic>,
                        );
                        _logger.d('✅ 파싱 테스트 성공: ${testRegion.locataddNm}');
                      } catch (parseError) {
                        _logger.e('❌ 파싱 테스트 실패: $parseError');
                        return [];
                      }
                    }

                    // 모든 항목 파싱
                    final regions = <StandardRegion>[];
                    for (final row in rows) {
                      try {
                        final region = StandardRegion.fromJson(
                          row as Map<String, dynamic>,
                        );
                        if (region.type == RegionType.sigungu) {
                          regions.add(region);
                        }
                      } catch (e) {
                        _logger.w('⚠️ 개별 항목 파싱 실패: $e, 데이터: $row');
                        continue;
                      }
                    }

                    _logger.i('✅ 시군구 ${regions.length}개 조회 완료');
                    return regions;
                  }
                }
              }
            }
          }

          _logger.w('⚠️ 응답 구조가 예상과 다름');
          return [];
        } catch (parseError) {
          _logger.e('❌ 응답 파싱 오류: $parseError');
          return [];
        }
      }

      _logger.w('⚠️ 응답 실패: ${response.statusCode}');
      return [];
    } catch (e) {
      _logger.e('❌ 시군구 목록 조회 실패: $e');
      rethrow;
    }
  }

  /// 특정 시군구의 읍면동 목록 조회
  Future<List<StandardRegion>> getUmdList(
    String sidoCode,
    String sggCode,
  ) async {
    _logger.i('📍 읍면동 목록 조회 요청: $sidoCode-$sggCode');

    try {
      // 요청 파라미터 준비
      final queryParameters = {
        'serviceKey': _apiKey,
        'type': 'json',
        'numOfRows': '500',
        'pageNo': '1',
        'sido_cd': sidoCode,
        'sgg_cd': sggCode,
      };

      // 요청 정보 로깅
      _logger.d('🔍 요청 URL: ${_dio.options.baseUrl}$_endpoint');
      _logger.d('🔍 요청 파라미터: $queryParameters');

      final response = await _dio.get(
        _endpoint,
        queryParameters: queryParameters,
      );

      _logger.d('✅ API 응답 수신: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = response.data as String;
        _logger.d('📊 응답 데이터 타입: ${responseData.runtimeType}');

        // XML 오류 응답 체크
        if (responseData.contains('<OpenAPI_ServiceResponse>')) {
          _logger.e('❌ API 오류 응답: $responseData');
          throw Exception('API 오류가 발생했습니다.');
        }

        // JSON 파싱 시도
        Map<String, dynamic> data;
        try {
          data = jsonDecode(responseData) as Map<String, dynamic>;
        } catch (e) {
          _logger.e('❌ JSON 파싱 실패: $e');
          throw Exception('JSON 파싱에 실패했습니다.');
        }

        // 응답 구조를 안전하게 파싱
        if (data.containsKey('StanReginCd')) {
          final stanReginCd = data['StanReginCd'];
          if (stanReginCd is List && stanReginCd.length > 1) {
            final rowData = stanReginCd[1];
            if (rowData is Map && rowData.containsKey('row')) {
              final rows = rowData['row'];
              if (rows is List) {
                final regions = <StandardRegion>[];
                for (final row in rows) {
                  try {
                    final region = StandardRegion.fromJson(
                      row as Map<String, dynamic>,
                    );
                    if (region.type == RegionType.umd) {
                      regions.add(region);
                    }
                  } catch (e) {
                    _logger.w('⚠️ 개별 항목 파싱 실패: $e');
                    continue;
                  }
                }

                _logger.i('✅ 읍면동 ${regions.length}개 조회 완료');
                return regions;
              }
            }
          }
        }

        _logger.w('⚠️ 응답 구조가 예상과 다름');
        return [];
      }

      _logger.w('⚠️ 응답 실패: ${response.statusCode}');
      return [];
    } catch (e) {
      _logger.e('❌ 읍면동 목록 조회 실패: $e');
      rethrow;
    }
  }

  /// 모든 지역 정보 조회 (캐시용)
  Future<List<StandardRegion>> getAllRegions() async {
    _logger.i('📍 전체 지역 정보 조회 요청');

    try {
      final response = await _dio.get(
        _endpoint,
        queryParameters: {
          'serviceKey': _apiKey,
          'type': 'json',
          'numOfRows': '50000', // 충분히 큰 수
          'pageNo': '1',
        },
      );

      _logger.d('✅ API 응답 수신: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data;
        _logger.d('📊 응답 데이터: $data');

        // 응답 구조: {"StanReginCd": [{"head": [...]], {"row": [...]}]}
        final stanReginCd = data['StanReginCd'];
        if (stanReginCd is List && stanReginCd.length > 1) {
          final rowData = stanReginCd[1];
          if (rowData is Map && rowData['row'] is List) {
            final rows = rowData['row'] as List;
            final regions =
                rows
                    .map(
                      (row) =>
                          StandardRegion.fromJson(row as Map<String, dynamic>),
                    )
                    .toList();

            _logger.i('✅ 전체 지역 ${regions.length}개 조회 완료');
            return regions;
          }
        }

        _logger.w('⚠️ 응답 구조가 예상과 다름');
        return [];
      }

      _logger.w('⚠️ 응답 실패: ${response.statusCode}');
      return [];
    } catch (e) {
      _logger.e('❌ 전체 지역 정보 조회 실패: $e');
      rethrow;
    }
  }

  /// 지역명으로 검색
  Future<List<StandardRegion>> searchRegions(String keyword) async {
    _logger.i('📍 지역 검색 요청: $keyword');

    try {
      final response = await _dio.get(
        _endpoint,
        queryParameters: {
          'serviceKey': _apiKey,
          'type': 'json',
          'numOfRows': '100',
          'pageNo': '1',
          'locatadd_nm': keyword,
        },
      );

      _logger.d('✅ API 응답 수신: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data;
        _logger.d('📊 응답 데이터: $data');

        // 응답 구조: {"StanReginCd": [{"head": [...]], {"row": [...]}]}
        final stanReginCd = data['StanReginCd'];
        if (stanReginCd is List && stanReginCd.length > 1) {
          final rowData = stanReginCd[1];
          if (rowData is Map && rowData['row'] is List) {
            final rows = rowData['row'] as List;
            final regions =
                rows
                    .map(
                      (row) =>
                          StandardRegion.fromJson(row as Map<String, dynamic>),
                    )
                    .toList();

            _logger.i('✅ 검색 결과 ${regions.length}개 조회 완료');
            return regions;
          }
        }

        _logger.w('⚠️ 응답 구조가 예상과 다름');
        return [];
      }

      _logger.w('⚠️ 응답 실패: ${response.statusCode}');
      return [];
    } catch (e) {
      _logger.e('❌ 지역 검색 실패: $e');
      rethrow;
    }
  }
}
