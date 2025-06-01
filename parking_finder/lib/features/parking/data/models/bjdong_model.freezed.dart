// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bjdong_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BjdongModel _$BjdongModelFromJson(Map<String, dynamic> json) {
  return _BjdongModel.fromJson(json);
}

/// @nodoc
mixin _$BjdongModel {
  /// 법정동 코드 (10자리)
  @JsonKey(name: 'bjdong_code')
  String get bjdongCode => throw _privateConstructorUsedError;

  /// 법정동명
  @JsonKey(name: 'bjdong_name')
  String get bjdongName => throw _privateConstructorUsedError;

  /// 시도 코드
  @JsonKey(name: 'sido_code')
  String get sidoCode => throw _privateConstructorUsedError;

  /// 시도명
  @JsonKey(name: 'sido_name')
  String get sidoName => throw _privateConstructorUsedError;

  /// 시군구 코드
  @JsonKey(name: 'sigungu_code')
  String get sigunguCode => throw _privateConstructorUsedError;

  /// 시군구명
  @JsonKey(name: 'sigungu_name')
  String get sigunguName => throw _privateConstructorUsedError;

  /// 읍면동 구분 (읍/면/동)
  @JsonKey(name: 'bjdong_type')
  BjdongType get bjdongType => throw _privateConstructorUsedError;

  /// 폐지 여부
  @JsonKey(name: 'is_abolished', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isAbolished => throw _privateConstructorUsedError;

  /// 생성일
  @JsonKey(name: 'created_date')
  DateTime? get createdDate => throw _privateConstructorUsedError;

  /// 폐지일
  @JsonKey(name: 'abolished_date')
  DateTime? get abolishedDate => throw _privateConstructorUsedError;

  /// Serializes this BjdongModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BjdongModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BjdongModelCopyWith<BjdongModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BjdongModelCopyWith<$Res> {
  factory $BjdongModelCopyWith(
    BjdongModel value,
    $Res Function(BjdongModel) then,
  ) = _$BjdongModelCopyWithImpl<$Res, BjdongModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'bjdong_code') String bjdongCode,
    @JsonKey(name: 'bjdong_name') String bjdongName,
    @JsonKey(name: 'sido_code') String sidoCode,
    @JsonKey(name: 'sido_name') String sidoName,
    @JsonKey(name: 'sigungu_code') String sigunguCode,
    @JsonKey(name: 'sigungu_name') String sigunguName,
    @JsonKey(name: 'bjdong_type') BjdongType bjdongType,
    @JsonKey(name: 'is_abolished', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isAbolished,
    @JsonKey(name: 'created_date') DateTime? createdDate,
    @JsonKey(name: 'abolished_date') DateTime? abolishedDate,
  });
}

/// @nodoc
class _$BjdongModelCopyWithImpl<$Res, $Val extends BjdongModel>
    implements $BjdongModelCopyWith<$Res> {
  _$BjdongModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BjdongModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bjdongCode = null,
    Object? bjdongName = null,
    Object? sidoCode = null,
    Object? sidoName = null,
    Object? sigunguCode = null,
    Object? sigunguName = null,
    Object? bjdongType = null,
    Object? isAbolished = null,
    Object? createdDate = freezed,
    Object? abolishedDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            bjdongCode:
                null == bjdongCode
                    ? _value.bjdongCode
                    : bjdongCode // ignore: cast_nullable_to_non_nullable
                        as String,
            bjdongName:
                null == bjdongName
                    ? _value.bjdongName
                    : bjdongName // ignore: cast_nullable_to_non_nullable
                        as String,
            sidoCode:
                null == sidoCode
                    ? _value.sidoCode
                    : sidoCode // ignore: cast_nullable_to_non_nullable
                        as String,
            sidoName:
                null == sidoName
                    ? _value.sidoName
                    : sidoName // ignore: cast_nullable_to_non_nullable
                        as String,
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
            bjdongType:
                null == bjdongType
                    ? _value.bjdongType
                    : bjdongType // ignore: cast_nullable_to_non_nullable
                        as BjdongType,
            isAbolished:
                null == isAbolished
                    ? _value.isAbolished
                    : isAbolished // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdDate:
                freezed == createdDate
                    ? _value.createdDate
                    : createdDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            abolishedDate:
                freezed == abolishedDate
                    ? _value.abolishedDate
                    : abolishedDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BjdongModelImplCopyWith<$Res>
    implements $BjdongModelCopyWith<$Res> {
  factory _$$BjdongModelImplCopyWith(
    _$BjdongModelImpl value,
    $Res Function(_$BjdongModelImpl) then,
  ) = __$$BjdongModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'bjdong_code') String bjdongCode,
    @JsonKey(name: 'bjdong_name') String bjdongName,
    @JsonKey(name: 'sido_code') String sidoCode,
    @JsonKey(name: 'sido_name') String sidoName,
    @JsonKey(name: 'sigungu_code') String sigunguCode,
    @JsonKey(name: 'sigungu_name') String sigunguName,
    @JsonKey(name: 'bjdong_type') BjdongType bjdongType,
    @JsonKey(name: 'is_abolished', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isAbolished,
    @JsonKey(name: 'created_date') DateTime? createdDate,
    @JsonKey(name: 'abolished_date') DateTime? abolishedDate,
  });
}

/// @nodoc
class __$$BjdongModelImplCopyWithImpl<$Res>
    extends _$BjdongModelCopyWithImpl<$Res, _$BjdongModelImpl>
    implements _$$BjdongModelImplCopyWith<$Res> {
  __$$BjdongModelImplCopyWithImpl(
    _$BjdongModelImpl _value,
    $Res Function(_$BjdongModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BjdongModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bjdongCode = null,
    Object? bjdongName = null,
    Object? sidoCode = null,
    Object? sidoName = null,
    Object? sigunguCode = null,
    Object? sigunguName = null,
    Object? bjdongType = null,
    Object? isAbolished = null,
    Object? createdDate = freezed,
    Object? abolishedDate = freezed,
  }) {
    return _then(
      _$BjdongModelImpl(
        bjdongCode:
            null == bjdongCode
                ? _value.bjdongCode
                : bjdongCode // ignore: cast_nullable_to_non_nullable
                    as String,
        bjdongName:
            null == bjdongName
                ? _value.bjdongName
                : bjdongName // ignore: cast_nullable_to_non_nullable
                    as String,
        sidoCode:
            null == sidoCode
                ? _value.sidoCode
                : sidoCode // ignore: cast_nullable_to_non_nullable
                    as String,
        sidoName:
            null == sidoName
                ? _value.sidoName
                : sidoName // ignore: cast_nullable_to_non_nullable
                    as String,
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
        bjdongType:
            null == bjdongType
                ? _value.bjdongType
                : bjdongType // ignore: cast_nullable_to_non_nullable
                    as BjdongType,
        isAbolished:
            null == isAbolished
                ? _value.isAbolished
                : isAbolished // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdDate:
            freezed == createdDate
                ? _value.createdDate
                : createdDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        abolishedDate:
            freezed == abolishedDate
                ? _value.abolishedDate
                : abolishedDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BjdongModelImpl extends _BjdongModel {
  const _$BjdongModelImpl({
    @JsonKey(name: 'bjdong_code') required this.bjdongCode,
    @JsonKey(name: 'bjdong_name') required this.bjdongName,
    @JsonKey(name: 'sido_code') required this.sidoCode,
    @JsonKey(name: 'sido_name') required this.sidoName,
    @JsonKey(name: 'sigungu_code') required this.sigunguCode,
    @JsonKey(name: 'sigungu_name') required this.sigunguName,
    @JsonKey(name: 'bjdong_type') required this.bjdongType,
    @JsonKey(name: 'is_abolished', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isAbolished = false,
    @JsonKey(name: 'created_date') this.createdDate,
    @JsonKey(name: 'abolished_date') this.abolishedDate,
  }) : super._();

  factory _$BjdongModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BjdongModelImplFromJson(json);

  /// 법정동 코드 (10자리)
  @override
  @JsonKey(name: 'bjdong_code')
  final String bjdongCode;

  /// 법정동명
  @override
  @JsonKey(name: 'bjdong_name')
  final String bjdongName;

  /// 시도 코드
  @override
  @JsonKey(name: 'sido_code')
  final String sidoCode;

  /// 시도명
  @override
  @JsonKey(name: 'sido_name')
  final String sidoName;

  /// 시군구 코드
  @override
  @JsonKey(name: 'sigungu_code')
  final String sigunguCode;

  /// 시군구명
  @override
  @JsonKey(name: 'sigungu_name')
  final String sigunguName;

  /// 읍면동 구분 (읍/면/동)
  @override
  @JsonKey(name: 'bjdong_type')
  final BjdongType bjdongType;

  /// 폐지 여부
  @override
  @JsonKey(name: 'is_abolished', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isAbolished;

  /// 생성일
  @override
  @JsonKey(name: 'created_date')
  final DateTime? createdDate;

  /// 폐지일
  @override
  @JsonKey(name: 'abolished_date')
  final DateTime? abolishedDate;

  @override
  String toString() {
    return 'BjdongModel(bjdongCode: $bjdongCode, bjdongName: $bjdongName, sidoCode: $sidoCode, sidoName: $sidoName, sigunguCode: $sigunguCode, sigunguName: $sigunguName, bjdongType: $bjdongType, isAbolished: $isAbolished, createdDate: $createdDate, abolishedDate: $abolishedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BjdongModelImpl &&
            (identical(other.bjdongCode, bjdongCode) ||
                other.bjdongCode == bjdongCode) &&
            (identical(other.bjdongName, bjdongName) ||
                other.bjdongName == bjdongName) &&
            (identical(other.sidoCode, sidoCode) ||
                other.sidoCode == sidoCode) &&
            (identical(other.sidoName, sidoName) ||
                other.sidoName == sidoName) &&
            (identical(other.sigunguCode, sigunguCode) ||
                other.sigunguCode == sigunguCode) &&
            (identical(other.sigunguName, sigunguName) ||
                other.sigunguName == sigunguName) &&
            (identical(other.bjdongType, bjdongType) ||
                other.bjdongType == bjdongType) &&
            (identical(other.isAbolished, isAbolished) ||
                other.isAbolished == isAbolished) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.abolishedDate, abolishedDate) ||
                other.abolishedDate == abolishedDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    bjdongCode,
    bjdongName,
    sidoCode,
    sidoName,
    sigunguCode,
    sigunguName,
    bjdongType,
    isAbolished,
    createdDate,
    abolishedDate,
  );

  /// Create a copy of BjdongModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BjdongModelImplCopyWith<_$BjdongModelImpl> get copyWith =>
      __$$BjdongModelImplCopyWithImpl<_$BjdongModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BjdongModelImplToJson(this);
  }
}

abstract class _BjdongModel extends BjdongModel {
  const factory _BjdongModel({
    @JsonKey(name: 'bjdong_code') required final String bjdongCode,
    @JsonKey(name: 'bjdong_name') required final String bjdongName,
    @JsonKey(name: 'sido_code') required final String sidoCode,
    @JsonKey(name: 'sido_name') required final String sidoName,
    @JsonKey(name: 'sigungu_code') required final String sigunguCode,
    @JsonKey(name: 'sigungu_name') required final String sigunguName,
    @JsonKey(name: 'bjdong_type') required final BjdongType bjdongType,
    @JsonKey(name: 'is_abolished', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isAbolished,
    @JsonKey(name: 'created_date') final DateTime? createdDate,
    @JsonKey(name: 'abolished_date') final DateTime? abolishedDate,
  }) = _$BjdongModelImpl;
  const _BjdongModel._() : super._();

  factory _BjdongModel.fromJson(Map<String, dynamic> json) =
      _$BjdongModelImpl.fromJson;

  /// 법정동 코드 (10자리)
  @override
  @JsonKey(name: 'bjdong_code')
  String get bjdongCode;

  /// 법정동명
  @override
  @JsonKey(name: 'bjdong_name')
  String get bjdongName;

  /// 시도 코드
  @override
  @JsonKey(name: 'sido_code')
  String get sidoCode;

  /// 시도명
  @override
  @JsonKey(name: 'sido_name')
  String get sidoName;

  /// 시군구 코드
  @override
  @JsonKey(name: 'sigungu_code')
  String get sigunguCode;

  /// 시군구명
  @override
  @JsonKey(name: 'sigungu_name')
  String get sigunguName;

  /// 읍면동 구분 (읍/면/동)
  @override
  @JsonKey(name: 'bjdong_type')
  BjdongType get bjdongType;

  /// 폐지 여부
  @override
  @JsonKey(name: 'is_abolished', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isAbolished;

  /// 생성일
  @override
  @JsonKey(name: 'created_date')
  DateTime? get createdDate;

  /// 폐지일
  @override
  @JsonKey(name: 'abolished_date')
  DateTime? get abolishedDate;

  /// Create a copy of BjdongModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BjdongModelImplCopyWith<_$BjdongModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
