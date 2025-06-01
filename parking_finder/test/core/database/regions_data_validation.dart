import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'package:parking_finder/core/database/migrations/initial_region_data_migration.dart';
import 'dart:io';

void main() {
  group('Regions 데이터 검증', () {
    late DatabaseHelper dbHelper;

    setUpAll(() {
      // FFI 초기화 (테스트 환경용)
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      // 테스트용 파일 데이터베이스 생성 (초기 데이터 마이그레이션 포함)
      final testDbPath = 'test_parking_database.db';
      dbHelper = DatabaseHelper.file(testDbPath);

      // 실제 데이터베이스 초기화
      await dbHelper.database;
    });

    tearDown(() async {
      await dbHelper.close();
      // 테스트 후 파일 정리
      try {
        final file = File('test_parking_database.db');
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print('테스트 데이터베이스 파일 삭제 실패: $e');
      }
    });

    test('sigungu.txt 파일 데이터 개수 확인', () async {
      // sigungu.txt 파일 읽기
      final file = File('scripts/sigungu.txt');
      expect(await file.exists(), isTrue, reason: 'sigungu.txt 파일이 존재해야 합니다');

      final lines = await file.readAsLines();
      // 첫 줄은 헤더, 빈 줄 제외
      final dataLines =
          lines.skip(1).where((line) => line.trim().isNotEmpty).toList();

      print('📄 sigungu.txt 파일의 데이터 라인 수: ${dataLines.length}');

      // 최소 500개 이상의 데이터가 있어야 함
      expect(
        dataLines.length,
        greaterThan(500),
        reason: 'sigungu.txt에 충분한 데이터가 있어야 합니다',
      );
    });

    test('데이터베이스 regions 테이블 데이터 확인', () async {
      final regions = await dbHelper.getAllRegions();
      print('🗂️ 현재 regions 테이블 데이터 개수: ${regions.length}');

      if (regions.isEmpty) {
        print('❌ regions 테이블이 비어있습니다. 데이터 마이그레이션이 필요합니다.');

        // 데이터가 없으면 마이그레이션 실행
        print('🚀 초기 데이터 마이그레이션 실행 중...');

        try {
          await InitialRegionDataMigration.migrate(dbHelper);

          // 마이그레이션 후 다시 확인
          final afterRegions = await dbHelper.getAllRegions();
          print('✅ 마이그레이션 완료: ${afterRegions.length}개 데이터 삽입');
        } catch (e) {
          print('❌ 마이그레이션 실패: $e');
          fail('데이터 마이그레이션이 실패했습니다: $e');
        }
      } else {
        print('✅ regions 테이블에 데이터가 있습니다.');

        // 주요 도시 데이터 확인
        final seoul = await dbHelper.getRegionByCode('11110');
        if (seoul != null) {
          print('✅ 서울특별시 종로구: ${seoul['sigungu_name']}');
        } else {
          print('❌ 서울특별시 종로구 데이터 없음');
        }

        final busan = await dbHelper.getRegionByCode('26110');
        if (busan != null) {
          print('✅ 부산광역시 중구: ${busan['sigungu_name']}');
        } else {
          print('❌ 부산광역시 중구 데이터 없음');
        }
      }
    });

    test('시군구 데이터 샘플 검증', () async {
      // 데이터 존재 확인
      final regions = await dbHelper.getAllRegions();
      expect(regions.isNotEmpty, isTrue, reason: '데이터가 있어야 합니다');

      // 서울특별시 관련 데이터 확인
      final db = await dbHelper.database;
      final seoulRegions = await db.query(
        'regions',
        where: 'sigungu_name LIKE ?',
        whereArgs: ['서울특별시%'],
      );

      print('🏙️ 서울특별시 관련 데이터: ${seoulRegions.length}개');
      if (seoulRegions.isNotEmpty) {
        print(
          '   샘플: ${seoulRegions.take(3).map((r) => r['sigungu_name']).join(', ')}...',
        );
      }

      // 경기도 관련 데이터 확인
      final gyeonggiRegions = await db.query(
        'regions',
        where: 'sigungu_name LIKE ?',
        whereArgs: ['경기도%'],
      );

      print('🏞️ 경기도 관련 데이터: ${gyeonggiRegions.length}개');
      if (gyeonggiRegions.isNotEmpty) {
        print(
          '   샘플: ${gyeonggiRegions.take(3).map((r) => r['sigungu_name']).join(', ')}...',
        );
      }

      // 전체 통계 출력
      print('📊 전체 통계:');
      print('   - 총 지역 수: ${regions.length}');
      print('   - 서울 지역 수: ${seoulRegions.length}');
      print('   - 경기도 지역 수: ${gyeonggiRegions.length}');
    });
  });
}
