// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RegionModel _$RegionModelFromJson(Map<String, dynamic> json) {
  return _RegionModel.fromJson(json);
}

/// @nodoc
mixin _$RegionModel {
  /// 데이터베이스 ID (자동 증가)
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;

  /// 통합분류코드 (고유 식별자)
  @JsonKey(name: 'unified_code')
  int get unifiedCode => throw _privateConstructorUsedError;

  /// 시군구코드 (행정구역 코드)
  @JsonKey(name: 'sigungu_code')
  String get sigunguCode => throw _privateConstructorUsedError;

  /// 시군구명 (행정구역 이름)
  @JsonKey(name: 'sigungu_name')
  String get sigunguName => throw _privateConstructorUsedError;

  /// 비자치구 여부 (true: 자치구, false: 비자치구)
  @JsonKey(
    name: 'is_autonomous_district',
    fromJson: _boolFromInt,
    toJson: _boolToInt,
  )
  bool get isAutonomousDistrict => throw _privateConstructorUsedError;

  /// 시도명 (상위 지역)
  @JsonKey(name: 'province')
  String get province => throw _privateConstructorUsedError;

  /// 시/군명
  @JsonKey(name: 'city')
  String get city => throw _privateConstructorUsedError;

  /// 생성일시
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// 수정일시
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this RegionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegionModelCopyWith<RegionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionModelCopyWith<$Res> {
  factory $RegionModelCopyWith(
    RegionModel value,
    $Res Function(RegionModel) then,
  ) = _$RegionModelCopyWithImpl<$Res, RegionModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'unified_code') int unifiedCode,
    @JsonKey(name: 'sigungu_code') String sigunguCode,
    @JsonKey(name: 'sigungu_name') String sigunguName,
    @JsonKey(
      name: 'is_autonomous_district',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    bool isAutonomousDistrict,
    @JsonKey(name: 'province') String province,
    @JsonKey(name: 'city') String city,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$RegionModelCopyWithImpl<$Res, $Val extends RegionModel>
    implements $RegionModelCopyWith<$Res> {
  _$RegionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? unifiedCode = null,
    Object? sigunguCode = null,
    Object? sigunguName = null,
    Object? isAutonomousDistrict = null,
    Object? province = null,
    Object? city = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int?,
            unifiedCode:
                null == unifiedCode
                    ? _value.unifiedCode
                    : unifiedCode // ignore: cast_nullable_to_non_nullable
                        as int,
            sigunguCode:
                null == sigunguCode
                    ? _value.sigunguCode
                    : sigunguCode // ignore: cast_nullable_to_non_nullable
                        as String,
            sigunguName:
                null == sigunguName
                    ? _value.sigunguName
                    : sigunguName // ignore: cast_nullable_to_non_nullable
                        as String,
            isAutonomousDistrict:
                null == isAutonomousDistrict
                    ? _value.isAutonomousDistrict
                    : isAutonomousDistrict // ignore: cast_nullable_to_non_nullable
                        as bool,
            province:
                null == province
                    ? _value.province
                    : province // ignore: cast_nullable_to_non_nullable
                        as String,
            city:
                null == city
                    ? _value.city
                    : city // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegionModelImplCopyWith<$Res>
    implements $RegionModelCopyWith<$Res> {
  factory _$$RegionModelImplCopyWith(
    _$RegionModelImpl value,
    $Res Function(_$RegionModelImpl) then,
  ) = __$$RegionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'unified_code') int unifiedCode,
    @JsonKey(name: 'sigungu_code') String sigunguCode,
    @JsonKey(name: 'sigungu_name') String sigunguName,
    @JsonKey(
      name: 'is_autonomous_district',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    bool isAutonomousDistrict,
    @JsonKey(name: 'province') String province,
    @JsonKey(name: 'city') String city,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$RegionModelImplCopyWithImpl<$Res>
    extends _$RegionModelCopyWithImpl<$Res, _$RegionModelImpl>
    implements _$$RegionModelImplCopyWith<$Res> {
  __$$RegionModelImplCopyWithImpl(
    _$RegionModelImpl _value,
    $Res Function(_$RegionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? unifiedCode = null,
    Object? sigunguCode = null,
    Object? sigunguName = null,
    Object? isAutonomousDistrict = null,
    Object? province = null,
    Object? city = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$RegionModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int?,
        unifiedCode:
            null == unifiedCode
                ? _value.unifiedCode
                : unifiedCode // ignore: cast_nullable_to_non_nullable
                    as int,
        sigunguCode:
            null == sigunguCode
                ? _value.sigunguCode
                : sigunguCode // ignore: cast_nullable_to_non_nullable
                    as String,
        sigunguName:
            null == sigunguName
                ? _value.sigunguName
                : sigunguName // ignore: cast_nullable_to_non_nullable
                    as String,
        isAutonomousDistrict:
            null == isAutonomousDistrict
                ? _value.isAutonomousDistrict
                : isAutonomousDistrict // ignore: cast_nullable_to_non_nullable
                    as bool,
        province:
            null == province
                ? _value.province
                : province // ignore: cast_nullable_to_non_nullable
                    as String,
        city:
            null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegionModelImpl extends _RegionModel {
  const _$RegionModelImpl({
    @JsonKey(name: 'id') this.id,
    @JsonKey(name: 'unified_code') this.unifiedCode = 0,
    @JsonKey(name: 'sigungu_code') this.sigunguCode = '',
    @JsonKey(name: 'sigungu_name') this.sigunguName = '',
    @JsonKey(
      name: 'is_autonomous_district',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    this.isAutonomousDistrict = false,
    @JsonKey(name: 'province') this.province = '',
    @JsonKey(name: 'city') this.city = '',
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : super._();

  factory _$RegionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionModelImplFromJson(json);

  /// 데이터베이스 ID (자동 증가)
  @override
  @JsonKey(name: 'id')
  final int? id;

  /// 통합분류코드 (고유 식별자)
  @override
  @JsonKey(name: 'unified_code')
  final int unifiedCode;

  /// 시군구코드 (행정구역 코드)
  @override
  @JsonKey(name: 'sigungu_code')
  final String sigunguCode;

  /// 시군구명 (행정구역 이름)
  @override
  @JsonKey(name: 'sigungu_name')
  final String sigunguName;

  /// 비자치구 여부 (true: 자치구, false: 비자치구)
  @override
  @JsonKey(
    name: 'is_autonomous_district',
    fromJson: _boolFromInt,
    toJson: _boolToInt,
  )
  final bool isAutonomousDistrict;

  /// 시도명 (상위 지역)
  @override
  @JsonKey(name: 'province')
  final String province;

  /// 시/군명
  @override
  @JsonKey(name: 'city')
  final String city;

  /// 생성일시
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// 수정일시
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'RegionModel(id: $id, unifiedCode: $unifiedCode, sigunguCode: $sigunguCode, sigunguName: $sigunguName, isAutonomousDistrict: $isAutonomousDistrict, province: $province, city: $city, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.unifiedCode, unifiedCode) ||
                other.unifiedCode == unifiedCode) &&
            (identical(other.sigunguCode, sigunguCode) ||
                other.sigunguCode == sigunguCode) &&
            (identical(other.sigunguName, sigunguName) ||
                other.sigunguName == sigunguName) &&
            (identical(other.isAutonomousDistrict, isAutonomousDistrict) ||
                other.isAutonomousDistrict == isAutonomousDistrict) &&
            (identical(other.province, province) ||
                other.province == province) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    unifiedCode,
    sigunguCode,
    sigunguName,
    isAutonomousDistrict,
    province,
    city,
    createdAt,
    updatedAt,
  );

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionModelImplCopyWith<_$RegionModelImpl> get copyWith =>
      __$$RegionModelImplCopyWithImpl<_$RegionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionModelImplToJson(this);
  }
}

abstract class _RegionModel extends RegionModel {
  const factory _RegionModel({
    @JsonKey(name: 'id') final int? id,
    @JsonKey(name: 'unified_code') final int unifiedCode,
    @JsonKey(name: 'sigungu_code') final String sigunguCode,
    @JsonKey(name: 'sigungu_name') final String sigunguName,
    @JsonKey(
      name: 'is_autonomous_district',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    final bool isAutonomousDistrict,
    @JsonKey(name: 'province') final String province,
    @JsonKey(name: 'city') final String city,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$RegionModelImpl;
  const _RegionModel._() : super._();

  factory _RegionModel.fromJson(Map<String, dynamic> json) =
      _$RegionModelImpl.fromJson;

  /// 데이터베이스 ID (자동 증가)
  @override
  @JsonKey(name: 'id')
  int? get id;

  /// 통합분류코드 (고유 식별자)
  @override
  @JsonKey(name: 'unified_code')
  int get unifiedCode;

  /// 시군구코드 (행정구역 코드)
  @override
  @JsonKey(name: 'sigungu_code')
  String get sigunguCode;

  /// 시군구명 (행정구역 이름)
  @override
  @JsonKey(name: 'sigungu_name')
  String get sigunguName;

  /// 비자치구 여부 (true: 자치구, false: 비자치구)
  @override
  @JsonKey(
    name: 'is_autonomous_district',
    fromJson: _boolFromInt,
    toJson: _boolToInt,
  )
  bool get isAutonomousDistrict;

  /// 시도명 (상위 지역)
  @override
  @JsonKey(name: 'province')
  String get province;

  /// 시/군명
  @override
  @JsonKey(name: 'city')
  String get city;

  /// 생성일시
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// 수정일시
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegionModelImplCopyWith<_$RegionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
