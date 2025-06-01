// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GeneralParkingModel _$GeneralParkingModelFromJson(Map<String, dynamic> json) {
  return _GeneralParkingModel.fromJson(json);
}

/// @nodoc
mixin _$GeneralParkingModel {
  @JsonKey(name: 'prkplceNm')
  String? get parkingName => throw _privateConstructorUsedError; // 주차장명
  @JsonKey(name: 'rdnmadr')
  String? get roadAddress => throw _privateConstructorUsedError; // 도로명주소
  @JsonKey(name: 'lnmadr')
  String? get lotAddress => throw _privateConstructorUsedError; // 지번주소
  @JsonKey(name: 'prkcmprt')
  String? get parkingCapacity => throw _privateConstructorUsedError; // 주차면수
  @JsonKey(name: 'feedingSe')
  String? get feedingType => throw _privateConstructorUsedError; // 급지구분
  @JsonKey(name: 'enforceSe')
  String? get enforceType => throw _privateConstructorUsedError; // 단속구분
  @JsonKey(name: 'operDay')
  String? get operatingDays => throw _privateConstructorUsedError; // 운영요일
  @JsonKey(name: 'weekdayOperOpenHhmm')
  String? get weekdayOpenTime => throw _privateConstructorUsedError; // 평일운영시작시각
  @JsonKey(name: 'weekdayOperColseHhmm')
  String? get weekdayCloseTime => throw _privateConstructorUsedError; // 평일운영종료시각
  @JsonKey(name: 'satOperOperOpenHhmm')
  String? get satOpenTime => throw _privateConstructorUsedError; // 토요일운영시작시각
  @JsonKey(name: 'satOperCloseHhmm')
  String? get satCloseTime => throw _privateConstructorUsedError; // 토요일운영종료시각
  @JsonKey(name: 'holidayOperOpenHhmm')
  String? get holidayOpenTime => throw _privateConstructorUsedError; // 공휴일운영시작시각
  @JsonKey(name: 'holidayCloseOpenHhmm')
  String? get holidayCloseTime => throw _privateConstructorUsedError; // 공휴일운영종료시각
  @JsonKey(name: 'parkingchrgeInfo')
  String? get parkingFeeInfo => throw _privateConstructorUsedError; // 주차요금정보
  @JsonKey(name: 'basicTime')
  String? get basicTime => throw _privateConstructorUsedError; // 기본시간
  @JsonKey(name: 'basicCharge')
  String? get basicCharge => throw _privateConstructorUsedError; // 기본요금
  @JsonKey(name: 'addUnitTime')
  String? get addUnitTime => throw _privateConstructorUsedError; // 추가단위시간
  @JsonKey(name: 'addUnitCharge')
  String? get addUnitCharge => throw _privateConstructorUsedError; // 추가단위요금
  @JsonKey(name: 'dayCmmtkt')
  String? get dayTicket => throw _privateConstructorUsedError; // 일일주차권요금
  @JsonKey(name: 'monthCmmtkt')
  String? get monthTicket => throw _privateConstructorUsedError; // 월정기권요금
  @JsonKey(name: 'metpay')
  String? get paymentMethod => throw _privateConstructorUsedError; // 결제방법
  @JsonKey(name: 'spcmnt')
  String? get specialNote => throw _privateConstructorUsedError; // 특기사항
  @JsonKey(name: 'institutionNm')
  String? get institutionName => throw _privateConstructorUsedError; // 관리기관명
  @JsonKey(name: 'phoneNumber')
  String? get phoneNumber => throw _privateConstructorUsedError; // 전화번호
  @JsonKey(name: 'latitude')
  String? get latitude => throw _privateConstructorUsedError; // 위도
  @JsonKey(name: 'longitude')
  String? get longitude => throw _privateConstructorUsedError; // 경도
  @JsonKey(name: 'referenceDate')
  String? get referenceDate => throw _privateConstructorUsedError;

  /// Serializes this GeneralParkingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeneralParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneralParkingModelCopyWith<GeneralParkingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneralParkingModelCopyWith<$Res> {
  factory $GeneralParkingModelCopyWith(
    GeneralParkingModel value,
    $Res Function(GeneralParkingModel) then,
  ) = _$GeneralParkingModelCopyWithImpl<$Res, GeneralParkingModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'prkplceNm') String? parkingName,
    @JsonKey(name: 'rdnmadr') String? roadAddress,
    @JsonKey(name: 'lnmadr') String? lotAddress,
    @JsonKey(name: 'prkcmprt') String? parkingCapacity,
    @JsonKey(name: 'feedingSe') String? feedingType,
    @JsonKey(name: 'enforceSe') String? enforceType,
    @JsonKey(name: 'operDay') String? operatingDays,
    @JsonKey(name: 'weekdayOperOpenHhmm') String? weekdayOpenTime,
    @JsonKey(name: 'weekdayOperColseHhmm') String? weekdayCloseTime,
    @JsonKey(name: 'satOperOperOpenHhmm') String? satOpenTime,
    @JsonKey(name: 'satOperCloseHhmm') String? satCloseTime,
    @JsonKey(name: 'holidayOperOpenHhmm') String? holidayOpenTime,
    @JsonKey(name: 'holidayCloseOpenHhmm') String? holidayCloseTime,
    @JsonKey(name: 'parkingchrgeInfo') String? parkingFeeInfo,
    @JsonKey(name: 'basicTime') String? basicTime,
    @JsonKey(name: 'basicCharge') String? basicCharge,
    @JsonKey(name: 'addUnitTime') String? addUnitTime,
    @JsonKey(name: 'addUnitCharge') String? addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') String? dayTicket,
    @JsonKey(name: 'monthCmmtkt') String? monthTicket,
    @JsonKey(name: 'metpay') String? paymentMethod,
    @JsonKey(name: 'spcmnt') String? specialNote,
    @JsonKey(name: 'institutionNm') String? institutionName,
    @JsonKey(name: 'phoneNumber') String? phoneNumber,
    @JsonKey(name: 'latitude') String? latitude,
    @JsonKey(name: 'longitude') String? longitude,
    @JsonKey(name: 'referenceDate') String? referenceDate,
  });
}

/// @nodoc
class _$GeneralParkingModelCopyWithImpl<$Res, $Val extends GeneralParkingModel>
    implements $GeneralParkingModelCopyWith<$Res> {
  _$GeneralParkingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneralParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parkingName = freezed,
    Object? roadAddress = freezed,
    Object? lotAddress = freezed,
    Object? parkingCapacity = freezed,
    Object? feedingType = freezed,
    Object? enforceType = freezed,
    Object? operatingDays = freezed,
    Object? weekdayOpenTime = freezed,
    Object? weekdayCloseTime = freezed,
    Object? satOpenTime = freezed,
    Object? satCloseTime = freezed,
    Object? holidayOpenTime = freezed,
    Object? holidayCloseTime = freezed,
    Object? parkingFeeInfo = freezed,
    Object? basicTime = freezed,
    Object? basicCharge = freezed,
    Object? addUnitTime = freezed,
    Object? addUnitCharge = freezed,
    Object? dayTicket = freezed,
    Object? monthTicket = freezed,
    Object? paymentMethod = freezed,
    Object? specialNote = freezed,
    Object? institutionName = freezed,
    Object? phoneNumber = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? referenceDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            parkingName:
                freezed == parkingName
                    ? _value.parkingName
                    : parkingName // ignore: cast_nullable_to_non_nullable
                        as String?,
            roadAddress:
                freezed == roadAddress
                    ? _value.roadAddress
                    : roadAddress // ignore: cast_nullable_to_non_nullable
                        as String?,
            lotAddress:
                freezed == lotAddress
                    ? _value.lotAddress
                    : lotAddress // ignore: cast_nullable_to_non_nullable
                        as String?,
            parkingCapacity:
                freezed == parkingCapacity
                    ? _value.parkingCapacity
                    : parkingCapacity // ignore: cast_nullable_to_non_nullable
                        as String?,
            feedingType:
                freezed == feedingType
                    ? _value.feedingType
                    : feedingType // ignore: cast_nullable_to_non_nullable
                        as String?,
            enforceType:
                freezed == enforceType
                    ? _value.enforceType
                    : enforceType // ignore: cast_nullable_to_non_nullable
                        as String?,
            operatingDays:
                freezed == operatingDays
                    ? _value.operatingDays
                    : operatingDays // ignore: cast_nullable_to_non_nullable
                        as String?,
            weekdayOpenTime:
                freezed == weekdayOpenTime
                    ? _value.weekdayOpenTime
                    : weekdayOpenTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            weekdayCloseTime:
                freezed == weekdayCloseTime
                    ? _value.weekdayCloseTime
                    : weekdayCloseTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            satOpenTime:
                freezed == satOpenTime
                    ? _value.satOpenTime
                    : satOpenTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            satCloseTime:
                freezed == satCloseTime
                    ? _value.satCloseTime
                    : satCloseTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            holidayOpenTime:
                freezed == holidayOpenTime
                    ? _value.holidayOpenTime
                    : holidayOpenTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            holidayCloseTime:
                freezed == holidayCloseTime
                    ? _value.holidayCloseTime
                    : holidayCloseTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            parkingFeeInfo:
                freezed == parkingFeeInfo
                    ? _value.parkingFeeInfo
                    : parkingFeeInfo // ignore: cast_nullable_to_non_nullable
                        as String?,
            basicTime:
                freezed == basicTime
                    ? _value.basicTime
                    : basicTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            basicCharge:
                freezed == basicCharge
                    ? _value.basicCharge
                    : basicCharge // ignore: cast_nullable_to_non_nullable
                        as String?,
            addUnitTime:
                freezed == addUnitTime
                    ? _value.addUnitTime
                    : addUnitTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            addUnitCharge:
                freezed == addUnitCharge
                    ? _value.addUnitCharge
                    : addUnitCharge // ignore: cast_nullable_to_non_nullable
                        as String?,
            dayTicket:
                freezed == dayTicket
                    ? _value.dayTicket
                    : dayTicket // ignore: cast_nullable_to_non_nullable
                        as String?,
            monthTicket:
                freezed == monthTicket
                    ? _value.monthTicket
                    : monthTicket // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentMethod:
                freezed == paymentMethod
                    ? _value.paymentMethod
                    : paymentMethod // ignore: cast_nullable_to_non_nullable
                        as String?,
            specialNote:
                freezed == specialNote
                    ? _value.specialNote
                    : specialNote // ignore: cast_nullable_to_non_nullable
                        as String?,
            institutionName:
                freezed == institutionName
                    ? _value.institutionName
                    : institutionName // ignore: cast_nullable_to_non_nullable
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
                        as String?,
            longitude:
                freezed == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as String?,
            referenceDate:
                freezed == referenceDate
                    ? _value.referenceDate
                    : referenceDate // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GeneralParkingModelImplCopyWith<$Res>
    implements $GeneralParkingModelCopyWith<$Res> {
  factory _$$GeneralParkingModelImplCopyWith(
    _$GeneralParkingModelImpl value,
    $Res Function(_$GeneralParkingModelImpl) then,
  ) = __$$GeneralParkingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'prkplceNm') String? parkingName,
    @JsonKey(name: 'rdnmadr') String? roadAddress,
    @JsonKey(name: 'lnmadr') String? lotAddress,
    @JsonKey(name: 'prkcmprt') String? parkingCapacity,
    @JsonKey(name: 'feedingSe') String? feedingType,
    @JsonKey(name: 'enforceSe') String? enforceType,
    @JsonKey(name: 'operDay') String? operatingDays,
    @JsonKey(name: 'weekdayOperOpenHhmm') String? weekdayOpenTime,
    @JsonKey(name: 'weekdayOperColseHhmm') String? weekdayCloseTime,
    @JsonKey(name: 'satOperOperOpenHhmm') String? satOpenTime,
    @JsonKey(name: 'satOperCloseHhmm') String? satCloseTime,
    @JsonKey(name: 'holidayOperOpenHhmm') String? holidayOpenTime,
    @JsonKey(name: 'holidayCloseOpenHhmm') String? holidayCloseTime,
    @JsonKey(name: 'parkingchrgeInfo') String? parkingFeeInfo,
    @JsonKey(name: 'basicTime') String? basicTime,
    @JsonKey(name: 'basicCharge') String? basicCharge,
    @JsonKey(name: 'addUnitTime') String? addUnitTime,
    @JsonKey(name: 'addUnitCharge') String? addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') String? dayTicket,
    @JsonKey(name: 'monthCmmtkt') String? monthTicket,
    @JsonKey(name: 'metpay') String? paymentMethod,
    @JsonKey(name: 'spcmnt') String? specialNote,
    @JsonKey(name: 'institutionNm') String? institutionName,
    @JsonKey(name: 'phoneNumber') String? phoneNumber,
    @JsonKey(name: 'latitude') String? latitude,
    @JsonKey(name: 'longitude') String? longitude,
    @JsonKey(name: 'referenceDate') String? referenceDate,
  });
}

/// @nodoc
class __$$GeneralParkingModelImplCopyWithImpl<$Res>
    extends _$GeneralParkingModelCopyWithImpl<$Res, _$GeneralParkingModelImpl>
    implements _$$GeneralParkingModelImplCopyWith<$Res> {
  __$$GeneralParkingModelImplCopyWithImpl(
    _$GeneralParkingModelImpl _value,
    $Res Function(_$GeneralParkingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GeneralParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parkingName = freezed,
    Object? roadAddress = freezed,
    Object? lotAddress = freezed,
    Object? parkingCapacity = freezed,
    Object? feedingType = freezed,
    Object? enforceType = freezed,
    Object? operatingDays = freezed,
    Object? weekdayOpenTime = freezed,
    Object? weekdayCloseTime = freezed,
    Object? satOpenTime = freezed,
    Object? satCloseTime = freezed,
    Object? holidayOpenTime = freezed,
    Object? holidayCloseTime = freezed,
    Object? parkingFeeInfo = freezed,
    Object? basicTime = freezed,
    Object? basicCharge = freezed,
    Object? addUnitTime = freezed,
    Object? addUnitCharge = freezed,
    Object? dayTicket = freezed,
    Object? monthTicket = freezed,
    Object? paymentMethod = freezed,
    Object? specialNote = freezed,
    Object? institutionName = freezed,
    Object? phoneNumber = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? referenceDate = freezed,
  }) {
    return _then(
      _$GeneralParkingModelImpl(
        parkingName:
            freezed == parkingName
                ? _value.parkingName
                : parkingName // ignore: cast_nullable_to_non_nullable
                    as String?,
        roadAddress:
            freezed == roadAddress
                ? _value.roadAddress
                : roadAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
        lotAddress:
            freezed == lotAddress
                ? _value.lotAddress
                : lotAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
        parkingCapacity:
            freezed == parkingCapacity
                ? _value.parkingCapacity
                : parkingCapacity // ignore: cast_nullable_to_non_nullable
                    as String?,
        feedingType:
            freezed == feedingType
                ? _value.feedingType
                : feedingType // ignore: cast_nullable_to_non_nullable
                    as String?,
        enforceType:
            freezed == enforceType
                ? _value.enforceType
                : enforceType // ignore: cast_nullable_to_non_nullable
                    as String?,
        operatingDays:
            freezed == operatingDays
                ? _value.operatingDays
                : operatingDays // ignore: cast_nullable_to_non_nullable
                    as String?,
        weekdayOpenTime:
            freezed == weekdayOpenTime
                ? _value.weekdayOpenTime
                : weekdayOpenTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        weekdayCloseTime:
            freezed == weekdayCloseTime
                ? _value.weekdayCloseTime
                : weekdayCloseTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        satOpenTime:
            freezed == satOpenTime
                ? _value.satOpenTime
                : satOpenTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        satCloseTime:
            freezed == satCloseTime
                ? _value.satCloseTime
                : satCloseTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        holidayOpenTime:
            freezed == holidayOpenTime
                ? _value.holidayOpenTime
                : holidayOpenTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        holidayCloseTime:
            freezed == holidayCloseTime
                ? _value.holidayCloseTime
                : holidayCloseTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        parkingFeeInfo:
            freezed == parkingFeeInfo
                ? _value.parkingFeeInfo
                : parkingFeeInfo // ignore: cast_nullable_to_non_nullable
                    as String?,
        basicTime:
            freezed == basicTime
                ? _value.basicTime
                : basicTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        basicCharge:
            freezed == basicCharge
                ? _value.basicCharge
                : basicCharge // ignore: cast_nullable_to_non_nullable
                    as String?,
        addUnitTime:
            freezed == addUnitTime
                ? _value.addUnitTime
                : addUnitTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        addUnitCharge:
            freezed == addUnitCharge
                ? _value.addUnitCharge
                : addUnitCharge // ignore: cast_nullable_to_non_nullable
                    as String?,
        dayTicket:
            freezed == dayTicket
                ? _value.dayTicket
                : dayTicket // ignore: cast_nullable_to_non_nullable
                    as String?,
        monthTicket:
            freezed == monthTicket
                ? _value.monthTicket
                : monthTicket // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentMethod:
            freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                    as String?,
        specialNote:
            freezed == specialNote
                ? _value.specialNote
                : specialNote // ignore: cast_nullable_to_non_nullable
                    as String?,
        institutionName:
            freezed == institutionName
                ? _value.institutionName
                : institutionName // ignore: cast_nullable_to_non_nullable
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
                    as String?,
        longitude:
            freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as String?,
        referenceDate:
            freezed == referenceDate
                ? _value.referenceDate
                : referenceDate // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneralParkingModelImpl implements _GeneralParkingModel {
  const _$GeneralParkingModelImpl({
    @JsonKey(name: 'prkplceNm') this.parkingName,
    @JsonKey(name: 'rdnmadr') this.roadAddress,
    @JsonKey(name: 'lnmadr') this.lotAddress,
    @JsonKey(name: 'prkcmprt') this.parkingCapacity,
    @JsonKey(name: 'feedingSe') this.feedingType,
    @JsonKey(name: 'enforceSe') this.enforceType,
    @JsonKey(name: 'operDay') this.operatingDays,
    @JsonKey(name: 'weekdayOperOpenHhmm') this.weekdayOpenTime,
    @JsonKey(name: 'weekdayOperColseHhmm') this.weekdayCloseTime,
    @JsonKey(name: 'satOperOperOpenHhmm') this.satOpenTime,
    @JsonKey(name: 'satOperCloseHhmm') this.satCloseTime,
    @JsonKey(name: 'holidayOperOpenHhmm') this.holidayOpenTime,
    @JsonKey(name: 'holidayCloseOpenHhmm') this.holidayCloseTime,
    @JsonKey(name: 'parkingchrgeInfo') this.parkingFeeInfo,
    @JsonKey(name: 'basicTime') this.basicTime,
    @JsonKey(name: 'basicCharge') this.basicCharge,
    @JsonKey(name: 'addUnitTime') this.addUnitTime,
    @JsonKey(name: 'addUnitCharge') this.addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') this.dayTicket,
    @JsonKey(name: 'monthCmmtkt') this.monthTicket,
    @JsonKey(name: 'metpay') this.paymentMethod,
    @JsonKey(name: 'spcmnt') this.specialNote,
    @JsonKey(name: 'institutionNm') this.institutionName,
    @JsonKey(name: 'phoneNumber') this.phoneNumber,
    @JsonKey(name: 'latitude') this.latitude,
    @JsonKey(name: 'longitude') this.longitude,
    @JsonKey(name: 'referenceDate') this.referenceDate,
  });

  factory _$GeneralParkingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneralParkingModelImplFromJson(json);

  @override
  @JsonKey(name: 'prkplceNm')
  final String? parkingName;
  // 주차장명
  @override
  @JsonKey(name: 'rdnmadr')
  final String? roadAddress;
  // 도로명주소
  @override
  @JsonKey(name: 'lnmadr')
  final String? lotAddress;
  // 지번주소
  @override
  @JsonKey(name: 'prkcmprt')
  final String? parkingCapacity;
  // 주차면수
  @override
  @JsonKey(name: 'feedingSe')
  final String? feedingType;
  // 급지구분
  @override
  @JsonKey(name: 'enforceSe')
  final String? enforceType;
  // 단속구분
  @override
  @JsonKey(name: 'operDay')
  final String? operatingDays;
  // 운영요일
  @override
  @JsonKey(name: 'weekdayOperOpenHhmm')
  final String? weekdayOpenTime;
  // 평일운영시작시각
  @override
  @JsonKey(name: 'weekdayOperColseHhmm')
  final String? weekdayCloseTime;
  // 평일운영종료시각
  @override
  @JsonKey(name: 'satOperOperOpenHhmm')
  final String? satOpenTime;
  // 토요일운영시작시각
  @override
  @JsonKey(name: 'satOperCloseHhmm')
  final String? satCloseTime;
  // 토요일운영종료시각
  @override
  @JsonKey(name: 'holidayOperOpenHhmm')
  final String? holidayOpenTime;
  // 공휴일운영시작시각
  @override
  @JsonKey(name: 'holidayCloseOpenHhmm')
  final String? holidayCloseTime;
  // 공휴일운영종료시각
  @override
  @JsonKey(name: 'parkingchrgeInfo')
  final String? parkingFeeInfo;
  // 주차요금정보
  @override
  @JsonKey(name: 'basicTime')
  final String? basicTime;
  // 기본시간
  @override
  @JsonKey(name: 'basicCharge')
  final String? basicCharge;
  // 기본요금
  @override
  @JsonKey(name: 'addUnitTime')
  final String? addUnitTime;
  // 추가단위시간
  @override
  @JsonKey(name: 'addUnitCharge')
  final String? addUnitCharge;
  // 추가단위요금
  @override
  @JsonKey(name: 'dayCmmtkt')
  final String? dayTicket;
  // 일일주차권요금
  @override
  @JsonKey(name: 'monthCmmtkt')
  final String? monthTicket;
  // 월정기권요금
  @override
  @JsonKey(name: 'metpay')
  final String? paymentMethod;
  // 결제방법
  @override
  @JsonKey(name: 'spcmnt')
  final String? specialNote;
  // 특기사항
  @override
  @JsonKey(name: 'institutionNm')
  final String? institutionName;
  // 관리기관명
  @override
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  // 전화번호
  @override
  @JsonKey(name: 'latitude')
  final String? latitude;
  // 위도
  @override
  @JsonKey(name: 'longitude')
  final String? longitude;
  // 경도
  @override
  @JsonKey(name: 'referenceDate')
  final String? referenceDate;

  @override
  String toString() {
    return 'GeneralParkingModel(parkingName: $parkingName, roadAddress: $roadAddress, lotAddress: $lotAddress, parkingCapacity: $parkingCapacity, feedingType: $feedingType, enforceType: $enforceType, operatingDays: $operatingDays, weekdayOpenTime: $weekdayOpenTime, weekdayCloseTime: $weekdayCloseTime, satOpenTime: $satOpenTime, satCloseTime: $satCloseTime, holidayOpenTime: $holidayOpenTime, holidayCloseTime: $holidayCloseTime, parkingFeeInfo: $parkingFeeInfo, basicTime: $basicTime, basicCharge: $basicCharge, addUnitTime: $addUnitTime, addUnitCharge: $addUnitCharge, dayTicket: $dayTicket, monthTicket: $monthTicket, paymentMethod: $paymentMethod, specialNote: $specialNote, institutionName: $institutionName, phoneNumber: $phoneNumber, latitude: $latitude, longitude: $longitude, referenceDate: $referenceDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneralParkingModelImpl &&
            (identical(other.parkingName, parkingName) ||
                other.parkingName == parkingName) &&
            (identical(other.roadAddress, roadAddress) ||
                other.roadAddress == roadAddress) &&
            (identical(other.lotAddress, lotAddress) ||
                other.lotAddress == lotAddress) &&
            (identical(other.parkingCapacity, parkingCapacity) ||
                other.parkingCapacity == parkingCapacity) &&
            (identical(other.feedingType, feedingType) ||
                other.feedingType == feedingType) &&
            (identical(other.enforceType, enforceType) ||
                other.enforceType == enforceType) &&
            (identical(other.operatingDays, operatingDays) ||
                other.operatingDays == operatingDays) &&
            (identical(other.weekdayOpenTime, weekdayOpenTime) ||
                other.weekdayOpenTime == weekdayOpenTime) &&
            (identical(other.weekdayCloseTime, weekdayCloseTime) ||
                other.weekdayCloseTime == weekdayCloseTime) &&
            (identical(other.satOpenTime, satOpenTime) ||
                other.satOpenTime == satOpenTime) &&
            (identical(other.satCloseTime, satCloseTime) ||
                other.satCloseTime == satCloseTime) &&
            (identical(other.holidayOpenTime, holidayOpenTime) ||
                other.holidayOpenTime == holidayOpenTime) &&
            (identical(other.holidayCloseTime, holidayCloseTime) ||
                other.holidayCloseTime == holidayCloseTime) &&
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
            (identical(other.dayTicket, dayTicket) ||
                other.dayTicket == dayTicket) &&
            (identical(other.monthTicket, monthTicket) ||
                other.monthTicket == monthTicket) &&
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
                other.referenceDate == referenceDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    parkingName,
    roadAddress,
    lotAddress,
    parkingCapacity,
    feedingType,
    enforceType,
    operatingDays,
    weekdayOpenTime,
    weekdayCloseTime,
    satOpenTime,
    satCloseTime,
    holidayOpenTime,
    holidayCloseTime,
    parkingFeeInfo,
    basicTime,
    basicCharge,
    addUnitTime,
    addUnitCharge,
    dayTicket,
    monthTicket,
    paymentMethod,
    specialNote,
    institutionName,
    phoneNumber,
    latitude,
    longitude,
    referenceDate,
  ]);

  /// Create a copy of GeneralParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneralParkingModelImplCopyWith<_$GeneralParkingModelImpl> get copyWith =>
      __$$GeneralParkingModelImplCopyWithImpl<_$GeneralParkingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneralParkingModelImplToJson(this);
  }
}

abstract class _GeneralParkingModel implements GeneralParkingModel {
  const factory _GeneralParkingModel({
    @JsonKey(name: 'prkplceNm') final String? parkingName,
    @JsonKey(name: 'rdnmadr') final String? roadAddress,
    @JsonKey(name: 'lnmadr') final String? lotAddress,
    @JsonKey(name: 'prkcmprt') final String? parkingCapacity,
    @JsonKey(name: 'feedingSe') final String? feedingType,
    @JsonKey(name: 'enforceSe') final String? enforceType,
    @JsonKey(name: 'operDay') final String? operatingDays,
    @JsonKey(name: 'weekdayOperOpenHhmm') final String? weekdayOpenTime,
    @JsonKey(name: 'weekdayOperColseHhmm') final String? weekdayCloseTime,
    @JsonKey(name: 'satOperOperOpenHhmm') final String? satOpenTime,
    @JsonKey(name: 'satOperCloseHhmm') final String? satCloseTime,
    @JsonKey(name: 'holidayOperOpenHhmm') final String? holidayOpenTime,
    @JsonKey(name: 'holidayCloseOpenHhmm') final String? holidayCloseTime,
    @JsonKey(name: 'parkingchrgeInfo') final String? parkingFeeInfo,
    @JsonKey(name: 'basicTime') final String? basicTime,
    @JsonKey(name: 'basicCharge') final String? basicCharge,
    @JsonKey(name: 'addUnitTime') final String? addUnitTime,
    @JsonKey(name: 'addUnitCharge') final String? addUnitCharge,
    @JsonKey(name: 'dayCmmtkt') final String? dayTicket,
    @JsonKey(name: 'monthCmmtkt') final String? monthTicket,
    @JsonKey(name: 'metpay') final String? paymentMethod,
    @JsonKey(name: 'spcmnt') final String? specialNote,
    @JsonKey(name: 'institutionNm') final String? institutionName,
    @JsonKey(name: 'phoneNumber') final String? phoneNumber,
    @JsonKey(name: 'latitude') final String? latitude,
    @JsonKey(name: 'longitude') final String? longitude,
    @JsonKey(name: 'referenceDate') final String? referenceDate,
  }) = _$GeneralParkingModelImpl;

  factory _GeneralParkingModel.fromJson(Map<String, dynamic> json) =
      _$GeneralParkingModelImpl.fromJson;

  @override
  @JsonKey(name: 'prkplceNm')
  String? get parkingName; // 주차장명
  @override
  @JsonKey(name: 'rdnmadr')
  String? get roadAddress; // 도로명주소
  @override
  @JsonKey(name: 'lnmadr')
  String? get lotAddress; // 지번주소
  @override
  @JsonKey(name: 'prkcmprt')
  String? get parkingCapacity; // 주차면수
  @override
  @JsonKey(name: 'feedingSe')
  String? get feedingType; // 급지구분
  @override
  @JsonKey(name: 'enforceSe')
  String? get enforceType; // 단속구분
  @override
  @JsonKey(name: 'operDay')
  String? get operatingDays; // 운영요일
  @override
  @JsonKey(name: 'weekdayOperOpenHhmm')
  String? get weekdayOpenTime; // 평일운영시작시각
  @override
  @JsonKey(name: 'weekdayOperColseHhmm')
  String? get weekdayCloseTime; // 평일운영종료시각
  @override
  @JsonKey(name: 'satOperOperOpenHhmm')
  String? get satOpenTime; // 토요일운영시작시각
  @override
  @JsonKey(name: 'satOperCloseHhmm')
  String? get satCloseTime; // 토요일운영종료시각
  @override
  @JsonKey(name: 'holidayOperOpenHhmm')
  String? get holidayOpenTime; // 공휴일운영시작시각
  @override
  @JsonKey(name: 'holidayCloseOpenHhmm')
  String? get holidayCloseTime; // 공휴일운영종료시각
  @override
  @JsonKey(name: 'parkingchrgeInfo')
  String? get parkingFeeInfo; // 주차요금정보
  @override
  @JsonKey(name: 'basicTime')
  String? get basicTime; // 기본시간
  @override
  @JsonKey(name: 'basicCharge')
  String? get basicCharge; // 기본요금
  @override
  @JsonKey(name: 'addUnitTime')
  String? get addUnitTime; // 추가단위시간
  @override
  @JsonKey(name: 'addUnitCharge')
  String? get addUnitCharge; // 추가단위요금
  @override
  @JsonKey(name: 'dayCmmtkt')
  String? get dayTicket; // 일일주차권요금
  @override
  @JsonKey(name: 'monthCmmtkt')
  String? get monthTicket; // 월정기권요금
  @override
  @JsonKey(name: 'metpay')
  String? get paymentMethod; // 결제방법
  @override
  @JsonKey(name: 'spcmnt')
  String? get specialNote; // 특기사항
  @override
  @JsonKey(name: 'institutionNm')
  String? get institutionName; // 관리기관명
  @override
  @JsonKey(name: 'phoneNumber')
  String? get phoneNumber; // 전화번호
  @override
  @JsonKey(name: 'latitude')
  String? get latitude; // 위도
  @override
  @JsonKey(name: 'longitude')
  String? get longitude; // 경도
  @override
  @JsonKey(name: 'referenceDate')
  String? get referenceDate;

  /// Create a copy of GeneralParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneralParkingModelImplCopyWith<_$GeneralParkingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttachedParkingModel _$AttachedParkingModelFromJson(Map<String, dynamic> json) {
  return _AttachedParkingModel.fromJson(json);
}

/// @nodoc
mixin _$AttachedParkingModel {
  @JsonKey(name: 'platPlc')
  String? get platPlc => throw _privateConstructorUsedError; // 소재지(주소)
  @JsonKey(name: 'bldNm')
  String? get bldNm => throw _privateConstructorUsedError; // 건물명
  @JsonKey(name: 'totPkngCnt')
  int? get totPkngCnt => throw _privateConstructorUsedError; // 총 주차면수
  @JsonKey(name: 'curPkngCnt')
  int? get curPkngCnt => throw _privateConstructorUsedError; // 현재 주차대수
  @JsonKey(name: 'pkngPosblCnt')
  int? get pkngPosblCnt => throw _privateConstructorUsedError; // 주차가능대수
  @JsonKey(name: 'useYn')
  String? get useYn => throw _privateConstructorUsedError; // 사용여부
  @JsonKey(name: 'ngtUseYn')
  String? get ngtUseYn => throw _privateConstructorUsedError; // 야간사용여부
  @JsonKey(name: 'feeYn')
  String? get feeYn => throw _privateConstructorUsedError; // 유료여부
  @JsonKey(name: 'pkngChrg')
  String? get pkngChrg => throw _privateConstructorUsedError; // 주차요금
  @JsonKey(name: 'oprDay')
  String? get oprDay => throw _privateConstructorUsedError; // 운영요일
  @JsonKey(name: 'satSttTm')
  String? get satSttTm => throw _privateConstructorUsedError; // 토요일시작시간
  @JsonKey(name: 'satEndTm')
  String? get satEndTm => throw _privateConstructorUsedError; // 토요일종료시간
  @JsonKey(name: 'hldSttTm')
  String? get hldSttTm => throw _privateConstructorUsedError; // 공휴일시작시간
  @JsonKey(name: 'hldEndTm')
  String? get hldEndTm => throw _privateConstructorUsedError; // 공휴일종료시간
  @JsonKey(name: 'syncTime')
  String? get syncTime => throw _privateConstructorUsedError; // 동기화시간
  @JsonKey(name: 'institutionCode')
  String? get institutionCode => throw _privateConstructorUsedError; // 기관코드
  @JsonKey(name: 'institutionName')
  String? get institutionName => throw _privateConstructorUsedError; // 기관명
  @JsonKey(name: 'phoneNumber')
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this AttachedParkingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttachedParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachedParkingModelCopyWith<AttachedParkingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachedParkingModelCopyWith<$Res> {
  factory $AttachedParkingModelCopyWith(
    AttachedParkingModel value,
    $Res Function(AttachedParkingModel) then,
  ) = _$AttachedParkingModelCopyWithImpl<$Res, AttachedParkingModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'platPlc') String? platPlc,
    @JsonKey(name: 'bldNm') String? bldNm,
    @JsonKey(name: 'totPkngCnt') int? totPkngCnt,
    @JsonKey(name: 'curPkngCnt') int? curPkngCnt,
    @JsonKey(name: 'pkngPosblCnt') int? pkngPosblCnt,
    @JsonKey(name: 'useYn') String? useYn,
    @JsonKey(name: 'ngtUseYn') String? ngtUseYn,
    @JsonKey(name: 'feeYn') String? feeYn,
    @JsonKey(name: 'pkngChrg') String? pkngChrg,
    @JsonKey(name: 'oprDay') String? oprDay,
    @JsonKey(name: 'satSttTm') String? satSttTm,
    @JsonKey(name: 'satEndTm') String? satEndTm,
    @JsonKey(name: 'hldSttTm') String? hldSttTm,
    @JsonKey(name: 'hldEndTm') String? hldEndTm,
    @JsonKey(name: 'syncTime') String? syncTime,
    @JsonKey(name: 'institutionCode') String? institutionCode,
    @JsonKey(name: 'institutionName') String? institutionName,
    @JsonKey(name: 'phoneNumber') String? phoneNumber,
  });
}

/// @nodoc
class _$AttachedParkingModelCopyWithImpl<
  $Res,
  $Val extends AttachedParkingModel
>
    implements $AttachedParkingModelCopyWith<$Res> {
  _$AttachedParkingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttachedParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platPlc = freezed,
    Object? bldNm = freezed,
    Object? totPkngCnt = freezed,
    Object? curPkngCnt = freezed,
    Object? pkngPosblCnt = freezed,
    Object? useYn = freezed,
    Object? ngtUseYn = freezed,
    Object? feeYn = freezed,
    Object? pkngChrg = freezed,
    Object? oprDay = freezed,
    Object? satSttTm = freezed,
    Object? satEndTm = freezed,
    Object? hldSttTm = freezed,
    Object? hldEndTm = freezed,
    Object? syncTime = freezed,
    Object? institutionCode = freezed,
    Object? institutionName = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            platPlc:
                freezed == platPlc
                    ? _value.platPlc
                    : platPlc // ignore: cast_nullable_to_non_nullable
                        as String?,
            bldNm:
                freezed == bldNm
                    ? _value.bldNm
                    : bldNm // ignore: cast_nullable_to_non_nullable
                        as String?,
            totPkngCnt:
                freezed == totPkngCnt
                    ? _value.totPkngCnt
                    : totPkngCnt // ignore: cast_nullable_to_non_nullable
                        as int?,
            curPkngCnt:
                freezed == curPkngCnt
                    ? _value.curPkngCnt
                    : curPkngCnt // ignore: cast_nullable_to_non_nullable
                        as int?,
            pkngPosblCnt:
                freezed == pkngPosblCnt
                    ? _value.pkngPosblCnt
                    : pkngPosblCnt // ignore: cast_nullable_to_non_nullable
                        as int?,
            useYn:
                freezed == useYn
                    ? _value.useYn
                    : useYn // ignore: cast_nullable_to_non_nullable
                        as String?,
            ngtUseYn:
                freezed == ngtUseYn
                    ? _value.ngtUseYn
                    : ngtUseYn // ignore: cast_nullable_to_non_nullable
                        as String?,
            feeYn:
                freezed == feeYn
                    ? _value.feeYn
                    : feeYn // ignore: cast_nullable_to_non_nullable
                        as String?,
            pkngChrg:
                freezed == pkngChrg
                    ? _value.pkngChrg
                    : pkngChrg // ignore: cast_nullable_to_non_nullable
                        as String?,
            oprDay:
                freezed == oprDay
                    ? _value.oprDay
                    : oprDay // ignore: cast_nullable_to_non_nullable
                        as String?,
            satSttTm:
                freezed == satSttTm
                    ? _value.satSttTm
                    : satSttTm // ignore: cast_nullable_to_non_nullable
                        as String?,
            satEndTm:
                freezed == satEndTm
                    ? _value.satEndTm
                    : satEndTm // ignore: cast_nullable_to_non_nullable
                        as String?,
            hldSttTm:
                freezed == hldSttTm
                    ? _value.hldSttTm
                    : hldSttTm // ignore: cast_nullable_to_non_nullable
                        as String?,
            hldEndTm:
                freezed == hldEndTm
                    ? _value.hldEndTm
                    : hldEndTm // ignore: cast_nullable_to_non_nullable
                        as String?,
            syncTime:
                freezed == syncTime
                    ? _value.syncTime
                    : syncTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            institutionCode:
                freezed == institutionCode
                    ? _value.institutionCode
                    : institutionCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            institutionName:
                freezed == institutionName
                    ? _value.institutionName
                    : institutionName // ignore: cast_nullable_to_non_nullable
                        as String?,
            phoneNumber:
                freezed == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttachedParkingModelImplCopyWith<$Res>
    implements $AttachedParkingModelCopyWith<$Res> {
  factory _$$AttachedParkingModelImplCopyWith(
    _$AttachedParkingModelImpl value,
    $Res Function(_$AttachedParkingModelImpl) then,
  ) = __$$AttachedParkingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'platPlc') String? platPlc,
    @JsonKey(name: 'bldNm') String? bldNm,
    @JsonKey(name: 'totPkngCnt') int? totPkngCnt,
    @JsonKey(name: 'curPkngCnt') int? curPkngCnt,
    @JsonKey(name: 'pkngPosblCnt') int? pkngPosblCnt,
    @JsonKey(name: 'useYn') String? useYn,
    @JsonKey(name: 'ngtUseYn') String? ngtUseYn,
    @JsonKey(name: 'feeYn') String? feeYn,
    @JsonKey(name: 'pkngChrg') String? pkngChrg,
    @JsonKey(name: 'oprDay') String? oprDay,
    @JsonKey(name: 'satSttTm') String? satSttTm,
    @JsonKey(name: 'satEndTm') String? satEndTm,
    @JsonKey(name: 'hldSttTm') String? hldSttTm,
    @JsonKey(name: 'hldEndTm') String? hldEndTm,
    @JsonKey(name: 'syncTime') String? syncTime,
    @JsonKey(name: 'institutionCode') String? institutionCode,
    @JsonKey(name: 'institutionName') String? institutionName,
    @JsonKey(name: 'phoneNumber') String? phoneNumber,
  });
}

/// @nodoc
class __$$AttachedParkingModelImplCopyWithImpl<$Res>
    extends _$AttachedParkingModelCopyWithImpl<$Res, _$AttachedParkingModelImpl>
    implements _$$AttachedParkingModelImplCopyWith<$Res> {
  __$$AttachedParkingModelImplCopyWithImpl(
    _$AttachedParkingModelImpl _value,
    $Res Function(_$AttachedParkingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttachedParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platPlc = freezed,
    Object? bldNm = freezed,
    Object? totPkngCnt = freezed,
    Object? curPkngCnt = freezed,
    Object? pkngPosblCnt = freezed,
    Object? useYn = freezed,
    Object? ngtUseYn = freezed,
    Object? feeYn = freezed,
    Object? pkngChrg = freezed,
    Object? oprDay = freezed,
    Object? satSttTm = freezed,
    Object? satEndTm = freezed,
    Object? hldSttTm = freezed,
    Object? hldEndTm = freezed,
    Object? syncTime = freezed,
    Object? institutionCode = freezed,
    Object? institutionName = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(
      _$AttachedParkingModelImpl(
        platPlc:
            freezed == platPlc
                ? _value.platPlc
                : platPlc // ignore: cast_nullable_to_non_nullable
                    as String?,
        bldNm:
            freezed == bldNm
                ? _value.bldNm
                : bldNm // ignore: cast_nullable_to_non_nullable
                    as String?,
        totPkngCnt:
            freezed == totPkngCnt
                ? _value.totPkngCnt
                : totPkngCnt // ignore: cast_nullable_to_non_nullable
                    as int?,
        curPkngCnt:
            freezed == curPkngCnt
                ? _value.curPkngCnt
                : curPkngCnt // ignore: cast_nullable_to_non_nullable
                    as int?,
        pkngPosblCnt:
            freezed == pkngPosblCnt
                ? _value.pkngPosblCnt
                : pkngPosblCnt // ignore: cast_nullable_to_non_nullable
                    as int?,
        useYn:
            freezed == useYn
                ? _value.useYn
                : useYn // ignore: cast_nullable_to_non_nullable
                    as String?,
        ngtUseYn:
            freezed == ngtUseYn
                ? _value.ngtUseYn
                : ngtUseYn // ignore: cast_nullable_to_non_nullable
                    as String?,
        feeYn:
            freezed == feeYn
                ? _value.feeYn
                : feeYn // ignore: cast_nullable_to_non_nullable
                    as String?,
        pkngChrg:
            freezed == pkngChrg
                ? _value.pkngChrg
                : pkngChrg // ignore: cast_nullable_to_non_nullable
                    as String?,
        oprDay:
            freezed == oprDay
                ? _value.oprDay
                : oprDay // ignore: cast_nullable_to_non_nullable
                    as String?,
        satSttTm:
            freezed == satSttTm
                ? _value.satSttTm
                : satSttTm // ignore: cast_nullable_to_non_nullable
                    as String?,
        satEndTm:
            freezed == satEndTm
                ? _value.satEndTm
                : satEndTm // ignore: cast_nullable_to_non_nullable
                    as String?,
        hldSttTm:
            freezed == hldSttTm
                ? _value.hldSttTm
                : hldSttTm // ignore: cast_nullable_to_non_nullable
                    as String?,
        hldEndTm:
            freezed == hldEndTm
                ? _value.hldEndTm
                : hldEndTm // ignore: cast_nullable_to_non_nullable
                    as String?,
        syncTime:
            freezed == syncTime
                ? _value.syncTime
                : syncTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        institutionCode:
            freezed == institutionCode
                ? _value.institutionCode
                : institutionCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        institutionName:
            freezed == institutionName
                ? _value.institutionName
                : institutionName // ignore: cast_nullable_to_non_nullable
                    as String?,
        phoneNumber:
            freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachedParkingModelImpl implements _AttachedParkingModel {
  const _$AttachedParkingModelImpl({
    @JsonKey(name: 'platPlc') this.platPlc,
    @JsonKey(name: 'bldNm') this.bldNm,
    @JsonKey(name: 'totPkngCnt') this.totPkngCnt,
    @JsonKey(name: 'curPkngCnt') this.curPkngCnt,
    @JsonKey(name: 'pkngPosblCnt') this.pkngPosblCnt,
    @JsonKey(name: 'useYn') this.useYn,
    @JsonKey(name: 'ngtUseYn') this.ngtUseYn,
    @JsonKey(name: 'feeYn') this.feeYn,
    @JsonKey(name: 'pkngChrg') this.pkngChrg,
    @JsonKey(name: 'oprDay') this.oprDay,
    @JsonKey(name: 'satSttTm') this.satSttTm,
    @JsonKey(name: 'satEndTm') this.satEndTm,
    @JsonKey(name: 'hldSttTm') this.hldSttTm,
    @JsonKey(name: 'hldEndTm') this.hldEndTm,
    @JsonKey(name: 'syncTime') this.syncTime,
    @JsonKey(name: 'institutionCode') this.institutionCode,
    @JsonKey(name: 'institutionName') this.institutionName,
    @JsonKey(name: 'phoneNumber') this.phoneNumber,
  });

  factory _$AttachedParkingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachedParkingModelImplFromJson(json);

  @override
  @JsonKey(name: 'platPlc')
  final String? platPlc;
  // 소재지(주소)
  @override
  @JsonKey(name: 'bldNm')
  final String? bldNm;
  // 건물명
  @override
  @JsonKey(name: 'totPkngCnt')
  final int? totPkngCnt;
  // 총 주차면수
  @override
  @JsonKey(name: 'curPkngCnt')
  final int? curPkngCnt;
  // 현재 주차대수
  @override
  @JsonKey(name: 'pkngPosblCnt')
  final int? pkngPosblCnt;
  // 주차가능대수
  @override
  @JsonKey(name: 'useYn')
  final String? useYn;
  // 사용여부
  @override
  @JsonKey(name: 'ngtUseYn')
  final String? ngtUseYn;
  // 야간사용여부
  @override
  @JsonKey(name: 'feeYn')
  final String? feeYn;
  // 유료여부
  @override
  @JsonKey(name: 'pkngChrg')
  final String? pkngChrg;
  // 주차요금
  @override
  @JsonKey(name: 'oprDay')
  final String? oprDay;
  // 운영요일
  @override
  @JsonKey(name: 'satSttTm')
  final String? satSttTm;
  // 토요일시작시간
  @override
  @JsonKey(name: 'satEndTm')
  final String? satEndTm;
  // 토요일종료시간
  @override
  @JsonKey(name: 'hldSttTm')
  final String? hldSttTm;
  // 공휴일시작시간
  @override
  @JsonKey(name: 'hldEndTm')
  final String? hldEndTm;
  // 공휴일종료시간
  @override
  @JsonKey(name: 'syncTime')
  final String? syncTime;
  // 동기화시간
  @override
  @JsonKey(name: 'institutionCode')
  final String? institutionCode;
  // 기관코드
  @override
  @JsonKey(name: 'institutionName')
  final String? institutionName;
  // 기관명
  @override
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;

  @override
  String toString() {
    return 'AttachedParkingModel(platPlc: $platPlc, bldNm: $bldNm, totPkngCnt: $totPkngCnt, curPkngCnt: $curPkngCnt, pkngPosblCnt: $pkngPosblCnt, useYn: $useYn, ngtUseYn: $ngtUseYn, feeYn: $feeYn, pkngChrg: $pkngChrg, oprDay: $oprDay, satSttTm: $satSttTm, satEndTm: $satEndTm, hldSttTm: $hldSttTm, hldEndTm: $hldEndTm, syncTime: $syncTime, institutionCode: $institutionCode, institutionName: $institutionName, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachedParkingModelImpl &&
            (identical(other.platPlc, platPlc) || other.platPlc == platPlc) &&
            (identical(other.bldNm, bldNm) || other.bldNm == bldNm) &&
            (identical(other.totPkngCnt, totPkngCnt) ||
                other.totPkngCnt == totPkngCnt) &&
            (identical(other.curPkngCnt, curPkngCnt) ||
                other.curPkngCnt == curPkngCnt) &&
            (identical(other.pkngPosblCnt, pkngPosblCnt) ||
                other.pkngPosblCnt == pkngPosblCnt) &&
            (identical(other.useYn, useYn) || other.useYn == useYn) &&
            (identical(other.ngtUseYn, ngtUseYn) ||
                other.ngtUseYn == ngtUseYn) &&
            (identical(other.feeYn, feeYn) || other.feeYn == feeYn) &&
            (identical(other.pkngChrg, pkngChrg) ||
                other.pkngChrg == pkngChrg) &&
            (identical(other.oprDay, oprDay) || other.oprDay == oprDay) &&
            (identical(other.satSttTm, satSttTm) ||
                other.satSttTm == satSttTm) &&
            (identical(other.satEndTm, satEndTm) ||
                other.satEndTm == satEndTm) &&
            (identical(other.hldSttTm, hldSttTm) ||
                other.hldSttTm == hldSttTm) &&
            (identical(other.hldEndTm, hldEndTm) ||
                other.hldEndTm == hldEndTm) &&
            (identical(other.syncTime, syncTime) ||
                other.syncTime == syncTime) &&
            (identical(other.institutionCode, institutionCode) ||
                other.institutionCode == institutionCode) &&
            (identical(other.institutionName, institutionName) ||
                other.institutionName == institutionName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    platPlc,
    bldNm,
    totPkngCnt,
    curPkngCnt,
    pkngPosblCnt,
    useYn,
    ngtUseYn,
    feeYn,
    pkngChrg,
    oprDay,
    satSttTm,
    satEndTm,
    hldSttTm,
    hldEndTm,
    syncTime,
    institutionCode,
    institutionName,
    phoneNumber,
  );

  /// Create a copy of AttachedParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachedParkingModelImplCopyWith<_$AttachedParkingModelImpl>
  get copyWith =>
      __$$AttachedParkingModelImplCopyWithImpl<_$AttachedParkingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachedParkingModelImplToJson(this);
  }
}

abstract class _AttachedParkingModel implements AttachedParkingModel {
  const factory _AttachedParkingModel({
    @JsonKey(name: 'platPlc') final String? platPlc,
    @JsonKey(name: 'bldNm') final String? bldNm,
    @JsonKey(name: 'totPkngCnt') final int? totPkngCnt,
    @JsonKey(name: 'curPkngCnt') final int? curPkngCnt,
    @JsonKey(name: 'pkngPosblCnt') final int? pkngPosblCnt,
    @JsonKey(name: 'useYn') final String? useYn,
    @JsonKey(name: 'ngtUseYn') final String? ngtUseYn,
    @JsonKey(name: 'feeYn') final String? feeYn,
    @JsonKey(name: 'pkngChrg') final String? pkngChrg,
    @JsonKey(name: 'oprDay') final String? oprDay,
    @JsonKey(name: 'satSttTm') final String? satSttTm,
    @JsonKey(name: 'satEndTm') final String? satEndTm,
    @JsonKey(name: 'hldSttTm') final String? hldSttTm,
    @JsonKey(name: 'hldEndTm') final String? hldEndTm,
    @JsonKey(name: 'syncTime') final String? syncTime,
    @JsonKey(name: 'institutionCode') final String? institutionCode,
    @JsonKey(name: 'institutionName') final String? institutionName,
    @JsonKey(name: 'phoneNumber') final String? phoneNumber,
  }) = _$AttachedParkingModelImpl;

  factory _AttachedParkingModel.fromJson(Map<String, dynamic> json) =
      _$AttachedParkingModelImpl.fromJson;

  @override
  @JsonKey(name: 'platPlc')
  String? get platPlc; // 소재지(주소)
  @override
  @JsonKey(name: 'bldNm')
  String? get bldNm; // 건물명
  @override
  @JsonKey(name: 'totPkngCnt')
  int? get totPkngCnt; // 총 주차면수
  @override
  @JsonKey(name: 'curPkngCnt')
  int? get curPkngCnt; // 현재 주차대수
  @override
  @JsonKey(name: 'pkngPosblCnt')
  int? get pkngPosblCnt; // 주차가능대수
  @override
  @JsonKey(name: 'useYn')
  String? get useYn; // 사용여부
  @override
  @JsonKey(name: 'ngtUseYn')
  String? get ngtUseYn; // 야간사용여부
  @override
  @JsonKey(name: 'feeYn')
  String? get feeYn; // 유료여부
  @override
  @JsonKey(name: 'pkngChrg')
  String? get pkngChrg; // 주차요금
  @override
  @JsonKey(name: 'oprDay')
  String? get oprDay; // 운영요일
  @override
  @JsonKey(name: 'satSttTm')
  String? get satSttTm; // 토요일시작시간
  @override
  @JsonKey(name: 'satEndTm')
  String? get satEndTm; // 토요일종료시간
  @override
  @JsonKey(name: 'hldSttTm')
  String? get hldSttTm; // 공휴일시작시간
  @override
  @JsonKey(name: 'hldEndTm')
  String? get hldEndTm; // 공휴일종료시간
  @override
  @JsonKey(name: 'syncTime')
  String? get syncTime; // 동기화시간
  @override
  @JsonKey(name: 'institutionCode')
  String? get institutionCode; // 기관코드
  @override
  @JsonKey(name: 'institutionName')
  String? get institutionName; // 기관명
  @override
  @JsonKey(name: 'phoneNumber')
  String? get phoneNumber;

  /// Create a copy of AttachedParkingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachedParkingModelImplCopyWith<_$AttachedParkingModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
