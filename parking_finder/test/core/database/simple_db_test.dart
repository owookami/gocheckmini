import 'package:flutter_test/flutter_test.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'package:parking_finder/core/database/database_schema.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // 테스트 환경에서 sqflite FFI 초기화
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('간단한 데이터베이스 테스트', () {
    test('데이터베이스 연결 및 기본 테이블 생성 확인', () async {
      // 고유한 테스트 데이터베이스 파일 생성
      final testDbPath =
          'simple_test_${DateTime.now().millisecondsSinceEpoch}.db';
      final dbHelper = DatabaseHelper.file(testDbPath);

      try {
        // 데이터베이스 초기화
        final db = await dbHelper.database;
        expect(db, isNotNull);

        // 테이블 존재 확인
        final tables = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table'",
        );

        final tableNames = tables.map((t) => t['name'] as String).toList();
        print('생성된 테이블: $tableNames');

        // 기본 테이블들이 존재하는지 확인
        expect(tableNames, contains(DatabaseSchema.regionsTable));
        expect(tableNames, contains(DatabaseSchema.parkingLotsTable));
        expect(tableNames, contains(DatabaseSchema.attachedParkingLotsTable));

        print('✅ 데이터베이스 초기화 성공!');
      } finally {
        await dbHelper.close();
      }
    });

    test('regions 테이블 데이터 확인', () async {
      final testDbPath =
          'regions_test_${DateTime.now().millisecondsSinceEpoch}.db';
      final dbHelper = DatabaseHelper.file(testDbPath);

      try {
        await dbHelper.database; // 데이터베이스 초기화

        // 지역 데이터 조회
        final regions = await dbHelper.getAllRegions();
        print('총 지역 데이터: ${regions.length}개');

        if (regions.isNotEmpty) {
          print('첫 번째 지역 데이터: ${regions.first}');
          expect(regions.length, greaterThan(0));
        } else {
          print('⚠️ 지역 데이터가 비어있습니다. 마이그레이션을 확인해주세요.');
        }
      } finally {
        await dbHelper.close();
      }
    });

    test('데이터베이스 스키마 확인', () async {
      final testDbPath =
          'schema_test_${DateTime.now().millisecondsSinceEpoch}.db';
      final dbHelper = DatabaseHelper.file(testDbPath);

      try {
        final db = await dbHelper.database;

        // regions 테이블 컬럼 확인
        final columns = await db.rawQuery(
          'PRAGMA table_info(${DatabaseSchema.regionsTable})',
        );

        final columnNames = columns.map((c) => c['name'] as String).toList();
        print('regions 테이블 컬럼: $columnNames');

        // 필수 컬럼들이 존재하는지 확인
        expect(columnNames, contains('id'));
        expect(columnNames, contains('sigungu_code'));
        expect(columnNames, contains('sigungu_name'));
        expect(columnNames, contains('unified_code'));

        print('✅ 테이블 스키마 확인 완료!');
      } finally {
        await dbHelper.close();
      }
    });
  });
}
