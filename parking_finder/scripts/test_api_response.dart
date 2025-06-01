import 'dart:convert';
import 'package:dio/dio.dart';

void main() async {
  print('🧪 공공데이터 API 응답 테스트 시작');

  final dio = Dio();
  const serviceKey =
      'Ucr8SdMuzgu0G/u9nDmIjIdkh/W8gU181DC6MBXioK11bJbW8OvTrTfVWetBY+kqDeUldK9UxiPlnezZqFZn+w==';
  const baseUrl = 'https://apis.data.go.kr/1741000/StanReginCd';

  try {
    print('📡 API 호출 중...');

    final response = await dio.get(
      baseUrl,
      queryParameters: {
        'serviceKey': serviceKey,
        'pageNo': '1',
        'numOfRows': '5', // 작은 숫자로 테스트
        'type': 'json',
      },
    );

    print('✅ 응답 코드: ${response.statusCode}');
    print('📄 응답 데이터:');
    print(const JsonEncoder.withIndent('  ').convert(response.data));

    // 응답 구조 분석
    print('\n🔍 응답 구조 분석:');
    if (response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      print('Root keys: ${data.keys.toList()}');

      // StanReginCd 키 확인
      if (data.containsKey('StanReginCd')) {
        final stanReginCd = data['StanReginCd'];
        print('StanReginCd type: ${stanReginCd.runtimeType}');
        print('StanReginCd: $stanReginCd');

        if (stanReginCd is List && stanReginCd.length > 1) {
          print('StanReginCd[0]: ${stanReginCd[0]}');
          print('StanReginCd[1]: ${stanReginCd[1]}');

          if (stanReginCd[1] is Map) {
            final secondElement = stanReginCd[1] as Map;
            print('StanReginCd[1] keys: ${secondElement.keys.toList()}');

            if (secondElement.containsKey('head')) {
              print('head: ${secondElement['head']}');
            }
            if (secondElement.containsKey('row')) {
              final row = secondElement['row'];
              print('row type: ${row.runtimeType}');
              if (row is List && row.isNotEmpty) {
                print('First row: ${row[0]}');
              }
            }
          }
        }
      }
    }
  } catch (e) {
    print('❌ API 호출 실패: $e');
    if (e is DioException && e.response != null) {
      print('응답 코드: ${e.response!.statusCode}');
      print('응답 데이터: ${e.response!.data}');
    }
  }
}
