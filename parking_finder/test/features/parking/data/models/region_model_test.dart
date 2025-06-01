import 'package:flutter_test/flutter_test.dart';
import 'package:parking_finder/features/parking/data/models/region_model.dart';
import 'package:parking_finder/features/parking/domain/entities/region.dart';

void main() {
  group('RegionModel', () {
    const testRegionModel = RegionModel(
      unifiedCode: 1001,
      sigunguCode: '11000',
      sigunguName: '서울특별시',
      isAutonomousDistrict: false,
      parentCode: null,
      level: 1,
    );

    const testRegionEntity = Region(
      unifiedCode: 1001,
      sigunguCode: '11000',
      sigunguName: '서울특별시',
      isAutonomousDistrict: false,
      parentCode: null,
      level: 1,
    );

    final testJson = {
      'unified_code': 1001,
      'sigungu_code': '11000',
      'sigungu_name': '서울특별시',
      'is_autonomous_district': false,
      'parent_code': null,
      'level': 1,
    };

    group('JSON Serialization', () {
      test('fromJson은 올바른 RegionModel 객체를 생성해야 함', () {
        // Act
        final result = RegionModel.fromJson(testJson);

        // Assert
        expect(result.unifiedCode, equals(1001));
        expect(result.sigunguCode, equals('11000'));
        expect(result.sigunguName, equals('서울특별시'));
        expect(result.isAutonomousDistrict, equals(false));
        expect(result.parentCode, isNull);
        expect(result.level, equals(1));
      });

      test('toJson은 올바른 JSON Map을 생성해야 함', () {
        // Act
        final result = testRegionModel.toJson();

        // Assert
        expect(result, equals(testJson));
      });

      test('JSON 직렬화-역직렬화 순환 과정이 일관성을 유지해야 함', () {
        // Act
        final jsonMap = testRegionModel.toJson();
        final recreatedModel = RegionModel.fromJson(jsonMap);

        // Assert
        expect(recreatedModel, equals(testRegionModel));
      });
    });

    group('Entity-Model Mapping', () {
      test('toEntity는 올바른 Region 엔티티를 생성해야 함', () {
        // Act
        final result = testRegionModel.toEntity();

        // Assert
        expect(result.unifiedCode, equals(testRegionEntity.unifiedCode));
        expect(result.sigunguCode, equals(testRegionEntity.sigunguCode));
        expect(result.sigunguName, equals(testRegionEntity.sigunguName));
        expect(
          result.isAutonomousDistrict,
          equals(testRegionEntity.isAutonomousDistrict),
        );
        expect(result.parentCode, equals(testRegionEntity.parentCode));
        expect(result.level, equals(testRegionEntity.level));
      });

      test('fromEntity는 올바른 RegionModel을 생성해야 함', () {
        // Act
        final result = RegionModel.fromEntity(testRegionEntity);

        // Assert
        expect(result.unifiedCode, equals(testRegionModel.unifiedCode));
        expect(result.sigunguCode, equals(testRegionModel.sigunguCode));
        expect(result.sigunguName, equals(testRegionModel.sigunguName));
        expect(
          result.isAutonomousDistrict,
          equals(testRegionModel.isAutonomousDistrict),
        );
        expect(result.parentCode, equals(testRegionModel.parentCode));
        expect(result.level, equals(testRegionModel.level));
      });

      test('Entity-Model 변환 순환 과정이 일관성을 유지해야 함', () {
        // Act
        final modelFromEntity = RegionModel.fromEntity(testRegionEntity);
        final entityFromModel = modelFromEntity.toEntity();

        // Assert
        expect(
          entityFromModel.unifiedCode,
          equals(testRegionEntity.unifiedCode),
        );
        expect(
          entityFromModel.sigunguCode,
          equals(testRegionEntity.sigunguCode),
        );
        expect(
          entityFromModel.sigunguName,
          equals(testRegionEntity.sigunguName),
        );
        expect(
          entityFromModel.isAutonomousDistrict,
          equals(testRegionEntity.isAutonomousDistrict),
        );
        expect(entityFromModel.parentCode, equals(testRegionEntity.parentCode));
        expect(entityFromModel.level, equals(testRegionEntity.level));
      });
    });

    group('Edge Cases', () {
      test('상위 지역 코드가 있는 지역구 모델을 처리해야 함', () {
        // Arrange
        final districtJson = {
          'unified_code': 1002,
          'sigungu_code': '11110',
          'sigungu_name': '서울특별시 종로구',
          'is_autonomous_district': false,
          'parent_code': '11000',
          'level': 2,
        };

        // Act
        final model = RegionModel.fromJson(districtJson);
        final entity = model.toEntity();

        // Assert
        expect(model.parentCode, equals('11000'));
        expect(entity.parentCode, equals('11000'));
        expect(model.level, equals(2));
        expect(entity.level, equals(2));
      });

      test('자치구 플래그가 true인 경우를 처리해야 함', () {
        // Arrange
        final autonomousJson = {
          'unified_code': 1084,
          'sigungu_code': '41111',
          'sigungu_name': '수원시 장안구',
          'is_autonomous_district': true,
          'parent_code': '41110',
          'level': 3,
        };

        // Act
        final model = RegionModel.fromJson(autonomousJson);
        final entity = model.toEntity();

        // Assert
        expect(model.isAutonomousDistrict, isTrue);
        expect(entity.isAutonomousDistrict, isTrue);
      });
    });
  });
}
