// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'standard_region_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StandardRegion _$StandardRegionFromJson(Map<String, dynamic> json) {
  return _StandardRegion.fromJson(json);
}

/// @nodoc
mixin _$StandardRegion {
  @JsonKey(name: 'region_cd')
  String? get regionCd => throw _privateConstructorUsedError; // 지역코드 (10자리)
  @JsonKey(name: 'sido_cd')
  String? get sidoCd => throw _privateConstructorUsedError; // 시도코드 (2자리)
  @JsonKey(name: 'sgg_cd')
  String? get sggCd => throw _privateConstructorUsedError; // 시군구코드 (3자리)
  @JsonKey(name: 'umd_cd')
  String? get umdCd => throw _privateConstructorUsedError; // 읍면동코드 (3자리)
  @JsonKey(name: 'ri_cd')
  String? get riCd => throw _privateConstructorUsedError; // 리코드 (2자리)
  @JsonKey(name: 'locatjumin_cd')
  String? get locatjuminCd => throw _privateConstructorUsedError; // 지역코드_주민
  @JsonKey(name: 'locatjijuk_cd')
  String? get locatjijukCd => throw _privateConstructorUsedError; // 지역코드_지적
  @JsonKey(name: 'locatadd_nm')
  String? get locataddNm => throw _privateConstructorUsedError; // 지역주소명
  @JsonKey(name: 'locat_order')
  int? get locatOrder => throw _privateConstructorUsedError; // 서열
  @JsonKey(name: 'locat_rm')
  String? get locatRm => throw _privateConstructorUsedError; // 비고
  @JsonKey(name: 'locathigh_cd')
  String? get locathighCd => throw _privateConstructorUsedError; // 상위지역코드
  @JsonKey(name: 'locatlow_nm')
  String? get locatlowNm => throw _privateConstructorUsedError; // 최하위지역명
  @JsonKey(name: 'adpt_de')
  String? get adptDe => throw _privateConstructorUsedError;

  /// Serializes this StandardRegion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StandardRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandardRegionCopyWith<StandardRegion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandardRegionCopyWith<$Res> {
  factory $StandardRegionCopyWith(
    StandardRegion value,
    $Res Function(StandardRegion) then,
  ) = _$StandardRegionCopyWithImpl<$Res, StandardRegion>;
  @useResult
  $Res call({
    @JsonKey(name: 'region_cd') String? regionCd,
    @JsonKey(name: 'sido_cd') String? sidoCd,
    @JsonKey(name: 'sgg_cd') String? sggCd,
    @JsonKey(name: 'umd_cd') String? umdCd,
    @JsonKey(name: 'ri_cd') String? riCd,
    @JsonKey(name: 'locatjumin_cd') String? locatjuminCd,
    @JsonKey(name: 'locatjijuk_cd') String? locatjijukCd,
    @JsonKey(name: 'locatadd_nm') String? locataddNm,
    @JsonKey(name: 'locat_order') int? locatOrder,
    @JsonKey(name: 'locat_rm') String? locatRm,
    @JsonKey(name: 'locathigh_cd') String? locathighCd,
    @JsonKey(name: 'locatlow_nm') String? locatlowNm,
    @JsonKey(name: 'adpt_de') String? adptDe,
  });
}

/// @nodoc
class _$StandardRegionCopyWithImpl<$Res, $Val extends StandardRegion>
    implements $StandardRegionCopyWith<$Res> {
  _$StandardRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StandardRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionCd = freezed,
    Object? sidoCd = freezed,
    Object? sggCd = freezed,
    Object? umdCd = freezed,
    Object? riCd = freezed,
    Object? locatjuminCd = freezed,
    Object? locatjijukCd = freezed,
    Object? locataddNm = freezed,
    Object? locatOrder = freezed,
    Object? locatRm = freezed,
    Object? locathighCd = freezed,
    Object? locatlowNm = freezed,
    Object? adptDe = freezed,
  }) {
    return _then(
      _value.copyWith(
            regionCd:
                freezed == regionCd
                    ? _value.regionCd
                    : regionCd // ignore: cast_nullable_to_non_nullable
                        as String?,
            sidoCd:
                freezed == sidoCd
                    ? _value.sidoCd
                    : sidoCd // ignore: cast_nullable_to_non_nullable
                        as String?,
            sggCd:
                freezed == sggCd
                    ? _value.sggCd
                    : sggCd // ignore: cast_nullable_to_non_nullable
                        as String?,
            umdCd:
                freezed == umdCd
                    ? _value.umdCd
                    : umdCd // ignore: cast_nullable_to_non_nullable
                        as String?,
            riCd:
                freezed == riCd
                    ? _value.riCd
                    : riCd // ignore: cast_nullable_to_non_nullable
                        as String?,
            locatjuminCd:
                freezed == locatjuminCd
                    ? _value.locatjuminCd
                    : locatjuminCd // ignore: cast_nullable_to_non_nullable
                        as String?,
            locatjijukCd:
                freezed == locatjijukCd
                    ? _value.locatjijukCd
                    : locatjijukCd // ignore: cast_nullable_to_non_nullable
                        as String?,
            locataddNm:
                freezed == locataddNm
                    ? _value.locataddNm
                    : locataddNm // ignore: cast_nullable_to_non_nullable
                        as String?,
            locatOrder:
                freezed == locatOrder
                    ? _value.locatOrder
                    : locatOrder // ignore: cast_nullable_to_non_nullable
                        as int?,
            locatRm:
                freezed == locatRm
                    ? _value.locatRm
                    : locatRm // ignore: cast_nullable_to_non_nullable
                        as String?,
            locathighCd:
                freezed == locathighCd
                    ? _value.locathighCd
                    : locathighCd // ignore: cast_nullable_to_non_nullable
                        as String?,
            locatlowNm:
                freezed == locatlowNm
                    ? _value.locatlowNm
                    : locatlowNm // ignore: cast_nullable_to_non_nullable
                        as String?,
            adptDe:
                freezed == adptDe
                    ? _value.adptDe
                    : adptDe // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StandardRegionImplCopyWith<$Res>
    implements $StandardRegionCopyWith<$Res> {
  factory _$$StandardRegionImplCopyWith(
    _$StandardRegionImpl value,
    $Res Function(_$StandardRegionImpl) then,
  ) = __$$StandardRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'region_cd') String? regionCd,
    @JsonKey(name: 'sido_cd') String? sidoCd,
    @JsonKey(name: 'sgg_cd') String? sggCd,
    @JsonKey(name: 'umd_cd') String? umdCd,
    @JsonKey(name: 'ri_cd') String? riCd,
    @JsonKey(name: 'locatjumin_cd') String? locatjuminCd,
    @JsonKey(name: 'locatjijuk_cd') String? locatjijukCd,
    @JsonKey(name: 'locatadd_nm') String? locataddNm,
    @JsonKey(name: 'locat_order') int? locatOrder,
    @JsonKey(name: 'locat_rm') String? locatRm,
    @JsonKey(name: 'locathigh_cd') String? locathighCd,
    @JsonKey(name: 'locatlow_nm') String? locatlowNm,
    @JsonKey(name: 'adpt_de') String? adptDe,
  });
}

/// @nodoc
class __$$StandardRegionImplCopyWithImpl<$Res>
    extends _$StandardRegionCopyWithImpl<$Res, _$StandardRegionImpl>
    implements _$$StandardRegionImplCopyWith<$Res> {
  __$$StandardRegionImplCopyWithImpl(
    _$StandardRegionImpl _value,
    $Res Function(_$StandardRegionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StandardRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionCd = freezed,
    Object? sidoCd = freezed,
    Object? sggCd = freezed,
    Object? umdCd = freezed,
    Object? riCd = freezed,
    Object? locatjuminCd = freezed,
    Object? locatjijukCd = freezed,
    Object? locataddNm = freezed,
    Object? locatOrder = freezed,
    Object? locatRm = freezed,
    Object? locathighCd = freezed,
    Object? locatlowNm = freezed,
    Object? adptDe = freezed,
  }) {
    return _then(
      _$StandardRegionImpl(
        regionCd:
            freezed == regionCd
                ? _value.regionCd
                : regionCd // ignore: cast_nullable_to_non_nullable
                    as String?,
        sidoCd:
            freezed == sidoCd
                ? _value.sidoCd
                : sidoCd // ignore: cast_nullable_to_non_nullable
                    as String?,
        sggCd:
            freezed == sggCd
                ? _value.sggCd
                : sggCd // ignore: cast_nullable_to_non_nullable
                    as String?,
        umdCd:
            freezed == umdCd
                ? _value.umdCd
                : umdCd // ignore: cast_nullable_to_non_nullable
                    as String?,
        riCd:
            freezed == riCd
                ? _value.riCd
                : riCd // ignore: cast_nullable_to_non_nullable
                    as String?,
        locatjuminCd:
            freezed == locatjuminCd
                ? _value.locatjuminCd
                : locatjuminCd // ignore: cast_nullable_to_non_nullable
                    as String?,
        locatjijukCd:
            freezed == locatjijukCd
                ? _value.locatjijukCd
                : locatjijukCd // ignore: cast_nullable_to_non_nullable
                    as String?,
        locataddNm:
            freezed == locataddNm
                ? _value.locataddNm
                : locataddNm // ignore: cast_nullable_to_non_nullable
                    as String?,
        locatOrder:
            freezed == locatOrder
                ? _value.locatOrder
                : locatOrder // ignore: cast_nullable_to_non_nullable
                    as int?,
        locatRm:
            freezed == locatRm
                ? _value.locatRm
                : locatRm // ignore: cast_nullable_to_non_nullable
                    as String?,
        locathighCd:
            freezed == locathighCd
                ? _value.locathighCd
                : locathighCd // ignore: cast_nullable_to_non_nullable
                    as String?,
        locatlowNm:
            freezed == locatlowNm
                ? _value.locatlowNm
                : locatlowNm // ignore: cast_nullable_to_non_nullable
                    as String?,
        adptDe:
            freezed == adptDe
                ? _value.adptDe
                : adptDe // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StandardRegionImpl implements _StandardRegion {
  const _$StandardRegionImpl({
    @JsonKey(name: 'region_cd') this.regionCd,
    @JsonKey(name: 'sido_cd') this.sidoCd,
    @JsonKey(name: 'sgg_cd') this.sggCd,
    @JsonKey(name: 'umd_cd') this.umdCd,
    @JsonKey(name: 'ri_cd') this.riCd,
    @JsonKey(name: 'locatjumin_cd') this.locatjuminCd,
    @JsonKey(name: 'locatjijuk_cd') this.locatjijukCd,
    @JsonKey(name: 'locatadd_nm') this.locataddNm,
    @JsonKey(name: 'locat_order') this.locatOrder,
    @JsonKey(name: 'locat_rm') this.locatRm,
    @JsonKey(name: 'locathigh_cd') this.locathighCd,
    @JsonKey(name: 'locatlow_nm') this.locatlowNm,
    @JsonKey(name: 'adpt_de') this.adptDe,
  });

  factory _$StandardRegionImpl.fromJson(Map<String, dynamic> json) =>
      _$$StandardRegionImplFromJson(json);

  @override
  @JsonKey(name: 'region_cd')
  final String? regionCd;
  // 지역코드 (10자리)
  @override
  @JsonKey(name: 'sido_cd')
  final String? sidoCd;
  // 시도코드 (2자리)
  @override
  @JsonKey(name: 'sgg_cd')
  final String? sggCd;
  // 시군구코드 (3자리)
  @override
  @JsonKey(name: 'umd_cd')
  final String? umdCd;
  // 읍면동코드 (3자리)
  @override
  @JsonKey(name: 'ri_cd')
  final String? riCd;
  // 리코드 (2자리)
  @override
  @JsonKey(name: 'locatjumin_cd')
  final String? locatjuminCd;
  // 지역코드_주민
  @override
  @JsonKey(name: 'locatjijuk_cd')
  final String? locatjijukCd;
  // 지역코드_지적
  @override
  @JsonKey(name: 'locatadd_nm')
  final String? locataddNm;
  // 지역주소명
  @override
  @JsonKey(name: 'locat_order')
  final int? locatOrder;
  // 서열
  @override
  @JsonKey(name: 'locat_rm')
  final String? locatRm;
  // 비고
  @override
  @JsonKey(name: 'locathigh_cd')
  final String? locathighCd;
  // 상위지역코드
  @override
  @JsonKey(name: 'locatlow_nm')
  final String? locatlowNm;
  // 최하위지역명
  @override
  @JsonKey(name: 'adpt_de')
  final String? adptDe;

  @override
  String toString() {
    return 'StandardRegion(regionCd: $regionCd, sidoCd: $sidoCd, sggCd: $sggCd, umdCd: $umdCd, riCd: $riCd, locatjuminCd: $locatjuminCd, locatjijukCd: $locatjijukCd, locataddNm: $locataddNm, locatOrder: $locatOrder, locatRm: $locatRm, locathighCd: $locathighCd, locatlowNm: $locatlowNm, adptDe: $adptDe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandardRegionImpl &&
            (identical(other.regionCd, regionCd) ||
                other.regionCd == regionCd) &&
            (identical(other.sidoCd, sidoCd) || other.sidoCd == sidoCd) &&
            (identical(other.sggCd, sggCd) || other.sggCd == sggCd) &&
            (identical(other.umdCd, umdCd) || other.umdCd == umdCd) &&
            (identical(other.riCd, riCd) || other.riCd == riCd) &&
            (identical(other.locatjuminCd, locatjuminCd) ||
                other.locatjuminCd == locatjuminCd) &&
            (identical(other.locatjijukCd, locatjijukCd) ||
                other.locatjijukCd == locatjijukCd) &&
            (identical(other.locataddNm, locataddNm) ||
                other.locataddNm == locataddNm) &&
            (identical(other.locatOrder, locatOrder) ||
                other.locatOrder == locatOrder) &&
            (identical(other.locatRm, locatRm) || other.locatRm == locatRm) &&
            (identical(other.locathighCd, locathighCd) ||
                other.locathighCd == locathighCd) &&
            (identical(other.locatlowNm, locatlowNm) ||
                other.locatlowNm == locatlowNm) &&
            (identical(other.adptDe, adptDe) || other.adptDe == adptDe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    regionCd,
    sidoCd,
    sggCd,
    umdCd,
    riCd,
    locatjuminCd,
    locatjijukCd,
    locataddNm,
    locatOrder,
    locatRm,
    locathighCd,
    locatlowNm,
    adptDe,
  );

  /// Create a copy of StandardRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandardRegionImplCopyWith<_$StandardRegionImpl> get copyWith =>
      __$$StandardRegionImplCopyWithImpl<_$StandardRegionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StandardRegionImplToJson(this);
  }
}

abstract class _StandardRegion implements StandardRegion {
  const factory _StandardRegion({
    @JsonKey(name: 'region_cd') final String? regionCd,
    @JsonKey(name: 'sido_cd') final String? sidoCd,
    @JsonKey(name: 'sgg_cd') final String? sggCd,
    @JsonKey(name: 'umd_cd') final String? umdCd,
    @JsonKey(name: 'ri_cd') final String? riCd,
    @JsonKey(name: 'locatjumin_cd') final String? locatjuminCd,
    @JsonKey(name: 'locatjijuk_cd') final String? locatjijukCd,
    @JsonKey(name: 'locatadd_nm') final String? locataddNm,
    @JsonKey(name: 'locat_order') final int? locatOrder,
    @JsonKey(name: 'locat_rm') final String? locatRm,
    @JsonKey(name: 'locathigh_cd') final String? locathighCd,
    @JsonKey(name: 'locatlow_nm') final String? locatlowNm,
    @JsonKey(name: 'adpt_de') final String? adptDe,
  }) = _$StandardRegionImpl;

  factory _StandardRegion.fromJson(Map<String, dynamic> json) =
      _$StandardRegionImpl.fromJson;

  @override
  @JsonKey(name: 'region_cd')
  String? get regionCd; // 지역코드 (10자리)
  @override
  @JsonKey(name: 'sido_cd')
  String? get sidoCd; // 시도코드 (2자리)
  @override
  @JsonKey(name: 'sgg_cd')
  String? get sggCd; // 시군구코드 (3자리)
  @override
  @JsonKey(name: 'umd_cd')
  String? get umdCd; // 읍면동코드 (3자리)
  @override
  @JsonKey(name: 'ri_cd')
  String? get riCd; // 리코드 (2자리)
  @override
  @JsonKey(name: 'locatjumin_cd')
  String? get locatjuminCd; // 지역코드_주민
  @override
  @JsonKey(name: 'locatjijuk_cd')
  String? get locatjijukCd; // 지역코드_지적
  @override
  @JsonKey(name: 'locatadd_nm')
  String? get locataddNm; // 지역주소명
  @override
  @JsonKey(name: 'locat_order')
  int? get locatOrder; // 서열
  @override
  @JsonKey(name: 'locat_rm')
  String? get locatRm; // 비고
  @override
  @JsonKey(name: 'locathigh_cd')
  String? get locathighCd; // 상위지역코드
  @override
  @JsonKey(name: 'locatlow_nm')
  String? get locatlowNm; // 최하위지역명
  @override
  @JsonKey(name: 'adpt_de')
  String? get adptDe;

  /// Create a copy of StandardRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandardRegionImplCopyWith<_$StandardRegionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StandardRegionResponse _$StandardRegionResponseFromJson(
  Map<String, dynamic> json,
) {
  return _StandardRegionResponse.fromJson(json);
}

/// @nodoc
mixin _$StandardRegionResponse {
  StandardRegionResponseHeader get header => throw _privateConstructorUsedError;
  StandardRegionResponseBody get body => throw _privateConstructorUsedError;

  /// Serializes this StandardRegionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StandardRegionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandardRegionResponseCopyWith<StandardRegionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandardRegionResponseCopyWith<$Res> {
  factory $StandardRegionResponseCopyWith(
    StandardRegionResponse value,
    $Res Function(StandardRegionResponse) then,
  ) = _$StandardRegionResponseCopyWithImpl<$Res, StandardRegionResponse>;
  @useResult
  $Res call({
    StandardRegionResponseHeader header,
    StandardRegionResponseBody body,
  });

  $StandardRegionResponseHeaderCopyWith<$Res> get header;
  $StandardRegionResponseBodyCopyWith<$Res> get body;
}

/// @nodoc
class _$StandardRegionResponseCopyWithImpl<
  $Res,
  $Val extends StandardRegionResponse
>
    implements $StandardRegionResponseCopyWith<$Res> {
  _$StandardRegionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StandardRegionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? header = null, Object? body = null}) {
    return _then(
      _value.copyWith(
            header:
                null == header
                    ? _value.header
                    : header // ignore: cast_nullable_to_non_nullable
                        as StandardRegionResponseHeader,
            body:
                null == body
                    ? _value.body
                    : body // ignore: cast_nullable_to_non_nullable
                        as StandardRegionResponseBody,
          )
          as $Val,
    );
  }

  /// Create a copy of StandardRegionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StandardRegionResponseHeaderCopyWith<$Res> get header {
    return $StandardRegionResponseHeaderCopyWith<$Res>(_value.header, (value) {
      return _then(_value.copyWith(header: value) as $Val);
    });
  }

  /// Create a copy of StandardRegionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StandardRegionResponseBodyCopyWith<$Res> get body {
    return $StandardRegionResponseBodyCopyWith<$Res>(_value.body, (value) {
      return _then(_value.copyWith(body: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StandardRegionResponseImplCopyWith<$Res>
    implements $StandardRegionResponseCopyWith<$Res> {
  factory _$$StandardRegionResponseImplCopyWith(
    _$StandardRegionResponseImpl value,
    $Res Function(_$StandardRegionResponseImpl) then,
  ) = __$$StandardRegionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    StandardRegionResponseHeader header,
    StandardRegionResponseBody body,
  });

  @override
  $StandardRegionResponseHeaderCopyWith<$Res> get header;
  @override
  $StandardRegionResponseBodyCopyWith<$Res> get body;
}

/// @nodoc
class __$$StandardRegionResponseImplCopyWithImpl<$Res>
    extends
        _$StandardRegionResponseCopyWithImpl<$Res, _$StandardRegionResponseImpl>
    implements _$$StandardRegionResponseImplCopyWith<$Res> {
  __$$StandardRegionResponseImplCopyWithImpl(
    _$StandardRegionResponseImpl _value,
    $Res Function(_$StandardRegionResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StandardRegionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? header = null, Object? body = null}) {
    return _then(
      _$StandardRegionResponseImpl(
        header:
            null == header
                ? _value.header
                : header // ignore: cast_nullable_to_non_nullable
                    as StandardRegionResponseHeader,
        body:
            null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                    as StandardRegionResponseBody,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StandardRegionResponseImpl implements _StandardRegionResponse {
  const _$StandardRegionResponseImpl({
    required this.header,
    required this.body,
  });

  factory _$StandardRegionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StandardRegionResponseImplFromJson(json);

  @override
  final StandardRegionResponseHeader header;
  @override
  final StandardRegionResponseBody body;

  @override
  String toString() {
    return 'StandardRegionResponse(header: $header, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandardRegionResponseImpl &&
            (identical(other.header, header) || other.header == header) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, header, body);

  /// Create a copy of StandardRegionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandardRegionResponseImplCopyWith<_$StandardRegionResponseImpl>
  get copyWith =>
      __$$StandardRegionResponseImplCopyWithImpl<_$StandardRegionResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StandardRegionResponseImplToJson(this);
  }
}

abstract class _StandardRegionResponse implements StandardRegionResponse {
  const factory _StandardRegionResponse({
    required final StandardRegionResponseHeader header,
    required final StandardRegionResponseBody body,
  }) = _$StandardRegionResponseImpl;

  factory _StandardRegionResponse.fromJson(Map<String, dynamic> json) =
      _$StandardRegionResponseImpl.fromJson;

  @override
  StandardRegionResponseHeader get header;
  @override
  StandardRegionResponseBody get body;

  /// Create a copy of StandardRegionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandardRegionResponseImplCopyWith<_$StandardRegionResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StandardRegionResponseHeader _$StandardRegionResponseHeaderFromJson(
  Map<String, dynamic> json,
) {
  return _StandardRegionResponseHeader.fromJson(json);
}

/// @nodoc
mixin _$StandardRegionResponseHeader {
  @JsonKey(name: 'resultCode')
  String? get resultCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'resultMsg')
  String? get resultMsg => throw _privateConstructorUsedError;

  /// Serializes this StandardRegionResponseHeader to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StandardRegionResponseHeader
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandardRegionResponseHeaderCopyWith<StandardRegionResponseHeader>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandardRegionResponseHeaderCopyWith<$Res> {
  factory $StandardRegionResponseHeaderCopyWith(
    StandardRegionResponseHeader value,
    $Res Function(StandardRegionResponseHeader) then,
  ) =
      _$StandardRegionResponseHeaderCopyWithImpl<
        $Res,
        StandardRegionResponseHeader
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'resultCode') String? resultCode,
    @JsonKey(name: 'resultMsg') String? resultMsg,
  });
}

/// @nodoc
class _$StandardRegionResponseHeaderCopyWithImpl<
  $Res,
  $Val extends StandardRegionResponseHeader
>
    implements $StandardRegionResponseHeaderCopyWith<$Res> {
  _$StandardRegionResponseHeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StandardRegionResponseHeader
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? resultCode = freezed, Object? resultMsg = freezed}) {
    return _then(
      _value.copyWith(
            resultCode:
                freezed == resultCode
                    ? _value.resultCode
                    : resultCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            resultMsg:
                freezed == resultMsg
                    ? _value.resultMsg
                    : resultMsg // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StandardRegionResponseHeaderImplCopyWith<$Res>
    implements $StandardRegionResponseHeaderCopyWith<$Res> {
  factory _$$StandardRegionResponseHeaderImplCopyWith(
    _$StandardRegionResponseHeaderImpl value,
    $Res Function(_$StandardRegionResponseHeaderImpl) then,
  ) = __$$StandardRegionResponseHeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'resultCode') String? resultCode,
    @JsonKey(name: 'resultMsg') String? resultMsg,
  });
}

/// @nodoc
class __$$StandardRegionResponseHeaderImplCopyWithImpl<$Res>
    extends
        _$StandardRegionResponseHeaderCopyWithImpl<
          $Res,
          _$StandardRegionResponseHeaderImpl
        >
    implements _$$StandardRegionResponseHeaderImplCopyWith<$Res> {
  __$$StandardRegionResponseHeaderImplCopyWithImpl(
    _$StandardRegionResponseHeaderImpl _value,
    $Res Function(_$StandardRegionResponseHeaderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StandardRegionResponseHeader
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? resultCode = freezed, Object? resultMsg = freezed}) {
    return _then(
      _$StandardRegionResponseHeaderImpl(
        resultCode:
            freezed == resultCode
                ? _value.resultCode
                : resultCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        resultMsg:
            freezed == resultMsg
                ? _value.resultMsg
                : resultMsg // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StandardRegionResponseHeaderImpl
    implements _StandardRegionResponseHeader {
  const _$StandardRegionResponseHeaderImpl({
    @JsonKey(name: 'resultCode') this.resultCode,
    @JsonKey(name: 'resultMsg') this.resultMsg,
  });

  factory _$StandardRegionResponseHeaderImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$StandardRegionResponseHeaderImplFromJson(json);

  @override
  @JsonKey(name: 'resultCode')
  final String? resultCode;
  @override
  @JsonKey(name: 'resultMsg')
  final String? resultMsg;

  @override
  String toString() {
    return 'StandardRegionResponseHeader(resultCode: $resultCode, resultMsg: $resultMsg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandardRegionResponseHeaderImpl &&
            (identical(other.resultCode, resultCode) ||
                other.resultCode == resultCode) &&
            (identical(other.resultMsg, resultMsg) ||
                other.resultMsg == resultMsg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, resultCode, resultMsg);

  /// Create a copy of StandardRegionResponseHeader
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandardRegionResponseHeaderImplCopyWith<
    _$StandardRegionResponseHeaderImpl
  >
  get copyWith => __$$StandardRegionResponseHeaderImplCopyWithImpl<
    _$StandardRegionResponseHeaderImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StandardRegionResponseHeaderImplToJson(this);
  }
}

abstract class _StandardRegionResponseHeader
    implements StandardRegionResponseHeader {
  const factory _StandardRegionResponseHeader({
    @JsonKey(name: 'resultCode') final String? resultCode,
    @JsonKey(name: 'resultMsg') final String? resultMsg,
  }) = _$StandardRegionResponseHeaderImpl;

  factory _StandardRegionResponseHeader.fromJson(Map<String, dynamic> json) =
      _$StandardRegionResponseHeaderImpl.fromJson;

  @override
  @JsonKey(name: 'resultCode')
  String? get resultCode;
  @override
  @JsonKey(name: 'resultMsg')
  String? get resultMsg;

  /// Create a copy of StandardRegionResponseHeader
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandardRegionResponseHeaderImplCopyWith<
    _$StandardRegionResponseHeaderImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

StandardRegionResponseBody _$StandardRegionResponseBodyFromJson(
  Map<String, dynamic> json,
) {
  return _StandardRegionResponseBody.fromJson(json);
}

/// @nodoc
mixin _$StandardRegionResponseBody {
  @JsonKey(name: 'numOfRows')
  int? get numOfRows => throw _privateConstructorUsedError;
  @JsonKey(name: 'pageNo')
  int? get pageNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalCount')
  int? get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  StandardRegionItems? get items => throw _privateConstructorUsedError;

  /// Serializes this StandardRegionResponseBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StandardRegionResponseBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandardRegionResponseBodyCopyWith<StandardRegionResponseBody>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandardRegionResponseBodyCopyWith<$Res> {
  factory $StandardRegionResponseBodyCopyWith(
    StandardRegionResponseBody value,
    $Res Function(StandardRegionResponseBody) then,
  ) =
      _$StandardRegionResponseBodyCopyWithImpl<
        $Res,
        StandardRegionResponseBody
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'numOfRows') int? numOfRows,
    @JsonKey(name: 'pageNo') int? pageNo,
    @JsonKey(name: 'totalCount') int? totalCount,
    @JsonKey(name: 'items') StandardRegionItems? items,
  });

  $StandardRegionItemsCopyWith<$Res>? get items;
}

/// @nodoc
class _$StandardRegionResponseBodyCopyWithImpl<
  $Res,
  $Val extends StandardRegionResponseBody
>
    implements $StandardRegionResponseBodyCopyWith<$Res> {
  _$StandardRegionResponseBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StandardRegionResponseBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numOfRows = freezed,
    Object? pageNo = freezed,
    Object? totalCount = freezed,
    Object? items = freezed,
  }) {
    return _then(
      _value.copyWith(
            numOfRows:
                freezed == numOfRows
                    ? _value.numOfRows
                    : numOfRows // ignore: cast_nullable_to_non_nullable
                        as int?,
            pageNo:
                freezed == pageNo
                    ? _value.pageNo
                    : pageNo // ignore: cast_nullable_to_non_nullable
                        as int?,
            totalCount:
                freezed == totalCount
                    ? _value.totalCount
                    : totalCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            items:
                freezed == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as StandardRegionItems?,
          )
          as $Val,
    );
  }

  /// Create a copy of StandardRegionResponseBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StandardRegionItemsCopyWith<$Res>? get items {
    if (_value.items == null) {
      return null;
    }

    final items = _value.items;
    if (items != null) {
      return $StandardRegionItemsCopyWith<$Res>(items, (value) {
        return _then(_value.copyWith(items: value) as $Val);
      });
    }
    return null;
  }
}

/// @nodoc
abstract class _$$StandardRegionResponseBodyImplCopyWith<$Res>
    implements $StandardRegionResponseBodyCopyWith<$Res> {
  factory _$$StandardRegionResponseBodyImplCopyWith(
    _$StandardRegionResponseBodyImpl value,
    $Res Function(_$StandardRegionResponseBodyImpl) then,
  ) = __$$StandardRegionResponseBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'numOfRows') int? numOfRows,
    @JsonKey(name: 'pageNo') int? pageNo,
    @JsonKey(name: 'totalCount') int? totalCount,
    @JsonKey(name: 'items') StandardRegionItems? items,
  });

  @override
  $StandardRegionItemsCopyWith<$Res>? get items;
}

/// @nodoc
class __$$StandardRegionResponseBodyImplCopyWithImpl<$Res>
    extends
        _$StandardRegionResponseBodyCopyWithImpl<
          $Res,
          _$StandardRegionResponseBodyImpl
        >
    implements _$$StandardRegionResponseBodyImplCopyWith<$Res> {
  __$$StandardRegionResponseBodyImplCopyWithImpl(
    _$StandardRegionResponseBodyImpl _value,
    $Res Function(_$StandardRegionResponseBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StandardRegionResponseBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numOfRows = freezed,
    Object? pageNo = freezed,
    Object? totalCount = freezed,
    Object? items = freezed,
  }) {
    return _then(
      _$StandardRegionResponseBodyImpl(
        numOfRows:
            freezed == numOfRows
                ? _value.numOfRows
                : numOfRows // ignore: cast_nullable_to_non_nullable
                    as int?,
        pageNo:
            freezed == pageNo
                ? _value.pageNo
                : pageNo // ignore: cast_nullable_to_non_nullable
                    as int?,
        totalCount:
            freezed == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        items:
            freezed == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                    as StandardRegionItems?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StandardRegionResponseBodyImpl implements _StandardRegionResponseBody {
  const _$StandardRegionResponseBodyImpl({
    @JsonKey(name: 'numOfRows') this.numOfRows,
    @JsonKey(name: 'pageNo') this.pageNo,
    @JsonKey(name: 'totalCount') this.totalCount,
    @JsonKey(name: 'items') this.items,
  });

  factory _$StandardRegionResponseBodyImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$StandardRegionResponseBodyImplFromJson(json);

  @override
  @JsonKey(name: 'numOfRows')
  final int? numOfRows;
  @override
  @JsonKey(name: 'pageNo')
  final int? pageNo;
  @override
  @JsonKey(name: 'totalCount')
  final int? totalCount;
  @override
  @JsonKey(name: 'items')
  final StandardRegionItems? items;

  @override
  String toString() {
    return 'StandardRegionResponseBody(numOfRows: $numOfRows, pageNo: $pageNo, totalCount: $totalCount, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandardRegionResponseBodyImpl &&
            (identical(other.numOfRows, numOfRows) ||
                other.numOfRows == numOfRows) &&
            (identical(other.pageNo, pageNo) || other.pageNo == pageNo) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.items, items) || other.items == items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, numOfRows, pageNo, totalCount, items);

  /// Create a copy of StandardRegionResponseBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandardRegionResponseBodyImplCopyWith<_$StandardRegionResponseBodyImpl>
  get copyWith => __$$StandardRegionResponseBodyImplCopyWithImpl<
    _$StandardRegionResponseBodyImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StandardRegionResponseBodyImplToJson(this);
  }
}

abstract class _StandardRegionResponseBody
    implements StandardRegionResponseBody {
  const factory _StandardRegionResponseBody({
    @JsonKey(name: 'numOfRows') final int? numOfRows,
    @JsonKey(name: 'pageNo') final int? pageNo,
    @JsonKey(name: 'totalCount') final int? totalCount,
    @JsonKey(name: 'items') final StandardRegionItems? items,
  }) = _$StandardRegionResponseBodyImpl;

  factory _StandardRegionResponseBody.fromJson(Map<String, dynamic> json) =
      _$StandardRegionResponseBodyImpl.fromJson;

  @override
  @JsonKey(name: 'numOfRows')
  int? get numOfRows;
  @override
  @JsonKey(name: 'pageNo')
  int? get pageNo;
  @override
  @JsonKey(name: 'totalCount')
  int? get totalCount;
  @override
  @JsonKey(name: 'items')
  StandardRegionItems? get items;

  /// Create a copy of StandardRegionResponseBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandardRegionResponseBodyImplCopyWith<_$StandardRegionResponseBodyImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StandardRegionItems _$StandardRegionItemsFromJson(Map<String, dynamic> json) {
  return _StandardRegionItems.fromJson(json);
}

/// @nodoc
mixin _$StandardRegionItems {
  @JsonKey(name: 'item')
  List<StandardRegion>? get item => throw _privateConstructorUsedError;

  /// Serializes this StandardRegionItems to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StandardRegionItems
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandardRegionItemsCopyWith<StandardRegionItems> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandardRegionItemsCopyWith<$Res> {
  factory $StandardRegionItemsCopyWith(
    StandardRegionItems value,
    $Res Function(StandardRegionItems) then,
  ) = _$StandardRegionItemsCopyWithImpl<$Res, StandardRegionItems>;
  @useResult
  $Res call({@JsonKey(name: 'item') List<StandardRegion>? item});
}

/// @nodoc
class _$StandardRegionItemsCopyWithImpl<$Res, $Val extends StandardRegionItems>
    implements $StandardRegionItemsCopyWith<$Res> {
  _$StandardRegionItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StandardRegionItems
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? item = freezed}) {
    return _then(
      _value.copyWith(
            item:
                freezed == item
                    ? _value.item
                    : item // ignore: cast_nullable_to_non_nullable
                        as List<StandardRegion>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StandardRegionItemsImplCopyWith<$Res>
    implements $StandardRegionItemsCopyWith<$Res> {
  factory _$$StandardRegionItemsImplCopyWith(
    _$StandardRegionItemsImpl value,
    $Res Function(_$StandardRegionItemsImpl) then,
  ) = __$$StandardRegionItemsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'item') List<StandardRegion>? item});
}

/// @nodoc
class __$$StandardRegionItemsImplCopyWithImpl<$Res>
    extends _$StandardRegionItemsCopyWithImpl<$Res, _$StandardRegionItemsImpl>
    implements _$$StandardRegionItemsImplCopyWith<$Res> {
  __$$StandardRegionItemsImplCopyWithImpl(
    _$StandardRegionItemsImpl _value,
    $Res Function(_$StandardRegionItemsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StandardRegionItems
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? item = freezed}) {
    return _then(
      _$StandardRegionItemsImpl(
        item:
            freezed == item
                ? _value._item
                : item // ignore: cast_nullable_to_non_nullable
                    as List<StandardRegion>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StandardRegionItemsImpl implements _StandardRegionItems {
  const _$StandardRegionItemsImpl({
    @JsonKey(name: 'item') final List<StandardRegion>? item,
  }) : _item = item;

  factory _$StandardRegionItemsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StandardRegionItemsImplFromJson(json);

  final List<StandardRegion>? _item;
  @override
  @JsonKey(name: 'item')
  List<StandardRegion>? get item {
    final value = _item;
    if (value == null) return null;
    if (_item is EqualUnmodifiableListView) return _item;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'StandardRegionItems(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandardRegionItemsImpl &&
            const DeepCollectionEquality().equals(other._item, _item));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_item));

  /// Create a copy of StandardRegionItems
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandardRegionItemsImplCopyWith<_$StandardRegionItemsImpl> get copyWith =>
      __$$StandardRegionItemsImplCopyWithImpl<_$StandardRegionItemsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StandardRegionItemsImplToJson(this);
  }
}

abstract class _StandardRegionItems implements StandardRegionItems {
  const factory _StandardRegionItems({
    @JsonKey(name: 'item') final List<StandardRegion>? item,
  }) = _$StandardRegionItemsImpl;

  factory _StandardRegionItems.fromJson(Map<String, dynamic> json) =
      _$StandardRegionItemsImpl.fromJson;

  @override
  @JsonKey(name: 'item')
  List<StandardRegion>? get item;

  /// Create a copy of StandardRegionItems
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandardRegionItemsImplCopyWith<_$StandardRegionItemsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
