// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegionModelImpl _$$RegionModelImplFromJson(Map<String, dynamic> json) =>
    _$RegionModelImpl(
      id: (json['id'] as num?)?.toInt(),
      unifiedCode: (json['unified_code'] as num?)?.toInt() ?? 0,
      sigunguCode: json['sigungu_code'] as String? ?? '',
      sigunguName: json['sigungu_name'] as String? ?? '',
      isAutonomousDistrict:
          json['is_autonomous_district'] == null
              ? false
              : _boolFromInt(json['is_autonomous_district']),
      province: json['province'] as String? ?? '',
      city: json['city'] as String? ?? '',
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$RegionModelImplToJson(_$RegionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unified_code': instance.unifiedCode,
      'sigungu_code': instance.sigunguCode,
      'sigungu_name': instance.sigunguName,
      'is_autonomous_district': _boolToInt(instance.isAutonomousDistrict),
      'province': instance.province,
      'city': instance.city,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
