import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

/// 행정안전부 법정동코드 API 서비스
class StandardRegionApiService {
  final Logger _logger = Logger();
  final http.Client _client = http.Client();

  /// .env에서 API 설정 읽기
  String get baseUrl =>
      dotenv.env['STANDARD_REGION_API_URL'] ??
      'https://apis.data.go.kr/1741000/StanReginCd';
  String get serviceKey => dotenv.env['STANDARD_REGION_API_KEY'] ?? '';

  /// 법정동코드 전체 조회
  Future<List<Map<String, dynamic>>> getAllLegalDistrictCodes({
    int pageNo = 1,
    int numOfRows = 1000,
  }) async {
    try {
      _logger.i('🌐 법정동코드 API 호출 시작 (페이지: $pageNo, 개수: $numOfRows)');

      if (serviceKey.isEmpty) {
        throw Exception('API 인증키가 설정되지 않았습니다. .env 파일을 확인하세요.');
      }

      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'ServiceKey': serviceKey,
          'pageNo': pageNo.toString(),
          'numOfRows': numOfRows.toString(),
          'type': 'json',
        },
      );

      _logger.d('📡 요청 URL: $uri');

      final response = await _client
          .get(
            uri,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json; charset=utf-8',
            },
          )
          .timeout(const Duration(seconds: 30));

      _logger.i('📨 응답 상태 코드: ${response.statusCode}');
      _logger.d(
        '📄 응답 내용 (처음 500자): ${response.body.substring(0, response.body.length > 500 ? 500 : response.body.length)}',
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // 다양한 응답 구조에 대응
        List<Map<String, dynamic>> resultData = [];

        if (jsonData is Map<String, dynamic>) {
          // 패턴 1: StanReginCd > row
          if (jsonData.containsKey('StanReginCd')) {
            final stanData = jsonData['StanReginCd'];
            if (stanData is Map && stanData.containsKey('row')) {
              final rowData = stanData['row'];
              if (rowData is List) {
                resultData = List<Map<String, dynamic>>.from(rowData);
              }
            }
          }
          // 패턴 2: response > body > items
          else if (jsonData.containsKey('response')) {
            final response = jsonData['response'];
            if (response is Map && response.containsKey('body')) {
              final body = response['body'];
              if (body is Map && body.containsKey('items')) {
                final items = body['items'];
                if (items is List) {
                  resultData = List<Map<String, dynamic>>.from(items);
                }
              }
            }
          }
          // 패턴 3: 직접 배열
          else if (jsonData.containsKey('data') && jsonData['data'] is List) {
            resultData = List<Map<String, dynamic>>.from(jsonData['data']);
          }
        }
        // 최상위가 배열인 경우
        else if (jsonData is List) {
          resultData = List<Map<String, dynamic>>.from(jsonData);
        }

        _logger.i('✅ 법정동코드 데이터 파싱 완료: ${resultData.length}개');
        return resultData;
      } else {
        _logger.e('❌ API 호출 실패 - 상태 코드: ${response.statusCode}');
        _logger.e('응답 내용: ${response.body}');
        throw Exception('API 호출 실패: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      _logger.e('❌ 법정동코드 API 호출 중 오류 발생', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// 모든 페이지의 데이터를 가져오기 (전국 전체)
  Future<List<Map<String, dynamic>>> getAllPagesData() async {
    final List<Map<String, dynamic>> allData = [];
    int currentPage = 1;
    const int pageSize = 1000;

    try {
      _logger.i('🚀 전국 법정동코드 전체 데이터 수집 시작');

      while (true) {
        final pageData = await getAllLegalDistrictCodes(
          pageNo: currentPage,
          numOfRows: pageSize,
        );

        if (pageData.isEmpty) {
          _logger.i('📄 더 이상 데이터가 없습니다. (페이지: $currentPage)');
          break;
        }

        allData.addAll(pageData);
        _logger.i('📊 페이지 $currentPage 완료 - 누적 데이터: ${allData.length}개');

        // 페이지 크기보다 적으면 마지막 페이지
        if (pageData.length < pageSize) {
          _logger.i('✅ 마지막 페이지 도달');
          break;
        }

        currentPage++;

        // API 호출 제한을 위한 딜레이
        await Future.delayed(const Duration(milliseconds: 200));
      }

      _logger.i('🎉 전체 데이터 수집 완료: ${allData.length}개');
      return allData;
    } catch (e, stackTrace) {
      _logger.e('❌ 전체 데이터 수집 중 오류 발생', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// API 연결 테스트
  Future<bool> testConnection() async {
    try {
      _logger.i('🔍 API 연결 테스트 시작');

      final testData = await getAllLegalDistrictCodes(pageNo: 1, numOfRows: 1);
      final isSuccess = testData.isNotEmpty;

      if (isSuccess) {
        _logger.i('✅ API 연결 테스트 성공');
      } else {
        _logger.w('⚠️ API 연결 테스트 실패: 데이터 없음');
      }

      return isSuccess;
    } catch (e) {
      _logger.e('❌ API 연결 테스트 실패', error: e);
      return false;
    }
  }

  /// 자원 해제
  void dispose() {
    _client.close();
  }
}
