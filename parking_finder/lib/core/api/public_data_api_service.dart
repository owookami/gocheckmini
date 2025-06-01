import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// 공공데이터포털 API 서비스
class PublicDataApiService {
  static const String _baseUrl = 'https://apis.data.go.kr/1741000/StanReginCd';
  static const String _serviceKey =
      'Ucr8SdMuzgu0G/u9nDmIjIdkh/W8gU181DC6MBXioK11bJbW8OvTrTfVWetBY+kqDeUldK9UxiPlnezZqFZn+w==';

  final Dio _dio;
  final Logger _logger = Logger();

  PublicDataApiService() : _dio = Dio() {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  /// 법정동코드 전체 데이터 가져오기
  Future<List<LegalDistrictCodeModel>> getAllLegalDistrictCodes() async {
    final List<LegalDistrictCodeModel> allData = [];
    int currentPage = 1;
    const int itemsPerPage = 1000; // 한 번에 많이 가져오기

    try {
      _logger.i('🚀 법정동코드 전체 데이터 다운로드 시작');

      while (true) {
        _logger.i('📄 페이지 $currentPage 요청 중...');

        final response = await _dio.get(
          _baseUrl,
          queryParameters: {
            'ServiceKey': _serviceKey,
            'pageNo': currentPage,
            'numOfRows': itemsPerPage,
            'type': 'json',
          },
        );

        if (response.statusCode == 200) {
          final data = response.data;

          if (data is Map<String, dynamic>) {
            final responseBody = data['StanReginCd'];
            if (responseBody != null) {
              final header = responseBody[0] as Map<String, dynamic>;
              final body = responseBody[1] as Map<String, dynamic>;

              final totalCount = int.parse(header['totalCount'].toString());
              final currentCount = int.parse(header['numOfRows'].toString());

              _logger.i('총 데이터 수: $totalCount, 현재 페이지 데이터 수: $currentCount');

              if (body['row'] != null) {
                final rows = body['row'] as List<dynamic>;
                final pageData =
                    rows
                        .map(
                          (row) => LegalDistrictCodeModel.fromJson(
                            row as Map<String, dynamic>,
                          ),
                        )
                        .toList();

                allData.addAll(pageData);
                _logger.i('현재까지 수집된 데이터: ${allData.length}개');

                // 더 이상 데이터가 없으면 종료
                if (rows.length < itemsPerPage ||
                    allData.length >= totalCount) {
                  break;
                }
              } else {
                break; // row가 없으면 종료
              }
            } else {
              break; // responseBody가 없으면 종료
            }
          } else {
            throw Exception('Invalid response format');
          }
        } else {
          throw Exception(
            'HTTP ${response.statusCode}: ${response.statusMessage}',
          );
        }

        currentPage++;

        // API 호출 제한을 위한 딜레이
        await Future.delayed(const Duration(milliseconds: 100));
      }

      _logger.i('✅ 법정동코드 데이터 다운로드 완료: 총 ${allData.length}개');
      return allData;
    } catch (e, stackTrace) {
      _logger.e('❌ 법정동코드 API 호출 실패: $e');
      _logger.e('스택 트레이스: $stackTrace');
      rethrow;
    }
  }

  /// 특정 지역의 법정동코드 조회
  Future<List<LegalDistrictCodeModel>> getLegalDistrictCodesByRegion(
    String regionName,
  ) async {
    try {
      _logger.i('🔍 지역별 법정동코드 조회: $regionName');

      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'ServiceKey': _serviceKey,
          'pageNo': 1,
          'numOfRows': 1000,
          'type': 'json',
          'locatadd_nm': regionName,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          final responseBody = data['StanReginCd'];
          if (responseBody != null && responseBody.length > 1) {
            final body = responseBody[1] as Map<String, dynamic>;

            if (body['row'] != null) {
              final rows = body['row'] as List<dynamic>;
              return rows
                  .map(
                    (row) => LegalDistrictCodeModel.fromJson(
                      row as Map<String, dynamic>,
                    ),
                  )
                  .toList();
            }
          }
        }
      }

      return [];
    } catch (e, stackTrace) {
      _logger.e('❌ 지역별 법정동코드 조회 실패: $e');
      _logger.e('스택 트레이스: $stackTrace');
      return [];
    }
  }
}

/// 법정동코드 모델
class LegalDistrictCodeModel {
  final String regionCd; // 지역코드
  final String sidoCd; // 시도코드
  final String sggCd; // 시군구코드
  final String umdCd; // 읍면동코드
  final String riCd; // 리코드
  final String locatjusoNm; // 지역주소명
  final String locataddNm; // 지역주소명(추가)
  final String locatRm; // 비고
  final String useAt; // 사용여부

  LegalDistrictCodeModel({
    required this.regionCd,
    required this.sidoCd,
    required this.sggCd,
    required this.umdCd,
    required this.riCd,
    required this.locatjusoNm,
    required this.locataddNm,
    required this.locatRm,
    required this.useAt,
  });

  factory LegalDistrictCodeModel.fromJson(Map<String, dynamic> json) {
    return LegalDistrictCodeModel(
      regionCd: json['region_cd']?.toString() ?? '',
      sidoCd: json['sido_cd']?.toString() ?? '',
      sggCd: json['sgg_cd']?.toString() ?? '',
      umdCd: json['umd_cd']?.toString() ?? '',
      riCd: json['ri_cd']?.toString() ?? '',
      locatjusoNm: json['locatjuso_nm']?.toString() ?? '',
      locataddNm: json['locatadd_nm']?.toString() ?? '',
      locatRm: json['locat_rm']?.toString() ?? '',
      useAt: json['use_at']?.toString() ?? 'Y',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region_cd': regionCd,
      'sido_cd': sidoCd,
      'sgg_cd': sggCd,
      'umd_cd': umdCd,
      'ri_cd': riCd,
      'locatjuso_nm': locatjusoNm,
      'locatadd_nm': locataddNm,
      'locat_rm': locatRm,
      'use_at': useAt,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  /// 시도명 추출
  String get provinceNm {
    final parts = locataddNm.split(' ');
    return parts.isNotEmpty ? parts[0] : '';
  }

  /// 시군구명 추출
  String get sigunguNm {
    final parts = locataddNm.split(' ');
    return parts.length > 1 ? parts[1] : '';
  }

  /// 읍면동명 추출
  String get umdNm {
    final parts = locataddNm.split(' ');
    return parts.length > 2 ? parts[2] : '';
  }

  /// 리명 추출
  String get riNm {
    final parts = locataddNm.split(' ');
    return parts.length > 3 ? parts[3] : '';
  }
}
