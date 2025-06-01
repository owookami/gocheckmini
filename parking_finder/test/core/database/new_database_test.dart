import 'package:flutter_test/flutter_test.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'package:parking_finder/core/database/database_schema.dart';
import 'package:parking_finder/core/database/migrations/sigungu_data_migration.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // 테스트 환경에서 sqflite FFI 초기화
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('새로운 데이터베이스 구조 테스트', () {
    late DatabaseHelper dbHelper;

    setUp(() async {
      // 고유한 테스트 데이터베이스 파일 생성
      final testDbPath = 'test_${DateTime.now().millisecondsSinceEpoch}.db';
      dbHelper = DatabaseHelper.file(testDbPath);
      await dbHelper.database; // 데이터베이스 초기화
    });

    tearDown(() async {
      await dbHelper.close();
    });

    test('데이터베이스 초기화 및 테이블 존재 확인', () async {
      final db = await dbHelper.database;

      // 테이블 존재 확인
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table'",
      );

      final tableNames = tables.map((t) => t['name'] as String).toList();

      print('생성된 테이블: $tableNames');

      expect(tableNames, contains(DatabaseSchema.regionsTable));
      expect(tableNames, contains(DatabaseSchema.parkingLotsTable));
      expect(tableNames, contains(DatabaseSchema.attachedParkingLotsTable));
    });

    test('regions 테이블 스키마 확인', () async {
      final db = await dbHelper.database;

      final columns = await db.rawQuery(
        'PRAGMA table_info(${DatabaseSchema.regionsTable})',
      );

      final columnNames = columns.map((c) => c['name'] as String).toList();

      print('regions 테이블 컬럼: $columnNames');

      expect(columnNames, contains('id'));
      expect(columnNames, contains('unified_code'));
      expect(columnNames, contains('sigungu_code'));
      expect(columnNames, contains('sigungu_name'));
      expect(columnNames, contains('is_autonomous_district'));
      expect(columnNames, contains('province'));
      expect(columnNames, contains('city'));
      expect(columnNames, contains('district'));
    });

    test('sigungu.txt 데이터 마이그레이션 확인', () async {
      // 지역 데이터 조회
      final regions = await dbHelper.getAllRegions();

      print('마이그레이션된 지역 데이터 수: ${regions.length}');

      // sigungu.txt에는 580개 정도의 데이터가 있어야 함
      expect(regions.length, greaterThan(500));

      // 몇 가지 주요 지역 확인
      final seoul = await dbHelper.getRegionByCode('11110');
      expect(seoul, isNotNull);
      expect(seoul!['sigungu_name'], '서울특별시 종로구');
      print('서울특별시 종로구: $seoul');

      final busan = await dbHelper.getRegionByCode('26110');
      expect(busan, isNotNull);
      expect(busan!['sigungu_name'], '부산광역시 중구');
      print('부산광역시 중구: $busan');
    });

    test('지역별 데이터 조회 테스트', () async {
      // 서울특별시 지역들 조회
      final seoulRegions = await dbHelper.getRegionsByProvince('서울특별시');

      print('서울특별시 지역 수: ${seoulRegions.length}');
      expect(seoulRegions.length, greaterThan(20)); // 서울은 25개 구

      // 경기도 지역들 조회
      final gyeonggiRegions = await dbHelper.getRegionsByProvince('경기도');

      print('경기도 지역 수: ${gyeonggiRegions.length}');
      expect(gyeonggiRegions.length, greaterThan(30)); // 경기도는 31개 시군
    });

    test('지역 검색 기능 테스트', () async {
      // '서울' 키워드로 검색
      final seoulResults = await dbHelper.searchRegionsByName('서울');

      print('서울 검색 결과: ${seoulResults.length}개');
      expect(seoulResults.length, greaterThan(0));

      // 모든 결과가 서울을 포함하는지 확인
      for (final region in seoulResults) {
        expect(region['sigungu_name'], contains('서울'));
      }
    });

    test('데이터베이스 통계 확인', () async {
      final stats = await dbHelper.getDatabaseStats();

      print('데이터베이스 통계: $stats');

      expect(stats['regions'], greaterThan(500));
      expect(stats['parking_lots'], equals(0)); // 아직 주차장 데이터는 없음
      expect(stats['attached_parking_lots'], equals(0)); // 아직 부설 주차장 데이터는 없음
    });

    test('주차장 데이터 CRUD 테스트', () async {
      // 샘플 주차장 데이터 삽입
      final sampleParkingLot = {
        'parking_place_no': 'TEST001',
        'parking_place_name': '테스트 주차장',
        'sigungu_code': '11110',
        'sigungu_name': '서울특별시 종로구',
        'address': '서울특별시 종로구 테스트로 1',
        'parking_space_count': 100,
        'latitude': 37.5665,
        'longitude': 126.978,
      };

      final insertId = await dbHelper.insertParkingLot(sampleParkingLot);
      expect(insertId, greaterThan(0));

      // 삽입된 데이터 조회
      final retrievedLot = await dbHelper.getParkingLotByNo('TEST001');
      expect(retrievedLot, isNotNull);
      expect(retrievedLot!['parking_place_name'], '테스트 주차장');

      // 지역별 주차장 조회
      final regionLots = await dbHelper.getParkingLotsByRegion('11110');
      expect(regionLots.length, equals(1));

      // 데이터 업데이트
      await dbHelper.updateParkingLot('TEST001', {
        'parking_place_name': '업데이트된 테스트 주차장',
        'parking_space_count': 150,
      });

      final updatedLot = await dbHelper.getParkingLotByNo('TEST001');
      expect(updatedLot!['parking_place_name'], '업데이트된 테스트 주차장');
      expect(updatedLot['parking_space_count'], 150);

      // 데이터 삭제
      final deleteCount = await dbHelper.deleteParkingLot('TEST001');
      expect(deleteCount, equals(1));

      final deletedLot = await dbHelper.getParkingLotByNo('TEST001');
      expect(deletedLot, isNull);
    });

    test('부설 주차장 데이터 CRUD 테스트', () async {
      // 샘플 부설 주차장 데이터 삽입
      final sampleAttachedLot = {
        'parking_place_no': 'ATTACH001',
        'parking_place_name': '테스트 부설 주차장',
        'sigungu_code': '11110',
        'sigungu_name': '서울특별시 종로구',
        'address': '서울특별시 종로구 테스트로 2',
        'building_name': '테스트 빌딩',
        'total_parking_space': 50,
        'current_parking_space': 30,
        'latitude': 37.5665,
        'longitude': 126.978,
      };

      final insertId = await dbHelper.insertAttachedParkingLot(
        sampleAttachedLot,
      );
      expect(insertId, greaterThan(0));

      // 삽입된 데이터 조회
      final retrievedLot = await dbHelper.getAttachedParkingLotByNo(
        'ATTACH001',
      );
      expect(retrievedLot, isNotNull);
      expect(retrievedLot!['parking_place_name'], '테스트 부설 주차장');

      // 지역별 부설 주차장 조회
      final regionLots = await dbHelper.getAttachedParkingLotsByRegion('11110');
      expect(regionLots.length, equals(1));

      // 데이터 삭제
      final deleteCount = await dbHelper.deleteAttachedParkingLot('ATTACH001');
      expect(deleteCount, equals(1));
    });
  });
}
