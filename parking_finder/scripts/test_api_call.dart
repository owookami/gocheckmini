import 'dart:io';
import 'package:dio/dio.dart';

void main() async {
  // 여러 지역으로 테스트
  await testMultipleRegions();
}

Future<void> testMultipleRegions() async {
  final testCases = [
    {'name': '서울시 중구', 'sigunguCd': '11000', 'bjdongCd': '11140'},
    {'name': '서울시 강남구', 'sigunguCd': '11000', 'bjdongCd': '11680'},
    {'name': '서울시 종로구', 'sigunguCd': '11000', 'bjdongCd': '11110'},
    {'name': '경기도 수원시', 'sigunguCd': '41000', 'bjdongCd': '41110'},
  ];

  for (final testCase in testCases) {
    print('\n${'=' * 60}');
    print('🌍 ${testCase['name']} 테스트');
    print('=' * 60);

    await testSingleRegion(
      testCase['name']!,
      testCase['sigunguCd']!,
      testCase['bjdongCd']!,
    );
  }
}

Future<void> testSingleRegion(
  String regionName,
  String sigunguCd,
  String bjdongCd,
) async {
  final dio = Dio();

  // JSON 응답을 받기 위해 ResponseType을 json으로 설정
  dio.options.responseType = ResponseType.json;

  // gzip 압축 처리를 위한 헤더 설정
  dio.options.headers = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'User-Agent': 'Flutter App',
  };

  // 사용자가 제공한 정확한 API 키 (디코딩된 상태)
  const apiKey =
      'Ucr8SdMuzgu0G/u9nDmIjIdkh/W8gU181DC6MBXioK11bJbW8OvTrTfVWetBY+kqDeUldK9UxiPlnezZqFZn+w==';

  final url =
      'https://apis.data.go.kr/1613000/ArchPmsHubService/getApAtchPklotInfo';

  print('🔍 API 테스트: $regionName');
  print('📍 시군구코드: $sigunguCd, 법정동코드: $bjdongCd');

  try {
    final response = await dio.get(
      url,
      queryParameters: {
        'serviceKey': apiKey, // Dio가 자동으로 URL 인코딩 처리
        'sigunguCd': sigunguCd,
        'bjdongCd': bjdongCd,
        'pageNo': 1,
        'numOfRows': 10,
        '_type': 'json', // JSON 응답 요청 (_type 파라미터 사용)
      },
    );

    print('✅ 응답 상태: ${response.statusCode}');
    print('📋 응답 헤더: ${response.headers}');

    if (response.data != null) {
      print('📄 응답 타입: ${response.data.runtimeType}');

      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        print('📄 JSON 응답 받음!');

        // response 객체 확인
        if (data.containsKey('response')) {
          final responseData = data['response'] as Map<String, dynamic>;

          // header 정보 확인
          if (responseData.containsKey('header')) {
            final header = responseData['header'] as Map<String, dynamic>;
            print('📊 결과 코드: ${header['resultCode']}');
            print('💬 결과 메시지: ${header['resultMsg']}');

            if (header['resultCode'] == '00') {
              print('✅ API 호출 성공!');
            } else {
              print('❌ API 오류 코드: ${header['resultCode']}');
              return;
            }
          }

          // body 정보 확인
          if (responseData.containsKey('body')) {
            final body = responseData['body'] as Map<String, dynamic>;

            if (body.containsKey('totalCount')) {
              final totalCount = body['totalCount'];
              print('📊 총 개수: $totalCount');

              if (totalCount == '0' || totalCount == 0) {
                print('⚠️ 해당 지역에 부설주차장 데이터가 없습니다.');
              } else {
                print('🏢 부설주차장 데이터 발견!');

                if (body.containsKey('items')) {
                  final items = body['items'];
                  if (items is Map && items.containsKey('item')) {
                    final itemList = items['item'];
                    if (itemList is List) {
                      print('📋 주차장 목록 (${itemList.length}개):');
                      for (int i = 0; i < itemList.length && i < 3; i++) {
                        final item = itemList[i] as Map<String, dynamic>;
                        print(
                          '  ${i + 1}. ${item['bldNm'] ?? '이름없음'} - ${item['platPlc'] ?? '주소없음'}',
                        );
                        print(
                          '     총 ${item['totPkngCnt'] ?? '?'}면, 현재 ${item['curPkngCnt'] ?? '?'}대 주차',
                        );
                      }
                      if (itemList.length > 3) {
                        print('  ... 외 ${itemList.length - 3}개 더');
                      }
                    } else if (itemList is Map) {
                      // 단일 항목인 경우
                      print('📋 주차장 정보:');
                      print('  - 이름: ${itemList['bldNm'] ?? '이름없음'}');
                      print('  - 주소: ${itemList['platPlc'] ?? '주소없음'}');
                      print('  - 총 주차면수: ${itemList['totPkngCnt'] ?? '?'}면');
                      print('  - 현재 주차대수: ${itemList['curPkngCnt'] ?? '?'}대');
                    }
                  }
                }
              }
            }
          }
        }

        // 전체 JSON 구조 출력 (처음 500자만)
        final jsonStr = data.toString();
        if (jsonStr.length > 500) {
          print('📄 JSON 응답 샘플: ${jsonStr.substring(0, 500)}...');
        } else {
          print('📄 전체 JSON 응답: $jsonStr');
        }
      } else {
        print('⚠️ 예상과 다른 응답 형식: ${response.data}');
        print('📄 실제 응답 내용: ${response.data.toString()}');
      }
    } else {
      print('⚠️ 응답이 null입니다.');
    }
  } catch (e) {
    print('❌ API 호출 실패: $e');
    if (e is DioException) {
      print('🔍 DioException 상세:');
      print('  - Type: ${e.type}');
      print('  - Message: ${e.message}');
      if (e.response != null) {
        print('  - Status: ${e.response!.statusCode}');
        print('  - Data: ${e.response!.data}');
        print('  - Headers: ${e.response!.headers}');
      }
    }
  }
}
