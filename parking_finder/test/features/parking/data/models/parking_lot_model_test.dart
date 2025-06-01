import 'package:flutter_test/flutter_test.dart';
import 'package:parking_finder/features/parking/data/models/parking_lot_model.dart';
import 'package:parking_finder/features/parking/domain/entities/parking_lot.dart';

void main() {
  group('ParkingLotModel', () {
    final testDateTime = DateTime(2024, 1, 15, 14, 30);

    final testParkingLotModel = ParkingLotModel(
      id: 'PLT001',
      name: '서울시청 공영주차장',
      address: '서울특별시 중구 세종대로 110',
      detailAddress: '지하 1층',
      type: ParkingLotType.general,
      totalCapacity: 250,
      availableSpots: 45,
      operatingHoursStart: '06:00',
      operatingHoursEnd: '23:00',
      feeInfo: '30분 1000원',
      phoneNumber: '02-1234-5678',
      latitude: 37.5662,
      longitude: 126.9779,
      facilityInfo: '장애인 주차구역 10대, 전기차 충전소 5대',
      managementAgency: '서울특별시',
      regionCode: '11140',
      lastUpdated: testDateTime,
    );

    final testParkingLotEntity = ParkingLot(
      id: 'PLT001',
      name: '서울시청 공영주차장',
      address: '서울특별시 중구 세종대로 110',
      detailAddress: '지하 1층',
      type: ParkingLotType.general,
      totalCapacity: 250,
      availableSpots: 45,
      operatingHoursStart: '06:00',
      operatingHoursEnd: '23:00',
      feeInfo: '30분 1000원',
      phoneNumber: '02-1234-5678',
      latitude: 37.5662,
      longitude: 126.9779,
      facilityInfo: '장애인 주차구역 10대, 전기차 충전소 5대',
      managementAgency: '서울특별시',
      regionCode: '11140',
      lastUpdated: testDateTime,
    );

    final testJson = {
      'id': 'PLT001',
      'name': '서울시청 공영주차장',
      'address': '서울특별시 중구 세종대로 110',
      'detail_address': '지하 1층',
      'type': 'general',
      'total_capacity': 250,
      'available_spots': 45,
      'operating_hours_start': '06:00',
      'operating_hours_end': '23:00',
      'fee_info': '30분 1000원',
      'phone_number': '02-1234-5678',
      'latitude': 37.5662,
      'longitude': 126.9779,
      'facility_info': '장애인 주차구역 10대, 전기차 충전소 5대',
      'management_agency': '서울특별시',
      'region_code': '11140',
      'last_updated': testDateTime.toIso8601String(),
    };

    group('JSON Serialization', () {
      test('fromJson은 올바른 ParkingLotModel 객체를 생성해야 함', () {
        // Act
        final result = ParkingLotModel.fromJson(testJson);

        // Assert
        expect(result.id, equals('PLT001'));
        expect(result.name, equals('서울시청 공영주차장'));
        expect(result.address, equals('서울특별시 중구 세종대로 110'));
        expect(result.detailAddress, equals('지하 1층'));
        expect(result.type, equals(ParkingLotType.general));
        expect(result.totalCapacity, equals(250));
        expect(result.availableSpots, equals(45));
        expect(result.operatingHoursStart, equals('06:00'));
        expect(result.operatingHoursEnd, equals('23:00'));
        expect(result.feeInfo, equals('30분 1000원'));
        expect(result.phoneNumber, equals('02-1234-5678'));
        expect(result.latitude, equals(37.5662));
        expect(result.longitude, equals(126.9779));
        expect(result.facilityInfo, equals('장애인 주차구역 10대, 전기차 충전소 5대'));
        expect(result.managementAgency, equals('서울특별시'));
        expect(result.regionCode, equals('11140'));
        expect(result.lastUpdated, equals(testDateTime));
      });

      test('toJson은 올바른 JSON Map을 생성해야 함', () {
        // Act
        final result = testParkingLotModel.toJson();

        // Assert
        expect(result['id'], equals('PLT001'));
        expect(result['name'], equals('서울시청 공영주차장'));
        expect(result['type'], equals('general'));
        expect(result['total_capacity'], equals(250));
        expect(result['region_code'], equals('11140'));
      });

      test('JSON 직렬화-역직렬화 순환 과정이 일관성을 유지해야 함', () {
        // Act
        final jsonMap = testParkingLotModel.toJson();
        final recreatedModel = ParkingLotModel.fromJson(jsonMap);

        // Assert
        expect(recreatedModel, equals(testParkingLotModel));
      });
    });

    group('Entity-Model Mapping', () {
      test('toEntity는 올바른 ParkingLot 엔티티를 생성해야 함', () {
        // Act
        final result = testParkingLotModel.toEntity();

        // Assert
        expect(result.id, equals(testParkingLotEntity.id));
        expect(result.name, equals(testParkingLotEntity.name));
        expect(result.address, equals(testParkingLotEntity.address));
        expect(result.type, equals(testParkingLotEntity.type));
        expect(
          result.totalCapacity,
          equals(testParkingLotEntity.totalCapacity),
        );
        expect(result.regionCode, equals(testParkingLotEntity.regionCode));
      });

      test('fromEntity는 올바른 ParkingLotModel을 생성해야 함', () {
        // Act
        final result = ParkingLotModel.fromEntity(testParkingLotEntity);

        // Assert
        expect(result.id, equals(testParkingLotModel.id));
        expect(result.name, equals(testParkingLotModel.name));
        expect(result.address, equals(testParkingLotModel.address));
        expect(result.type, equals(testParkingLotModel.type));
        expect(result.totalCapacity, equals(testParkingLotModel.totalCapacity));
        expect(result.regionCode, equals(testParkingLotModel.regionCode));
      });

      test('Entity-Model 변환 순환 과정이 일관성을 유지해야 함', () {
        // Act
        final modelFromEntity = ParkingLotModel.fromEntity(
          testParkingLotEntity,
        );
        final entityFromModel = modelFromEntity.toEntity();

        // Assert
        expect(entityFromModel.id, equals(testParkingLotEntity.id));
        expect(entityFromModel.name, equals(testParkingLotEntity.name));
        expect(entityFromModel.address, equals(testParkingLotEntity.address));
        expect(entityFromModel.type, equals(testParkingLotEntity.type));
        expect(
          entityFromModel.totalCapacity,
          equals(testParkingLotEntity.totalCapacity),
        );
        expect(
          entityFromModel.regionCode,
          equals(testParkingLotEntity.regionCode),
        );
      });
    });

    group('Edge Cases', () {
      test('선택적 필드가 null인 경우를 처리해야 함', () {
        // Arrange
        final minimalJson = {
          'id': 'PLT002',
          'name': '간이 주차장',
          'address': '서울특별시 강남구 역삼동',
          'type': 'attached',
          'total_capacity': 10,
          'region_code': '11680',
        };

        // Act
        final model = ParkingLotModel.fromJson(minimalJson);
        final entity = model.toEntity();

        // Assert
        expect(model.detailAddress, isNull);
        expect(model.availableSpots, isNull);
        expect(model.operatingHoursStart, isNull);
        expect(model.operatingHoursEnd, isNull);
        expect(model.phoneNumber, isNull);
        expect(model.latitude, isNull);
        expect(model.longitude, isNull);
        expect(entity.detailAddress, isNull);
        expect(entity.availableSpots, isNull);
        expect(entity.latitude, isNull);
        expect(entity.longitude, isNull);
      });

      test('부설 주차장 타입을 올바르게 처리해야 함', () {
        // Arrange
        final attachedJson = {
          'id': 'PLT003',
          'name': '아파트 부설주차장',
          'address': '서울특별시 송파구 잠실동',
          'type': 'attached',
          'total_capacity': 150,
          'region_code': '11710',
        };

        // Act
        final model = ParkingLotModel.fromJson(attachedJson);
        final entity = model.toEntity();

        // Assert
        expect(model.type, equals(ParkingLotType.attached));
        expect(entity.type, equals(ParkingLotType.attached));
        expect(entity.type.displayName, equals('부설주차장'));
      });
    });

    group('ParkingLotType Enum', () {
      test('displayName은 올바른 한국어 이름을 반환해야 함', () {
        expect(ParkingLotType.general.displayName, equals('일반주차장'));
        expect(ParkingLotType.attached.displayName, equals('부설주차장'));
      });
    });
  });
}
