import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/parking_lot.dart';

part 'parking_lot_model.freezed.dart';
part 'parking_lot_model.g.dart';

/// ParkingLot 엔티티의 데이터 모델 클래스
@freezed
class ParkingLotModel with _$ParkingLotModel {
  const factory ParkingLotModel({
    /// 고유 식별자
    @JsonKey(name: 'id') required String id,

    /// 주차장명
    @JsonKey(name: 'name') required String name,

    /// 주소
    @JsonKey(name: 'address') required String address,

    /// 상세주소
    @JsonKey(name: 'detail_address') String? detailAddress,

    /// 주차장 구분 (일반/부설)
    @JsonKey(name: 'type') required ParkingLotType type,

    /// 총 주차대수
    @JsonKey(name: 'total_capacity') required int totalCapacity,

    /// 현재 주차가능 대수
    @JsonKey(name: 'available_spots') int? availableSpots,

    /// 운영시간 시작
    @JsonKey(name: 'operating_hours_start') String? operatingHoursStart,

    /// 운영시간 종료
    @JsonKey(name: 'operating_hours_end') String? operatingHoursEnd,

    /// 주차요금 정보
    @JsonKey(name: 'fee_info') String? feeInfo,

    /// 전화번호
    @JsonKey(name: 'phone_number') String? phoneNumber,

    /// 위도
    @JsonKey(name: 'latitude') double? latitude,

    /// 경도
    @JsonKey(name: 'longitude') double? longitude,

    /// 시설정보
    @JsonKey(name: 'facility_info') String? facilityInfo,

    /// 면적 (공작물관리대장용)
    @JsonKey(name: 'area') double? area,

    /// 관리기관
    @JsonKey(name: 'management_agency') String? managementAgency,

    /// 지역 코드
    @JsonKey(name: 'region_code') required String regionCode,

    /// 데이터 수집일시
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
  }) = _ParkingLotModel;

  const ParkingLotModel._();

  /// JSON에서 모델 생성
  factory ParkingLotModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotModelFromJson(json);

  /// 엔티티로 변환
  ParkingLot toEntity() {
    return ParkingLot(
      id: id,
      name: name,
      address: address,
      detailAddress: detailAddress,
      type: type,
      totalCapacity: totalCapacity,
      availableSpots: availableSpots,
      operatingHoursStart: operatingHoursStart,
      operatingHoursEnd: operatingHoursEnd,
      feeInfo: feeInfo,
      phoneNumber: phoneNumber,
      latitude: latitude,
      longitude: longitude,
      facilityInfo: facilityInfo,
      area: area,
      managementAgency: managementAgency,
      regionCode: regionCode,
      lastUpdated: lastUpdated,
    );
  }

  /// 엔티티에서 모델 생성
  factory ParkingLotModel.fromEntity(ParkingLot entity) {
    return ParkingLotModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      detailAddress: entity.detailAddress,
      type: entity.type,
      totalCapacity: entity.totalCapacity,
      availableSpots: entity.availableSpots,
      operatingHoursStart: entity.operatingHoursStart,
      operatingHoursEnd: entity.operatingHoursEnd,
      feeInfo: entity.feeInfo,
      phoneNumber: entity.phoneNumber,
      latitude: entity.latitude,
      longitude: entity.longitude,
      facilityInfo: entity.facilityInfo,
      area: entity.area,
      managementAgency: entity.managementAgency,
      regionCode: entity.regionCode,
      lastUpdated: entity.lastUpdated,
    );
  }
}
