import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../core/config/env_config.dart';
import '../models/parking_lot_model.dart';
import '../../domain/entities/parking_lot.dart';

enum ParkingSearchType {
  general('일반 주차장'),
  attached('부설 주차장'),
  structure('건축인허가 공작물관리대장');

  const ParkingSearchType(this.description);
  final String description;

  String get displayName => description;
}

/// 주차장 검색 서비스
class ParkingSearchService {
  static const String _baseUrl = 'https://apis.data.go.kr';
  static const String _generalEndpoint =
      '/1613000/ArchPmsHubService/getApPklotInfo';
  static const String _attachedEndpoint =
      '/1613000/ArchPmsHubService/getApAtchPklotInfo';
  static const String _structureEndpoint =
      '/1613000/ArchPmsHubService/getApHdcrMgmRgstInfo';

  late final Dio _dio;
  final Logger _logger = Logger();

  ParkingSearchService() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);

    // JSON 응답 처리를 위한 헤더 설정
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'User-Agent': 'Flutter/1.0',
    };

    // 로깅 인터셉터 추가
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: false, // 큰 응답 때문에 false로 설정
        requestHeader: false,
        responseHeader: false,
        logPrint: (obj) => _logger.d('🌐 $obj'),
      ),
    );
  }

  /// API 키 가져오기
  String get _apiKey {
    // 건축HUB API는 같은 공공데이터 포털 API 키 사용
    final key = EnvConfig.architectureHubApiKey;
    if (key.isEmpty || key == 'your_api_key_here') {
      _logger.w('⚠️ ARCHITECTURE_HUB_API_KEY가 설정되지 않음, 기본 키 사용');
      return 'Ucr8SdMuzgu0G/u9nDmIjIdkh/W8gU181DC6MBXioK11bJbW8OvTrTfVWetBY+kqDeUldK9UxiPlnezZqFZn+w==';
    }
    _logger.d('✅ API 키 로드 성공');
    return key;
  }

  /// 주차장 검색 수행 (페이지네이션 지원)
  Future<List<ParkingLotModel>> searchParking({
    required ParkingSearchType searchType,
    required String sigunguCode,
    required String bjdongCode,
  }) async {
    _logger.i('🔍 ${searchType.description} 검색 시작');
    _logger.d('📍 지역코드: $sigunguCode, 법정동코드: $bjdongCode');

    try {
      // 타입별 엔드포인트 선택
      final endpoint =
          searchType == ParkingSearchType.general
              ? _generalEndpoint
              : searchType == ParkingSearchType.attached
              ? _attachedEndpoint
              : _structureEndpoint;

      _logger.d('🔗 선택된 엔드포인트: $endpoint');

      // 모든 페이지의 데이터를 수집할 리스트
      final allParkingLots = <ParkingLotModel>[];
      int currentPage = 1;
      int totalCount = 0;
      const int numOfRows = 50; // 페이지당 50개

      do {
        _logger.d('📄 페이지 $currentPage 요청 중...');

        // 공통 쿼리 파라미터
        final queryParameters = <String, dynamic>{
          'serviceKey': _apiKey,
          'sigunguCd': sigunguCode,
          'bjdongCd': bjdongCode,
          '_type': 'json',
          'numOfRows': numOfRows.toString(),
          'pageNo': currentPage.toString(),
        };

        // 요청 정보 로깅
        _logger.d('🔍 엔드포인트: $endpoint');
        _logger.d('🔍 요청 파라미터: $queryParameters');

        final response = await _dio.get(
          endpoint,
          queryParameters: queryParameters,
        );

        _logger.d('✅ 페이지 $currentPage API 응답 수신: ${response.statusCode}');

        if (response.statusCode == 200) {
          // 응답 데이터 처리
          dynamic responseData = response.data;
          _logger.d('📊 응답 데이터 타입: ${responseData.runtimeType}');

          // 응답이 비어있는지 확인
          if (responseData == null) {
            _logger.w('⚠️ 페이지 $currentPage 응답이 null입니다');
            break;
          }

          Map<String, dynamic> data;

          if (responseData is Map<String, dynamic>) {
            // 이미 JSON 객체인 경우
            data = responseData;
            _logger.d('📊 JSON 객체로 직접 수신: ${data.keys}');
          } else if (responseData is String) {
            // 문자열 응답인 경우 JSON 파싱
            final responseString = responseData as String;
            _logger.d('📊 문자열 응답 길이: ${responseString.length}');

            if (responseString.isEmpty) {
              _logger.w('⚠️ 페이지 $currentPage 응답 문자열이 비어있습니다');
              break;
            }

            // XML 오류 응답 체크
            if (responseString.contains('<OpenAPI_ServiceResponse>')) {
              _logger.e('❌ 페이지 $currentPage API 오류 응답: $responseString');
              if (responseString.contains('SERVICE ERROR')) {
                throw Exception('API 서비스 오류: 인증 또는 요청 파라미터에 문제가 있습니다.');
              } else if (responseString.contains('HTTP ROUTING ERROR')) {
                throw Exception('API 라우팅 오류: 요청 URL 또는 파라미터에 문제가 있습니다.');
              } else {
                throw Exception('알 수 없는 API 오류가 발생했습니다.');
              }
            }

            // JSON 파싱 시도
            try {
              data = jsonDecode(responseString) as Map<String, dynamic>;
              _logger.d('📊 JSON 파싱 성공: ${data.keys}');
            } catch (parseError) {
              _logger.e('❌ 페이지 $currentPage JSON 파싱 실패: $parseError');
              _logger.d('📊 파싱 실패한 응답: ${responseString.substring(0, 200)}...');
              break;
            }
          } else {
            _logger.e(
              '❌ 페이지 $currentPage 예상치 못한 응답 타입: ${responseData.runtimeType}',
            );
            break;
          }

          // API 응답 검증
          if (!data.containsKey('response')) {
            _logger.e('❌ 페이지 $currentPage 응답에 response 키가 없습니다');
            break;
          }

          final apiResponse = data['response'];
          if (apiResponse is! Map) {
            _logger.e('❌ 페이지 $currentPage response가 Map이 아닙니다');
            break;
          }

          // 헤더 확인
          if (apiResponse.containsKey('header')) {
            final header = apiResponse['header'];
            if (header is Map) {
              final resultCode = header['resultCode']?.toString();
              final resultMsg = header['resultMsg']?.toString();
              _logger.d('📊 API 응답 헤더: $resultCode - $resultMsg');

              if (resultCode != '00') {
                _logger.e('❌ API 오류 응답: $resultCode - $resultMsg');
                throw Exception('API 오류: $resultMsg ($resultCode)');
              }
            }
          }

          // 첫 번째 페이지에서 총 개수 확인
          if (currentPage == 1) {
            if (apiResponse.containsKey('body') &&
                apiResponse['body'] is Map &&
                apiResponse['body']['totalCount'] != null) {
              totalCount =
                  int.tryParse(apiResponse['body']['totalCount'].toString()) ??
                  0;
              _logger.i('📊 총 데이터 개수: $totalCount');

              if (totalCount == 0) {
                _logger.i('📊 검색 결과가 없습니다');
                break;
              }
            }
          }

          // 응답 데이터 파싱
          final pageResults = <ParkingLotModel>[];

          if (apiResponse.containsKey('body')) {
            final body = apiResponse['body'];
            if (body is Map && body.containsKey('items')) {
              final items = body['items'];
              if (items is Map && items.containsKey('item')) {
                final itemList = items['item'];
                final List<dynamic> actualItems =
                    itemList is List ? itemList : [itemList];

                _logger.d('📊 페이지 $currentPage 아이템 개수: ${actualItems.length}');

                int filteredCount = 0;
                for (final item in actualItems) {
                  try {
                    final itemMap = item as Map<String, dynamic>;

                    // 건축인허가 공작물관리대장의 경우 hdcrKindCd가 "06"인 것만 필터링
                    if (searchType == ParkingSearchType.structure) {
                      final hdcrKindCd = itemMap['hdcrKindCd']?.toString();
                      if (hdcrKindCd != '06') {
                        _logger.d('📊 hdcrKindCd $hdcrKindCd는 06이 아니므로 제외');
                        filteredCount++;
                        continue;
                      }
                    }

                    final parkingLot = _mapApiResponseToParkingLot(
                      itemMap,
                      searchType,
                    );
                    if (parkingLot != null) {
                      pageResults.add(parkingLot);
                    }
                  } catch (e) {
                    _logger.w('⚠️ 페이지 $currentPage 개별 주차장 파싱 실패: $e');
                    continue;
                  }
                }

                if (searchType == ParkingSearchType.structure &&
                    filteredCount > 0) {
                  _logger.d(
                    '📊 페이지 $currentPage에서 $filteredCount개 항목이 hdcrKindCd 필터링으로 제외됨',
                  );
                }
              }
            }
          }

          allParkingLots.addAll(pageResults);
          _logger.d(
            '📊 페이지 $currentPage 완료: ${pageResults.length}개 추가, 총 ${allParkingLots.length}개',
          );

          // 다음 페이지 확인 (totalCount 기반)
          currentPage++;

          // 더 이상 데이터가 없거나 모든 데이터를 받았으면 종료
          if (pageResults.isEmpty) {
            _logger.d('📊 더 이상 데이터가 없음 - 검색 종료');
            break;
          }

          // totalCount가 있으면 그것을 기준으로, 없으면 빈 페이지까지 계속
          if (totalCount > 0) {
            final totalPages = ((totalCount - 1) ~/ numOfRows) + 1;
            if (currentPage > totalPages) {
              _logger.d('📊 모든 페이지 ($totalPages) 처리 완료 - 검색 종료');
              break;
            }
          }
        } else {
          _logger.w('⚠️ 페이지 $currentPage 응답 실패: ${response.statusCode}');
          break;
        }
      } while (true);

      _logger.i(
        '✅ ${searchType.description} 총 ${allParkingLots.length}개 조회 완료',
      );
      return allParkingLots;
    } catch (e) {
      _logger.e('❌ 주차장 검색 실패: $e');
      rethrow;
    }
  }

  /// API 응답을 ParkingLotModel로 매핑
  ParkingLotModel? _mapApiResponseToParkingLot(
    Map<String, dynamic> apiData,
    ParkingSearchType searchType,
  ) {
    try {
      _logger.d('📊 매핑할 API 데이터: $apiData');

      // 타입별 매핑 로직
      switch (searchType) {
        case ParkingSearchType.general:
        case ParkingSearchType.attached:
          // 일반/부설 주차장 매핑
          return ParkingLotModel(
            id:
                apiData['mgmPmsrgstPk']?.toString() ??
                apiData['rnum']?.toString() ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            name:
                apiData['bldNm']?.toString() ??
                apiData['relJibunNm']?.toString() ??
                '주차장',
            address: apiData['platPlc']?.toString() ?? '주소 정보 없음',
            detailAddress: apiData['detailAddress']?.toString(),
            type:
                searchType == ParkingSearchType.general
                    ? ParkingLotType.general
                    : ParkingLotType.attached,
            totalCapacity: _parseIntSafely(
              apiData['totPkngCnt'] ?? apiData['totalCapacity'],
            ),
            availableSpots: _parseIntSafely(
              apiData['pkngPosblCnt'] ?? apiData['availableSpots'],
            ),
            operatingHoursStart: apiData['operatingHoursStart']?.toString(),
            operatingHoursEnd: apiData['operatingHoursEnd']?.toString(),
            feeInfo:
                apiData['pkngChrg']?.toString() ??
                apiData['feeInfo']?.toString(),
            phoneNumber: apiData['phoneNumber']?.toString(),
            latitude: _parseDoubleSafely(apiData['latitude']),
            longitude: _parseDoubleSafely(apiData['longitude']),
            facilityInfo: apiData['facilityInfo']?.toString(),
            area: null, // 일반/부설 주차장에는 면적 정보 없음
            managementAgency:
                apiData['institutionName']?.toString() ??
                apiData['managementAgency']?.toString(),
            regionCode:
                '${apiData['sigunguCd'] ?? ''}${apiData['bjdongCd'] ?? ''}',
            lastUpdated: DateTime.now(),
          );

        case ParkingSearchType.structure:
          // 건축인허가 공작물관리대장 매핑
          return ParkingLotModel(
            id:
                apiData['mgmPmsrgstPk']?.toString() ??
                apiData['rnum']?.toString() ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            name:
                apiData['bldNm']?.toString().isNotEmpty == true
                    ? apiData['bldNm'].toString()
                    : '${apiData['hdcrKindCdNm']?.toString() ?? '공작물'} (${apiData['platPlc']?.toString().split(' ').last ?? ''})',
            address: apiData['platPlc']?.toString() ?? '주소 정보 없음',
            detailAddress: apiData['relJibunNm']?.toString(),
            type: ParkingLotType.structure,
            totalCapacity: 0, // 공작물관리대장에는 주차 정보가 없음
            availableSpots: 0,
            operatingHoursStart: null,
            operatingHoursEnd: null,
            feeInfo: null,
            phoneNumber: null,
            latitude: null,
            longitude: null,
            facilityInfo:
                '${apiData['hdcrKindCdNm']?.toString() ?? ''} - ${apiData['strctCdNm']?.toString() ?? ''}',
            area: _parseDoubleSafely(apiData['area']),
            managementAgency: null,
            regionCode:
                '${apiData['sigunguCd'] ?? ''}${apiData['bjdongCd'] ?? ''}',
            lastUpdated: DateTime.now(),
          );
      }
    } catch (e) {
      _logger.e('❌ API 데이터 매핑 실패: $e');
      _logger.e('❌ 문제가 된 데이터: $apiData');
      return null;
    }
  }

  /// 안전한 정수 파싱
  int _parseIntSafely(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  /// 안전한 실수 파싱
  double? _parseDoubleSafely(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  /// 리소스 정리
  void dispose() {
    _dio.close();
  }
}
