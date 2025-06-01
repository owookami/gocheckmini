// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_lot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParkingLotModelImpl _$$ParkingLotModelImplFromJson(
  Map<String, dynamic> json,
) => _$ParkingLotModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  detailAddress: json['detail_address'] as String?,
  type: $enumDecode(_$ParkingLotTypeEnumMap, json['type']),
  totalCapacity: (json['total_capacity'] as num).toInt(),
  availableSpots: (json['available_spots'] as num?)?.toInt(),
  operatingHoursStart: json['operating_hours_start'] as String?,
  operatingHoursEnd: json['operating_hours_end'] as String?,
  feeInfo: json['fee_info'] as String?,
  phoneNumber: json['phone_number'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  facilityInfo: json['facility_info'] as String?,
  area: (json['area'] as num?)?.toDouble(),
  managementAgency: json['management_agency'] as String?,
  regionCode: json['region_code'] as String,
  lastUpdated:
      json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
);

Map<String, dynamic> _$$ParkingLotModelImplToJson(
  _$ParkingLotModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'detail_address': instance.detailAddress,
  'type': _$ParkingLotTypeEnumMap[instance.type]!,
  'total_capacity': instance.totalCapacity,
  'available_spots': instance.availableSpots,
  'operating_hours_start': instance.operatingHoursStart,
  'operating_hours_end': instance.operatingHoursEnd,
  'fee_info': instance.feeInfo,
  'phone_number': instance.phoneNumber,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'facility_info': instance.facilityInfo,
  'area': instance.area,
  'management_agency': instance.managementAgency,
  'region_code': instance.regionCode,
  'last_updated': instance.lastUpdated?.toIso8601String(),
};

const _$ParkingLotTypeEnumMap = {
  ParkingLotType.general: 'general',
  ParkingLotType.attached: 'attached',
  ParkingLotType.structure: 'structure',
};
