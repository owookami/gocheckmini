// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parking_lot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ParkingLotModel _$ParkingLotModelFromJson(Map<String, dynamic> json) {
  return _ParkingLotModel.fromJson(json);
}

/// @nodoc
mixin _$ParkingLotModel {
  /// 고유 식별자
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;

  /// 주차장명
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  /// 주소
  @JsonKey(name: 'address')
  String get address => throw _privateConstructorUsedError;

  /// 상세주소
  @JsonKey(name: 'detail_address')
  String? get detailAddress => throw _privateConstructorUsedError;

  /// 주차장 구분 (일반/부설)
  @JsonKey(name: 'type')
  ParkingLotType get type => throw _privateConstructorUsedError;

  /// 총 주차대수
  @JsonKey(name: 'total_capacity')
  int get totalCapacity => throw _privateConstructorUsedError;

  /// 현재 주차가능 대수
  @JsonKey(name: 'available_spots')
  int? get availableSpots => throw _privateConstructorUsedError;

  /// 운영시간 시작
  @JsonKey(name: 'operating_hours_start')
  String? get operatingHoursStart => throw _privateConstructorUsedError;

  /// 운영시간 종료
  @JsonKey(name: 'operating_hours_end')
  String? get operatingHoursEnd => throw _privateConstructorUsedError;

  /// 주차요금 정보
  @JsonKey(name: 'fee_info')
  String? get feeInfo => throw _privateConstructorUsedError;

  /// 전화번호
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// 위도
  @JsonKey(name: 'latitude')
  double? get latitude => throw _privateConstructorUsedError;

  /// 경도
  @JsonKey(name: 'longitude')
  double? get longitude => throw _privateConstructorUsedError;

  /// 시설정보
  @JsonKey(name: 'facility_info')
  String? get facilityInfo => throw _privateConstructorUsedError;

  /// 면적 (공작물관리대장용)
  @JsonKey(name: 'area')
  double? get area => throw _privateConstructorUsedError;

  /// 관리기관
  @JsonKey(name: 'management_agency')
  String? get managementAgency => throw _privateConstructorUsedError;

  /// 지역 코드
  @JsonKey(name: 'region_code')
  String get regionCode => throw _privateConstructorUsedError;

  /// 데이터 수집일시
  @JsonKey(name: 'last_updated')
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this ParkingLotModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParkingLotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParkingLotModelCopyWith<ParkingLotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParkingLotModelCopyWith<$Res> {
  factory $ParkingLotModelCopyWith(
    ParkingLotModel value,
    $Res Function(ParkingLotModel) then,
  ) = _$ParkingLotModelCopyWithImpl<$Res, ParkingLotModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'address') String address,
    @JsonKey(name: 'detail_address') String? detailAddress,
    @JsonKey(name: 'type') ParkingLotType type,
    @JsonKey(name: 'total_capacity') int totalCapacity,
    @JsonKey(name: 'available_spots') int? availableSpots,
    @JsonKey(name: 'operating_hours_start') String? operatingHoursStart,
    @JsonKey(name: 'operating_hours_end') String? operatingHoursEnd,
    @JsonKey(name: 'fee_info') String? feeInfo,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
    @JsonKey(name: 'facility_info') String? facilityInfo,
    @JsonKey(name: 'area') double? area,
    @JsonKey(name: 'management_agency') String? managementAgency,
    @JsonKey(name: 'region_code') String regionCode,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
  });
}

/// @nodoc
class _$ParkingLotModelCopyWithImpl<$Res, $Val extends ParkingLotModel>
    implements $ParkingLotModelCopyWith<$Res> {
  _$ParkingLotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParkingLotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? detailAddress = freezed,
    Object? type = null,
    Object? totalCapacity = null,
    Object? availableSpots = freezed,
    Object? operatingHoursStart = freezed,
    Object? operatingHoursEnd = freezed,
    Object? feeInfo = freezed,
    Object? phoneNumber = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? facilityInfo = freezed,
    Object? area = freezed,
    Object? managementAgency = freezed,
    Object? regionCode = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            detailAddress:
                freezed == detailAddress
                    ? _value.detailAddress
                    : detailAddress // ignore: cast_nullable_to_non_nullable
                        as String?,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ParkingLotType,
            totalCapacity:
                null == totalCapacity
                    ? _value.totalCapacity
                    : totalCapacity // ignore: cast_nullable_to_non_nullable
                        as int,
            availableSpots:
                freezed == availableSpots
                    ? _value.availableSpots
                    : availableSpots // ignore: cast_nullable_to_non_nullable
                        as int?,
            operatingHoursStart:
                freezed == operatingHoursStart
                    ? _value.operatingHoursStart
                    : operatingHoursStart // ignore: cast_nullable_to_non_nullable
                        as String?,
            operatingHoursEnd:
                freezed == operatingHoursEnd
                    ? _value.operatingHoursEnd
                    : operatingHoursEnd // ignore: cast_nullable_to_non_nullable
                        as String?,
            feeInfo:
                freezed == feeInfo
                    ? _value.feeInfo
                    : feeInfo // ignore: cast_nullable_to_non_nullable
                        as String?,
            phoneNumber:
                freezed == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            latitude:
                freezed == latitude
                    ? _value.latitude
                    : latitude // ignore: cast_nullable_to_non_nullable
                        as double?,
            longitude:
                freezed == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as double?,
            facilityInfo:
                freezed == facilityInfo
                    ? _value.facilityInfo
                    : facilityInfo // ignore: cast_nullable_to_non_nullable
                        as String?,
            area:
                freezed == area
                    ? _value.area
                    : area // ignore: cast_nullable_to_non_nullable
                        as double?,
            managementAgency:
                freezed == managementAgency
                    ? _value.managementAgency
                    : managementAgency // ignore: cast_nullable_to_non_nullable
                        as String?,
            regionCode:
                null == regionCode
                    ? _value.regionCode
                    : regionCode // ignore: cast_nullable_to_non_nullable
                        as String,
            lastUpdated:
                freezed == lastUpdated
                    ? _value.lastUpdated
                    : lastUpdated // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParkingLotModelImplCopyWith<$Res>
    implements $ParkingLotModelCopyWith<$Res> {
  factory _$$ParkingLotModelImplCopyWith(
    _$ParkingLotModelImpl value,
    $Res Function(_$ParkingLotModelImpl) then,
  ) = __$$ParkingLotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'address') String address,
    @JsonKey(name: 'detail_address') String? detailAddress,
    @JsonKey(name: 'type') ParkingLotType type,
    @JsonKey(name: 'total_capacity') int totalCapacity,
    @JsonKey(name: 'available_spots') int? availableSpots,
    @JsonKey(name: 'operating_hours_start') String? operatingHoursStart,
    @JsonKey(name: 'operating_hours_end') String? operatingHoursEnd,
    @JsonKey(name: 'fee_info') String? feeInfo,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
    @JsonKey(name: 'facility_info') String? facilityInfo,
    @JsonKey(name: 'area') double? area,
    @JsonKey(name: 'management_agency') String? managementAgency,
    @JsonKey(name: 'region_code') String regionCode,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$ParkingLotModelImplCopyWithImpl<$Res>
    extends _$ParkingLotModelCopyWithImpl<$Res, _$ParkingLotModelImpl>
    implements _$$ParkingLotModelImplCopyWith<$Res> {
  __$$ParkingLotModelImplCopyWithImpl(
    _$ParkingLotModelImpl _value,
    $Res Function(_$ParkingLotModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParkingLotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? detailAddress = freezed,
    Object? type = null,
    Object? totalCapacity = null,
    Object? availableSpots = freezed,
    Object? operatingHoursStart = freezed,
    Object? operatingHoursEnd = freezed,
    Object? feeInfo = freezed,
    Object? phoneNumber = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? facilityInfo = freezed,
    Object? area = freezed,
    Object? managementAgency = freezed,
    Object? regionCode = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$ParkingLotModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        detailAddress:
            freezed == detailAddress
                ? _value.detailAddress
                : detailAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ParkingLotType,
        totalCapacity:
            null == totalCapacity
                ? _value.totalCapacity
                : totalCapacity // ignore: cast_nullable_to_non_nullable
                    as int,
        availableSpots:
            freezed == availableSpots
                ? _value.availableSpots
                : availableSpots // ignore: cast_nullable_to_non_nullable
                    as int?,
        operatingHoursStart:
            freezed == operatingHoursStart
                ? _value.operatingHoursStart
                : operatingHoursStart // ignore: cast_nullable_to_non_nullable
                    as String?,
        operatingHoursEnd:
            freezed == operatingHoursEnd
                ? _value.operatingHoursEnd
                : operatingHoursEnd // ignore: cast_nullable_to_non_nullable
                    as String?,
        feeInfo:
            freezed == feeInfo
                ? _value.feeInfo
                : feeInfo // ignore: cast_nullable_to_non_nullable
                    as String?,
        phoneNumber:
            freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        latitude:
            freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                    as double?,
        longitude:
            freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as double?,
        facilityInfo:
            freezed == facilityInfo
                ? _value.facilityInfo
                : facilityInfo // ignore: cast_nullable_to_non_nullable
                    as String?,
        area:
            freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                    as double?,
        managementAgency:
            freezed == managementAgency
                ? _value.managementAgency
                : managementAgency // ignore: cast_nullable_to_non_nullable
                    as String?,
        regionCode:
            null == regionCode
                ? _value.regionCode
                : regionCode // ignore: cast_nullable_to_non_nullable
                    as String,
        lastUpdated:
            freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParkingLotModelImpl extends _ParkingLotModel {
  const _$ParkingLotModelImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'address') required this.address,
    @JsonKey(name: 'detail_address') this.detailAddress,
    @JsonKey(name: 'type') required this.type,
    @JsonKey(name: 'total_capacity') required this.totalCapacity,
    @JsonKey(name: 'available_spots') this.availableSpots,
    @JsonKey(name: 'operating_hours_start') this.operatingHoursStart,
    @JsonKey(name: 'operating_hours_end') this.operatingHoursEnd,
    @JsonKey(name: 'fee_info') this.feeInfo,
    @JsonKey(name: 'phone_number') this.phoneNumber,
    @JsonKey(name: 'latitude') this.latitude,
    @JsonKey(name: 'longitude') this.longitude,
    @JsonKey(name: 'facility_info') this.facilityInfo,
    @JsonKey(name: 'area') this.area,
    @JsonKey(name: 'management_agency') this.managementAgency,
    @JsonKey(name: 'region_code') required this.regionCode,
    @JsonKey(name: 'last_updated') this.lastUpdated,
  }) : super._();

  factory _$ParkingLotModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParkingLotModelImplFromJson(json);

  /// 고유 식별자
  @override
  @JsonKey(name: 'id')
  final String id;

  /// 주차장명
  @override
  @JsonKey(name: 'name')
  final String name;

  /// 주소
  @override
  @JsonKey(name: 'address')
  final String address;

  /// 상세주소
  @override
  @JsonKey(name: 'detail_address')
  final String? detailAddress;

  /// 주차장 구분 (일반/부설)
  @override
  @JsonKey(name: 'type')
  final ParkingLotType type;

  /// 총 주차대수
  @override
  @JsonKey(name: 'total_capacity')
  final int totalCapacity;

  /// 현재 주차가능 대수
  @override
  @JsonKey(name: 'available_spots')
  final int? availableSpots;

  /// 운영시간 시작
  @override
  @JsonKey(name: 'operating_hours_start')
  final String? operatingHoursStart;

  /// 운영시간 종료
  @override
  @JsonKey(name: 'operating_hours_end')
  final String? operatingHoursEnd;

  /// 주차요금 정보
  @override
  @JsonKey(name: 'fee_info')
  final String? feeInfo;

  /// 전화번호
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  /// 위도
  @override
  @JsonKey(name: 'latitude')
  final double? latitude;

  /// 경도
  @override
  @JsonKey(name: 'longitude')
  final double? longitude;

  /// 시설정보
  @override
  @JsonKey(name: 'facility_info')
  final String? facilityInfo;

  /// 면적 (공작물관리대장용)
  @override
  @JsonKey(name: 'area')
  final double? area;

  /// 관리기관
  @override
  @JsonKey(name: 'management_agency')
  final String? managementAgency;

  /// 지역 코드
  @override
  @JsonKey(name: 'region_code')
  final String regionCode;

  /// 데이터 수집일시
  @override
  @JsonKey(name: 'last_updated')
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'ParkingLotModel(id: $id, name: $name, address: $address, detailAddress: $detailAddress, type: $type, totalCapacity: $totalCapacity, availableSpots: $availableSpots, operatingHoursStart: $operatingHoursStart, operatingHoursEnd: $operatingHoursEnd, feeInfo: $feeInfo, phoneNumber: $phoneNumber, latitude: $latitude, longitude: $longitude, facilityInfo: $facilityInfo, area: $area, managementAgency: $managementAgency, regionCode: $regionCode, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParkingLotModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.detailAddress, detailAddress) ||
                other.detailAddress == detailAddress) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.totalCapacity, totalCapacity) ||
                other.totalCapacity == totalCapacity) &&
            (identical(other.availableSpots, availableSpots) ||
                other.availableSpots == availableSpots) &&
            (identical(other.operatingHoursStart, operatingHoursStart) ||
                other.operatingHoursStart == operatingHoursStart) &&
            (identical(other.operatingHoursEnd, operatingHoursEnd) ||
                other.operatingHoursEnd == operatingHoursEnd) &&
            (identical(other.feeInfo, feeInfo) || other.feeInfo == feeInfo) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.facilityInfo, facilityInfo) ||
                other.facilityInfo == facilityInfo) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.managementAgency, managementAgency) ||
                other.managementAgency == managementAgency) &&
            (identical(other.regionCode, regionCode) ||
                other.regionCode == regionCode) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    detailAddress,
    type,
    totalCapacity,
    availableSpots,
    operatingHoursStart,
    operatingHoursEnd,
    feeInfo,
    phoneNumber,
    latitude,
    longitude,
    facilityInfo,
    area,
    managementAgency,
    regionCode,
    lastUpdated,
  );

  /// Create a copy of ParkingLotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParkingLotModelImplCopyWith<_$ParkingLotModelImpl> get copyWith =>
      __$$ParkingLotModelImplCopyWithImpl<_$ParkingLotModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParkingLotModelImplToJson(this);
  }
}

abstract class _ParkingLotModel extends ParkingLotModel {
  const factory _ParkingLotModel({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'address') required final String address,
    @JsonKey(name: 'detail_address') final String? detailAddress,
    @JsonKey(name: 'type') required final ParkingLotType type,
    @JsonKey(name: 'total_capacity') required final int totalCapacity,
    @JsonKey(name: 'available_spots') final int? availableSpots,
    @JsonKey(name: 'operating_hours_start') final String? operatingHoursStart,
    @JsonKey(name: 'operating_hours_end') final String? operatingHoursEnd,
    @JsonKey(name: 'fee_info') final String? feeInfo,
    @JsonKey(name: 'phone_number') final String? phoneNumber,
    @JsonKey(name: 'latitude') final double? latitude,
    @JsonKey(name: 'longitude') final double? longitude,
    @JsonKey(name: 'facility_info') final String? facilityInfo,
    @JsonKey(name: 'area') final double? area,
    @JsonKey(name: 'management_agency') final String? managementAgency,
    @JsonKey(name: 'region_code') required final String regionCode,
    @JsonKey(name: 'last_updated') final DateTime? lastUpdated,
  }) = _$ParkingLotModelImpl;
  const _ParkingLotModel._() : super._();

  factory _ParkingLotModel.fromJson(Map<String, dynamic> json) =
      _$ParkingLotModelImpl.fromJson;

  /// 고유 식별자
  @override
  @JsonKey(name: 'id')
  String get id;

  /// 주차장명
  @override
  @JsonKey(name: 'name')
  String get name;

  /// 주소
  @override
  @JsonKey(name: 'address')
  String get address;

  /// 상세주소
  @override
  @JsonKey(name: 'detail_address')
  String? get detailAddress;

  /// 주차장 구분 (일반/부설)
  @override
  @JsonKey(name: 'type')
  ParkingLotType get type;

  /// 총 주차대수
  @override
  @JsonKey(name: 'total_capacity')
  int get totalCapacity;

  /// 현재 주차가능 대수
  @override
  @JsonKey(name: 'available_spots')
  int? get availableSpots;

  /// 운영시간 시작
  @override
  @JsonKey(name: 'operating_hours_start')
  String? get operatingHoursStart;

  /// 운영시간 종료
  @override
  @JsonKey(name: 'operating_hours_end')
  String? get operatingHoursEnd;

  /// 주차요금 정보
  @override
  @JsonKey(name: 'fee_info')
  String? get feeInfo;

  /// 전화번호
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;

  /// 위도
  @override
  @JsonKey(name: 'latitude')
  double? get latitude;

  /// 경도
  @override
  @JsonKey(name: 'longitude')
  double? get longitude;

  /// 시설정보
  @override
  @JsonKey(name: 'facility_info')
  String? get facilityInfo;

  /// 면적 (공작물관리대장용)
  @override
  @JsonKey(name: 'area')
  double? get area;

  /// 관리기관
  @override
  @JsonKey(name: 'management_agency')
  String? get managementAgency;

  /// 지역 코드
  @override
  @JsonKey(name: 'region_code')
  String get regionCode;

  /// 데이터 수집일시
  @override
  @JsonKey(name: 'last_updated')
  DateTime? get lastUpdated;

  /// Create a copy of ParkingLotModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParkingLotModelImplCopyWith<_$ParkingLotModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
