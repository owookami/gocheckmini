import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';
import 'package:logger/logger.dart';
import '../models/parking_analysis_model.dart';

/// 건축물 생애이력 관리시스템 크롤링 서비스
class BuildingInfoService {
  static const String _baseUrl = 'https://blcm.go.kr';
  static const String _searchUrl = '/cmm/buildingSearch/buildingInfoSearch.do';

  final Dio _dio;
  final Logger _logger = Logger();

  BuildingInfoService({Dio? dio}) : _dio = dio ?? Dio() {
    _setupDio();
  }

  void _setupDio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      'Accept-Language': 'ko-KR,ko;q=0.9,en;q=0.8',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Upgrade-Insecure-Requests': '1',
    };
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  /// 주소로 건축물 정보 검색
  Future<BuildingBasicInfo> searchBuildingByAddress(String address) async {
    try {
      _logger.i('건축물 정보 검색 시작: $address');

      // 1. 검색 페이지 접근
      final searchResponse = await _dio.get(_searchUrl);
      final searchDocument = html_parser.parse(searchResponse.data);

      // 2. CSRF 토큰 등 필요한 정보 추출
      final csrfToken = _extractCsrfToken(searchDocument);

      // 3. 검색 요청 (주소 기반)
      final searchResult = await _performAddressSearch(address, csrfToken);

      if (searchResult.isEmpty) {
        return const BuildingBasicInfo(
          address: '',
          isSuccess: false,
          errorMessage: '검색 결과가 없습니다.',
        );
      }

      // 4. 첫 번째 결과의 상세 정보 조회
      final buildingInfo = await _getBuildingDetail(searchResult.first);

      return buildingInfo.copyWith(address: address);
    } catch (e, stackTrace) {
      _logger.e('건축물 정보 검색 실패: $e', error: e, stackTrace: stackTrace);
      return BuildingBasicInfo(
        address: address,
        isSuccess: false,
        errorMessage: '검색 중 오류가 발생했습니다: $e',
      );
    }
  }

  /// 도로명 주소로 검색
  Future<List<Map<String, String>>> _performAddressSearch(
    String address,
    String? csrfToken,
  ) async {
    try {
      // 주소를 파싱하여 검색 파라미터 구성
      final addressParts = _parseAddress(address);

      final formData = FormData.fromMap({
        'searchType': 'roadAddr', // 도로명 주소 검색
        'sido': addressParts['sido'] ?? '',
        'sigungu': addressParts['sigungu'] ?? '',
        'roadName': addressParts['roadName'] ?? '',
        'buildingNumber1': addressParts['buildingNumber1'] ?? '',
        'buildingNumber2': addressParts['buildingNumber2'] ?? '',
        if (csrfToken != null) '_csrf': csrfToken,
      });

      final response = await _dio.post(
        '/cmm/buildingSearch/buildingSearchList.do',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );

      return _parseSearchResults(response.data);
    } catch (e) {
      _logger.e('주소 검색 실패: $e');
      return [];
    }
  }

  /// 건축물 상세 정보 조회
  Future<BuildingBasicInfo> _getBuildingDetail(
    Map<String, String> searchResult,
  ) async {
    try {
      final buildingId = searchResult['buildingId'];
      if (buildingId == null) {
        throw Exception('건축물 ID를 찾을 수 없습니다.');
      }

      final response = await _dio.post(
        '/cmm/buildingSearch/buildingDetailInfo.do',
        data: FormData.fromMap({'buildingId': buildingId}),
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );

      return _parseBuildingDetail(response.data);
    } catch (e) {
      _logger.e('건축물 상세 정보 조회 실패: $e');
      return const BuildingBasicInfo(
        address: '',
        isSuccess: false,
        errorMessage: '상세 정보 조회에 실패했습니다.',
      );
    }
  }

  /// CSRF 토큰 추출
  String? _extractCsrfToken(Document document) {
    try {
      final csrfMeta = document.querySelector('meta[name="_csrf"]');
      return csrfMeta?.attributes['content'];
    } catch (e) {
      _logger.w('CSRF 토큰 추출 실패: $e');
      return null;
    }
  }

  /// 주소 파싱
  Map<String, String> _parseAddress(String address) {
    final result = <String, String>{};

    try {
      // 간단한 주소 파싱 로직
      // 예: "서울특별시 강남구 테헤란로 123-45"
      final parts = address.split(' ');

      if (parts.isNotEmpty) {
        result['sido'] = parts[0]; // 시도
      }
      if (parts.length > 1) {
        result['sigungu'] = parts[1]; // 시군구
      }
      if (parts.length > 2) {
        result['roadName'] = parts[2]; // 도로명
      }
      if (parts.length > 3) {
        final buildingNumber = parts[3];
        if (buildingNumber.contains('-')) {
          final numberParts = buildingNumber.split('-');
          result['buildingNumber1'] = numberParts[0];
          if (numberParts.length > 1) {
            result['buildingNumber2'] = numberParts[1];
          }
        } else {
          result['buildingNumber1'] = buildingNumber;
        }
      }
    } catch (e) {
      _logger.e('주소 파싱 실패: $e');
    }

    return result;
  }

  /// 검색 결과 파싱
  List<Map<String, String>> _parseSearchResults(String html) {
    try {
      final document = html_parser.parse(html);
      final results = <Map<String, String>>[];

      // 검색 결과 테이블 파싱
      final rows = document.querySelectorAll('tbody tr');

      for (final row in rows) {
        final cells = row.querySelectorAll('td');
        if (cells.length >= 4) {
          final buildingId =
              row.attributes['data-building-id'] ??
              cells[0].querySelector('input')?.attributes['value'];

          if (buildingId != null) {
            results.add({
              'buildingId': buildingId,
              'address': cells[1].text.trim(),
              'buildingName': cells[2].text.trim(),
              'buildYear': cells[3].text.trim(),
            });
          }
        }
      }

      return results;
    } catch (e) {
      _logger.e('검색 결과 파싱 실패: $e');
      return [];
    }
  }

  /// 건축물 상세 정보 파싱
  BuildingBasicInfo _parseBuildingDetail(String html) {
    try {
      final document = html_parser.parse(html);

      // 상세 정보 추출
      final buildingName = _extractInfoValue(document, '건축물명');
      final buildYear = _extractIntValue(document, '건축년도');
      final structureType = _extractInfoValue(document, '구조형식');
      final buildingUse = _extractInfoValue(document, '주용도');
      final groundFloors = _extractIntValue(document, '지상층수');
      final undergroundFloors = _extractIntValue(document, '지하층수');
      final totalArea = _extractDoubleValue(document, '연면적');
      final landArea = _extractDoubleValue(document, '대지면적');
      final buildingCoverageRatio = _extractDoubleValue(document, '건폐율');
      final floorAreaRatio = _extractDoubleValue(document, '용적률');
      final permitDate = _extractInfoValue(document, '건축허가일');
      final approvalDate = _extractInfoValue(document, '사용승인일');

      return BuildingBasicInfo(
        address: _extractInfoValue(document, '주소') ?? '',
        buildingName: buildingName,
        buildYear: buildYear,
        structureType: structureType,
        buildingUse: buildingUse,
        groundFloors: groundFloors,
        undergroundFloors: undergroundFloors,
        totalArea: totalArea,
        landArea: landArea,
        buildingCoverageRatio: buildingCoverageRatio,
        floorAreaRatio: floorAreaRatio,
        permitDate: permitDate,
        approvalDate: approvalDate,
        isSuccess: true,
      );
    } catch (e) {
      _logger.e('상세 정보 파싱 실패: $e');
      return const BuildingBasicInfo(
        address: '',
        isSuccess: false,
        errorMessage: '상세 정보 파싱에 실패했습니다.',
      );
    }
  }

  /// HTML에서 특정 정보 추출
  String? _extractInfoValue(Document document, String labelText) {
    try {
      // 라벨을 포함하는 th 요소 찾기
      final thElements = document.querySelectorAll('th');
      for (final th in thElements) {
        if (th.text.trim().contains(labelText)) {
          // 다음 td 요소의 값 추출
          final nextTd = th.nextElementSibling;
          if (nextTd?.localName == 'td') {
            return nextTd!.text.trim();
          }
          // 같은 행의 td 찾기
          final row = th.parent;
          final td = row?.querySelector('td');
          return td?.text.trim();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 정수 값 추출
  int? _extractIntValue(Document document, String labelText) {
    final value = _extractInfoValue(document, labelText);
    if (value == null) return null;

    // 숫자만 추출
    final numbers = value.replaceAll(RegExp(r'[^0-9]'), '');
    return numbers.isNotEmpty ? int.tryParse(numbers) : null;
  }

  /// 실수 값 추출
  double? _extractDoubleValue(Document document, String labelText) {
    final value = _extractInfoValue(document, labelText);
    if (value == null) return null;

    // 숫자와 소수점만 추출
    final numbers = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return numbers.isNotEmpty ? double.tryParse(numbers) : null;
  }
}
