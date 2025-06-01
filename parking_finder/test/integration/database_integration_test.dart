import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'package:parking_finder/core/database/database_schema.dart';
import 'package:parking_finder/core/database/migrations/initial_region_data_migration.dart';
import 'dart:io';

void main() {
  group('Database Integration Tests', () {
    late DatabaseHelper databaseHelper;
    late Directory tempDir;

    setUpAll(() {
      // FFI 초기화 (테스트 환경용)
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      // 테스트용 임시 디렉토리 생성
      tempDir = Directory.systemTemp.createTempSync('parking_finder_test_');
      databaseHelper = DatabaseHelper.file('${tempDir.path}/test_database.db');
    });

    tearDown(() async {
      // 테스트 후 정리
      await databaseHelper.close();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('데이터베이스 초기화 및 스키마 확인', () async {
      // When
      final db = await databaseHelper.database;

      // Then
      expect(db.isOpen, isTrue);

      // 테이블 존재 확인
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
      );

      final tableNames =
          tables.map((table) => table['name'] as String).toList();
      expect(tableNames, contains(DatabaseSchema.regionsTable));
      expect(tableNames, contains(DatabaseSchema.bjdongsTable));
      expect(tableNames, contains(DatabaseSchema.parkingLotsTable));
    });

    test('실제 sigungu.txt 파일을 이용한 데이터 마이그레이션', () async {
      // Given
      await databaseHelper.database; // 데이터베이스 초기화

      // When
      await InitialRegionDataMigration.migrate(databaseHelper);

      // Then
      final regions = await databaseHelper.getAllRegions();
      expect(regions.length, greaterThan(0));

      // 서울특별시 종로구 확인
      final jongno = await databaseHelper.getRegionByCode('11110');
      expect(jongno, isNotNull);
      expect(jongno!['sigungu_name'], equals('종로구'));
    });

    test('대용량 데이터 처리 성능 테스트', () async {
      // Given
      await databaseHelper.database;
      final stopwatch = Stopwatch()..start();

      // When
      for (int i = 0; i < 1000; i++) {
        await databaseHelper.insertRegion({
          'unified_code': 11110 + i,
          'sigungu_code': '11${(110 + i).toString().padLeft(3, '0')}',
          'sigungu_name': '테스트구$i',
          'is_autonomous_district': 0,
        });
      }

      stopwatch.stop();

      // Then
      final regions = await databaseHelper.getAllRegions();
      expect(regions.length, greaterThanOrEqualTo(1000));
      expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // 5초 이내
    });

    test('트랜잭션 롤백 테스트', () async {
      // Given
      final db = await databaseHelper.database;

      // When & Then
      try {
        await db.transaction((txn) async {
          await txn.insert(DatabaseSchema.regionsTable, {
            'unified_code': 99999,
            'sigungu_code': '99999',
            'sigungu_name': '테스트구',
            'is_autonomous_district': 0,
          });

          // 의도적으로 에러 발생
          throw Exception('테스트 에러');
        });
      } catch (e) {
        // 예상된 에러
      }

      // 롤백 확인
      final region = await databaseHelper.getRegionByCode('99999');
      expect(region, isNull);
    });

    test('외래키 제약 조건 확인', () async {
      // Given
      await databaseHelper.database;

      // 지역 데이터 삽입
      await databaseHelper.insertRegion({
        'unified_code': 11110,
        'sigungu_code': '11110',
        'sigungu_name': '종로구',
        'is_autonomous_district': 0,
      });

      // When & Then
      // 올바른 외래키로 법정동 삽입 (성공)
      final bjdongId = await databaseHelper.insertBjdong({
        'bjdong_code': '1111010100',
        'sido_code': '11',
        'sigungu_code': '11110',
        'bjdong_name': '청운동',
      });
      expect(bjdongId, greaterThan(0));

      // 잘못된 외래키로 법정동 삽입 시도 (실패)
      expect(
        () => databaseHelper.insertBjdong({
          'bjdong_code': '9999910100',
          'sido_code': '99',
          'sigungu_code': '99999',
          'bjdong_name': '존재하지않는동',
        }),
        throwsA(isA<Exception>()),
      );
    });

    test('인덱스 성능 확인', () async {
      // Given
      await databaseHelper.database;

      // 테스트 데이터 삽입
      for (int i = 0; i < 100; i++) {
        await databaseHelper.insertRegion({
          'unified_code': 11110 + i,
          'sigungu_code': '11${(110 + i).toString().padLeft(3, '0')}',
          'sigungu_name': '테스트구$i',
          'is_autonomous_district': 0,
        });
      }

      // When
      final stopwatch = Stopwatch()..start();
      final regions = await databaseHelper.searchRegionsByName('테스트구5');
      stopwatch.stop();

      // Then
      expect(regions.length, greaterThan(0));
      expect(stopwatch.elapsedMilliseconds, lessThan(100)); // 100ms 이내
    });

    test('데이터 무결성 확인', () async {
      // Given
      await databaseHelper.database;

      // When
      await databaseHelper.insertRegion({
        'unified_code': 11110,
        'sigungu_code': '11110',
        'sigungu_name': '종로구',
        'is_autonomous_district': 0,
      });

      await databaseHelper.insertBjdong({
        'bjdong_code': '1111010100',
        'sido_code': '11',
        'sigungu_code': '11110',
        'bjdong_name': '청운동',
      });

      await databaseHelper.insertParkingLot({
        'name': '종로구청 주차장',
        'address': '서울시 종로구 청운동',
        'total_spaces': 100,
        'available_spaces': 50,
        'sido_code': '11',
        'sigungu_code': '11110',
        'latitude': 37.5665,
        'longitude': 126.9780,
      });

      // Then
      final stats = await databaseHelper.getRegionStats();
      expect(stats['total_regions'], equals(1));
      expect(stats['total_bjdongs'], equals(1));
      expect(stats['total_parking_lots'], equals(1));
    });

    test('동시성 테스트', () async {
      // Given
      await databaseHelper.database;

      // When
      final futures = <Future>[];
      for (int i = 0; i < 10; i++) {
        futures.add(
          databaseHelper.insertRegion({
            'unified_code': 11110 + i,
            'sigungu_code': '11${(110 + i).toString().padLeft(3, '0')}',
            'sigungu_name': '테스트구$i',
            'is_autonomous_district': 0,
          }),
        );
      }

      await Future.wait(futures);

      // Then
      final regions = await databaseHelper.getAllRegions();
      expect(regions.length, equals(10));
    });

    test('데이터베이스 재시작 후 데이터 지속성 확인', () async {
      // Given - 첫 번째 세션
      await databaseHelper.database;

      await databaseHelper.insertRegion({
        'unified_code': 11110,
        'sigungu_code': '11110',
        'sigungu_name': '종로구',
        'is_autonomous_district': 0,
      });

      await databaseHelper.close();

      // When - 새로운 세션
      final newDatabaseHelper = DatabaseHelper.file(
        '${tempDir.path}/test_database.db',
      );

      // Then
      final regions = await newDatabaseHelper.getAllRegions();
      expect(regions.length, equals(1));
      expect(regions.first['sigungu_name'], equals('종로구'));

      await newDatabaseHelper.close();
    });
  });
}
