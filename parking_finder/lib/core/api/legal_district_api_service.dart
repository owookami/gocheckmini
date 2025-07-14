import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// 법정동코드 API 응답 데이터 모델
class LegalDistrictCodeResponseItem {
  final String regionCode;
  final String sidoCode;
  final String emdCode;
  final String liCode;
  final String regionAddrName;

  LegalDistrictCodeResponseItem({
    required this.regionCode,
    required this.sidoCode,
    required this.emdCode,
    required this.liCode,
    required this.regionAddrName,
  });

  factory LegalDistrictCodeResponseItem.fromJson(Map<String, dynamic> json) {
    return LegalDistrictCodeResponseItem(
      regionCode: json['region_cd']?.toString() ?? '',
      sidoCode: json['sido_cd']?.toString() ?? '',
      emdCode: json['emd_cd']?.toString() ?? '',
      liCode: json['li_cd']?.toString() ?? '',
      regionAddrName: json['locatadd_nm']?.toString() ?? '',
    );
  }
}

/// 법정동코드 API 응답 모델
class LegalDistrictCodeResponse {
  final int totalCount;
  final int pageNo;
  final int numOfRows;
  final List<LegalDistrictCodeResponseItem> items;

  LegalDistrictCodeResponse({
    required this.totalCount,
    required this.pageNo,
    required this.numOfRows,
    required this.items,
  });

  factory LegalDistrictCodeResponse.fromJson(Map<String, dynamic> json) {
    final response = json['StanReginCd']?[1];
    final header = response?['head']?[1];
    final body = response?['row'];

    final totalCount =
        int.tryParse(header?['totalCount']?.toString() ?? '0') ?? 0;
    final pageNo = int.tryParse(header?['pageNo']?.toString() ?? '1') ?? 1;
    final numOfRows =
        int.tryParse(header?['numOfRows']?.toString() ?? '10') ?? 10;

    final List<LegalDistrictCodeResponseItem> items = [];
    if (body != null && body is List) {
      for (final item in body) {
        if (item is Map<String, dynamic>) {
          items.add(LegalDistrictCodeResponseItem.fromJson(item));
        }
      }
    }

    return LegalDistrictCodeResponse(
      totalCount: totalCount,
      pageNo: pageNo,
      numOfRows: numOfRows,
      items: items,
    );
  }
}

/// 공공데이터포털 법정동코드 API 서비스
class LegalDistrictApiService {
  static const String _baseUrl = 'https://apis.data.go.kr/1741000/StanReginCd';
  static const String _serviceKey =
      'Ucr8SdMuzgu0G/u9nDmIjIdkh/W8gU181DC6MBXioK11bJbW8OvTrTfVWetBY+kqDeUldK9UxiPlnezZqFZn+w==';

  final Dio _dio;
  final Logger _logger = Logger();

  LegalDistrictApiService() : _dio = Dio() {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  /// 전체 법정동코드 데이터 가져오기
  Future<List<LegalDistrictCodeResponseItem>> getAllLegalDistrictCodes() async {
    final List<LegalDistrictCodeResponseItem> allData = [];
    int currentPage = 1;
    const int itemsPerPage = 1000; // 한 번에 많이 가져오기
    bool hasMoreData = true;

    try {
      _logger.i('🚀 법정동코드 전체 데이터 다운로드 시작');

      while (hasMoreData) {
        _logger.i('📥 페이지 $currentPage 요청 중...');

        final response = await _fetchPage(currentPage, itemsPerPage);

        if (response.items.isEmpty) {
          _logger.i('📄 페이지 $currentPage: 데이터 없음. 다운로드 완료');
          hasMoreData = false;
        } else {
          allData.addAll(response.items);
          _logger.i(
            '📄 페이지 $currentPage: ${response.items.length}개 항목 수신 (총 ${allData.length}개)',
          );

          // 현재 페이지가 마지막 페이지인지 확인
          final totalPages = (response.totalCount / itemsPerPage).ceil();
          if (currentPage >= totalPages) {
            hasMoreData = false;
            _logger.i(
              '📋 총 ${response.totalCount}개 항목 중 ${allData.length}개 다운로드 완료',
            );
          } else {
            currentPage++;
            // API 호출 제한을 위한 짧은 대기
            await Future.delayed(const Duration(milliseconds: 100));
          }
        }
      }

      _logger.i('✅ 법정동코드 데이터 다운로드 완료: ${allData.length}개');
      return allData;
    } catch (e, stackTrace) {
      _logger.e('❌ 법정동코드 데이터 다운로드 실패', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// 특정 페이지 데이터 가져오기
  Future<LegalDistrictCodeResponse> _fetchPage(
    int pageNo,
    int numOfRows,
  ) async {
    try {
      final queryParameters = {
        'serviceKey': _serviceKey,
        'pageNo': pageNo.toString(),
        'numOfRows': numOfRows.toString(),
        'type': 'json',
      };

      _logger.d('🌐 API 요청: $_baseUrl');
      _logger.d('📋 파라미터: $queryParameters');

      final response = await _dio.get(
        _baseUrl,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        _logger.d('✅ API 응답 성공 (페이지 $pageNo)');
        return LegalDistrictCodeResponse.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'HTTP ${response.statusCode}: API 호출 실패',
        );
      }
    } on DioException catch (e) {
      _logger.e('❌ API 호출 실패 (페이지 $pageNo)', error: e);
      final errorResponse = e.response;
      if (errorResponse != null) {
        _logger.e('응답 데이터: ${errorResponse.data}');
      }
      rethrow;
    } catch (e) {
      _logger.e('❌ 예상치 못한 오류 (페이지 $pageNo)', error: e);
      rethrow;
    }
  }

  /// 특정 지역으로 필터링해서 데이터 가져오기
  Future<List<LegalDistrictCodeResponseItem>> getLegalDistrictCodesByRegion(
    String regionName,
  ) async {
    try {
      _logger.i('🔍 지역별 법정동코드 검색: $regionName');

      const int itemsPerPage = 1000;
      final queryParameters = {
        'serviceKey': _serviceKey,
        'pageNo': '1',
        'numOfRows': itemsPerPage.toString(),
        'type': 'json',
        'locatadd_nm': regionName,
      };

      final response = await _dio.get(
        _baseUrl,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final responseData = LegalDistrictCodeResponse.fromJson(response.data);
        _logger.i('✅ 지역 검색 완료: ${responseData.items.length}개 결과');
        return responseData.items;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'HTTP ${response.statusCode}: API 호출 실패',
        );
      }
    } catch (e) {
      _logger.e('❌ 지역별 검색 실패: $regionName', error: e);
      rethrow;
    }
  }
}
