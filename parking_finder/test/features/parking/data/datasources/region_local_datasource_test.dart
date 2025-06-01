import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'package:parking_finder/features/parking/data/datasources/region_local_datasource.dart';
import 'package:parking_finder/features/parking/data/models/region_model.dart';

void main() {
  group('RegionLocalDataSource', () {
    late DatabaseHelper databaseHelper;
    late RegionLocalDataSource dataSource;

    setUpAll(() {
      // FFI 초기화 (테스트 환경용)
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      databaseHelper = DatabaseHelper();
      dataSource = RegionLocalDataSourceImpl(databaseHelper);

      // 데이터베이스 초기화
      await databaseHelper.database;
    });

    tearDown(() async {
      // 테스트 후 데이터베이스 정리
      await databaseHelper.deleteDatabase();
    });

    group('insertRegion & getRegionById', () {
      test('지역 삽입 및 조회 테스트', () async {
        // Given
        const testRegion = RegionModel(
          unifiedCode: 1001,
          sigunguCode: '11000',
          sigunguName: '서울특별시',
          isAutonomousDistrict: false,
          parentCode: null,
          level: 1,
        );

        // When
        final insertedId = await dataSource.insertRegion(testRegion);
        final retrievedRegion = await dataSource.getRegionById(1001);

        // Then
        expect(insertedId, greaterThan(0));
        expect(retrievedRegion, isNotNull);
        expect(retrievedRegion!.sigunguName, '서울특별시');
        expect(retrievedRegion.unifiedCode, 1001);
      });

      test('존재하지 않는 지역 조회시 null 반환', () async {
        // When
        final result = await dataSource.getRegionById(99999);

        // Then
        expect(result, isNull);
      });
    });

    group('getRegionBySigunguCode', () {
      test('시군구 코드로 지역 조회 테스트', () async {
        // Given
        const testRegion = RegionModel(
          unifiedCode: 1001,
          sigunguCode: '11000',
          sigunguName: '서울특별시',
          isAutonomousDistrict: false,
          parentCode: null,
          level: 1,
        );
        await dataSource.insertRegion(testRegion);

        // When
        final result = await dataSource.getRegionBySigunguCode('11000');

        // Then
        expect(result, isNotNull);
        expect(result!.sigunguName, '서울특별시');
      });
    });

    group('insertRegions & getAllRegions', () {
      test('여러 지역 일괄 삽입 및 전체 조회 테스트', () async {
        // Given
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
          const RegionModel(
            unifiedCode: 1003,
            sigunguCode: '11140',
            sigunguName: '중구',
            isAutonomousDistrict: true,
            parentCode: '11000',
            level: 2,
          ),
        ];

        // When
        await dataSource.insertRegions(testRegions);
        final allRegions = await dataSource.getAllRegions();

        // Then
        expect(allRegions.length, 3);
        expect(
          allRegions.map((r) => r.sigunguName).toList(),
          containsAll(['서울특별시', '종로구', '중구']),
        );
      });
    });

    group('getRegionsByLevel', () {
      test('레벨별 지역 조회 테스트', () async {
        // Given
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
        await dataSource.insertRegions(testRegions);

        // When
        final level1Regions = await dataSource.getRegionsByLevel(1);
        final level2Regions = await dataSource.getRegionsByLevel(2);

        // Then
        expect(level1Regions.length, 1);
        expect(level1Regions.first.sigunguName, '서울특별시');
        expect(level2Regions.length, 1);
        expect(level2Regions.first.sigunguName, '종로구');
      });
    });

    group('getRegionsByParentCode', () {
      test('상위 지역 코드로 하위 지역 조회 테스트', () async {
        // Given
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
          const RegionModel(
            unifiedCode: 1003,
            sigunguCode: '11140',
            sigunguName: '중구',
            isAutonomousDistrict: true,
            parentCode: '11000',
            level: 2,
          ),
        ];
        await dataSource.insertRegions(testRegions);

        // When
        final subRegions = await dataSource.getRegionsByParentCode('11000');

        // Then
        expect(subRegions.length, 2);
        expect(
          subRegions.map((r) => r.sigunguName).toList(),
          containsAll(['종로구', '중구']),
        );
      });
    });

    group('updateRegion', () {
      test('지역 업데이트 테스트', () async {
        // Given
        const originalRegion = RegionModel(
          unifiedCode: 1001,
          sigunguCode: '11000',
          sigunguName: '서울특별시',
          isAutonomousDistrict: false,
          parentCode: null,
          level: 1,
        );
        await dataSource.insertRegion(originalRegion);

        // When
        const updatedRegion = RegionModel(
          unifiedCode: 1001,
          sigunguCode: '11000',
          sigunguName: '서울특별시 (수정됨)',
          isAutonomousDistrict: false,
          parentCode: null,
          level: 1,
        );
        await dataSource.updateRegion(updatedRegion);

        // Then
        final result = await dataSource.getRegionById(1001);
        expect(result, isNotNull);
        expect(result!.sigunguName, '서울특별시 (수정됨)');
      });

      test('존재하지 않는 지역 업데이트시 예외 발생', () async {
        // Given
        const nonExistentRegion = RegionModel(
          unifiedCode: 99999,
          sigunguCode: '99999',
          sigunguName: '존재하지않는곳',
          isAutonomousDistrict: false,
          parentCode: null,
          level: 1,
        );

        // When & Then
        expect(
          () => dataSource.updateRegion(nonExistentRegion),
          throwsException,
        );
      });
    });

    group('deleteRegion', () {
      test('지역 삭제 테스트', () async {
        // Given
        const testRegion = RegionModel(
          unifiedCode: 1001,
          sigunguCode: '11000',
          sigunguName: '서울특별시',
          isAutonomousDistrict: false,
          parentCode: null,
          level: 1,
        );
        await dataSource.insertRegion(testRegion);

        // When
        await dataSource.deleteRegion(1001);

        // Then
        final result = await dataSource.getRegionById(1001);
        expect(result, isNull);
      });

      test('존재하지 않는 지역 삭제시 예외 발생', () async {
        // When & Then
        expect(() => dataSource.deleteRegion(99999), throwsException);
      });
    });

    group('getRegionCount', () {
      test('지역 개수 조회 테스트', () async {
        // Given
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
        await dataSource.insertRegions(testRegions);

        // When
        final count = await dataSource.getRegionCount();

        // Then
        expect(count, 2);
      });
    });

    group('searchRegionsByName', () {
      test('지역명 검색 테스트', () async {
        // Given
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
          const RegionModel(
            unifiedCode: 1003,
            sigunguCode: '26000',
            sigunguName: '부산광역시',
            isAutonomousDistrict: false,
            parentCode: null,
            level: 1,
          ),
        ];
        await dataSource.insertRegions(testRegions);

        // When
        final seoulResults = await dataSource.searchRegionsByName('서울');
        final guResults = await dataSource.searchRegionsByName('구');

        // Then
        expect(seoulResults.length, 1);
        expect(seoulResults.first.sigunguName, '서울특별시');
        expect(guResults.length, 1);
        expect(guResults.first.sigunguName, '종로구');
      });
    });

    group('deleteAllRegions', () {
      test('모든 지역 삭제 테스트', () async {
        // Given
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
        await dataSource.insertRegions(testRegions);

        // When
        await dataSource.deleteAllRegions();

        // Then
        final count = await dataSource.getRegionCount();
        expect(count, 0);
      });
    });
  });
}
