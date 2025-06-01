import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'package:parking_finder/core/database/database_schema.dart';

void main() {
  group('DatabaseHelper', () {
    late DatabaseHelper databaseHelper;

    setUpAll(() {
      // FFI 초기화 (테스트 환경용)
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() {
      databaseHelper = DatabaseHelper.inMemory();
    });

    tearDown(() async {
      // 테스트 후 데이터베이스 정리
      await databaseHelper.close();
    });

    test('데이터베이스 초기화 테스트', () async {
      // When
      final db = await databaseHelper.database;

      // Then
      expect(db.isOpen, isTrue);

      // 데이터베이스 정보 확인
      final info = await databaseHelper.getDatabaseInfo();
      expect(info['version'], equals(DatabaseSchema.databaseVersion));
      expect(info['tables'], isA<List>());

      final tables = info['tables'] as List;
      expect(tables, contains('regions'));
      expect(tables, contains('bjdongs'));
      expect(tables, contains('parking_lots'));
    });

    test('데이터베이스 무결성 검사 테스트', () async {
      // When
      await databaseHelper.database; // 초기화
      final isIntegrityOk = await databaseHelper.checkIntegrity();

      // Then
      expect(isIntegrityOk, isTrue);
    });

    test('데이터베이스 연결 상태 확인 테스트', () async {
      // When
      final isOpenBefore = await databaseHelper.isOpen();
      await databaseHelper.database; // 초기화
      final isOpenAfter = await databaseHelper.isOpen();

      // Then
      expect(isOpenBefore, isFalse);
      expect(isOpenAfter, isTrue);
    });

    test('배치 작업 테스트', () async {
      // Given
      await databaseHelper.database; // 초기화

      final operations = [
        BatchOperation.insert(DatabaseSchema.regionsTable, {
          'unified_code': 1001,
          'sigungu_code': '11000',
          'sigungu_name': '서울특별시',
          'is_autonomous_district': 0,
        }),
        BatchOperation.insert(DatabaseSchema.regionsTable, {
          'unified_code': 1002,
          'sigungu_code': '11110',
          'sigungu_name': '종로구',
          'is_autonomous_district': 0,
        }),
      ];

      // When
      final results = await databaseHelper.batch(operations);

      // Then
      expect(results, hasLength(2));
      expect(results.every((r) => r is int && r > 0), isTrue);
    });

    test('트랜잭션 테스트', () async {
      // Given
      await databaseHelper.database; // 초기화

      // When
      final result = await databaseHelper.transaction((txn) async {
        await txn.insert(DatabaseSchema.regionsTable, {
          'unified_code': 1001,
          'sigungu_code': '11000',
          'sigungu_name': '서울특별시',
          'is_autonomous_district': 0,
        });

        final count = await txn.query(
          DatabaseSchema.regionsTable,
          where: 'unified_code = ?',
          whereArgs: [1001],
        );

        return count.length;
      });

      // Then
      expect(result, equals(1));
    });

    test('데이터베이스 닫기 테스트', () async {
      // Given
      await databaseHelper.database; // 초기화
      expect(await databaseHelper.isOpen(), isTrue);

      // When
      await databaseHelper.close();

      // Then
      expect(await databaseHelper.isOpen(), isFalse);
    });

    test('BatchOperation 팩토리 메서드 테스트', () {
      // Insert 배치 작업
      final insertOp = BatchOperation.insert('test_table', {
        'id': 1,
        'name': 'test',
      });
      expect(insertOp.type, equals(BatchOperationType.insert));
      expect(insertOp.table, equals('test_table'));
      expect(insertOp.values, equals({'id': 1, 'name': 'test'}));

      // Update 배치 작업
      final updateOp = BatchOperation.update(
        'test_table',
        {'name': 'updated'},
        where: 'id = ?',
        whereArgs: [1],
      );
      expect(updateOp.type, equals(BatchOperationType.update));
      expect(updateOp.where, equals('id = ?'));
      expect(updateOp.whereArgs, equals([1]));

      // Delete 배치 작업
      final deleteOp = BatchOperation.delete(
        'test_table',
        where: 'id = ?',
        whereArgs: [1],
      );
      expect(deleteOp.type, equals(BatchOperationType.delete));
      expect(deleteOp.where, equals('id = ?'));
      expect(deleteOp.whereArgs, equals([1]));
    });

    group('지역 데이터 CRUD 테스트', () {
      test('지역 데이터 삽입/조회 테스트', () async {
        // Given
        final testRegion = {
          'unified_code': 11680,
          'sigungu_code': '11680',
          'sigungu_name': '강남구',
          'is_autonomous_district': 1,
        };

        // When
        final insertId = await databaseHelper.insertRegion(testRegion);
        final retrievedRegion = await databaseHelper.getRegionById(11680);

        // Then
        expect(insertId, 11680);
        expect(retrievedRegion, isNotNull);
        expect(retrievedRegion!['sigungu_name'], '강남구');
        expect(retrievedRegion['sigungu_code'], '11680');
        expect(retrievedRegion['is_autonomous_district'], 1);
      });

      test('지역 데이터 코드로 조회 테스트', () async {
        // Given
        final testRegion = {
          'unified_code': 26440,
          'sigungu_code': '26440',
          'sigungu_name': '부산진구',
          'is_autonomous_district': 0,
        };
        await databaseHelper.insertRegion(testRegion);

        // When
        final retrievedRegion = await databaseHelper.getRegionByCode('26440');

        // Then
        expect(retrievedRegion, isNotNull);
        expect(retrievedRegion!['sigungu_name'], '부산진구');
        expect(retrievedRegion['unified_code'], 26440);
      });

      test('지역 데이터 업데이트 테스트', () async {
        // Given
        final originalRegion = {
          'unified_code': 48170,
          'sigungu_code': '48170',
          'sigungu_name': '양산시',
          'is_autonomous_district': 0,
        };
        await databaseHelper.insertRegion(originalRegion);

        final updatedData = {
          'sigungu_code': '48170',
          'sigungu_name': '양산시(수정)',
          'is_autonomous_district': 1,
        };

        // When
        final updateCount = await databaseHelper.updateRegion(
          48170,
          updatedData,
        );
        final retrievedRegion = await databaseHelper.getRegionById(48170);

        // Then
        expect(updateCount, 1);
        expect(retrievedRegion!['sigungu_name'], '양산시(수정)');
        expect(retrievedRegion['is_autonomous_district'], 1);
      });

      test('지역 데이터 삭제 테스트', () async {
        // Given
        final testRegion = {
          'unified_code': 31140,
          'sigungu_code': '31140',
          'sigungu_name': '울산 중구',
          'is_autonomous_district': 0,
        };
        await databaseHelper.insertRegion(testRegion);

        // When
        final deleteCount = await databaseHelper.deleteRegion(31140);
        final retrievedRegion = await databaseHelper.getRegionById(31140);

        // Then
        expect(deleteCount, 1);
        expect(retrievedRegion, isNull);
      });

      test('지역 이름 검색 테스트', () async {
        // Given
        final regions = [
          {
            'unified_code': 11110,
            'sigungu_code': '11110',
            'sigungu_name': '종로구',
            'is_autonomous_district': 1,
          },
          {
            'unified_code': 11140,
            'sigungu_code': '11140',
            'sigungu_name': '중구',
            'is_autonomous_district': 1,
          },
          {
            'unified_code': 11170,
            'sigungu_code': '11170',
            'sigungu_name': '용산구',
            'is_autonomous_district': 1,
          },
        ];

        for (final region in regions) {
          await databaseHelper.insertRegion(region);
        }

        // When
        final searchResults = await databaseHelper.searchRegionsByName('구');

        // Then
        expect(searchResults.length, 3);
        expect(
          searchResults.map((r) => r['sigungu_name']).toList(),
          containsAll(['종로구', '중구', '용산구']),
        );
      });
    });

    group('법정동 데이터 CRUD 테스트', () {
      test('법정동 데이터 삽입 및 조회 테스트', () async {
        // Given
        await databaseHelper.database; // 초기화

        final bjdongData = {
          'bjdong_code': '1111010100',
          'bjdong_name': '청운동',
          'sido_code': '11',
          'sido_name': '서울특별시',
          'sigungu_code': '11110',
          'sigungu_name': '종로구',
          'bjdong_type': 'dong',
          'is_abolished': 0,
        };

        // When
        final insertedId = await databaseHelper.insertBjdong(bjdongData);
        final retrievedBjdongs = await databaseHelper.getBjdongsByRegion(
          '11110',
        );
        final allBjdongs = await databaseHelper.getAllBjdongs();

        // Then
        expect(insertedId, isA<int>());
        expect(retrievedBjdongs.length, equals(1));
        expect(allBjdongs.length, greaterThanOrEqualTo(1));
        expect(retrievedBjdongs.first['bjdong_name'], equals('청운동'));
      });

      test('법정동 데이터 업데이트 및 삭제 테스트', () async {
        // Given
        await databaseHelper.database; // 초기화

        final bjdongData = {
          'bjdong_code': '1111010200',
          'bjdong_name': '효자동',
          'sido_code': '11',
          'sido_name': '서울특별시',
          'sigungu_code': '11110',
          'sigungu_name': '종로구',
          'bjdong_type': 'dong',
          'is_abolished': 0,
        };

        await databaseHelper.insertBjdong(bjdongData);

        // When & Then (업데이트)
        final updatedData = {
          'bjdong_name': '효자동_수정',
          'updated_at': DateTime.now().toIso8601String(),
        };
        final updateCount = await databaseHelper.updateBjdong(
          '1111010200',
          updatedData,
        );
        expect(updateCount, equals(1));

        // When & Then (삭제)
        final deleteCount = await databaseHelper.deleteBjdong('1111010200');
        expect(deleteCount, equals(1));
      });
    });

    group('주차장 데이터 CRUD 테스트', () {
      test('주차장 데이터 삽입 및 조회 테스트', () async {
        // Given
        await databaseHelper.database; // 초기화

        final parkingLotData = {
          'name': '테스트 주차장',
          'address': '서울특별시 종로구 청운동 123',
          'total_spaces': 100,
          'available_spaces': 50,
          'latitude': 37.5665,
          'longitude': 126.9780,
          'operating_hours': '24시간',
          'parking_fee': '시간당 1000원',
          'phone_number': '02-123-4567',
          'facility_type': '공영주차장',
          'sido_code': '11',
          'sigungu_code': '11110',
          'bjdong_code': '1111010100',
        };

        // When
        final insertedId = await databaseHelper.insertParkingLot(
          parkingLotData,
        );
        final retrievedParkingLots = await databaseHelper
            .getParkingLotsByRegion('11110');
        final allParkingLots = await databaseHelper.getAllParkingLots();

        // Then
        expect(insertedId, isA<int>());
        expect(retrievedParkingLots.length, equals(1));
        expect(allParkingLots.length, greaterThanOrEqualTo(1));
        expect(retrievedParkingLots.first['name'], equals('테스트 주차장'));
      });

      test('주차장 데이터 업데이트 및 삭제 테스트', () async {
        // Given
        await databaseHelper.database; // 초기화

        final parkingLotData = {
          'name': '테스트 주차장2',
          'address': '서울특별시 종로구 효자동 456',
          'total_spaces': 80,
          'available_spaces': 30,
          'sido_code': '11',
          'sigungu_code': '11110',
        };

        final insertedId = await databaseHelper.insertParkingLot(
          parkingLotData,
        );

        // When & Then (업데이트)
        final updatedData = {
          'available_spaces': 40,
          'updated_at': DateTime.now().toIso8601String(),
        };
        final updateCount = await databaseHelper.updateParkingLot(
          insertedId,
          updatedData,
        );
        expect(updateCount, equals(1));

        // When & Then (삭제)
        final deleteCount = await databaseHelper.deleteParkingLot(insertedId);
        expect(deleteCount, equals(1));
      });
    });

    test('데이터베이스 통계 조회 테스트', () async {
      // Given
      await databaseHelper.database; // 초기화

      // When
      final stats = await databaseHelper.getRegionStats();

      // Then
      expect(stats, isA<Map<String, int>>());
      expect(stats['total_regions'], isA<int>());
      expect(stats['autonomous_regions'], isA<int>());
      expect(stats['total_bjdongs'], isA<int>());
      expect(stats['total_parking_lots'], isA<int>());
    });
  });
}
