// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bjdong_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BjdongModelImpl _$$BjdongModelImplFromJson(Map<String, dynamic> json) =>
    _$BjdongModelImpl(
      bjdongCode: json['bjdong_code'] as String,
      bjdongName: json['bjdong_name'] as String,
      sidoCode: json['sido_code'] as String,
      sidoName: json['sido_name'] as String,
      sigunguCode: json['sigungu_code'] as String,
      sigunguName: json['sigungu_name'] as String,
      bjdongType: $enumDecode(_$BjdongTypeEnumMap, json['bjdong_type']),
      isAbolished:
          json['is_abolished'] == null
              ? false
              : _boolFromInt(json['is_abolished']),
      createdDate:
          json['created_date'] == null
              ? null
              : DateTime.parse(json['created_date'] as String),
      abolishedDate:
          json['abolished_date'] == null
              ? null
              : DateTime.parse(json['abolished_date'] as String),
    );

Map<String, dynamic> _$$BjdongModelImplToJson(_$BjdongModelImpl instance) =>
    <String, dynamic>{
      'bjdong_code': instance.bjdongCode,
      'bjdong_name': instance.bjdongName,
      'sido_code': instance.sidoCode,
      'sido_name': instance.sidoName,
      'sigungu_code': instance.sigunguCode,
      'sigungu_name': instance.sigunguName,
      'bjdong_type': _$BjdongTypeEnumMap[instance.bjdongType]!,
      'is_abolished': _boolToInt(instance.isAbolished),
      'created_date': instance.createdDate?.toIso8601String(),
      'abolished_date': instance.abolishedDate?.toIso8601String(),
    };

const _$BjdongTypeEnumMap = {
  BjdongType.eup: 'eup',
  BjdongType.myeon: 'myeon',
  BjdongType.dong: 'dong',
};
