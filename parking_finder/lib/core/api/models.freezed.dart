// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ParkingLotResponse _$ParkingLotResponseFromJson(Map<String, dynamic> json) {
  return _ParkingLotResponse.fromJson(json);
}

/// @nodoc
mixin _$ParkingLotResponse {
  String get resultCode => throw _privateConstructorUsedError;
  String get resultMsg => throw _privateConstructorUsedError;
  int get numOfRows => throw _privateConstructorUsedError;
  int get pageNo => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  List<ParkingLotInfo> get items => throw _privateConstructorUsedError;

  /// Serializes this ParkingLotResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParkingLotResponseCopyWith<ParkingLotResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParkingLotResponseCopyWith<$Res> {
  factory $ParkingLotResponseCopyWith(
    ParkingLotResponse value,
    $Res Function(ParkingLotResponse) then,
  ) = _$ParkingLotResponseCopyWithImpl<$Res, ParkingLotResponse>;
  @useResult
  $Res call({
    String resultCode,
    String resultMsg,
    int numOfRows,
    int pageNo,
    int totalCount,
    List<ParkingLotInfo> items,
  });
}

/// @nodoc
class _$ParkingLotResponseCopyWithImpl<$Res, $Val extends ParkingLotResponse>
    implements $ParkingLotResponseCopyWith<$Res> {
  _$ParkingLotResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultCode = null,
    Object? resultMsg = null,
    Object? numOfRows = null,
    Object? pageNo = null,
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            resultCode:
                null == resultCode
                    ? _value.resultCode
                    : resultCode // ignore: cast_nullable_to_non_nullable
                        as String,
            resultMsg:
                null == resultMsg
                    ? _value.resultMsg
                    : resultMsg // ignore: cast_nullable_to_non_nullable
                        as String,
            numOfRows:
                null == numOfRows
                    ? _value.numOfRows
                    : numOfRows // ignore: cast_nullable_to_non_nullable
                        as int,
            pageNo:
                null == pageNo
                    ? _value.pageNo
                    : pageNo // ignore: cast_nullable_to_non_nullable
                        as int,
            totalCount:
                null == totalCount
                    ? _value.totalCount
                    : totalCount // ignore: cast_nullable_to_non_nullable
                        as int,
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<ParkingLotInfo>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParkingLotResponseImplCopyWith<$Res>
    implements $ParkingLotResponseCopyWith<$Res> {
  factory _$$ParkingLotResponseImplCopyWith(
    _$ParkingLotResponseImpl value,
    $Res Function(_$ParkingLotResponseImpl) then,
  ) = __$$ParkingLotResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String resultCode,
    String resultMsg,
    int numOfRows,
    int pageNo,
    int totalCount,
    List<ParkingLotInfo> items,
  });
}

/// @nodoc
class __$$ParkingLotResponseImplCopyWithImpl<$Res>
    extends _$ParkingLotResponseCopyWithImpl<$Res, _$ParkingLotResponseImpl>
    implements _$$ParkingLotResponseImplCopyWith<$Res> {
  __$$ParkingLotResponseImplCopyWithImpl(
    _$ParkingLotResponseImpl _value,
    $Res Function(_$ParkingLotResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultCode = null,
    Object? resultMsg = null,
    Object? numOfRows = null,
    Object? pageNo = null,
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(
      _$ParkingLotResponseImpl(
        resultCode:
            null == resultCode
                ? _value.resultCode
                : resultCode // ignore: cast_nullable_to_non_nullable
                    as String,
        resultMsg:
            null == resultMsg
                ? _value.resultMsg
                : resultMsg // ignore: cast_nullable_to_non_nullable
                    as String,
        numOfRows:
            null == numOfRows
                ? _value.numOfRows
                : numOfRows // ignore: cast_nullable_to_non_nullable
                    as int,
        pageNo:
            null == pageNo
                ? _value.pageNo
                : pageNo // ignore: cast_nullable_to_non_nullable
                    as int,
        totalCount:
            null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                    as int,
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<ParkingLotInfo>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParkingLotResponseImpl implements _ParkingLotResponse {
  const _$ParkingLotResponseImpl({
    required this.resultCode,
    required this.resultMsg,
    required this.numOfRows,
    required this.pageNo,
    required this.totalCount,
    required final List<ParkingLotInfo> items,
  }) : _items = items;

  factory _$ParkingLotResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParkingLotResponseImplFromJson(json);

  @override
  final String resultCode;
  @override
  final String resultMsg;
  @override
  final int numOfRows;
  @override
  final int pageNo;
  @override
  final int totalCount;
  final List<ParkingLotInfo> _items;
  @override
  List<ParkingLotInfo> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ParkingLotResponse(resultCode: $resultCode, resultMsg: $resultMsg, numOfRows: $numOfRows, pageNo: $pageNo, totalCount: $totalCount, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParkingLotResponseImpl &&
            (identical(other.resultCode, resultCode) ||
                other.resultCode == resultCode) &&
            (identical(other.resultMsg, resultMsg) ||
                other.resultMsg == resultMsg) &&
            (identical(other.numOfRows, numOfRows) ||
                other.numOfRows == numOfRows) &&
            (identical(other.pageNo, pageNo) || other.pageNo == pageNo) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    resultCode,
    resultMsg,
    numOfRows,
    pageNo,
    totalCount,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of ParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParkingLotResponseImplCopyWith<_$ParkingLotResponseImpl> get copyWith =>
      __$$ParkingLotResponseImplCopyWithImpl<_$ParkingLotResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParkingLotResponseImplToJson(this);
  }
}

abstract class _ParkingLotResponse implements ParkingLotResponse {
  const factory _ParkingLotResponse({
    required final String resultCode,
    required final String resultMsg,
    required final int numOfRows,
    required final int pageNo,
    required final int totalCount,
    required final List<ParkingLotInfo> items,
  }) = _$ParkingLotResponseImpl;

  factory _ParkingLotResponse.fromJson(Map<String, dynamic> json) =
      _$ParkingLotResponseImpl.fromJson;

  @override
  String get resultCode;
  @override
  String get resultMsg;
  @override
  int get numOfRows;
  @override
  int get pageNo;
  @override
  int get totalCount;
  @override
  List<ParkingLotInfo> get items;

  /// Create a copy of ParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParkingLotResponseImplCopyWith<_$ParkingLotResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttachedParkingLotResponse _$AttachedParkingLotResponseFromJson(
  Map<String, dynamic> json,
) {
  return _AttachedParkingLotResponse.fromJson(json);
}

/// @nodoc
mixin _$AttachedParkingLotResponse {
  String get resultCode => throw _privateConstructorUsedError;
  String get resultMsg => throw _privateConstructorUsedError;
  int get numOfRows => throw _privateConstructorUsedError;
  int get pageNo => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  List<AttachedParkingLotInfo> get items => throw _privateConstructorUsedError;

  /// Serializes this AttachedParkingLotResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttachedParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachedParkingLotResponseCopyWith<AttachedParkingLotResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachedParkingLotResponseCopyWith<$Res> {
  factory $AttachedParkingLotResponseCopyWith(
    AttachedParkingLotResponse value,
    $Res Function(AttachedParkingLotResponse) then,
  ) =
      _$AttachedParkingLotResponseCopyWithImpl<
        $Res,
        AttachedParkingLotResponse
      >;
  @useResult
  $Res call({
    String resultCode,
    String resultMsg,
    int numOfRows,
    int pageNo,
    int totalCount,
    List<AttachedParkingLotInfo> items,
  });
}

/// @nodoc
class _$AttachedParkingLotResponseCopyWithImpl<
  $Res,
  $Val extends AttachedParkingLotResponse
>
    implements $AttachedParkingLotResponseCopyWith<$Res> {
  _$AttachedParkingLotResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttachedParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultCode = null,
    Object? resultMsg = null,
    Object? numOfRows = null,
    Object? pageNo = null,
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            resultCode:
                null == resultCode
                    ? _value.resultCode
                    : resultCode // ignore: cast_nullable_to_non_nullable
                        as String,
            resultMsg:
                null == resultMsg
                    ? _value.resultMsg
                    : resultMsg // ignore: cast_nullable_to_non_nullable
                        as String,
            numOfRows:
                null == numOfRows
                    ? _value.numOfRows
                    : numOfRows // ignore: cast_nullable_to_non_nullable
                        as int,
            pageNo:
                null == pageNo
                    ? _value.pageNo
                    : pageNo // ignore: cast_nullable_to_non_nullable
                        as int,
            totalCount:
                null == totalCount
                    ? _value.totalCount
                    : totalCount // ignore: cast_nullable_to_non_nullable
                        as int,
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<AttachedParkingLotInfo>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttachedParkingLotResponseImplCopyWith<$Res>
    implements $AttachedParkingLotResponseCopyWith<$Res> {
  factory _$$AttachedParkingLotResponseImplCopyWith(
    _$AttachedParkingLotResponseImpl value,
    $Res Function(_$AttachedParkingLotResponseImpl) then,
  ) = __$$AttachedParkingLotResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String resultCode,
    String resultMsg,
    int numOfRows,
    int pageNo,
    int totalCount,
    List<AttachedParkingLotInfo> items,
  });
}

/// @nodoc
class __$$AttachedParkingLotResponseImplCopyWithImpl<$Res>
    extends
        _$AttachedParkingLotResponseCopyWithImpl<
          $Res,
          _$AttachedParkingLotResponseImpl
        >
    implements _$$AttachedParkingLotResponseImplCopyWith<$Res> {
  __$$AttachedParkingLotResponseImplCopyWithImpl(
    _$AttachedParkingLotResponseImpl _value,
    $Res Function(_$AttachedParkingLotResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttachedParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultCode = null,
    Object? resultMsg = null,
    Object? numOfRows = null,
    Object? pageNo = null,
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(
      _$AttachedParkingLotResponseImpl(
        resultCode:
            null == resultCode
                ? _value.resultCode
                : resultCode // ignore: cast_nullable_to_non_nullable
                    as String,
        resultMsg:
            null == resultMsg
                ? _value.resultMsg
                : resultMsg // ignore: cast_nullable_to_non_nullable
                    as String,
        numOfRows:
            null == numOfRows
                ? _value.numOfRows
                : numOfRows // ignore: cast_nullable_to_non_nullable
                    as int,
        pageNo:
            null == pageNo
                ? _value.pageNo
                : pageNo // ignore: cast_nullable_to_non_nullable
                    as int,
        totalCount:
            null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                    as int,
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<AttachedParkingLotInfo>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachedParkingLotResponseImpl implements _AttachedParkingLotResponse {
  const _$AttachedParkingLotResponseImpl({
    required this.resultCode,
    required this.resultMsg,
    required this.numOfRows,
    required this.pageNo,
    required this.totalCount,
    required final List<AttachedParkingLotInfo> items,
  }) : _items = items;

  factory _$AttachedParkingLotResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AttachedParkingLotResponseImplFromJson(json);

  @override
  final String resultCode;
  @override
  final String resultMsg;
  @override
  final int numOfRows;
  @override
  final int pageNo;
  @override
  final int totalCount;
  final List<AttachedParkingLotInfo> _items;
  @override
  List<AttachedParkingLotInfo> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'AttachedParkingLotResponse(resultCode: $resultCode, resultMsg: $resultMsg, numOfRows: $numOfRows, pageNo: $pageNo, totalCount: $totalCount, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachedParkingLotResponseImpl &&
            (identical(other.resultCode, resultCode) ||
                other.resultCode == resultCode) &&
            (identical(other.resultMsg, resultMsg) ||
                other.resultMsg == resultMsg) &&
            (identical(other.numOfRows, numOfRows) ||
                other.numOfRows == numOfRows) &&
            (identical(other.pageNo, pageNo) || other.pageNo == pageNo) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    resultCode,
    resultMsg,
    numOfRows,
    pageNo,
    totalCount,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of AttachedParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachedParkingLotResponseImplCopyWith<_$AttachedParkingLotResponseImpl>
  get copyWith => __$$AttachedParkingLotResponseImplCopyWithImpl<
    _$AttachedParkingLotResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachedParkingLotResponseImplToJson(this);
  }
}

abstract class _AttachedParkingLotResponse
    implements AttachedParkingLotResponse {
  const factory _AttachedParkingLotResponse({
    required final String resultCode,
    required final String resultMsg,
    required final int numOfRows,
    required final int pageNo,
    required final int totalCount,
    required final List<AttachedParkingLotInfo> items,
  }) = _$AttachedParkingLotResponseImpl;

  factory _AttachedParkingLotResponse.fromJson(Map<String, dynamic> json) =
      _$AttachedParkingLotResponseImpl.fromJson;

  @override
  String get resultCode;
  @override
  String get resultMsg;
  @override
  int get numOfRows;
  @override
  int get pageNo;
  @override
  int get totalCount;
  @override
  List<AttachedParkingLotInfo> get items;

  /// Create a copy of AttachedParkingLotResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachedParkingLotResponseImplCopyWith<_$AttachedParkingLotResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ParkingLotInfo _$ParkingLotInfoFromJson(Map<String, dynamic> json) {
  return _ParkingLotInfo.fromJson(json);
}

/// @nodoc
mixin _$ParkingLotInfo {
  @JsonKey(name: 'prkplceNo')
  String get parkingPlaceNo => throw _privateConstructorUsedError; // 주차장관리번호
  @JsonKey(name: 'prkplceNm')
  String get parkingPlaceName => throw _privateConstructorUsedError; // 주차장명
  @JsonKey(name: 'prkplceSe')
  String get parkingPlaceType => throw _privateConstructorUsedError; // 주차장구분
  @JsonKey(name: 'prkplceType')
  String get parkingType => throw _privateConstructorUsedError; // 주차장유형
  @JsonKey(name: 'rdnmadr')
  String get roadAddress => throw _privateConstructorUsedError; // 소재지도로명주소
  @JsonKey(name: 'lnmadr')
  String get address => throw _privateConstructorUsedError; // 소재지지번주소
  @JsonKey(name: 'prkcmprt')
  int get parkingSpace => throw _privateConstructorUsedError; // 주차구획수
  @JsonKey(name: 'feedSe')
  String get feeType => throw _privateConstructorUsedError; // 급지구분
  @JsonKey(name: 'enforceSe')
  String get enforceType => throw _privateConstructorUsedError; // 부제시행구분
  @JsonKey(name: 'operDay')
  String get operatingDays => throw _privateConstructorUsedError; // 운영요일
  @JsonKey(name: 'operOpenHm')
  String get operatingStartTime => throw _privateConstructorUsedError; // 평일운영시작시각
  @JsonKey(name: 'operColseHm')
  String get operatingEndTime => throw _privateConstructorUsedError; // 평일운영종료시각
  @JsonKey(name: 'satOperOpenHm')
  String get satOperatingStartTime => throw _privateConstructorUsedError; // 토요일운영시작시각
  @JsonKey(name: 'satOperCloseHm')
  String get satOperatingEndTime => throw _privateConstructorUsedError; // 토요일운영종료시각
  @JsonKey(name: 'holidayOperOpenHm')
  String get holidayOperatingStartTime => throw _privateConstructorUsedError; // 공휴일운영시작시각
  @JsonKey(name: 'holidayCloseOpenHm')
  String get holidayOperatingEndTime => throw _privateConstructorUsedError; // 공휴일운영종료시각
  @JsonKey(name: 'parkingchrgeInfo')
  String get parkingFeeInfo => throw _privateConstructorUsedError; // 주차요금정보
  @JsonKey(name: 'basicTime')
  String get basicTime => throw _privateConstructorUsedError; // 주차기본시간
  @JsonKey(name: 'basicCharge')
  String get basicCharge => throw _privateConstructorUsedError; // 주차기본요금
  @JsonKey(name: 'addUnitTime')
  String get addUnitTime => throw _privateConstructorUsedError; // 추가단위시간
  @JsonKey(name: 'addUnitCharge')
  String get addUnitCharge => throw _privateConstructorUsedError; // 추가단위요금
  @JsonKey(name: 'dayCmmtkt')
  String get dayCommutingTicket => throw _privateConstructorUsedError; // 일주차권요금
  @JsonKey(name: 'monthCmmtkt')
  String get monthCommutingTicket => throw _privateConstructorUsedError; // 월정기권요금
  @JsonKey(name: 'metpay')
  String get paymentMethod => throw _privateConstructorUsedError; // 결제방법
  @JsonKey(name: 'spcmnt')
  String get specialNote => throw _privateConstructorUsedError; // 특기사항
  @JsonKey(name: 'institutionNm')
  String get institutionName => throw _privateConstructorUsedError; // 관리기관명
  @JsonKey(name: 'phoneNumber')
  String get phoneNumber => throw _privateConstructorUsedError; // 전화번호
  @JsonKey(name: 'latitude')
  String get latitude => throw _privateConstructorUsedError; // 위도
  @JsonKey(name: 'longitude')
  String get longitude => throw _privateConstructorUsedError; // 경도
  @JsonKey(name: 'referenceDate')
  String get referenceDate => throw _privateConstructorUsedError; // 데이터기준일자
  @JsonKey(name: 'instt_code')
  String get institutionCode => throw _privateConstructorUsedError; // 제공기관코드
  @JsonKey(name: 'instt_nm')
  String get institutionProviderName => throw _privateConstructorUsedError;

  /// Serializes this ParkingLotInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParkingLotInfoCopyWith<ParkingLotInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParkingLotInfoCopyWith<$Res> {
  factory $ParkingLotInfoCopyWith(
    ParkingLotInfo value,
    $Res Function(ParkingLotInfo) then,
  ) = _$ParkingLotInfoCopyWithImpl<$Res, ParkingLotInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'prkplceNo') String parkingPlaceNo,
    @JsonKey(name: 'prkplceNm') String parkingPlaceName,
    @JsonKey(name: 'prkplceSe') String parkingPlaceType,
    @JsonKey(name: 'prkplceType') String parkingType,
    @JsonKey(name: 'rdnmadr') String roadAddress,
    @JsonKey(name: 'lnmadr') String address,
    @JsonKey(name: 'prkcmprt') int parkingSpace,
    @JsonKey(name: 'feedSe') String feeType,
    @JsonKey(name: 'enforceSe') String enforceType,
    @JsonKey(name: 'operDay') String operatingDays,
    @JsonKey(name: 'operOpenHm') String operatingStartTime,
    @JsonKey(name: 'operColseHm') String operatingEndTime,
    @JsonKey(name: 'satOperOpenHm') String satOperatingStartTime,
    @JsonKey(name: 'satOperCloseHm') String satOperatingEndTime,
    @JsonKey(name: 'holidayOperOpenHm') String holidayOperatingStartTime,
    @JsonKey(name: 'holidayCloseOpenHm') String holidayOperatingEndTime,
    @JsonKey(name: 'parkingchrgeInfo') String parkingFeeInfo,
    @JsonKey(name: 'basicTime') String basicTime,
    @JsonKey(name: 'basicCharge') String basicCharge,
    @JsonKey(name: 'addUnitTime') String addUnitTime,
    @JsonKey(name: 'addUnitCharge') String addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') String dayCommutingTicket,
    @JsonKey(name: 'monthCmmtkt') String monthCommutingTicket,
    @JsonKey(name: 'metpay') String paymentMethod,
    @JsonKey(name: 'spcmnt') String specialNote,
    @JsonKey(name: 'institutionNm') String institutionName,
    @JsonKey(name: 'phoneNumber') String phoneNumber,
    @JsonKey(name: 'latitude') String latitude,
    @JsonKey(name: 'longitude') String longitude,
    @JsonKey(name: 'referenceDate') String referenceDate,
    @JsonKey(name: 'instt_code') String institutionCode,
    @JsonKey(name: 'instt_nm') String institutionProviderName,
  });
}

/// @nodoc
class _$ParkingLotInfoCopyWithImpl<$Res, $Val extends ParkingLotInfo>
    implements $ParkingLotInfoCopyWith<$Res> {
  _$ParkingLotInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parkingPlaceNo = null,
    Object? parkingPlaceName = null,
    Object? parkingPlaceType = null,
    Object? parkingType = null,
    Object? roadAddress = null,
    Object? address = null,
    Object? parkingSpace = null,
    Object? feeType = null,
    Object? enforceType = null,
    Object? operatingDays = null,
    Object? operatingStartTime = null,
    Object? operatingEndTime = null,
    Object? satOperatingStartTime = null,
    Object? satOperatingEndTime = null,
    Object? holidayOperatingStartTime = null,
    Object? holidayOperatingEndTime = null,
    Object? parkingFeeInfo = null,
    Object? basicTime = null,
    Object? basicCharge = null,
    Object? addUnitTime = null,
    Object? addUnitCharge = null,
    Object? dayCommutingTicket = null,
    Object? monthCommutingTicket = null,
    Object? paymentMethod = null,
    Object? specialNote = null,
    Object? institutionName = null,
    Object? phoneNumber = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? referenceDate = null,
    Object? institutionCode = null,
    Object? institutionProviderName = null,
  }) {
    return _then(
      _value.copyWith(
            parkingPlaceNo:
                null == parkingPlaceNo
                    ? _value.parkingPlaceNo
                    : parkingPlaceNo // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingPlaceName:
                null == parkingPlaceName
                    ? _value.parkingPlaceName
                    : parkingPlaceName // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingPlaceType:
                null == parkingPlaceType
                    ? _value.parkingPlaceType
                    : parkingPlaceType // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingType:
                null == parkingType
                    ? _value.parkingType
                    : parkingType // ignore: cast_nullable_to_non_nullable
                        as String,
            roadAddress:
                null == roadAddress
                    ? _value.roadAddress
                    : roadAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingSpace:
                null == parkingSpace
                    ? _value.parkingSpace
                    : parkingSpace // ignore: cast_nullable_to_non_nullable
                        as int,
            feeType:
                null == feeType
                    ? _value.feeType
                    : feeType // ignore: cast_nullable_to_non_nullable
                        as String,
            enforceType:
                null == enforceType
                    ? _value.enforceType
                    : enforceType // ignore: cast_nullable_to_non_nullable
                        as String,
            operatingDays:
                null == operatingDays
                    ? _value.operatingDays
                    : operatingDays // ignore: cast_nullable_to_non_nullable
                        as String,
            operatingStartTime:
                null == operatingStartTime
                    ? _value.operatingStartTime
                    : operatingStartTime // ignore: cast_nullable_to_non_nullable
                        as String,
            operatingEndTime:
                null == operatingEndTime
                    ? _value.operatingEndTime
                    : operatingEndTime // ignore: cast_nullable_to_non_nullable
                        as String,
            satOperatingStartTime:
                null == satOperatingStartTime
                    ? _value.satOperatingStartTime
                    : satOperatingStartTime // ignore: cast_nullable_to_non_nullable
                        as String,
            satOperatingEndTime:
                null == satOperatingEndTime
                    ? _value.satOperatingEndTime
                    : satOperatingEndTime // ignore: cast_nullable_to_non_nullable
                        as String,
            holidayOperatingStartTime:
                null == holidayOperatingStartTime
                    ? _value.holidayOperatingStartTime
                    : holidayOperatingStartTime // ignore: cast_nullable_to_non_nullable
                        as String,
            holidayOperatingEndTime:
                null == holidayOperatingEndTime
                    ? _value.holidayOperatingEndTime
                    : holidayOperatingEndTime // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingFeeInfo:
                null == parkingFeeInfo
                    ? _value.parkingFeeInfo
                    : parkingFeeInfo // ignore: cast_nullable_to_non_nullable
                        as String,
            basicTime:
                null == basicTime
                    ? _value.basicTime
                    : basicTime // ignore: cast_nullable_to_non_nullable
                        as String,
            basicCharge:
                null == basicCharge
                    ? _value.basicCharge
                    : basicCharge // ignore: cast_nullable_to_non_nullable
                        as String,
            addUnitTime:
                null == addUnitTime
                    ? _value.addUnitTime
                    : addUnitTime // ignore: cast_nullable_to_non_nullable
                        as String,
            addUnitCharge:
                null == addUnitCharge
                    ? _value.addUnitCharge
                    : addUnitCharge // ignore: cast_nullable_to_non_nullable
                        as String,
            dayCommutingTicket:
                null == dayCommutingTicket
                    ? _value.dayCommutingTicket
                    : dayCommutingTicket // ignore: cast_nullable_to_non_nullable
                        as String,
            monthCommutingTicket:
                null == monthCommutingTicket
                    ? _value.monthCommutingTicket
                    : monthCommutingTicket // ignore: cast_nullable_to_non_nullable
                        as String,
            paymentMethod:
                null == paymentMethod
                    ? _value.paymentMethod
                    : paymentMethod // ignore: cast_nullable_to_non_nullable
                        as String,
            specialNote:
                null == specialNote
                    ? _value.specialNote
                    : specialNote // ignore: cast_nullable_to_non_nullable
                        as String,
            institutionName:
                null == institutionName
                    ? _value.institutionName
                    : institutionName // ignore: cast_nullable_to_non_nullable
                        as String,
            phoneNumber:
                null == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            latitude:
                null == latitude
                    ? _value.latitude
                    : latitude // ignore: cast_nullable_to_non_nullable
                        as String,
            longitude:
                null == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as String,
            referenceDate:
                null == referenceDate
                    ? _value.referenceDate
                    : referenceDate // ignore: cast_nullable_to_non_nullable
                        as String,
            institutionCode:
                null == institutionCode
                    ? _value.institutionCode
                    : institutionCode // ignore: cast_nullable_to_non_nullable
                        as String,
            institutionProviderName:
                null == institutionProviderName
                    ? _value.institutionProviderName
                    : institutionProviderName // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParkingLotInfoImplCopyWith<$Res>
    implements $ParkingLotInfoCopyWith<$Res> {
  factory _$$ParkingLotInfoImplCopyWith(
    _$ParkingLotInfoImpl value,
    $Res Function(_$ParkingLotInfoImpl) then,
  ) = __$$ParkingLotInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'prkplceNo') String parkingPlaceNo,
    @JsonKey(name: 'prkplceNm') String parkingPlaceName,
    @JsonKey(name: 'prkplceSe') String parkingPlaceType,
    @JsonKey(name: 'prkplceType') String parkingType,
    @JsonKey(name: 'rdnmadr') String roadAddress,
    @JsonKey(name: 'lnmadr') String address,
    @JsonKey(name: 'prkcmprt') int parkingSpace,
    @JsonKey(name: 'feedSe') String feeType,
    @JsonKey(name: 'enforceSe') String enforceType,
    @JsonKey(name: 'operDay') String operatingDays,
    @JsonKey(name: 'operOpenHm') String operatingStartTime,
    @JsonKey(name: 'operColseHm') String operatingEndTime,
    @JsonKey(name: 'satOperOpenHm') String satOperatingStartTime,
    @JsonKey(name: 'satOperCloseHm') String satOperatingEndTime,
    @JsonKey(name: 'holidayOperOpenHm') String holidayOperatingStartTime,
    @JsonKey(name: 'holidayCloseOpenHm') String holidayOperatingEndTime,
    @JsonKey(name: 'parkingchrgeInfo') String parkingFeeInfo,
    @JsonKey(name: 'basicTime') String basicTime,
    @JsonKey(name: 'basicCharge') String basicCharge,
    @JsonKey(name: 'addUnitTime') String addUnitTime,
    @JsonKey(name: 'addUnitCharge') String addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') String dayCommutingTicket,
    @JsonKey(name: 'monthCmmtkt') String monthCommutingTicket,
    @JsonKey(name: 'metpay') String paymentMethod,
    @JsonKey(name: 'spcmnt') String specialNote,
    @JsonKey(name: 'institutionNm') String institutionName,
    @JsonKey(name: 'phoneNumber') String phoneNumber,
    @JsonKey(name: 'latitude') String latitude,
    @JsonKey(name: 'longitude') String longitude,
    @JsonKey(name: 'referenceDate') String referenceDate,
    @JsonKey(name: 'instt_code') String institutionCode,
    @JsonKey(name: 'instt_nm') String institutionProviderName,
  });
}

/// @nodoc
class __$$ParkingLotInfoImplCopyWithImpl<$Res>
    extends _$ParkingLotInfoCopyWithImpl<$Res, _$ParkingLotInfoImpl>
    implements _$$ParkingLotInfoImplCopyWith<$Res> {
  __$$ParkingLotInfoImplCopyWithImpl(
    _$ParkingLotInfoImpl _value,
    $Res Function(_$ParkingLotInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parkingPlaceNo = null,
    Object? parkingPlaceName = null,
    Object? parkingPlaceType = null,
    Object? parkingType = null,
    Object? roadAddress = null,
    Object? address = null,
    Object? parkingSpace = null,
    Object? feeType = null,
    Object? enforceType = null,
    Object? operatingDays = null,
    Object? operatingStartTime = null,
    Object? operatingEndTime = null,
    Object? satOperatingStartTime = null,
    Object? satOperatingEndTime = null,
    Object? holidayOperatingStartTime = null,
    Object? holidayOperatingEndTime = null,
    Object? parkingFeeInfo = null,
    Object? basicTime = null,
    Object? basicCharge = null,
    Object? addUnitTime = null,
    Object? addUnitCharge = null,
    Object? dayCommutingTicket = null,
    Object? monthCommutingTicket = null,
    Object? paymentMethod = null,
    Object? specialNote = null,
    Object? institutionName = null,
    Object? phoneNumber = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? referenceDate = null,
    Object? institutionCode = null,
    Object? institutionProviderName = null,
  }) {
    return _then(
      _$ParkingLotInfoImpl(
        parkingPlaceNo:
            null == parkingPlaceNo
                ? _value.parkingPlaceNo
                : parkingPlaceNo // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingPlaceName:
            null == parkingPlaceName
                ? _value.parkingPlaceName
                : parkingPlaceName // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingPlaceType:
            null == parkingPlaceType
                ? _value.parkingPlaceType
                : parkingPlaceType // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingType:
            null == parkingType
                ? _value.parkingType
                : parkingType // ignore: cast_nullable_to_non_nullable
                    as String,
        roadAddress:
            null == roadAddress
                ? _value.roadAddress
                : roadAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingSpace:
            null == parkingSpace
                ? _value.parkingSpace
                : parkingSpace // ignore: cast_nullable_to_non_nullable
                    as int,
        feeType:
            null == feeType
                ? _value.feeType
                : feeType // ignore: cast_nullable_to_non_nullable
                    as String,
        enforceType:
            null == enforceType
                ? _value.enforceType
                : enforceType // ignore: cast_nullable_to_non_nullable
                    as String,
        operatingDays:
            null == operatingDays
                ? _value.operatingDays
                : operatingDays // ignore: cast_nullable_to_non_nullable
                    as String,
        operatingStartTime:
            null == operatingStartTime
                ? _value.operatingStartTime
                : operatingStartTime // ignore: cast_nullable_to_non_nullable
                    as String,
        operatingEndTime:
            null == operatingEndTime
                ? _value.operatingEndTime
                : operatingEndTime // ignore: cast_nullable_to_non_nullable
                    as String,
        satOperatingStartTime:
            null == satOperatingStartTime
                ? _value.satOperatingStartTime
                : satOperatingStartTime // ignore: cast_nullable_to_non_nullable
                    as String,
        satOperatingEndTime:
            null == satOperatingEndTime
                ? _value.satOperatingEndTime
                : satOperatingEndTime // ignore: cast_nullable_to_non_nullable
                    as String,
        holidayOperatingStartTime:
            null == holidayOperatingStartTime
                ? _value.holidayOperatingStartTime
                : holidayOperatingStartTime // ignore: cast_nullable_to_non_nullable
                    as String,
        holidayOperatingEndTime:
            null == holidayOperatingEndTime
                ? _value.holidayOperatingEndTime
                : holidayOperatingEndTime // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingFeeInfo:
            null == parkingFeeInfo
                ? _value.parkingFeeInfo
                : parkingFeeInfo // ignore: cast_nullable_to_non_nullable
                    as String,
        basicTime:
            null == basicTime
                ? _value.basicTime
                : basicTime // ignore: cast_nullable_to_non_nullable
                    as String,
        basicCharge:
            null == basicCharge
                ? _value.basicCharge
                : basicCharge // ignore: cast_nullable_to_non_nullable
                    as String,
        addUnitTime:
            null == addUnitTime
                ? _value.addUnitTime
                : addUnitTime // ignore: cast_nullable_to_non_nullable
                    as String,
        addUnitCharge:
            null == addUnitCharge
                ? _value.addUnitCharge
                : addUnitCharge // ignore: cast_nullable_to_non_nullable
                    as String,
        dayCommutingTicket:
            null == dayCommutingTicket
                ? _value.dayCommutingTicket
                : dayCommutingTicket // ignore: cast_nullable_to_non_nullable
                    as String,
        monthCommutingTicket:
            null == monthCommutingTicket
                ? _value.monthCommutingTicket
                : monthCommutingTicket // ignore: cast_nullable_to_non_nullable
                    as String,
        paymentMethod:
            null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                    as String,
        specialNote:
            null == specialNote
                ? _value.specialNote
                : specialNote // ignore: cast_nullable_to_non_nullable
                    as String,
        institutionName:
            null == institutionName
                ? _value.institutionName
                : institutionName // ignore: cast_nullable_to_non_nullable
                    as String,
        phoneNumber:
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        latitude:
            null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                    as String,
        longitude:
            null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as String,
        referenceDate:
            null == referenceDate
                ? _value.referenceDate
                : referenceDate // ignore: cast_nullable_to_non_nullable
                    as String,
        institutionCode:
            null == institutionCode
                ? _value.institutionCode
                : institutionCode // ignore: cast_nullable_to_non_nullable
                    as String,
        institutionProviderName:
            null == institutionProviderName
                ? _value.institutionProviderName
                : institutionProviderName // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParkingLotInfoImpl implements _ParkingLotInfo {
  const _$ParkingLotInfoImpl({
    @JsonKey(name: 'prkplceNo') required this.parkingPlaceNo,
    @JsonKey(name: 'prkplceNm') required this.parkingPlaceName,
    @JsonKey(name: 'prkplceSe') required this.parkingPlaceType,
    @JsonKey(name: 'prkplceType') required this.parkingType,
    @JsonKey(name: 'rdnmadr') required this.roadAddress,
    @JsonKey(name: 'lnmadr') required this.address,
    @JsonKey(name: 'prkcmprt') required this.parkingSpace,
    @JsonKey(name: 'feedSe') required this.feeType,
    @JsonKey(name: 'enforceSe') required this.enforceType,
    @JsonKey(name: 'operDay') required this.operatingDays,
    @JsonKey(name: 'operOpenHm') required this.operatingStartTime,
    @JsonKey(name: 'operColseHm') required this.operatingEndTime,
    @JsonKey(name: 'satOperOpenHm') required this.satOperatingStartTime,
    @JsonKey(name: 'satOperCloseHm') required this.satOperatingEndTime,
    @JsonKey(name: 'holidayOperOpenHm') required this.holidayOperatingStartTime,
    @JsonKey(name: 'holidayCloseOpenHm') required this.holidayOperatingEndTime,
    @JsonKey(name: 'parkingchrgeInfo') required this.parkingFeeInfo,
    @JsonKey(name: 'basicTime') required this.basicTime,
    @JsonKey(name: 'basicCharge') required this.basicCharge,
    @JsonKey(name: 'addUnitTime') required this.addUnitTime,
    @JsonKey(name: 'addUnitCharge') required this.addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') required this.dayCommutingTicket,
    @JsonKey(name: 'monthCmmtkt') required this.monthCommutingTicket,
    @JsonKey(name: 'metpay') required this.paymentMethod,
    @JsonKey(name: 'spcmnt') required this.specialNote,
    @JsonKey(name: 'institutionNm') required this.institutionName,
    @JsonKey(name: 'phoneNumber') required this.phoneNumber,
    @JsonKey(name: 'latitude') required this.latitude,
    @JsonKey(name: 'longitude') required this.longitude,
    @JsonKey(name: 'referenceDate') required this.referenceDate,
    @JsonKey(name: 'instt_code') required this.institutionCode,
    @JsonKey(name: 'instt_nm') required this.institutionProviderName,
  });

  factory _$ParkingLotInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParkingLotInfoImplFromJson(json);

  @override
  @JsonKey(name: 'prkplceNo')
  final String parkingPlaceNo;
  // 주차장관리번호
  @override
  @JsonKey(name: 'prkplceNm')
  final String parkingPlaceName;
  // 주차장명
  @override
  @JsonKey(name: 'prkplceSe')
  final String parkingPlaceType;
  // 주차장구분
  @override
  @JsonKey(name: 'prkplceType')
  final String parkingType;
  // 주차장유형
  @override
  @JsonKey(name: 'rdnmadr')
  final String roadAddress;
  // 소재지도로명주소
  @override
  @JsonKey(name: 'lnmadr')
  final String address;
  // 소재지지번주소
  @override
  @JsonKey(name: 'prkcmprt')
  final int parkingSpace;
  // 주차구획수
  @override
  @JsonKey(name: 'feedSe')
  final String feeType;
  // 급지구분
  @override
  @JsonKey(name: 'enforceSe')
  final String enforceType;
  // 부제시행구분
  @override
  @JsonKey(name: 'operDay')
  final String operatingDays;
  // 운영요일
  @override
  @JsonKey(name: 'operOpenHm')
  final String operatingStartTime;
  // 평일운영시작시각
  @override
  @JsonKey(name: 'operColseHm')
  final String operatingEndTime;
  // 평일운영종료시각
  @override
  @JsonKey(name: 'satOperOpenHm')
  final String satOperatingStartTime;
  // 토요일운영시작시각
  @override
  @JsonKey(name: 'satOperCloseHm')
  final String satOperatingEndTime;
  // 토요일운영종료시각
  @override
  @JsonKey(name: 'holidayOperOpenHm')
  final String holidayOperatingStartTime;
  // 공휴일운영시작시각
  @override
  @JsonKey(name: 'holidayCloseOpenHm')
  final String holidayOperatingEndTime;
  // 공휴일운영종료시각
  @override
  @JsonKey(name: 'parkingchrgeInfo')
  final String parkingFeeInfo;
  // 주차요금정보
  @override
  @JsonKey(name: 'basicTime')
  final String basicTime;
  // 주차기본시간
  @override
  @JsonKey(name: 'basicCharge')
  final String basicCharge;
  // 주차기본요금
  @override
  @JsonKey(name: 'addUnitTime')
  final String addUnitTime;
  // 추가단위시간
  @override
  @JsonKey(name: 'addUnitCharge')
  final String addUnitCharge;
  // 추가단위요금
  @override
  @JsonKey(name: 'dayCmmtkt')
  final String dayCommutingTicket;
  // 일주차권요금
  @override
  @JsonKey(name: 'monthCmmtkt')
  final String monthCommutingTicket;
  // 월정기권요금
  @override
  @JsonKey(name: 'metpay')
  final String paymentMethod;
  // 결제방법
  @override
  @JsonKey(name: 'spcmnt')
  final String specialNote;
  // 특기사항
  @override
  @JsonKey(name: 'institutionNm')
  final String institutionName;
  // 관리기관명
  @override
  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;
  // 전화번호
  @override
  @JsonKey(name: 'latitude')
  final String latitude;
  // 위도
  @override
  @JsonKey(name: 'longitude')
  final String longitude;
  // 경도
  @override
  @JsonKey(name: 'referenceDate')
  final String referenceDate;
  // 데이터기준일자
  @override
  @JsonKey(name: 'instt_code')
  final String institutionCode;
  // 제공기관코드
  @override
  @JsonKey(name: 'instt_nm')
  final String institutionProviderName;

  @override
  String toString() {
    return 'ParkingLotInfo(parkingPlaceNo: $parkingPlaceNo, parkingPlaceName: $parkingPlaceName, parkingPlaceType: $parkingPlaceType, parkingType: $parkingType, roadAddress: $roadAddress, address: $address, parkingSpace: $parkingSpace, feeType: $feeType, enforceType: $enforceType, operatingDays: $operatingDays, operatingStartTime: $operatingStartTime, operatingEndTime: $operatingEndTime, satOperatingStartTime: $satOperatingStartTime, satOperatingEndTime: $satOperatingEndTime, holidayOperatingStartTime: $holidayOperatingStartTime, holidayOperatingEndTime: $holidayOperatingEndTime, parkingFeeInfo: $parkingFeeInfo, basicTime: $basicTime, basicCharge: $basicCharge, addUnitTime: $addUnitTime, addUnitCharge: $addUnitCharge, dayCommutingTicket: $dayCommutingTicket, monthCommutingTicket: $monthCommutingTicket, paymentMethod: $paymentMethod, specialNote: $specialNote, institutionName: $institutionName, phoneNumber: $phoneNumber, latitude: $latitude, longitude: $longitude, referenceDate: $referenceDate, institutionCode: $institutionCode, institutionProviderName: $institutionProviderName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParkingLotInfoImpl &&
            (identical(other.parkingPlaceNo, parkingPlaceNo) ||
                other.parkingPlaceNo == parkingPlaceNo) &&
            (identical(other.parkingPlaceName, parkingPlaceName) ||
                other.parkingPlaceName == parkingPlaceName) &&
            (identical(other.parkingPlaceType, parkingPlaceType) ||
                other.parkingPlaceType == parkingPlaceType) &&
            (identical(other.parkingType, parkingType) ||
                other.parkingType == parkingType) &&
            (identical(other.roadAddress, roadAddress) ||
                other.roadAddress == roadAddress) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.parkingSpace, parkingSpace) ||
                other.parkingSpace == parkingSpace) &&
            (identical(other.feeType, feeType) || other.feeType == feeType) &&
            (identical(other.enforceType, enforceType) ||
                other.enforceType == enforceType) &&
            (identical(other.operatingDays, operatingDays) ||
                other.operatingDays == operatingDays) &&
            (identical(other.operatingStartTime, operatingStartTime) ||
                other.operatingStartTime == operatingStartTime) &&
            (identical(other.operatingEndTime, operatingEndTime) ||
                other.operatingEndTime == operatingEndTime) &&
            (identical(other.satOperatingStartTime, satOperatingStartTime) ||
                other.satOperatingStartTime == satOperatingStartTime) &&
            (identical(other.satOperatingEndTime, satOperatingEndTime) ||
                other.satOperatingEndTime == satOperatingEndTime) &&
            (identical(
                  other.holidayOperatingStartTime,
                  holidayOperatingStartTime,
                ) ||
                other.holidayOperatingStartTime == holidayOperatingStartTime) &&
            (identical(
                  other.holidayOperatingEndTime,
                  holidayOperatingEndTime,
                ) ||
                other.holidayOperatingEndTime == holidayOperatingEndTime) &&
            (identical(other.parkingFeeInfo, parkingFeeInfo) ||
                other.parkingFeeInfo == parkingFeeInfo) &&
            (identical(other.basicTime, basicTime) ||
                other.basicTime == basicTime) &&
            (identical(other.basicCharge, basicCharge) ||
                other.basicCharge == basicCharge) &&
            (identical(other.addUnitTime, addUnitTime) ||
                other.addUnitTime == addUnitTime) &&
            (identical(other.addUnitCharge, addUnitCharge) ||
                other.addUnitCharge == addUnitCharge) &&
            (identical(other.dayCommutingTicket, dayCommutingTicket) ||
                other.dayCommutingTicket == dayCommutingTicket) &&
            (identical(other.monthCommutingTicket, monthCommutingTicket) ||
                other.monthCommutingTicket == monthCommutingTicket) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.specialNote, specialNote) ||
                other.specialNote == specialNote) &&
            (identical(other.institutionName, institutionName) ||
                other.institutionName == institutionName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.referenceDate, referenceDate) ||
                other.referenceDate == referenceDate) &&
            (identical(other.institutionCode, institutionCode) ||
                other.institutionCode == institutionCode) &&
            (identical(
                  other.institutionProviderName,
                  institutionProviderName,
                ) ||
                other.institutionProviderName == institutionProviderName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    parkingPlaceNo,
    parkingPlaceName,
    parkingPlaceType,
    parkingType,
    roadAddress,
    address,
    parkingSpace,
    feeType,
    enforceType,
    operatingDays,
    operatingStartTime,
    operatingEndTime,
    satOperatingStartTime,
    satOperatingEndTime,
    holidayOperatingStartTime,
    holidayOperatingEndTime,
    parkingFeeInfo,
    basicTime,
    basicCharge,
    addUnitTime,
    addUnitCharge,
    dayCommutingTicket,
    monthCommutingTicket,
    paymentMethod,
    specialNote,
    institutionName,
    phoneNumber,
    latitude,
    longitude,
    referenceDate,
    institutionCode,
    institutionProviderName,
  ]);

  /// Create a copy of ParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParkingLotInfoImplCopyWith<_$ParkingLotInfoImpl> get copyWith =>
      __$$ParkingLotInfoImplCopyWithImpl<_$ParkingLotInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParkingLotInfoImplToJson(this);
  }
}

abstract class _ParkingLotInfo implements ParkingLotInfo {
  const factory _ParkingLotInfo({
    @JsonKey(name: 'prkplceNo') required final String parkingPlaceNo,
    @JsonKey(name: 'prkplceNm') required final String parkingPlaceName,
    @JsonKey(name: 'prkplceSe') required final String parkingPlaceType,
    @JsonKey(name: 'prkplceType') required final String parkingType,
    @JsonKey(name: 'rdnmadr') required final String roadAddress,
    @JsonKey(name: 'lnmadr') required final String address,
    @JsonKey(name: 'prkcmprt') required final int parkingSpace,
    @JsonKey(name: 'feedSe') required final String feeType,
    @JsonKey(name: 'enforceSe') required final String enforceType,
    @JsonKey(name: 'operDay') required final String operatingDays,
    @JsonKey(name: 'operOpenHm') required final String operatingStartTime,
    @JsonKey(name: 'operColseHm') required final String operatingEndTime,
    @JsonKey(name: 'satOperOpenHm') required final String satOperatingStartTime,
    @JsonKey(name: 'satOperCloseHm') required final String satOperatingEndTime,
    @JsonKey(name: 'holidayOperOpenHm')
    required final String holidayOperatingStartTime,
    @JsonKey(name: 'holidayCloseOpenHm')
    required final String holidayOperatingEndTime,
    @JsonKey(name: 'parkingchrgeInfo') required final String parkingFeeInfo,
    @JsonKey(name: 'basicTime') required final String basicTime,
    @JsonKey(name: 'basicCharge') required final String basicCharge,
    @JsonKey(name: 'addUnitTime') required final String addUnitTime,
    @JsonKey(name: 'addUnitCharge') required final String addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') required final String dayCommutingTicket,
    @JsonKey(name: 'monthCmmtkt') required final String monthCommutingTicket,
    @JsonKey(name: 'metpay') required final String paymentMethod,
    @JsonKey(name: 'spcmnt') required final String specialNote,
    @JsonKey(name: 'institutionNm') required final String institutionName,
    @JsonKey(name: 'phoneNumber') required final String phoneNumber,
    @JsonKey(name: 'latitude') required final String latitude,
    @JsonKey(name: 'longitude') required final String longitude,
    @JsonKey(name: 'referenceDate') required final String referenceDate,
    @JsonKey(name: 'instt_code') required final String institutionCode,
    @JsonKey(name: 'instt_nm') required final String institutionProviderName,
  }) = _$ParkingLotInfoImpl;

  factory _ParkingLotInfo.fromJson(Map<String, dynamic> json) =
      _$ParkingLotInfoImpl.fromJson;

  @override
  @JsonKey(name: 'prkplceNo')
  String get parkingPlaceNo; // 주차장관리번호
  @override
  @JsonKey(name: 'prkplceNm')
  String get parkingPlaceName; // 주차장명
  @override
  @JsonKey(name: 'prkplceSe')
  String get parkingPlaceType; // 주차장구분
  @override
  @JsonKey(name: 'prkplceType')
  String get parkingType; // 주차장유형
  @override
  @JsonKey(name: 'rdnmadr')
  String get roadAddress; // 소재지도로명주소
  @override
  @JsonKey(name: 'lnmadr')
  String get address; // 소재지지번주소
  @override
  @JsonKey(name: 'prkcmprt')
  int get parkingSpace; // 주차구획수
  @override
  @JsonKey(name: 'feedSe')
  String get feeType; // 급지구분
  @override
  @JsonKey(name: 'enforceSe')
  String get enforceType; // 부제시행구분
  @override
  @JsonKey(name: 'operDay')
  String get operatingDays; // 운영요일
  @override
  @JsonKey(name: 'operOpenHm')
  String get operatingStartTime; // 평일운영시작시각
  @override
  @JsonKey(name: 'operColseHm')
  String get operatingEndTime; // 평일운영종료시각
  @override
  @JsonKey(name: 'satOperOpenHm')
  String get satOperatingStartTime; // 토요일운영시작시각
  @override
  @JsonKey(name: 'satOperCloseHm')
  String get satOperatingEndTime; // 토요일운영종료시각
  @override
  @JsonKey(name: 'holidayOperOpenHm')
  String get holidayOperatingStartTime; // 공휴일운영시작시각
  @override
  @JsonKey(name: 'holidayCloseOpenHm')
  String get holidayOperatingEndTime; // 공휴일운영종료시각
  @override
  @JsonKey(name: 'parkingchrgeInfo')
  String get parkingFeeInfo; // 주차요금정보
  @override
  @JsonKey(name: 'basicTime')
  String get basicTime; // 주차기본시간
  @override
  @JsonKey(name: 'basicCharge')
  String get basicCharge; // 주차기본요금
  @override
  @JsonKey(name: 'addUnitTime')
  String get addUnitTime; // 추가단위시간
  @override
  @JsonKey(name: 'addUnitCharge')
  String get addUnitCharge; // 추가단위요금
  @override
  @JsonKey(name: 'dayCmmtkt')
  String get dayCommutingTicket; // 일주차권요금
  @override
  @JsonKey(name: 'monthCmmtkt')
  String get monthCommutingTicket; // 월정기권요금
  @override
  @JsonKey(name: 'metpay')
  String get paymentMethod; // 결제방법
  @override
  @JsonKey(name: 'spcmnt')
  String get specialNote; // 특기사항
  @override
  @JsonKey(name: 'institutionNm')
  String get institutionName; // 관리기관명
  @override
  @JsonKey(name: 'phoneNumber')
  String get phoneNumber; // 전화번호
  @override
  @JsonKey(name: 'latitude')
  String get latitude; // 위도
  @override
  @JsonKey(name: 'longitude')
  String get longitude; // 경도
  @override
  @JsonKey(name: 'referenceDate')
  String get referenceDate; // 데이터기준일자
  @override
  @JsonKey(name: 'instt_code')
  String get institutionCode; // 제공기관코드
  @override
  @JsonKey(name: 'instt_nm')
  String get institutionProviderName;

  /// Create a copy of ParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParkingLotInfoImplCopyWith<_$ParkingLotInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttachedParkingLotInfo _$AttachedParkingLotInfoFromJson(
  Map<String, dynamic> json,
) {
  return _AttachedParkingLotInfo.fromJson(json);
}

/// @nodoc
mixin _$AttachedParkingLotInfo {
  @JsonKey(name: 'prkplceNo')
  String get parkingPlaceNo => throw _privateConstructorUsedError; // 주차장관리번호
  @JsonKey(name: 'prkplceNm')
  String get parkingPlaceName => throw _privateConstructorUsedError; // 주차장명
  @JsonKey(name: 'prkplceSe')
  String get parkingPlaceType => throw _privateConstructorUsedError; // 주차장구분
  @JsonKey(name: 'prkplceType')
  String get parkingType => throw _privateConstructorUsedError; // 주차장유형
  @JsonKey(name: 'rdnmadr')
  String get roadAddress => throw _privateConstructorUsedError; // 소재지도로명주소
  @JsonKey(name: 'lnmadr')
  String get address => throw _privateConstructorUsedError; // 소재지지번주소
  @JsonKey(name: 'prkcmprt')
  int get parkingSpace => throw _privateConstructorUsedError; // 주차구획수
  @JsonKey(name: 'feedSe')
  String get feeType => throw _privateConstructorUsedError; // 급지구분
  @JsonKey(name: 'enforceSe')
  String get enforceType => throw _privateConstructorUsedError; // 부제시행구분
  @JsonKey(name: 'operDay')
  String get operatingDays => throw _privateConstructorUsedError; // 운영요일
  @JsonKey(name: 'operOpenHm')
  String get operatingStartTime => throw _privateConstructorUsedError; // 평일운영시작시각
  @JsonKey(name: 'operColseHm')
  String get operatingEndTime => throw _privateConstructorUsedError; // 평일운영종료시각
  @JsonKey(name: 'satOperOpenHm')
  String get satOperatingStartTime => throw _privateConstructorUsedError; // 토요일운영시작시각
  @JsonKey(name: 'satOperCloseHm')
  String get satOperatingEndTime => throw _privateConstructorUsedError; // 토요일운영종료시각
  @JsonKey(name: 'holidayOperOpenHm')
  String get holidayOperatingStartTime => throw _privateConstructorUsedError; // 공휴일운영시작시각
  @JsonKey(name: 'holidayCloseOpenHm')
  String get holidayOperatingEndTime => throw _privateConstructorUsedError; // 공휴일운영종료시각
  @JsonKey(name: 'parkingchrgeInfo')
  String get parkingFeeInfo => throw _privateConstructorUsedError; // 주차요금정보
  @JsonKey(name: 'basicTime')
  String get basicTime => throw _privateConstructorUsedError; // 주차기본시간
  @JsonKey(name: 'basicCharge')
  String get basicCharge => throw _privateConstructorUsedError; // 주차기본요금
  @JsonKey(name: 'addUnitTime')
  String get addUnitTime => throw _privateConstructorUsedError; // 추가단위시간
  @JsonKey(name: 'addUnitCharge')
  String get addUnitCharge => throw _privateConstructorUsedError; // 추가단위요금
  @JsonKey(name: 'dayCmmtkt')
  String get dayCommutingTicket => throw _privateConstructorUsedError; // 일주차권요금
  @JsonKey(name: 'monthCmmtkt')
  String get monthCommutingTicket => throw _privateConstructorUsedError; // 월정기권요금
  @JsonKey(name: 'metpay')
  String get paymentMethod => throw _privateConstructorUsedError; // 결제방법
  @JsonKey(name: 'spcmnt')
  String get specialNote => throw _privateConstructorUsedError; // 특기사항
  @JsonKey(name: 'institutionNm')
  String get institutionName => throw _privateConstructorUsedError; // 관리기관명
  @JsonKey(name: 'phoneNumber')
  String get phoneNumber => throw _privateConstructorUsedError; // 전화번호
  @JsonKey(name: 'latitude')
  String get latitude => throw _privateConstructorUsedError; // 위도
  @JsonKey(name: 'longitude')
  String get longitude => throw _privateConstructorUsedError; // 경도
  @JsonKey(name: 'referenceDate')
  String get referenceDate => throw _privateConstructorUsedError; // 데이터기준일자
  @JsonKey(name: 'instt_code')
  String get institutionCode => throw _privateConstructorUsedError; // 제공기관코드
  @JsonKey(name: 'instt_nm')
  String get institutionProviderName => throw _privateConstructorUsedError;

  /// Serializes this AttachedParkingLotInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttachedParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachedParkingLotInfoCopyWith<AttachedParkingLotInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachedParkingLotInfoCopyWith<$Res> {
  factory $AttachedParkingLotInfoCopyWith(
    AttachedParkingLotInfo value,
    $Res Function(AttachedParkingLotInfo) then,
  ) = _$AttachedParkingLotInfoCopyWithImpl<$Res, AttachedParkingLotInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'prkplceNo') String parkingPlaceNo,
    @JsonKey(name: 'prkplceNm') String parkingPlaceName,
    @JsonKey(name: 'prkplceSe') String parkingPlaceType,
    @JsonKey(name: 'prkplceType') String parkingType,
    @JsonKey(name: 'rdnmadr') String roadAddress,
    @JsonKey(name: 'lnmadr') String address,
    @JsonKey(name: 'prkcmprt') int parkingSpace,
    @JsonKey(name: 'feedSe') String feeType,
    @JsonKey(name: 'enforceSe') String enforceType,
    @JsonKey(name: 'operDay') String operatingDays,
    @JsonKey(name: 'operOpenHm') String operatingStartTime,
    @JsonKey(name: 'operColseHm') String operatingEndTime,
    @JsonKey(name: 'satOperOpenHm') String satOperatingStartTime,
    @JsonKey(name: 'satOperCloseHm') String satOperatingEndTime,
    @JsonKey(name: 'holidayOperOpenHm') String holidayOperatingStartTime,
    @JsonKey(name: 'holidayCloseOpenHm') String holidayOperatingEndTime,
    @JsonKey(name: 'parkingchrgeInfo') String parkingFeeInfo,
    @JsonKey(name: 'basicTime') String basicTime,
    @JsonKey(name: 'basicCharge') String basicCharge,
    @JsonKey(name: 'addUnitTime') String addUnitTime,
    @JsonKey(name: 'addUnitCharge') String addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') String dayCommutingTicket,
    @JsonKey(name: 'monthCmmtkt') String monthCommutingTicket,
    @JsonKey(name: 'metpay') String paymentMethod,
    @JsonKey(name: 'spcmnt') String specialNote,
    @JsonKey(name: 'institutionNm') String institutionName,
    @JsonKey(name: 'phoneNumber') String phoneNumber,
    @JsonKey(name: 'latitude') String latitude,
    @JsonKey(name: 'longitude') String longitude,
    @JsonKey(name: 'referenceDate') String referenceDate,
    @JsonKey(name: 'instt_code') String institutionCode,
    @JsonKey(name: 'instt_nm') String institutionProviderName,
  });
}

/// @nodoc
class _$AttachedParkingLotInfoCopyWithImpl<
  $Res,
  $Val extends AttachedParkingLotInfo
>
    implements $AttachedParkingLotInfoCopyWith<$Res> {
  _$AttachedParkingLotInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttachedParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parkingPlaceNo = null,
    Object? parkingPlaceName = null,
    Object? parkingPlaceType = null,
    Object? parkingType = null,
    Object? roadAddress = null,
    Object? address = null,
    Object? parkingSpace = null,
    Object? feeType = null,
    Object? enforceType = null,
    Object? operatingDays = null,
    Object? operatingStartTime = null,
    Object? operatingEndTime = null,
    Object? satOperatingStartTime = null,
    Object? satOperatingEndTime = null,
    Object? holidayOperatingStartTime = null,
    Object? holidayOperatingEndTime = null,
    Object? parkingFeeInfo = null,
    Object? basicTime = null,
    Object? basicCharge = null,
    Object? addUnitTime = null,
    Object? addUnitCharge = null,
    Object? dayCommutingTicket = null,
    Object? monthCommutingTicket = null,
    Object? paymentMethod = null,
    Object? specialNote = null,
    Object? institutionName = null,
    Object? phoneNumber = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? referenceDate = null,
    Object? institutionCode = null,
    Object? institutionProviderName = null,
  }) {
    return _then(
      _value.copyWith(
            parkingPlaceNo:
                null == parkingPlaceNo
                    ? _value.parkingPlaceNo
                    : parkingPlaceNo // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingPlaceName:
                null == parkingPlaceName
                    ? _value.parkingPlaceName
                    : parkingPlaceName // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingPlaceType:
                null == parkingPlaceType
                    ? _value.parkingPlaceType
                    : parkingPlaceType // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingType:
                null == parkingType
                    ? _value.parkingType
                    : parkingType // ignore: cast_nullable_to_non_nullable
                        as String,
            roadAddress:
                null == roadAddress
                    ? _value.roadAddress
                    : roadAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingSpace:
                null == parkingSpace
                    ? _value.parkingSpace
                    : parkingSpace // ignore: cast_nullable_to_non_nullable
                        as int,
            feeType:
                null == feeType
                    ? _value.feeType
                    : feeType // ignore: cast_nullable_to_non_nullable
                        as String,
            enforceType:
                null == enforceType
                    ? _value.enforceType
                    : enforceType // ignore: cast_nullable_to_non_nullable
                        as String,
            operatingDays:
                null == operatingDays
                    ? _value.operatingDays
                    : operatingDays // ignore: cast_nullable_to_non_nullable
                        as String,
            operatingStartTime:
                null == operatingStartTime
                    ? _value.operatingStartTime
                    : operatingStartTime // ignore: cast_nullable_to_non_nullable
                        as String,
            operatingEndTime:
                null == operatingEndTime
                    ? _value.operatingEndTime
                    : operatingEndTime // ignore: cast_nullable_to_non_nullable
                        as String,
            satOperatingStartTime:
                null == satOperatingStartTime
                    ? _value.satOperatingStartTime
                    : satOperatingStartTime // ignore: cast_nullable_to_non_nullable
                        as String,
            satOperatingEndTime:
                null == satOperatingEndTime
                    ? _value.satOperatingEndTime
                    : satOperatingEndTime // ignore: cast_nullable_to_non_nullable
                        as String,
            holidayOperatingStartTime:
                null == holidayOperatingStartTime
                    ? _value.holidayOperatingStartTime
                    : holidayOperatingStartTime // ignore: cast_nullable_to_non_nullable
                        as String,
            holidayOperatingEndTime:
                null == holidayOperatingEndTime
                    ? _value.holidayOperatingEndTime
                    : holidayOperatingEndTime // ignore: cast_nullable_to_non_nullable
                        as String,
            parkingFeeInfo:
                null == parkingFeeInfo
                    ? _value.parkingFeeInfo
                    : parkingFeeInfo // ignore: cast_nullable_to_non_nullable
                        as String,
            basicTime:
                null == basicTime
                    ? _value.basicTime
                    : basicTime // ignore: cast_nullable_to_non_nullable
                        as String,
            basicCharge:
                null == basicCharge
                    ? _value.basicCharge
                    : basicCharge // ignore: cast_nullable_to_non_nullable
                        as String,
            addUnitTime:
                null == addUnitTime
                    ? _value.addUnitTime
                    : addUnitTime // ignore: cast_nullable_to_non_nullable
                        as String,
            addUnitCharge:
                null == addUnitCharge
                    ? _value.addUnitCharge
                    : addUnitCharge // ignore: cast_nullable_to_non_nullable
                        as String,
            dayCommutingTicket:
                null == dayCommutingTicket
                    ? _value.dayCommutingTicket
                    : dayCommutingTicket // ignore: cast_nullable_to_non_nullable
                        as String,
            monthCommutingTicket:
                null == monthCommutingTicket
                    ? _value.monthCommutingTicket
                    : monthCommutingTicket // ignore: cast_nullable_to_non_nullable
                        as String,
            paymentMethod:
                null == paymentMethod
                    ? _value.paymentMethod
                    : paymentMethod // ignore: cast_nullable_to_non_nullable
                        as String,
            specialNote:
                null == specialNote
                    ? _value.specialNote
                    : specialNote // ignore: cast_nullable_to_non_nullable
                        as String,
            institutionName:
                null == institutionName
                    ? _value.institutionName
                    : institutionName // ignore: cast_nullable_to_non_nullable
                        as String,
            phoneNumber:
                null == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            latitude:
                null == latitude
                    ? _value.latitude
                    : latitude // ignore: cast_nullable_to_non_nullable
                        as String,
            longitude:
                null == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as String,
            referenceDate:
                null == referenceDate
                    ? _value.referenceDate
                    : referenceDate // ignore: cast_nullable_to_non_nullable
                        as String,
            institutionCode:
                null == institutionCode
                    ? _value.institutionCode
                    : institutionCode // ignore: cast_nullable_to_non_nullable
                        as String,
            institutionProviderName:
                null == institutionProviderName
                    ? _value.institutionProviderName
                    : institutionProviderName // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttachedParkingLotInfoImplCopyWith<$Res>
    implements $AttachedParkingLotInfoCopyWith<$Res> {
  factory _$$AttachedParkingLotInfoImplCopyWith(
    _$AttachedParkingLotInfoImpl value,
    $Res Function(_$AttachedParkingLotInfoImpl) then,
  ) = __$$AttachedParkingLotInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'prkplceNo') String parkingPlaceNo,
    @JsonKey(name: 'prkplceNm') String parkingPlaceName,
    @JsonKey(name: 'prkplceSe') String parkingPlaceType,
    @JsonKey(name: 'prkplceType') String parkingType,
    @JsonKey(name: 'rdnmadr') String roadAddress,
    @JsonKey(name: 'lnmadr') String address,
    @JsonKey(name: 'prkcmprt') int parkingSpace,
    @JsonKey(name: 'feedSe') String feeType,
    @JsonKey(name: 'enforceSe') String enforceType,
    @JsonKey(name: 'operDay') String operatingDays,
    @JsonKey(name: 'operOpenHm') String operatingStartTime,
    @JsonKey(name: 'operColseHm') String operatingEndTime,
    @JsonKey(name: 'satOperOpenHm') String satOperatingStartTime,
    @JsonKey(name: 'satOperCloseHm') String satOperatingEndTime,
    @JsonKey(name: 'holidayOperOpenHm') String holidayOperatingStartTime,
    @JsonKey(name: 'holidayCloseOpenHm') String holidayOperatingEndTime,
    @JsonKey(name: 'parkingchrgeInfo') String parkingFeeInfo,
    @JsonKey(name: 'basicTime') String basicTime,
    @JsonKey(name: 'basicCharge') String basicCharge,
    @JsonKey(name: 'addUnitTime') String addUnitTime,
    @JsonKey(name: 'addUnitCharge') String addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') String dayCommutingTicket,
    @JsonKey(name: 'monthCmmtkt') String monthCommutingTicket,
    @JsonKey(name: 'metpay') String paymentMethod,
    @JsonKey(name: 'spcmnt') String specialNote,
    @JsonKey(name: 'institutionNm') String institutionName,
    @JsonKey(name: 'phoneNumber') String phoneNumber,
    @JsonKey(name: 'latitude') String latitude,
    @JsonKey(name: 'longitude') String longitude,
    @JsonKey(name: 'referenceDate') String referenceDate,
    @JsonKey(name: 'instt_code') String institutionCode,
    @JsonKey(name: 'instt_nm') String institutionProviderName,
  });
}

/// @nodoc
class __$$AttachedParkingLotInfoImplCopyWithImpl<$Res>
    extends
        _$AttachedParkingLotInfoCopyWithImpl<$Res, _$AttachedParkingLotInfoImpl>
    implements _$$AttachedParkingLotInfoImplCopyWith<$Res> {
  __$$AttachedParkingLotInfoImplCopyWithImpl(
    _$AttachedParkingLotInfoImpl _value,
    $Res Function(_$AttachedParkingLotInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttachedParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parkingPlaceNo = null,
    Object? parkingPlaceName = null,
    Object? parkingPlaceType = null,
    Object? parkingType = null,
    Object? roadAddress = null,
    Object? address = null,
    Object? parkingSpace = null,
    Object? feeType = null,
    Object? enforceType = null,
    Object? operatingDays = null,
    Object? operatingStartTime = null,
    Object? operatingEndTime = null,
    Object? satOperatingStartTime = null,
    Object? satOperatingEndTime = null,
    Object? holidayOperatingStartTime = null,
    Object? holidayOperatingEndTime = null,
    Object? parkingFeeInfo = null,
    Object? basicTime = null,
    Object? basicCharge = null,
    Object? addUnitTime = null,
    Object? addUnitCharge = null,
    Object? dayCommutingTicket = null,
    Object? monthCommutingTicket = null,
    Object? paymentMethod = null,
    Object? specialNote = null,
    Object? institutionName = null,
    Object? phoneNumber = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? referenceDate = null,
    Object? institutionCode = null,
    Object? institutionProviderName = null,
  }) {
    return _then(
      _$AttachedParkingLotInfoImpl(
        parkingPlaceNo:
            null == parkingPlaceNo
                ? _value.parkingPlaceNo
                : parkingPlaceNo // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingPlaceName:
            null == parkingPlaceName
                ? _value.parkingPlaceName
                : parkingPlaceName // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingPlaceType:
            null == parkingPlaceType
                ? _value.parkingPlaceType
                : parkingPlaceType // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingType:
            null == parkingType
                ? _value.parkingType
                : parkingType // ignore: cast_nullable_to_non_nullable
                    as String,
        roadAddress:
            null == roadAddress
                ? _value.roadAddress
                : roadAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingSpace:
            null == parkingSpace
                ? _value.parkingSpace
                : parkingSpace // ignore: cast_nullable_to_non_nullable
                    as int,
        feeType:
            null == feeType
                ? _value.feeType
                : feeType // ignore: cast_nullable_to_non_nullable
                    as String,
        enforceType:
            null == enforceType
                ? _value.enforceType
                : enforceType // ignore: cast_nullable_to_non_nullable
                    as String,
        operatingDays:
            null == operatingDays
                ? _value.operatingDays
                : operatingDays // ignore: cast_nullable_to_non_nullable
                    as String,
        operatingStartTime:
            null == operatingStartTime
                ? _value.operatingStartTime
                : operatingStartTime // ignore: cast_nullable_to_non_nullable
                    as String,
        operatingEndTime:
            null == operatingEndTime
                ? _value.operatingEndTime
                : operatingEndTime // ignore: cast_nullable_to_non_nullable
                    as String,
        satOperatingStartTime:
            null == satOperatingStartTime
                ? _value.satOperatingStartTime
                : satOperatingStartTime // ignore: cast_nullable_to_non_nullable
                    as String,
        satOperatingEndTime:
            null == satOperatingEndTime
                ? _value.satOperatingEndTime
                : satOperatingEndTime // ignore: cast_nullable_to_non_nullable
                    as String,
        holidayOperatingStartTime:
            null == holidayOperatingStartTime
                ? _value.holidayOperatingStartTime
                : holidayOperatingStartTime // ignore: cast_nullable_to_non_nullable
                    as String,
        holidayOperatingEndTime:
            null == holidayOperatingEndTime
                ? _value.holidayOperatingEndTime
                : holidayOperatingEndTime // ignore: cast_nullable_to_non_nullable
                    as String,
        parkingFeeInfo:
            null == parkingFeeInfo
                ? _value.parkingFeeInfo
                : parkingFeeInfo // ignore: cast_nullable_to_non_nullable
                    as String,
        basicTime:
            null == basicTime
                ? _value.basicTime
                : basicTime // ignore: cast_nullable_to_non_nullable
                    as String,
        basicCharge:
            null == basicCharge
                ? _value.basicCharge
                : basicCharge // ignore: cast_nullable_to_non_nullable
                    as String,
        addUnitTime:
            null == addUnitTime
                ? _value.addUnitTime
                : addUnitTime // ignore: cast_nullable_to_non_nullable
                    as String,
        addUnitCharge:
            null == addUnitCharge
                ? _value.addUnitCharge
                : addUnitCharge // ignore: cast_nullable_to_non_nullable
                    as String,
        dayCommutingTicket:
            null == dayCommutingTicket
                ? _value.dayCommutingTicket
                : dayCommutingTicket // ignore: cast_nullable_to_non_nullable
                    as String,
        monthCommutingTicket:
            null == monthCommutingTicket
                ? _value.monthCommutingTicket
                : monthCommutingTicket // ignore: cast_nullable_to_non_nullable
                    as String,
        paymentMethod:
            null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                    as String,
        specialNote:
            null == specialNote
                ? _value.specialNote
                : specialNote // ignore: cast_nullable_to_non_nullable
                    as String,
        institutionName:
            null == institutionName
                ? _value.institutionName
                : institutionName // ignore: cast_nullable_to_non_nullable
                    as String,
        phoneNumber:
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        latitude:
            null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                    as String,
        longitude:
            null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as String,
        referenceDate:
            null == referenceDate
                ? _value.referenceDate
                : referenceDate // ignore: cast_nullable_to_non_nullable
                    as String,
        institutionCode:
            null == institutionCode
                ? _value.institutionCode
                : institutionCode // ignore: cast_nullable_to_non_nullable
                    as String,
        institutionProviderName:
            null == institutionProviderName
                ? _value.institutionProviderName
                : institutionProviderName // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachedParkingLotInfoImpl implements _AttachedParkingLotInfo {
  const _$AttachedParkingLotInfoImpl({
    @JsonKey(name: 'prkplceNo') required this.parkingPlaceNo,
    @JsonKey(name: 'prkplceNm') required this.parkingPlaceName,
    @JsonKey(name: 'prkplceSe') required this.parkingPlaceType,
    @JsonKey(name: 'prkplceType') required this.parkingType,
    @JsonKey(name: 'rdnmadr') required this.roadAddress,
    @JsonKey(name: 'lnmadr') required this.address,
    @JsonKey(name: 'prkcmprt') required this.parkingSpace,
    @JsonKey(name: 'feedSe') required this.feeType,
    @JsonKey(name: 'enforceSe') required this.enforceType,
    @JsonKey(name: 'operDay') required this.operatingDays,
    @JsonKey(name: 'operOpenHm') required this.operatingStartTime,
    @JsonKey(name: 'operColseHm') required this.operatingEndTime,
    @JsonKey(name: 'satOperOpenHm') required this.satOperatingStartTime,
    @JsonKey(name: 'satOperCloseHm') required this.satOperatingEndTime,
    @JsonKey(name: 'holidayOperOpenHm') required this.holidayOperatingStartTime,
    @JsonKey(name: 'holidayCloseOpenHm') required this.holidayOperatingEndTime,
    @JsonKey(name: 'parkingchrgeInfo') required this.parkingFeeInfo,
    @JsonKey(name: 'basicTime') required this.basicTime,
    @JsonKey(name: 'basicCharge') required this.basicCharge,
    @JsonKey(name: 'addUnitTime') required this.addUnitTime,
    @JsonKey(name: 'addUnitCharge') required this.addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') required this.dayCommutingTicket,
    @JsonKey(name: 'monthCmmtkt') required this.monthCommutingTicket,
    @JsonKey(name: 'metpay') required this.paymentMethod,
    @JsonKey(name: 'spcmnt') required this.specialNote,
    @JsonKey(name: 'institutionNm') required this.institutionName,
    @JsonKey(name: 'phoneNumber') required this.phoneNumber,
    @JsonKey(name: 'latitude') required this.latitude,
    @JsonKey(name: 'longitude') required this.longitude,
    @JsonKey(name: 'referenceDate') required this.referenceDate,
    @JsonKey(name: 'instt_code') required this.institutionCode,
    @JsonKey(name: 'instt_nm') required this.institutionProviderName,
  });

  factory _$AttachedParkingLotInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachedParkingLotInfoImplFromJson(json);

  @override
  @JsonKey(name: 'prkplceNo')
  final String parkingPlaceNo;
  // 주차장관리번호
  @override
  @JsonKey(name: 'prkplceNm')
  final String parkingPlaceName;
  // 주차장명
  @override
  @JsonKey(name: 'prkplceSe')
  final String parkingPlaceType;
  // 주차장구분
  @override
  @JsonKey(name: 'prkplceType')
  final String parkingType;
  // 주차장유형
  @override
  @JsonKey(name: 'rdnmadr')
  final String roadAddress;
  // 소재지도로명주소
  @override
  @JsonKey(name: 'lnmadr')
  final String address;
  // 소재지지번주소
  @override
  @JsonKey(name: 'prkcmprt')
  final int parkingSpace;
  // 주차구획수
  @override
  @JsonKey(name: 'feedSe')
  final String feeType;
  // 급지구분
  @override
  @JsonKey(name: 'enforceSe')
  final String enforceType;
  // 부제시행구분
  @override
  @JsonKey(name: 'operDay')
  final String operatingDays;
  // 운영요일
  @override
  @JsonKey(name: 'operOpenHm')
  final String operatingStartTime;
  // 평일운영시작시각
  @override
  @JsonKey(name: 'operColseHm')
  final String operatingEndTime;
  // 평일운영종료시각
  @override
  @JsonKey(name: 'satOperOpenHm')
  final String satOperatingStartTime;
  // 토요일운영시작시각
  @override
  @JsonKey(name: 'satOperCloseHm')
  final String satOperatingEndTime;
  // 토요일운영종료시각
  @override
  @JsonKey(name: 'holidayOperOpenHm')
  final String holidayOperatingStartTime;
  // 공휴일운영시작시각
  @override
  @JsonKey(name: 'holidayCloseOpenHm')
  final String holidayOperatingEndTime;
  // 공휴일운영종료시각
  @override
  @JsonKey(name: 'parkingchrgeInfo')
  final String parkingFeeInfo;
  // 주차요금정보
  @override
  @JsonKey(name: 'basicTime')
  final String basicTime;
  // 주차기본시간
  @override
  @JsonKey(name: 'basicCharge')
  final String basicCharge;
  // 주차기본요금
  @override
  @JsonKey(name: 'addUnitTime')
  final String addUnitTime;
  // 추가단위시간
  @override
  @JsonKey(name: 'addUnitCharge')
  final String addUnitCharge;
  // 추가단위요금
  @override
  @JsonKey(name: 'dayCmmtkt')
  final String dayCommutingTicket;
  // 일주차권요금
  @override
  @JsonKey(name: 'monthCmmtkt')
  final String monthCommutingTicket;
  // 월정기권요금
  @override
  @JsonKey(name: 'metpay')
  final String paymentMethod;
  // 결제방법
  @override
  @JsonKey(name: 'spcmnt')
  final String specialNote;
  // 특기사항
  @override
  @JsonKey(name: 'institutionNm')
  final String institutionName;
  // 관리기관명
  @override
  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;
  // 전화번호
  @override
  @JsonKey(name: 'latitude')
  final String latitude;
  // 위도
  @override
  @JsonKey(name: 'longitude')
  final String longitude;
  // 경도
  @override
  @JsonKey(name: 'referenceDate')
  final String referenceDate;
  // 데이터기준일자
  @override
  @JsonKey(name: 'instt_code')
  final String institutionCode;
  // 제공기관코드
  @override
  @JsonKey(name: 'instt_nm')
  final String institutionProviderName;

  @override
  String toString() {
    return 'AttachedParkingLotInfo(parkingPlaceNo: $parkingPlaceNo, parkingPlaceName: $parkingPlaceName, parkingPlaceType: $parkingPlaceType, parkingType: $parkingType, roadAddress: $roadAddress, address: $address, parkingSpace: $parkingSpace, feeType: $feeType, enforceType: $enforceType, operatingDays: $operatingDays, operatingStartTime: $operatingStartTime, operatingEndTime: $operatingEndTime, satOperatingStartTime: $satOperatingStartTime, satOperatingEndTime: $satOperatingEndTime, holidayOperatingStartTime: $holidayOperatingStartTime, holidayOperatingEndTime: $holidayOperatingEndTime, parkingFeeInfo: $parkingFeeInfo, basicTime: $basicTime, basicCharge: $basicCharge, addUnitTime: $addUnitTime, addUnitCharge: $addUnitCharge, dayCommutingTicket: $dayCommutingTicket, monthCommutingTicket: $monthCommutingTicket, paymentMethod: $paymentMethod, specialNote: $specialNote, institutionName: $institutionName, phoneNumber: $phoneNumber, latitude: $latitude, longitude: $longitude, referenceDate: $referenceDate, institutionCode: $institutionCode, institutionProviderName: $institutionProviderName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachedParkingLotInfoImpl &&
            (identical(other.parkingPlaceNo, parkingPlaceNo) ||
                other.parkingPlaceNo == parkingPlaceNo) &&
            (identical(other.parkingPlaceName, parkingPlaceName) ||
                other.parkingPlaceName == parkingPlaceName) &&
            (identical(other.parkingPlaceType, parkingPlaceType) ||
                other.parkingPlaceType == parkingPlaceType) &&
            (identical(other.parkingType, parkingType) ||
                other.parkingType == parkingType) &&
            (identical(other.roadAddress, roadAddress) ||
                other.roadAddress == roadAddress) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.parkingSpace, parkingSpace) ||
                other.parkingSpace == parkingSpace) &&
            (identical(other.feeType, feeType) || other.feeType == feeType) &&
            (identical(other.enforceType, enforceType) ||
                other.enforceType == enforceType) &&
            (identical(other.operatingDays, operatingDays) ||
                other.operatingDays == operatingDays) &&
            (identical(other.operatingStartTime, operatingStartTime) ||
                other.operatingStartTime == operatingStartTime) &&
            (identical(other.operatingEndTime, operatingEndTime) ||
                other.operatingEndTime == operatingEndTime) &&
            (identical(other.satOperatingStartTime, satOperatingStartTime) ||
                other.satOperatingStartTime == satOperatingStartTime) &&
            (identical(other.satOperatingEndTime, satOperatingEndTime) ||
                other.satOperatingEndTime == satOperatingEndTime) &&
            (identical(
                  other.holidayOperatingStartTime,
                  holidayOperatingStartTime,
                ) ||
                other.holidayOperatingStartTime == holidayOperatingStartTime) &&
            (identical(
                  other.holidayOperatingEndTime,
                  holidayOperatingEndTime,
                ) ||
                other.holidayOperatingEndTime == holidayOperatingEndTime) &&
            (identical(other.parkingFeeInfo, parkingFeeInfo) ||
                other.parkingFeeInfo == parkingFeeInfo) &&
            (identical(other.basicTime, basicTime) ||
                other.basicTime == basicTime) &&
            (identical(other.basicCharge, basicCharge) ||
                other.basicCharge == basicCharge) &&
            (identical(other.addUnitTime, addUnitTime) ||
                other.addUnitTime == addUnitTime) &&
            (identical(other.addUnitCharge, addUnitCharge) ||
                other.addUnitCharge == addUnitCharge) &&
            (identical(other.dayCommutingTicket, dayCommutingTicket) ||
                other.dayCommutingTicket == dayCommutingTicket) &&
            (identical(other.monthCommutingTicket, monthCommutingTicket) ||
                other.monthCommutingTicket == monthCommutingTicket) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.specialNote, specialNote) ||
                other.specialNote == specialNote) &&
            (identical(other.institutionName, institutionName) ||
                other.institutionName == institutionName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.referenceDate, referenceDate) ||
                other.referenceDate == referenceDate) &&
            (identical(other.institutionCode, institutionCode) ||
                other.institutionCode == institutionCode) &&
            (identical(
                  other.institutionProviderName,
                  institutionProviderName,
                ) ||
                other.institutionProviderName == institutionProviderName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    parkingPlaceNo,
    parkingPlaceName,
    parkingPlaceType,
    parkingType,
    roadAddress,
    address,
    parkingSpace,
    feeType,
    enforceType,
    operatingDays,
    operatingStartTime,
    operatingEndTime,
    satOperatingStartTime,
    satOperatingEndTime,
    holidayOperatingStartTime,
    holidayOperatingEndTime,
    parkingFeeInfo,
    basicTime,
    basicCharge,
    addUnitTime,
    addUnitCharge,
    dayCommutingTicket,
    monthCommutingTicket,
    paymentMethod,
    specialNote,
    institutionName,
    phoneNumber,
    latitude,
    longitude,
    referenceDate,
    institutionCode,
    institutionProviderName,
  ]);

  /// Create a copy of AttachedParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachedParkingLotInfoImplCopyWith<_$AttachedParkingLotInfoImpl>
  get copyWith =>
      __$$AttachedParkingLotInfoImplCopyWithImpl<_$AttachedParkingLotInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachedParkingLotInfoImplToJson(this);
  }
}

abstract class _AttachedParkingLotInfo implements AttachedParkingLotInfo {
  const factory _AttachedParkingLotInfo({
    @JsonKey(name: 'prkplceNo') required final String parkingPlaceNo,
    @JsonKey(name: 'prkplceNm') required final String parkingPlaceName,
    @JsonKey(name: 'prkplceSe') required final String parkingPlaceType,
    @JsonKey(name: 'prkplceType') required final String parkingType,
    @JsonKey(name: 'rdnmadr') required final String roadAddress,
    @JsonKey(name: 'lnmadr') required final String address,
    @JsonKey(name: 'prkcmprt') required final int parkingSpace,
    @JsonKey(name: 'feedSe') required final String feeType,
    @JsonKey(name: 'enforceSe') required final String enforceType,
    @JsonKey(name: 'operDay') required final String operatingDays,
    @JsonKey(name: 'operOpenHm') required final String operatingStartTime,
    @JsonKey(name: 'operColseHm') required final String operatingEndTime,
    @JsonKey(name: 'satOperOpenHm') required final String satOperatingStartTime,
    @JsonKey(name: 'satOperCloseHm') required final String satOperatingEndTime,
    @JsonKey(name: 'holidayOperOpenHm')
    required final String holidayOperatingStartTime,
    @JsonKey(name: 'holidayCloseOpenHm')
    required final String holidayOperatingEndTime,
    @JsonKey(name: 'parkingchrgeInfo') required final String parkingFeeInfo,
    @JsonKey(name: 'basicTime') required final String basicTime,
    @JsonKey(name: 'basicCharge') required final String basicCharge,
    @JsonKey(name: 'addUnitTime') required final String addUnitTime,
    @JsonKey(name: 'addUnitCharge') required final String addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') required final String dayCommutingTicket,
    @JsonKey(name: 'monthCmmtkt') required final String monthCommutingTicket,
    @JsonKey(name: 'metpay') required final String paymentMethod,
    @JsonKey(name: 'spcmnt') required final String specialNote,
    @JsonKey(name: 'institutionNm') required final String institutionName,
    @JsonKey(name: 'phoneNumber') required final String phoneNumber,
    @JsonKey(name: 'latitude') required final String latitude,
    @JsonKey(name: 'longitude') required final String longitude,
    @JsonKey(name: 'referenceDate') required final String referenceDate,
    @JsonKey(name: 'instt_code') required final String institutionCode,
    @JsonKey(name: 'instt_nm') required final String institutionProviderName,
  }) = _$AttachedParkingLotInfoImpl;

  factory _AttachedParkingLotInfo.fromJson(Map<String, dynamic> json) =
      _$AttachedParkingLotInfoImpl.fromJson;

  @override
  @JsonKey(name: 'prkplceNo')
  String get parkingPlaceNo; // 주차장관리번호
  @override
  @JsonKey(name: 'prkplceNm')
  String get parkingPlaceName; // 주차장명
  @override
  @JsonKey(name: 'prkplceSe')
  String get parkingPlaceType; // 주차장구분
  @override
  @JsonKey(name: 'prkplceType')
  String get parkingType; // 주차장유형
  @override
  @JsonKey(name: 'rdnmadr')
  String get roadAddress; // 소재지도로명주소
  @override
  @JsonKey(name: 'lnmadr')
  String get address; // 소재지지번주소
  @override
  @JsonKey(name: 'prkcmprt')
  int get parkingSpace; // 주차구획수
  @override
  @JsonKey(name: 'feedSe')
  String get feeType; // 급지구분
  @override
  @JsonKey(name: 'enforceSe')
  String get enforceType; // 부제시행구분
  @override
  @JsonKey(name: 'operDay')
  String get operatingDays; // 운영요일
  @override
  @JsonKey(name: 'operOpenHm')
  String get operatingStartTime; // 평일운영시작시각
  @override
  @JsonKey(name: 'operColseHm')
  String get operatingEndTime; // 평일운영종료시각
  @override
  @JsonKey(name: 'satOperOpenHm')
  String get satOperatingStartTime; // 토요일운영시작시각
  @override
  @JsonKey(name: 'satOperCloseHm')
  String get satOperatingEndTime; // 토요일운영종료시각
  @override
  @JsonKey(name: 'holidayOperOpenHm')
  String get holidayOperatingStartTime; // 공휴일운영시작시각
  @override
  @JsonKey(name: 'holidayCloseOpenHm')
  String get holidayOperatingEndTime; // 공휴일운영종료시각
  @override
  @JsonKey(name: 'parkingchrgeInfo')
  String get parkingFeeInfo; // 주차요금정보
  @override
  @JsonKey(name: 'basicTime')
  String get basicTime; // 주차기본시간
  @override
  @JsonKey(name: 'basicCharge')
  String get basicCharge; // 주차기본요금
  @override
  @JsonKey(name: 'addUnitTime')
  String get addUnitTime; // 추가단위시간
  @override
  @JsonKey(name: 'addUnitCharge')
  String get addUnitCharge; // 추가단위요금
  @override
  @JsonKey(name: 'dayCmmtkt')
  String get dayCommutingTicket; // 일주차권요금
  @override
  @JsonKey(name: 'monthCmmtkt')
  String get monthCommutingTicket; // 월정기권요금
  @override
  @JsonKey(name: 'metpay')
  String get paymentMethod; // 결제방법
  @override
  @JsonKey(name: 'spcmnt')
  String get specialNote; // 특기사항
  @override
  @JsonKey(name: 'institutionNm')
  String get institutionName; // 관리기관명
  @override
  @JsonKey(name: 'phoneNumber')
  String get phoneNumber; // 전화번호
  @override
  @JsonKey(name: 'latitude')
  String get latitude; // 위도
  @override
  @JsonKey(name: 'longitude')
  String get longitude; // 경도
  @override
  @JsonKey(name: 'referenceDate')
  String get referenceDate; // 데이터기준일자
  @override
  @JsonKey(name: 'instt_code')
  String get institutionCode; // 제공기관코드
  @override
  @JsonKey(name: 'instt_nm')
  String get institutionProviderName;

  /// Create a copy of AttachedParkingLotInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachedParkingLotInfoImplCopyWith<_$AttachedParkingLotInfoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
