import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:parking_finder/core/database/migrations/initial_region_data_migration.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'package:parking_finder/core/database/database_schema.dart';
import 'package:parking_finder/features/parking/data/models/region_model.dart';

void main() {
  group('InitialRegionDataMigration', () {
    late DatabaseHelper databaseHelper;

    setUpAll(() {
      // FFI 초기화 (테스트 환경용)
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() {
      databaseHelper = DatabaseHelper();
    });

    tearDown(() async {
      // 테스트 후 데이터베이스 정리
      await databaseHelper.deleteDatabase();
    });

    test('시군구 데이터 파싱 기능 테스트', () async {
      // Given: 테스트용 시군구 데이터
      const testData = '''통합분류코드	시군구코드	시군구명	비자치구여부
1000	1000	국토교통부	미해당
1001	11000	서울특별시	미해당
1002	11110	종로구	해당
1003	11140	중구	해당
1004	26000	부산광역시	미해당
1005	26110	중구	해당''';

      // When: 파싱 기능 테스트 (내부 파싱 로직만 테스트)
      final lines =
          testData.split('\n').where((line) => line.trim().isNotEmpty).toList();

      final dataLines = lines.skip(1).toList(); // 헤더 제거
      final regions = <RegionModel>[];

      for (final line in dataLines) {
        final regionModel = InitialRegionDataMigration.parseRegionLineForTest(
          line,
        );
        if (regionModel != null) {
          regions.add(regionModel);
        }
      }

      // Then: 결과 검증
      expect(regions.length, equals(5));

      // 첫 번째 레코드 검증 (국토교통부)
      expect(regions[0].unifiedCode, equals(1000));
      expect(regions[0].sigunguCode, equals('1000'));
      expect(regions[0].sigunguName, equals('국토교통부'));
      expect(regions[0].isAutonomousDistrict, isFalse);
      expect(regions[0].level, equals(1));

      // 서울특별시 검증
      expect(regions[1].unifiedCode, equals(1001));
      expect(regions[1].sigunguCode, equals('11000'));
      expect(regions[1].sigunguName, equals('서울특별시'));
      expect(regions[1].isAutonomousDistrict, isFalse);
      expect(regions[1].level, equals(1));

      // 종로구 검증 (자치구)
      expect(regions[2].unifiedCode, equals(1002));
      expect(regions[2].sigunguCode, equals('11110'));
      expect(regions[2].sigunguName, equals('종로구'));
      expect(regions[2].isAutonomousDistrict, isTrue);
      expect(regions[2].level, equals(2));
      expect(regions[2].parentCode, equals('11000'));
    });

    test('빈 데이터베이스에서 지역 개수 확인 테스트', () async {
      // Given: 빈 데이터베이스
      final db = await databaseHelper.database;

      // When: 지역 개수 조회
      final count = await db.rawQuery('SELECT COUNT(*) as count FROM regions');
      final regionCount = count.first['count'] as int;

      // Then: 개수가 0이어야 함
      expect(regionCount, equals(0));
    });

    test('배치 삽입 기능 테스트', () async {
      // Given: 테스트 데이터
      final testRegions = [
        const RegionModel(
          unifiedCode: 1001,
          sigunguCode: '11000',
          sigunguName: '서울특별시',
          isAutonomousDistrict: false,
          parentCode: null,
          level: 1,
        ),
        const RegionModel(
          unifiedCode: 1002,
          sigunguCode: '11110',
          sigunguName: '종로구',
          isAutonomousDistrict: true,
          parentCode: '11000',
          level: 2,
        ),
      ];

      final db = await databaseHelper.database;

      // When: 배치 삽입 실행
      await InitialRegionDataMigration.insertRegionsInBatchForTest(
        db,
        testRegions,
      );

      // Then: 데이터 확인
      final result = await db.query('regions', orderBy: 'unified_code ASC');
      expect(result.length, equals(2));

      final region1 = RegionModel.fromJson(result[0]);
      expect(region1.sigunguName, equals('서울특별시'));
      expect(region1.level, equals(1));

      final region2 = RegionModel.fromJson(result[1]);
      expect(region2.sigunguName, equals('종로구'));
      expect(region2.level, equals(2));
      expect(region2.parentCode, equals('11000'));
    });

    test('데이터베이스 테이블 구조 확인 테스트', () async {
      // Given: 초기화된 데이터베이스
      final db = await databaseHelper.database;

      // When: 테이블 정보 조회
      final tableInfo = await db.rawQuery("PRAGMA table_info(regions)");

      // Then: 테이블 구조 검증
      expect(tableInfo.isNotEmpty, isTrue);

      final columnNames =
          tableInfo.map((row) => row['name'] as String).toList();
      expect(columnNames, contains('unified_code'));
      expect(columnNames, contains('sigungu_code'));
      expect(columnNames, contains('sigungu_name'));
      expect(columnNames, contains('is_autonomous_district'));
      expect(columnNames, contains('parent_code'));
      expect(columnNames, contains('level'));
      expect(columnNames, contains('created_at'));
      expect(columnNames, contains('updated_at'));
    });

    test('외래키 제약조건 확인 테스트', () async {
      // Given: 초기화된 데이터베이스
      final db = await databaseHelper.database;

      // When: 외래키 정보 조회
      final foreignKeys = await db.rawQuery("PRAGMA foreign_key_list(bjdongs)");

      // Then: 외래키 제약조건 확인
      expect(foreignKeys.isNotEmpty, isTrue);
      final fkInfo = foreignKeys.first;
      expect(fkInfo['table'], equals('regions'));
      expect(fkInfo['from'], equals('sigungu_code'));
      expect(fkInfo['to'], equals('sigungu_code'));
    });

    test('마이그레이션 상태 확인 테스트', () async {
      // Given: 빈 데이터베이스
      // When: 마이그레이션 상태 확인
      final status = await InitialRegionDataMigration.getMigrationStatus();

      // Then: 상태 검증
      expect(status['isCompleted'], isFalse);
      expect(status['regionCount'], equals(0));
      expect(status['migrationName'], equals('InitialRegionDataMigration'));
      expect(status['timestamp'], isA<String>());
    });
  });
}
