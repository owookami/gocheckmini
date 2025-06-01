import 'package:flutter_test/flutter_test.dart';
import 'package:parking_finder/features/parking/data/models/bjdong_model.dart';
import 'package:parking_finder/features/parking/domain/entities/bjdong.dart';

void main() {
  group('BjdongModel', () {
    final testCreatedDate = DateTime(2020, 1, 1);

    const testBjdongModel = BjdongModel(
      bjdongCode: '1111010100',
      bjdongName: '청와대',
      sidoCode: '11',
      sidoName: '서울특별시',
      sigunguCode: '11110',
      sigunguName: '종로구',
      bjdongType: BjdongType.dong,
      isAbolished: false,
      createdDate: null,
      abolishedDate: null,
    );

    const testBjdongEntity = Bjdong(
      bjdongCode: '1111010100',
      bjdongName: '청와대',
      sidoCode: '11',
      sidoName: '서울특별시',
      sigunguCode: '11110',
      sigunguName: '종로구',
      bjdongType: BjdongType.dong,
      isAbolished: false,
      createdDate: null,
      abolishedDate: null,
    );

    const testJson = {
      'bjdong_code': '1111010100',
      'bjdong_name': '청와대',
      'sido_code': '11',
      'sido_name': '서울특별시',
      'sigungu_code': '11110',
      'sigungu_name': '종로구',
      'bjdong_type': 'dong',
      'is_abolished': false,
      'created_date': null,
      'abolished_date': null,
    };

    group('JSON Serialization', () {
      test('fromJson은 올바른 BjdongModel 객체를 생성해야 함', () {
        // Act
        final result = BjdongModel.fromJson(testJson);

        // Assert
        expect(result.bjdongCode, equals('1111010100'));
        expect(result.bjdongName, equals('청와대'));
        expect(result.sidoCode, equals('11'));
        expect(result.sidoName, equals('서울특별시'));
        expect(result.sigunguCode, equals('11110'));
        expect(result.sigunguName, equals('종로구'));
        expect(result.bjdongType, equals(BjdongType.dong));
        expect(result.isAbolished, equals(false));
        expect(result.createdDate, isNull);
        expect(result.abolishedDate, isNull);
      });

      test('toJson은 올바른 JSON Map을 생성해야 함', () {
        // Act
        final result = testBjdongModel.toJson();

        // Assert
        expect(result, equals(testJson));
      });

      test('JSON 직렬화-역직렬화 순환 과정이 일관성을 유지해야 함', () {
        // Act
        final jsonMap = testBjdongModel.toJson();
        final recreatedModel = BjdongModel.fromJson(jsonMap);

        // Assert
        expect(recreatedModel, equals(testBjdongModel));
      });
    });

    group('Entity-Model Mapping', () {
      test('toEntity는 올바른 Bjdong 엔티티를 생성해야 함', () {
        // Act
        final result = testBjdongModel.toEntity();

        // Assert
        expect(result.bjdongCode, equals(testBjdongEntity.bjdongCode));
        expect(result.bjdongName, equals(testBjdongEntity.bjdongName));
        expect(result.sidoCode, equals(testBjdongEntity.sidoCode));
        expect(result.sidoName, equals(testBjdongEntity.sidoName));
        expect(result.sigunguCode, equals(testBjdongEntity.sigunguCode));
        expect(result.sigunguName, equals(testBjdongEntity.sigunguName));
        expect(result.bjdongType, equals(testBjdongEntity.bjdongType));
        expect(result.isAbolished, equals(testBjdongEntity.isAbolished));
        expect(result.fullAddress, equals('서울특별시 종로구 청와대'));
      });

      test('fromEntity는 올바른 BjdongModel을 생성해야 함', () {
        // Act
        final result = BjdongModel.fromEntity(testBjdongEntity);

        // Assert
        expect(result.bjdongCode, equals(testBjdongModel.bjdongCode));
        expect(result.bjdongName, equals(testBjdongModel.bjdongName));
        expect(result.sidoCode, equals(testBjdongModel.sidoCode));
        expect(result.sidoName, equals(testBjdongModel.sidoName));
        expect(result.sigunguCode, equals(testBjdongModel.sigunguCode));
        expect(result.sigunguName, equals(testBjdongModel.sigunguName));
        expect(result.bjdongType, equals(testBjdongModel.bjdongType));
        expect(result.isAbolished, equals(testBjdongModel.isAbolished));
      });

      test('Entity-Model 변환 순환 과정이 일관성을 유지해야 함', () {
        // Act
        final modelFromEntity = BjdongModel.fromEntity(testBjdongEntity);
        final entityFromModel = modelFromEntity.toEntity();

        // Assert
        expect(entityFromModel.bjdongCode, equals(testBjdongEntity.bjdongCode));
        expect(entityFromModel.bjdongName, equals(testBjdongEntity.bjdongName));
        expect(entityFromModel.sidoCode, equals(testBjdongEntity.sidoCode));
        expect(entityFromModel.sidoName, equals(testBjdongEntity.sidoName));
        expect(
          entityFromModel.sigunguCode,
          equals(testBjdongEntity.sigunguCode),
        );
        expect(
          entityFromModel.sigunguName,
          equals(testBjdongEntity.sigunguName),
        );
        expect(entityFromModel.bjdongType, equals(testBjdongEntity.bjdongType));
        expect(
          entityFromModel.isAbolished,
          equals(testBjdongEntity.isAbolished),
        );
      });
    });

    group('BjdongType Enum', () {
      test('displayName은 올바른 한국어 이름을 반환해야 함', () {
        expect(BjdongType.eup.displayName, equals('읍'));
        expect(BjdongType.myeon.displayName, equals('면'));
        expect(BjdongType.dong.displayName, equals('동'));
      });

      test('fromName은 이름에서 올바른 타입을 추론해야 함', () {
        expect(BjdongType.fromName('청량리동'), equals(BjdongType.dong));
        expect(BjdongType.fromName('신월읍'), equals(BjdongType.eup));
        expect(BjdongType.fromName('행현면'), equals(BjdongType.myeon));
        expect(BjdongType.fromName('강남'), equals(BjdongType.dong)); // 기본값
      });
    });

    group('Edge Cases', () {
      test('폐지된 법정동을 처리해야 함', () {
        // Arrange
        final abolishedDate = DateTime(2023, 12, 31);
        final abolishedJson = {
          'bjdong_code': '1111010200',
          'bjdong_name': '폐지된동',
          'sido_code': '11',
          'sido_name': '서울특별시',
          'sigungu_code': '11110',
          'sigungu_name': '종로구',
          'bjdong_type': 'dong',
          'is_abolished': true,
          'created_date': testCreatedDate.toIso8601String(),
          'abolished_date': abolishedDate.toIso8601String(),
        };

        // Act
        final model = BjdongModel.fromJson(abolishedJson);
        final entity = model.toEntity();

        // Assert
        expect(model.isAbolished, isTrue);
        expect(model.createdDate, equals(testCreatedDate));
        expect(model.abolishedDate, equals(abolishedDate));
        expect(entity.isAbolished, isTrue);
        expect(entity.createdDate, equals(testCreatedDate));
        expect(entity.abolishedDate, equals(abolishedDate));
      });

      test('읍 타입 법정동을 처리해야 함', () {
        // Arrange
        final eupJson = {
          'bjdong_code': '4371025033',
          'bjdong_name': '청송읍',
          'sido_code': '43',
          'sido_name': '충청북도',
          'sigungu_code': '43730',
          'sigungu_name': '옥천군',
          'bjdong_type': 'eup',
          'is_abolished': false,
          'created_date': null,
          'abolished_date': null,
        };

        // Act
        final model = BjdongModel.fromJson(eupJson);
        final entity = model.toEntity();

        // Assert
        expect(model.bjdongType, equals(BjdongType.eup));
        expect(entity.bjdongType, equals(BjdongType.eup));
        expect(entity.bjdongType.displayName, equals('읍'));
        expect(entity.fullAddress, equals('충청북도 옥천군 청송읍'));
      });

      test('면 타입 법정동을 처리해야 함', () {
        // Arrange
        final myeonJson = {
          'bjdong_code': '4371025033',
          'bjdong_name': '안내면',
          'sido_code': '43',
          'sido_name': '충청북도',
          'sigungu_code': '43730',
          'sigungu_name': '옥천군',
          'bjdong_type': 'myeon',
          'is_abolished': false,
          'created_date': null,
          'abolished_date': null,
        };

        // Act
        final model = BjdongModel.fromJson(myeonJson);
        final entity = model.toEntity();

        // Assert
        expect(model.bjdongType, equals(BjdongType.myeon));
        expect(entity.bjdongType, equals(BjdongType.myeon));
        expect(entity.bjdongType.displayName, equals('면'));
        expect(entity.fullAddress, equals('충청북도 옥천군 안내면'));
      });
    });
  });
}
