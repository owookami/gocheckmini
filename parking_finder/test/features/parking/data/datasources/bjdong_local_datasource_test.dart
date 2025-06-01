import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:parking_finder/core/database/database_helper.dart';
import 'package:parking_finder/features/parking/data/datasources/bjdong_local_datasource.dart';
import 'package:parking_finder/features/parking/data/models/bjdong_model.dart';
import 'package:parking_finder/features/parking/data/models/region_model.dart';
import 'package:parking_finder/features/parking/domain/entities/bjdong.dart';

void main() {
  group('BjdongLocalDataSource', () {
    late DatabaseHelper databaseHelper;
    late BjdongLocalDataSource dataSource;

    setUpAll(() {
      // FFI 초기화 (테스트 환경용)
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      // 메모리 데이터베이스 사용으로 각 테스트가 독립적으로 실행
      databaseHelper = DatabaseHelper.inMemory();
      await databaseHelper.database;
      dataSource = BjdongLocalDataSourceImpl(databaseHelper);
    });

    tearDown(() async {
      await databaseHelper.close();
    });

    // 헬퍼 메서드: 테스트용 지역 데이터 삽입
    Future<void> insertTestRegion(
      String sigunguCode,
      String sigunguName,
    ) async {
      try {
        final testRegion = RegionModel(
          unifiedCode: int.parse(sigunguCode),
          sigunguCode: sigunguCode,
          sigunguName: sigunguName,
          isAutonomousDistrict: false,
          parentCode: sigunguCode.substring(0, 2),
          level: 2,
        );

        final db = await databaseHelper.database;
        await db.insert('regions', testRegion.toJson());
      } catch (e) {
        // 이미 존재하는 경우 무시
        print('Region already exists: $sigunguCode');
      }
    }

    group('getAllBjdongs', () {
      test('모든 법정동 조회 테스트', () async {
        // Given
        await insertTestRegion('11110', '종로구');

        final testBjdongs = [
          const BjdongModel(
            bjdongCode: '1111010100',
            bjdongName: '청운동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11110',
            sigunguName: '종로구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
          const BjdongModel(
            bjdongCode: '1111010200',
            bjdongName: '신교동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11110',
            sigunguName: '종로구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
        ];

        for (final bjdong in testBjdongs) {
          await dataSource.insertBjdong(bjdong);
        }

        // When
        final result = await dataSource.getAllBjdongs();

        // Then
        expect(result, isA<List<BjdongModel>>());
        expect(result.length, equals(2));
        expect(result.map((b) => b.bjdongName), containsAll(['청운동', '신교동']));
      });
    });

    group('getBjdongByCode', () {
      test('법정동 코드로 조회 성공 테스트', () async {
        // Given
        await insertTestRegion('11120', '중구');

        const testBjdong = BjdongModel(
          bjdongCode: '1112010100',
          bjdongName: '소공동',
          sidoCode: '11',
          sidoName: '서울특별시',
          sigunguCode: '11120',
          sigunguName: '중구',
          bjdongType: BjdongType.dong,
          isAbolished: false,
          createdDate: DateTime.now(),
        );

        await dataSource.insertBjdong(testBjdong);

        // When
        final result = await dataSource.getBjdongByCode('1112010100');

        // Then
        expect(result, isNotNull);
        expect(result!.bjdongName, equals('소공동'));
        expect(result.bjdongCode, equals('1112010100'));
      });

      test('존재하지 않는 법정동 코드 조회 테스트', () async {
        // When
        final result = await dataSource.getBjdongByCode('9999999999');

        // Then
        expect(result, isNull);
      });
    });

    group('getBjdongsBySidoCode', () {
      test('시도별 법정동 조회 테스트', () async {
        // Given
        await insertTestRegion('11130', '용산구');
        await insertTestRegion('11140', '성동구');

        final testBjdongs = [
          const BjdongModel(
            bjdongCode: '1113010100',
            bjdongName: '후암동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11130',
            sigunguName: '용산구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
          const BjdongModel(
            bjdongCode: '1114010100',
            bjdongName: '왕십리동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11140',
            sigunguName: '성동구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
        ];

        for (final bjdong in testBjdongs) {
          await dataSource.insertBjdong(bjdong);
        }

        // When
        final result = await dataSource.getBjdongsBySidoCode('11');

        // Then
        expect(result, isA<List<BjdongModel>>());
        expect(result.length, equals(2));
        expect(result.every((b) => b.sidoCode == '11'), isTrue);
      });
    });

    group('getBjdongsBySigunguCode', () {
      test('시군구별 법정동 조회 테스트', () async {
        // Given
        await insertTestRegion('11150', '중구');

        final testBjdongs = [
          const BjdongModel(
            bjdongCode: '1115010100',
            bjdongName: '황학동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11150',
            sigunguName: '중구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
          const BjdongModel(
            bjdongCode: '1115010200',
            bjdongName: '중림동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11150',
            sigunguName: '중구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
        ];

        for (final bjdong in testBjdongs) {
          await dataSource.insertBjdong(bjdong);
        }

        // When
        final result = await dataSource.getBjdongsBySigunguCode('11150');

        // Then
        expect(result, isA<List<BjdongModel>>());
        expect(result.length, equals(2));
        expect(result.every((b) => b.sigunguCode == '11150'), isTrue);
      });
    });

    group('getActiveBjdongs', () {
      test('활성 법정동 조회 테스트', () async {
        // Given
        await insertTestRegion('11160', '종로구');

        final testBjdongs = [
          const BjdongModel(
            bjdongCode: '1116010100',
            bjdongName: '청운동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11160',
            sigunguName: '종로구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
          BjdongModel(
            bjdongCode: '1116010200',
            bjdongName: '신교동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11160',
            sigunguName: '종로구',
            bjdongType: BjdongType.dong,
            isAbolished: true,
            createdDate: DateTime(2020, 1, 1),
          ),
        ];

        for (final bjdong in testBjdongs) {
          await dataSource.insertBjdong(bjdong);
        }

        // When
        final result = await dataSource.getActiveBjdongs();

        // Then
        expect(result, isA<List<BjdongModel>>());
        expect(result.length, equals(1));
        expect(result.first.bjdongName, equals('청운동'));
        expect(result.every((b) => !b.isAbolished), isTrue);
      });
    });

    group('insertBjdong', () {
      test('법정동 삽입 테스트', () async {
        // Given
        await insertTestRegion('11170', '강남구');

        const testBjdong = BjdongModel(
          bjdongCode: '1117010100',
          bjdongName: '신사동',
          sidoCode: '11',
          sidoName: '서울특별시',
          sigunguCode: '11170',
          sigunguName: '강남구',
          bjdongType: BjdongType.dong,
          isAbolished: false,
          createdDate: DateTime.now(),
        );

        // When
        await dataSource.insertBjdong(testBjdong);

        // Then
        final result = await dataSource.getBjdongByCode('1117010100');
        expect(result, isNotNull);
        expect(result!.bjdongName, equals('신사동'));
      });
    });

    group('updateBjdong', () {
      test('법정동 업데이트 테스트', () async {
        // Given
        await insertTestRegion('11180', '강남구');

        const originalBjdong = BjdongModel(
          bjdongCode: '1118010100',
          bjdongName: '논현동',
          sidoCode: '11',
          sidoName: '서울특별시',
          sigunguCode: '11180',
          sigunguName: '강남구',
          bjdongType: BjdongType.dong,
          isAbolished: false,
          createdDate: DateTime.now(),
        );

        await dataSource.insertBjdong(originalBjdong);

        const updatedBjdong = BjdongModel(
          bjdongCode: '1118010100',
          bjdongName: '논현동(수정됨)',
          sidoCode: '11',
          sidoName: '서울특별시',
          sigunguCode: '11180',
          sigunguName: '강남구',
          bjdongType: BjdongType.dong,
          isAbolished: true,
          createdDate: DateTime.now(),
        );

        // When
        await dataSource.updateBjdong(updatedBjdong);

        // Then
        final result = await dataSource.getBjdongByCode('1118010100');
        expect(result, isNotNull);
        expect(result!.bjdongName, equals('논현동(수정됨)'));
        expect(result.isAbolished, isTrue);
      });
    });

    group('deleteBjdong', () {
      test('법정동 삭제 테스트', () async {
        // Given
        await insertTestRegion('11190', '강남구');

        const testBjdong = BjdongModel(
          bjdongCode: '1119010100',
          bjdongName: '역삼동',
          sidoCode: '11',
          sidoName: '서울특별시',
          sigunguCode: '11190',
          sigunguName: '강남구',
          bjdongType: BjdongType.dong,
          isAbolished: false,
          createdDate: DateTime.now(),
        );

        await dataSource.insertBjdong(testBjdong);

        // When
        await dataSource.deleteBjdong('1119010100');

        // Then
        final result = await dataSource.getBjdongByCode('1119010100');
        expect(result, isNull);
      });
    });

    group('getBjdongCount', () {
      test('법정동 개수 조회 테스트', () async {
        // Given
        await insertTestRegion('11200', '강남구');

        final testBjdongs = [
          const BjdongModel(
            bjdongCode: '1120010100',
            bjdongName: '개포동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11200',
            sigunguName: '강남구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
          const BjdongModel(
            bjdongCode: '1120010200',
            bjdongName: '세곡동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11200',
            sigunguName: '강남구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
        ];

        for (final bjdong in testBjdongs) {
          await dataSource.insertBjdong(bjdong);
        }

        // When
        final result = await dataSource.getBjdongCount();

        // Then
        expect(result, equals(2));
      });
    });

    group('searchBjdongsByName', () {
      test('법정동명 검색 테스트', () async {
        // Given
        await insertTestRegion('11210', '강남구');

        final testBjdongs = [
          const BjdongModel(
            bjdongCode: '1121010100',
            bjdongName: '대치동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11210',
            sigunguName: '강남구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
          const BjdongModel(
            bjdongCode: '1121010200',
            bjdongName: '수서동',
            sidoCode: '11',
            sidoName: '서울특별시',
            sigunguCode: '11210',
            sigunguName: '강남구',
            bjdongType: BjdongType.dong,
            isAbolished: false,
            createdDate: DateTime.now(),
          ),
        ];

        for (final bjdong in testBjdongs) {
          await dataSource.insertBjdong(bjdong);
        }

        // When
        final result = await dataSource.searchBjdongsByName('대치');

        // Then
        expect(result, isA<List<BjdongModel>>());
        expect(result.length, equals(1));
        expect(result.first.bjdongName, equals('대치동'));
      });
    });

    test('데이터베이스가 초기화되고 시군구 데이터가 로드되는지 확인', () async {
      // Given: 데이터베이스가 초기화됨
      final db = await databaseHelper.database;

      // When: 시군구 데이터 조회
      final result = await db.query('regions', limit: 5);

      // Then: 데이터가 존재하는지 확인
      expect(result, isNotEmpty);
      print('로드된 시군구 데이터 수: ${result.length}');
      if (result.isNotEmpty) {
        print('첫 번째 시군구: ${result.first}');
      }
    });

    test('법정동 데이터 삽입 테스트', () async {
      // Given: 법정동 데이터
      final bjdongData = BjdongModel(
        bjdongCode: '1111010100',
        bjdongName: '청운동',
        sidoCode: '11',
        sidoName: '서울특별시',
        sigunguCode: '11110',
        sigunguName: '종로구',
        bjdongType: BjdongType.dong,
        isAbolished: false,
        createdDate: DateTime.now(),
      );

      // When: 법정동 데이터 삽입
      await dataSource.insertBjdong(bjdongData);

      // Then: 삽입된 데이터 조회
      final result = await dataSource.getBjdongByCode('1111010100');
      expect(result, isNotNull);
      expect(result!.bjdongName, '청운동');
    });

    test('시도코드로 법정동 조회', () async {
      // Given: 여러 법정동 데이터 삽입
      final bjdongs = [
        BjdongModel(
          bjdongCode: '1111010100',
          bjdongName: '청운동',
          sidoCode: '11',
          sidoName: '서울특별시',
          sigunguCode: '11110',
          sigunguName: '종로구',
          bjdongType: BjdongType.dong,
          isAbolished: false,
          createdDate: DateTime.now(),
        ),
        BjdongModel(
          bjdongCode: '1111010200',
          bjdongName: '효자동',
          sidoCode: '11',
          sidoName: '서울특별시',
          sigunguCode: '11110',
          sigunguName: '종로구',
          bjdongType: BjdongType.dong,
          isAbolished: false,
          createdDate: DateTime.now(),
        ),
      ];

      for (final bjdong in bjdongs) {
        await dataSource.insertBjdong(bjdong);
      }

      // When: 시도코드로 법정동 조회
      final result = await dataSource.getBjdongsBySidoCode('11');

      // Then: 서울 지역의 법정동들이 조회됨
      expect(result, hasLength(2));
      expect(result.every((b) => b.sidoCode == '11'), isTrue);
    });
  });
}
