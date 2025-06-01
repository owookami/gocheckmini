import 'package:flutter_test/flutter_test.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'dart:io';

void main() {
  group('Regions 데이터 확인', () {
    late DatabaseHelper dbHelper;

    setUp(() async {
      dbHelper = DatabaseHelper();
      await dbHelper.database; // 데이터베이스 초기화
    });

    tearDown(() async {
      await dbHelper.close();
    });

    test('regions 테이블 데이터 개수 확인', () async {
      final regions = await dbHelper.getAllRegions();
      print('현재 regions 테이블 데이터 개수: ${regions.length}');

      // sigungu.txt 파일 읽기 (헤더 제외)
      final file = File('scripts/sigungu.txt');
      final lines = await file.readAsLines();
      final dataLines =
          lines
              .skip(2)
              .where((line) => line.trim().isNotEmpty)
              .toList(); // 헤더 2줄 제외

      print('sigungu.txt 파일 데이터 줄 수: ${dataLines.length}');

      if (regions.length == 0) {
        print('❌ regions 테이블이 비어있습니다. 데이터를 삽입해야 합니다.');
      } else if (regions.length != dataLines.length) {
        print(
          '⚠️  데이터 개수가 일치하지 않습니다. (DB: ${regions.length}, 파일: ${dataLines.length})',
        );
      } else {
        print('✅ 데이터 개수가 일치합니다.');
      }

      // 첫 몇 개 데이터 확인
      if (regions.isNotEmpty) {
        print('\n현재 DB의 첫 5개 데이터:');
        for (int i = 0; i < regions.length && i < 5; i++) {
          final region = regions[i];
          print(
            '${region['unified_code']}: ${region['sigungu_code']} - ${region['sigungu_name']}',
          );
        }
      }
    });

    test('특정 지역 데이터 확인', () async {
      // 서울특별시 종로구 (sigungu_code: 11110) 확인
      final jongno = await dbHelper.getRegionByCode('11110');

      if (jongno != null) {
        print('✅ 서울특별시 종로구 데이터 확인: ${jongno['sigungu_name']}');
      } else {
        print('❌ 서울특별시 종로구 데이터가 없습니다.');
      }

      // 경기도 수원시 장안구 (sigungu_code: 41111) 확인
      final suwon = await dbHelper.getRegionByCode('41111');

      if (suwon != null) {
        print('✅ 수원시 장안구 데이터 확인: ${suwon['sigungu_name']}');
      } else {
        print('❌ 수원시 장안구 데이터가 없습니다.');
      }
    });
  });
}
