// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parking_analysis_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ParkingAnalysisModel _$ParkingAnalysisModelFromJson(Map<String, dynamic> json) {
  return _ParkingAnalysisModel.fromJson(json);
}

/// @nodoc
mixin _$ParkingAnalysisModel {
  /// 건축년도 (2000년대 이후 → 철골데크 가능성 높음)
  int get buildYear => throw _privateConstructorUsedError;

  /// 층수 (3층 이상 → 철골데크 적합)
  int get floors => throw _privateConstructorUsedError;

  /// 연면적 (넓은 면적 → 철골데크 선호)
  double get area => throw _privateConstructorUsedError;

  /// 건축물 용도 (상업지역 → 철골데크 가능성)
  String get buildingUse => throw _privateConstructorUsedError;

  /// 구조형식 (철골구조, 철근콘크리트구조 등)
  String get structureType => throw _privateConstructorUsedError;

  /// 지역 구분 (상업지역, 공업지역 등)
  String get location => throw _privateConstructorUsedError;

  /// 철골데크 확률 (0.0 ~ 1.0)
  double get steelDeckProbability => throw _privateConstructorUsedError;

  /// 건축물 주소
  String get address => throw _privateConstructorUsedError;

  /// 건축물 명칭
  String? get buildingName => throw _privateConstructorUsedError;

  /// 건축허가일
  String? get permitDate => throw _privateConstructorUsedError;

  /// 사용승인일
  String? get approvalDate => throw _privateConstructorUsedError;

  /// 대지면적
  double? get landArea => throw _privateConstructorUsedError;

  /// 건폐율
  double? get buildingCoverageRatio => throw _privateConstructorUsedError;

  /// 용적률
  double? get floorAreaRatio => throw _privateConstructorUsedError;

  /// 지상층수
  int? get groundFloors => throw _privateConstructorUsedError;

  /// 지하층수
  int? get undergroundFloors => throw _privateConstructorUsedError;

  /// 분석 일시
  DateTime? get analysisDateTime => throw _privateConstructorUsedError;

  /// Serializes this ParkingAnalysisModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParkingAnalysisModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParkingAnalysisModelCopyWith<ParkingAnalysisModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParkingAnalysisModelCopyWith<$Res> {
  factory $ParkingAnalysisModelCopyWith(
    ParkingAnalysisModel value,
    $Res Function(ParkingAnalysisModel) then,
  ) = _$ParkingAnalysisModelCopyWithImpl<$Res, ParkingAnalysisModel>;
  @useResult
  $Res call({
    int buildYear,
    int floors,
    double area,
    String buildingUse,
    String structureType,
    String location,
    double steelDeckProbability,
    String address,
    String? buildingName,
    String? permitDate,
    String? approvalDate,
    double? landArea,
    double? buildingCoverageRatio,
    double? floorAreaRatio,
    int? groundFloors,
    int? undergroundFloors,
    DateTime? analysisDateTime,
  });
}

/// @nodoc
class _$ParkingAnalysisModelCopyWithImpl<
  $Res,
  $Val extends ParkingAnalysisModel
>
    implements $ParkingAnalysisModelCopyWith<$Res> {
  _$ParkingAnalysisModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParkingAnalysisModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildYear = null,
    Object? floors = null,
    Object? area = null,
    Object? buildingUse = null,
    Object? structureType = null,
    Object? location = null,
    Object? steelDeckProbability = null,
    Object? address = null,
    Object? buildingName = freezed,
    Object? permitDate = freezed,
    Object? approvalDate = freezed,
    Object? landArea = freezed,
    Object? buildingCoverageRatio = freezed,
    Object? floorAreaRatio = freezed,
    Object? groundFloors = freezed,
    Object? undergroundFloors = freezed,
    Object? analysisDateTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            buildYear:
                null == buildYear
                    ? _value.buildYear
                    : buildYear // ignore: cast_nullable_to_non_nullable
                        as int,
            floors:
                null == floors
                    ? _value.floors
                    : floors // ignore: cast_nullable_to_non_nullable
                        as int,
            area:
                null == area
                    ? _value.area
                    : area // ignore: cast_nullable_to_non_nullable
                        as double,
            buildingUse:
                null == buildingUse
                    ? _value.buildingUse
                    : buildingUse // ignore: cast_nullable_to_non_nullable
                        as String,
            structureType:
                null == structureType
                    ? _value.structureType
                    : structureType // ignore: cast_nullable_to_non_nullable
                        as String,
            location:
                null == location
                    ? _value.location
                    : location // ignore: cast_nullable_to_non_nullable
                        as String,
            steelDeckProbability:
                null == steelDeckProbability
                    ? _value.steelDeckProbability
                    : steelDeckProbability // ignore: cast_nullable_to_non_nullable
                        as double,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            buildingName:
                freezed == buildingName
                    ? _value.buildingName
                    : buildingName // ignore: cast_nullable_to_non_nullable
                        as String?,
            permitDate:
                freezed == permitDate
                    ? _value.permitDate
                    : permitDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            approvalDate:
                freezed == approvalDate
                    ? _value.approvalDate
                    : approvalDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            landArea:
                freezed == landArea
                    ? _value.landArea
                    : landArea // ignore: cast_nullable_to_non_nullable
                        as double?,
            buildingCoverageRatio:
                freezed == buildingCoverageRatio
                    ? _value.buildingCoverageRatio
                    : buildingCoverageRatio // ignore: cast_nullable_to_non_nullable
                        as double?,
            floorAreaRatio:
                freezed == floorAreaRatio
                    ? _value.floorAreaRatio
                    : floorAreaRatio // ignore: cast_nullable_to_non_nullable
                        as double?,
            groundFloors:
                freezed == groundFloors
                    ? _value.groundFloors
                    : groundFloors // ignore: cast_nullable_to_non_nullable
                        as int?,
            undergroundFloors:
                freezed == undergroundFloors
                    ? _value.undergroundFloors
                    : undergroundFloors // ignore: cast_nullable_to_non_nullable
                        as int?,
            analysisDateTime:
                freezed == analysisDateTime
                    ? _value.analysisDateTime
                    : analysisDateTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParkingAnalysisModelImplCopyWith<$Res>
    implements $ParkingAnalysisModelCopyWith<$Res> {
  factory _$$ParkingAnalysisModelImplCopyWith(
    _$ParkingAnalysisModelImpl value,
    $Res Function(_$ParkingAnalysisModelImpl) then,
  ) = __$$ParkingAnalysisModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int buildYear,
    int floors,
    double area,
    String buildingUse,
    String structureType,
    String location,
    double steelDeckProbability,
    String address,
    String? buildingName,
    String? permitDate,
    String? approvalDate,
    double? landArea,
    double? buildingCoverageRatio,
    double? floorAreaRatio,
    int? groundFloors,
    int? undergroundFloors,
    DateTime? analysisDateTime,
  });
}

/// @nodoc
class __$$ParkingAnalysisModelImplCopyWithImpl<$Res>
    extends _$ParkingAnalysisModelCopyWithImpl<$Res, _$ParkingAnalysisModelImpl>
    implements _$$ParkingAnalysisModelImplCopyWith<$Res> {
  __$$ParkingAnalysisModelImplCopyWithImpl(
    _$ParkingAnalysisModelImpl _value,
    $Res Function(_$ParkingAnalysisModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParkingAnalysisModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildYear = null,
    Object? floors = null,
    Object? area = null,
    Object? buildingUse = null,
    Object? structureType = null,
    Object? location = null,
    Object? steelDeckProbability = null,
    Object? address = null,
    Object? buildingName = freezed,
    Object? permitDate = freezed,
    Object? approvalDate = freezed,
    Object? landArea = freezed,
    Object? buildingCoverageRatio = freezed,
    Object? floorAreaRatio = freezed,
    Object? groundFloors = freezed,
    Object? undergroundFloors = freezed,
    Object? analysisDateTime = freezed,
  }) {
    return _then(
      _$ParkingAnalysisModelImpl(
        buildYear:
            null == buildYear
                ? _value.buildYear
                : buildYear // ignore: cast_nullable_to_non_nullable
                    as int,
        floors:
            null == floors
                ? _value.floors
                : floors // ignore: cast_nullable_to_non_nullable
                    as int,
        area:
            null == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                    as double,
        buildingUse:
            null == buildingUse
                ? _value.buildingUse
                : buildingUse // ignore: cast_nullable_to_non_nullable
                    as String,
        structureType:
            null == structureType
                ? _value.structureType
                : structureType // ignore: cast_nullable_to_non_nullable
                    as String,
        location:
            null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                    as String,
        steelDeckProbability:
            null == steelDeckProbability
                ? _value.steelDeckProbability
                : steelDeckProbability // ignore: cast_nullable_to_non_nullable
                    as double,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        buildingName:
            freezed == buildingName
                ? _value.buildingName
                : buildingName // ignore: cast_nullable_to_non_nullable
                    as String?,
        permitDate:
            freezed == permitDate
                ? _value.permitDate
                : permitDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        approvalDate:
            freezed == approvalDate
                ? _value.approvalDate
                : approvalDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        landArea:
            freezed == landArea
                ? _value.landArea
                : landArea // ignore: cast_nullable_to_non_nullable
                    as double?,
        buildingCoverageRatio:
            freezed == buildingCoverageRatio
                ? _value.buildingCoverageRatio
                : buildingCoverageRatio // ignore: cast_nullable_to_non_nullable
                    as double?,
        floorAreaRatio:
            freezed == floorAreaRatio
                ? _value.floorAreaRatio
                : floorAreaRatio // ignore: cast_nullable_to_non_nullable
                    as double?,
        groundFloors:
            freezed == groundFloors
                ? _value.groundFloors
                : groundFloors // ignore: cast_nullable_to_non_nullable
                    as int?,
        undergroundFloors:
            freezed == undergroundFloors
                ? _value.undergroundFloors
                : undergroundFloors // ignore: cast_nullable_to_non_nullable
                    as int?,
        analysisDateTime:
            freezed == analysisDateTime
                ? _value.analysisDateTime
                : analysisDateTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParkingAnalysisModelImpl implements _ParkingAnalysisModel {
  const _$ParkingAnalysisModelImpl({
    required this.buildYear,
    required this.floors,
    required this.area,
    required this.buildingUse,
    required this.structureType,
    required this.location,
    required this.steelDeckProbability,
    required this.address,
    this.buildingName,
    this.permitDate,
    this.approvalDate,
    this.landArea,
    this.buildingCoverageRatio,
    this.floorAreaRatio,
    this.groundFloors,
    this.undergroundFloors,
    this.analysisDateTime,
  });

  factory _$ParkingAnalysisModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParkingAnalysisModelImplFromJson(json);

  /// 건축년도 (2000년대 이후 → 철골데크 가능성 높음)
  @override
  final int buildYear;

  /// 층수 (3층 이상 → 철골데크 적합)
  @override
  final int floors;

  /// 연면적 (넓은 면적 → 철골데크 선호)
  @override
  final double area;

  /// 건축물 용도 (상업지역 → 철골데크 가능성)
  @override
  final String buildingUse;

  /// 구조형식 (철골구조, 철근콘크리트구조 등)
  @override
  final String structureType;

  /// 지역 구분 (상업지역, 공업지역 등)
  @override
  final String location;

  /// 철골데크 확률 (0.0 ~ 1.0)
  @override
  final double steelDeckProbability;

  /// 건축물 주소
  @override
  final String address;

  /// 건축물 명칭
  @override
  final String? buildingName;

  /// 건축허가일
  @override
  final String? permitDate;

  /// 사용승인일
  @override
  final String? approvalDate;

  /// 대지면적
  @override
  final double? landArea;

  /// 건폐율
  @override
  final double? buildingCoverageRatio;

  /// 용적률
  @override
  final double? floorAreaRatio;

  /// 지상층수
  @override
  final int? groundFloors;

  /// 지하층수
  @override
  final int? undergroundFloors;

  /// 분석 일시
  @override
  final DateTime? analysisDateTime;

  @override
  String toString() {
    return 'ParkingAnalysisModel(buildYear: $buildYear, floors: $floors, area: $area, buildingUse: $buildingUse, structureType: $structureType, location: $location, steelDeckProbability: $steelDeckProbability, address: $address, buildingName: $buildingName, permitDate: $permitDate, approvalDate: $approvalDate, landArea: $landArea, buildingCoverageRatio: $buildingCoverageRatio, floorAreaRatio: $floorAreaRatio, groundFloors: $groundFloors, undergroundFloors: $undergroundFloors, analysisDateTime: $analysisDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParkingAnalysisModelImpl &&
            (identical(other.buildYear, buildYear) ||
                other.buildYear == buildYear) &&
            (identical(other.floors, floors) || other.floors == floors) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.buildingUse, buildingUse) ||
                other.buildingUse == buildingUse) &&
            (identical(other.structureType, structureType) ||
                other.structureType == structureType) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.steelDeckProbability, steelDeckProbability) ||
                other.steelDeckProbability == steelDeckProbability) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.buildingName, buildingName) ||
                other.buildingName == buildingName) &&
            (identical(other.permitDate, permitDate) ||
                other.permitDate == permitDate) &&
            (identical(other.approvalDate, approvalDate) ||
                other.approvalDate == approvalDate) &&
            (identical(other.landArea, landArea) ||
                other.landArea == landArea) &&
            (identical(other.buildingCoverageRatio, buildingCoverageRatio) ||
                other.buildingCoverageRatio == buildingCoverageRatio) &&
            (identical(other.floorAreaRatio, floorAreaRatio) ||
                other.floorAreaRatio == floorAreaRatio) &&
            (identical(other.groundFloors, groundFloors) ||
                other.groundFloors == groundFloors) &&
            (identical(other.undergroundFloors, undergroundFloors) ||
                other.undergroundFloors == undergroundFloors) &&
            (identical(other.analysisDateTime, analysisDateTime) ||
                other.analysisDateTime == analysisDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    buildYear,
    floors,
    area,
    buildingUse,
    structureType,
    location,
    steelDeckProbability,
    address,
    buildingName,
    permitDate,
    approvalDate,
    landArea,
    buildingCoverageRatio,
    floorAreaRatio,
    groundFloors,
    undergroundFloors,
    analysisDateTime,
  );

  /// Create a copy of ParkingAnalysisModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParkingAnalysisModelImplCopyWith<_$ParkingAnalysisModelImpl>
  get copyWith =>
      __$$ParkingAnalysisModelImplCopyWithImpl<_$ParkingAnalysisModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParkingAnalysisModelImplToJson(this);
  }
}

abstract class _ParkingAnalysisModel implements ParkingAnalysisModel {
  const factory _ParkingAnalysisModel({
    required final int buildYear,
    required final int floors,
    required final double area,
    required final String buildingUse,
    required final String structureType,
    required final String location,
    required final double steelDeckProbability,
    required final String address,
    final String? buildingName,
    final String? permitDate,
    final String? approvalDate,
    final double? landArea,
    final double? buildingCoverageRatio,
    final double? floorAreaRatio,
    final int? groundFloors,
    final int? undergroundFloors,
    final DateTime? analysisDateTime,
  }) = _$ParkingAnalysisModelImpl;

  factory _ParkingAnalysisModel.fromJson(Map<String, dynamic> json) =
      _$ParkingAnalysisModelImpl.fromJson;

  /// 건축년도 (2000년대 이후 → 철골데크 가능성 높음)
  @override
  int get buildYear;

  /// 층수 (3층 이상 → 철골데크 적합)
  @override
  int get floors;

  /// 연면적 (넓은 면적 → 철골데크 선호)
  @override
  double get area;

  /// 건축물 용도 (상업지역 → 철골데크 가능성)
  @override
  String get buildingUse;

  /// 구조형식 (철골구조, 철근콘크리트구조 등)
  @override
  String get structureType;

  /// 지역 구분 (상업지역, 공업지역 등)
  @override
  String get location;

  /// 철골데크 확률 (0.0 ~ 1.0)
  @override
  double get steelDeckProbability;

  /// 건축물 주소
  @override
  String get address;

  /// 건축물 명칭
  @override
  String? get buildingName;

  /// 건축허가일
  @override
  String? get permitDate;

  /// 사용승인일
  @override
  String? get approvalDate;

  /// 대지면적
  @override
  double? get landArea;

  /// 건폐율
  @override
  double? get buildingCoverageRatio;

  /// 용적률
  @override
  double? get floorAreaRatio;

  /// 지상층수
  @override
  int? get groundFloors;

  /// 지하층수
  @override
  int? get undergroundFloors;

  /// 분석 일시
  @override
  DateTime? get analysisDateTime;

  /// Create a copy of ParkingAnalysisModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParkingAnalysisModelImplCopyWith<_$ParkingAnalysisModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StructureAnalysisResult _$StructureAnalysisResultFromJson(
  Map<String, dynamic> json,
) {
  return _StructureAnalysisResult.fromJson(json);
}

/// @nodoc
mixin _$StructureAnalysisResult {
  /// 철골데크 확률 점수
  double get probability => throw _privateConstructorUsedError;

  /// 분석 상세 점수
  AnalysisScoreDetails get scoreDetails => throw _privateConstructorUsedError;

  /// 추천 여부
  bool get isRecommended => throw _privateConstructorUsedError;

  /// 신뢰도 (0.0 ~ 1.0)
  double get confidence => throw _privateConstructorUsedError;

  /// 분석 결과 설명
  String get explanation => throw _privateConstructorUsedError;

  /// 위험 요소들
  List<String> get riskFactors => throw _privateConstructorUsedError;

  /// 장점들
  List<String> get advantages => throw _privateConstructorUsedError;

  /// Serializes this StructureAnalysisResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StructureAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StructureAnalysisResultCopyWith<StructureAnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StructureAnalysisResultCopyWith<$Res> {
  factory $StructureAnalysisResultCopyWith(
    StructureAnalysisResult value,
    $Res Function(StructureAnalysisResult) then,
  ) = _$StructureAnalysisResultCopyWithImpl<$Res, StructureAnalysisResult>;
  @useResult
  $Res call({
    double probability,
    AnalysisScoreDetails scoreDetails,
    bool isRecommended,
    double confidence,
    String explanation,
    List<String> riskFactors,
    List<String> advantages,
  });

  $AnalysisScoreDetailsCopyWith<$Res> get scoreDetails;
}

/// @nodoc
class _$StructureAnalysisResultCopyWithImpl<
  $Res,
  $Val extends StructureAnalysisResult
>
    implements $StructureAnalysisResultCopyWith<$Res> {
  _$StructureAnalysisResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StructureAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? probability = null,
    Object? scoreDetails = null,
    Object? isRecommended = null,
    Object? confidence = null,
    Object? explanation = null,
    Object? riskFactors = null,
    Object? advantages = null,
  }) {
    return _then(
      _value.copyWith(
            probability:
                null == probability
                    ? _value.probability
                    : probability // ignore: cast_nullable_to_non_nullable
                        as double,
            scoreDetails:
                null == scoreDetails
                    ? _value.scoreDetails
                    : scoreDetails // ignore: cast_nullable_to_non_nullable
                        as AnalysisScoreDetails,
            isRecommended:
                null == isRecommended
                    ? _value.isRecommended
                    : isRecommended // ignore: cast_nullable_to_non_nullable
                        as bool,
            confidence:
                null == confidence
                    ? _value.confidence
                    : confidence // ignore: cast_nullable_to_non_nullable
                        as double,
            explanation:
                null == explanation
                    ? _value.explanation
                    : explanation // ignore: cast_nullable_to_non_nullable
                        as String,
            riskFactors:
                null == riskFactors
                    ? _value.riskFactors
                    : riskFactors // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            advantages:
                null == advantages
                    ? _value.advantages
                    : advantages // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of StructureAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalysisScoreDetailsCopyWith<$Res> get scoreDetails {
    return $AnalysisScoreDetailsCopyWith<$Res>(_value.scoreDetails, (value) {
      return _then(_value.copyWith(scoreDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StructureAnalysisResultImplCopyWith<$Res>
    implements $StructureAnalysisResultCopyWith<$Res> {
  factory _$$StructureAnalysisResultImplCopyWith(
    _$StructureAnalysisResultImpl value,
    $Res Function(_$StructureAnalysisResultImpl) then,
  ) = __$$StructureAnalysisResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double probability,
    AnalysisScoreDetails scoreDetails,
    bool isRecommended,
    double confidence,
    String explanation,
    List<String> riskFactors,
    List<String> advantages,
  });

  @override
  $AnalysisScoreDetailsCopyWith<$Res> get scoreDetails;
}

/// @nodoc
class __$$StructureAnalysisResultImplCopyWithImpl<$Res>
    extends
        _$StructureAnalysisResultCopyWithImpl<
          $Res,
          _$StructureAnalysisResultImpl
        >
    implements _$$StructureAnalysisResultImplCopyWith<$Res> {
  __$$StructureAnalysisResultImplCopyWithImpl(
    _$StructureAnalysisResultImpl _value,
    $Res Function(_$StructureAnalysisResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StructureAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? probability = null,
    Object? scoreDetails = null,
    Object? isRecommended = null,
    Object? confidence = null,
    Object? explanation = null,
    Object? riskFactors = null,
    Object? advantages = null,
  }) {
    return _then(
      _$StructureAnalysisResultImpl(
        probability:
            null == probability
                ? _value.probability
                : probability // ignore: cast_nullable_to_non_nullable
                    as double,
        scoreDetails:
            null == scoreDetails
                ? _value.scoreDetails
                : scoreDetails // ignore: cast_nullable_to_non_nullable
                    as AnalysisScoreDetails,
        isRecommended:
            null == isRecommended
                ? _value.isRecommended
                : isRecommended // ignore: cast_nullable_to_non_nullable
                    as bool,
        confidence:
            null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                    as double,
        explanation:
            null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                    as String,
        riskFactors:
            null == riskFactors
                ? _value._riskFactors
                : riskFactors // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        advantages:
            null == advantages
                ? _value._advantages
                : advantages // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StructureAnalysisResultImpl implements _StructureAnalysisResult {
  const _$StructureAnalysisResultImpl({
    required this.probability,
    required this.scoreDetails,
    required this.isRecommended,
    required this.confidence,
    required this.explanation,
    required final List<String> riskFactors,
    required final List<String> advantages,
  }) : _riskFactors = riskFactors,
       _advantages = advantages;

  factory _$StructureAnalysisResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$StructureAnalysisResultImplFromJson(json);

  /// 철골데크 확률 점수
  @override
  final double probability;

  /// 분석 상세 점수
  @override
  final AnalysisScoreDetails scoreDetails;

  /// 추천 여부
  @override
  final bool isRecommended;

  /// 신뢰도 (0.0 ~ 1.0)
  @override
  final double confidence;

  /// 분석 결과 설명
  @override
  final String explanation;

  /// 위험 요소들
  final List<String> _riskFactors;

  /// 위험 요소들
  @override
  List<String> get riskFactors {
    if (_riskFactors is EqualUnmodifiableListView) return _riskFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_riskFactors);
  }

  /// 장점들
  final List<String> _advantages;

  /// 장점들
  @override
  List<String> get advantages {
    if (_advantages is EqualUnmodifiableListView) return _advantages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_advantages);
  }

  @override
  String toString() {
    return 'StructureAnalysisResult(probability: $probability, scoreDetails: $scoreDetails, isRecommended: $isRecommended, confidence: $confidence, explanation: $explanation, riskFactors: $riskFactors, advantages: $advantages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StructureAnalysisResultImpl &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.scoreDetails, scoreDetails) ||
                other.scoreDetails == scoreDetails) &&
            (identical(other.isRecommended, isRecommended) ||
                other.isRecommended == isRecommended) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            const DeepCollectionEquality().equals(
              other._riskFactors,
              _riskFactors,
            ) &&
            const DeepCollectionEquality().equals(
              other._advantages,
              _advantages,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    probability,
    scoreDetails,
    isRecommended,
    confidence,
    explanation,
    const DeepCollectionEquality().hash(_riskFactors),
    const DeepCollectionEquality().hash(_advantages),
  );

  /// Create a copy of StructureAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StructureAnalysisResultImplCopyWith<_$StructureAnalysisResultImpl>
  get copyWith => __$$StructureAnalysisResultImplCopyWithImpl<
    _$StructureAnalysisResultImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StructureAnalysisResultImplToJson(this);
  }
}

abstract class _StructureAnalysisResult implements StructureAnalysisResult {
  const factory _StructureAnalysisResult({
    required final double probability,
    required final AnalysisScoreDetails scoreDetails,
    required final bool isRecommended,
    required final double confidence,
    required final String explanation,
    required final List<String> riskFactors,
    required final List<String> advantages,
  }) = _$StructureAnalysisResultImpl;

  factory _StructureAnalysisResult.fromJson(Map<String, dynamic> json) =
      _$StructureAnalysisResultImpl.fromJson;

  /// 철골데크 확률 점수
  @override
  double get probability;

  /// 분석 상세 점수
  @override
  AnalysisScoreDetails get scoreDetails;

  /// 추천 여부
  @override
  bool get isRecommended;

  /// 신뢰도 (0.0 ~ 1.0)
  @override
  double get confidence;

  /// 분석 결과 설명
  @override
  String get explanation;

  /// 위험 요소들
  @override
  List<String> get riskFactors;

  /// 장점들
  @override
  List<String> get advantages;

  /// Create a copy of StructureAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StructureAnalysisResultImplCopyWith<_$StructureAnalysisResultImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AnalysisScoreDetails _$AnalysisScoreDetailsFromJson(Map<String, dynamic> json) {
  return _AnalysisScoreDetails.fromJson(json);
}

/// @nodoc
mixin _$AnalysisScoreDetails {
  /// 건축년도 점수 (0.0 ~ 0.3)
  double get buildYearScore => throw _privateConstructorUsedError;

  /// 층수 점수 (0.0 ~ 0.4)
  double get floorsScore => throw _privateConstructorUsedError;

  /// 면적 점수 (0.0 ~ 0.2)
  double get areaScore => throw _privateConstructorUsedError;

  /// 구조형식 점수 (0.0 ~ 0.1)
  double get structureTypeScore => throw _privateConstructorUsedError;

  /// 건축물 용도 점수 (0.0 ~ 0.1)
  double get buildingUseScore => throw _privateConstructorUsedError;

  /// 총 점수
  double get totalScore => throw _privateConstructorUsedError;

  /// Serializes this AnalysisScoreDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalysisScoreDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalysisScoreDetailsCopyWith<AnalysisScoreDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisScoreDetailsCopyWith<$Res> {
  factory $AnalysisScoreDetailsCopyWith(
    AnalysisScoreDetails value,
    $Res Function(AnalysisScoreDetails) then,
  ) = _$AnalysisScoreDetailsCopyWithImpl<$Res, AnalysisScoreDetails>;
  @useResult
  $Res call({
    double buildYearScore,
    double floorsScore,
    double areaScore,
    double structureTypeScore,
    double buildingUseScore,
    double totalScore,
  });
}

/// @nodoc
class _$AnalysisScoreDetailsCopyWithImpl<
  $Res,
  $Val extends AnalysisScoreDetails
>
    implements $AnalysisScoreDetailsCopyWith<$Res> {
  _$AnalysisScoreDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalysisScoreDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildYearScore = null,
    Object? floorsScore = null,
    Object? areaScore = null,
    Object? structureTypeScore = null,
    Object? buildingUseScore = null,
    Object? totalScore = null,
  }) {
    return _then(
      _value.copyWith(
            buildYearScore:
                null == buildYearScore
                    ? _value.buildYearScore
                    : buildYearScore // ignore: cast_nullable_to_non_nullable
                        as double,
            floorsScore:
                null == floorsScore
                    ? _value.floorsScore
                    : floorsScore // ignore: cast_nullable_to_non_nullable
                        as double,
            areaScore:
                null == areaScore
                    ? _value.areaScore
                    : areaScore // ignore: cast_nullable_to_non_nullable
                        as double,
            structureTypeScore:
                null == structureTypeScore
                    ? _value.structureTypeScore
                    : structureTypeScore // ignore: cast_nullable_to_non_nullable
                        as double,
            buildingUseScore:
                null == buildingUseScore
                    ? _value.buildingUseScore
                    : buildingUseScore // ignore: cast_nullable_to_non_nullable
                        as double,
            totalScore:
                null == totalScore
                    ? _value.totalScore
                    : totalScore // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalysisScoreDetailsImplCopyWith<$Res>
    implements $AnalysisScoreDetailsCopyWith<$Res> {
  factory _$$AnalysisScoreDetailsImplCopyWith(
    _$AnalysisScoreDetailsImpl value,
    $Res Function(_$AnalysisScoreDetailsImpl) then,
  ) = __$$AnalysisScoreDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double buildYearScore,
    double floorsScore,
    double areaScore,
    double structureTypeScore,
    double buildingUseScore,
    double totalScore,
  });
}

/// @nodoc
class __$$AnalysisScoreDetailsImplCopyWithImpl<$Res>
    extends _$AnalysisScoreDetailsCopyWithImpl<$Res, _$AnalysisScoreDetailsImpl>
    implements _$$AnalysisScoreDetailsImplCopyWith<$Res> {
  __$$AnalysisScoreDetailsImplCopyWithImpl(
    _$AnalysisScoreDetailsImpl _value,
    $Res Function(_$AnalysisScoreDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalysisScoreDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildYearScore = null,
    Object? floorsScore = null,
    Object? areaScore = null,
    Object? structureTypeScore = null,
    Object? buildingUseScore = null,
    Object? totalScore = null,
  }) {
    return _then(
      _$AnalysisScoreDetailsImpl(
        buildYearScore:
            null == buildYearScore
                ? _value.buildYearScore
                : buildYearScore // ignore: cast_nullable_to_non_nullable
                    as double,
        floorsScore:
            null == floorsScore
                ? _value.floorsScore
                : floorsScore // ignore: cast_nullable_to_non_nullable
                    as double,
        areaScore:
            null == areaScore
                ? _value.areaScore
                : areaScore // ignore: cast_nullable_to_non_nullable
                    as double,
        structureTypeScore:
            null == structureTypeScore
                ? _value.structureTypeScore
                : structureTypeScore // ignore: cast_nullable_to_non_nullable
                    as double,
        buildingUseScore:
            null == buildingUseScore
                ? _value.buildingUseScore
                : buildingUseScore // ignore: cast_nullable_to_non_nullable
                    as double,
        totalScore:
            null == totalScore
                ? _value.totalScore
                : totalScore // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalysisScoreDetailsImpl implements _AnalysisScoreDetails {
  const _$AnalysisScoreDetailsImpl({
    required this.buildYearScore,
    required this.floorsScore,
    required this.areaScore,
    required this.structureTypeScore,
    required this.buildingUseScore,
    required this.totalScore,
  });

  factory _$AnalysisScoreDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalysisScoreDetailsImplFromJson(json);

  /// 건축년도 점수 (0.0 ~ 0.3)
  @override
  final double buildYearScore;

  /// 층수 점수 (0.0 ~ 0.4)
  @override
  final double floorsScore;

  /// 면적 점수 (0.0 ~ 0.2)
  @override
  final double areaScore;

  /// 구조형식 점수 (0.0 ~ 0.1)
  @override
  final double structureTypeScore;

  /// 건축물 용도 점수 (0.0 ~ 0.1)
  @override
  final double buildingUseScore;

  /// 총 점수
  @override
  final double totalScore;

  @override
  String toString() {
    return 'AnalysisScoreDetails(buildYearScore: $buildYearScore, floorsScore: $floorsScore, areaScore: $areaScore, structureTypeScore: $structureTypeScore, buildingUseScore: $buildingUseScore, totalScore: $totalScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisScoreDetailsImpl &&
            (identical(other.buildYearScore, buildYearScore) ||
                other.buildYearScore == buildYearScore) &&
            (identical(other.floorsScore, floorsScore) ||
                other.floorsScore == floorsScore) &&
            (identical(other.areaScore, areaScore) ||
                other.areaScore == areaScore) &&
            (identical(other.structureTypeScore, structureTypeScore) ||
                other.structureTypeScore == structureTypeScore) &&
            (identical(other.buildingUseScore, buildingUseScore) ||
                other.buildingUseScore == buildingUseScore) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    buildYearScore,
    floorsScore,
    areaScore,
    structureTypeScore,
    buildingUseScore,
    totalScore,
  );

  /// Create a copy of AnalysisScoreDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisScoreDetailsImplCopyWith<_$AnalysisScoreDetailsImpl>
  get copyWith =>
      __$$AnalysisScoreDetailsImplCopyWithImpl<_$AnalysisScoreDetailsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalysisScoreDetailsImplToJson(this);
  }
}

abstract class _AnalysisScoreDetails implements AnalysisScoreDetails {
  const factory _AnalysisScoreDetails({
    required final double buildYearScore,
    required final double floorsScore,
    required final double areaScore,
    required final double structureTypeScore,
    required final double buildingUseScore,
    required final double totalScore,
  }) = _$AnalysisScoreDetailsImpl;

  factory _AnalysisScoreDetails.fromJson(Map<String, dynamic> json) =
      _$AnalysisScoreDetailsImpl.fromJson;

  /// 건축년도 점수 (0.0 ~ 0.3)
  @override
  double get buildYearScore;

  /// 층수 점수 (0.0 ~ 0.4)
  @override
  double get floorsScore;

  /// 면적 점수 (0.0 ~ 0.2)
  @override
  double get areaScore;

  /// 구조형식 점수 (0.0 ~ 0.1)
  @override
  double get structureTypeScore;

  /// 건축물 용도 점수 (0.0 ~ 0.1)
  @override
  double get buildingUseScore;

  /// 총 점수
  @override
  double get totalScore;

  /// Create a copy of AnalysisScoreDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisScoreDetailsImplCopyWith<_$AnalysisScoreDetailsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BuildingBasicInfo _$BuildingBasicInfoFromJson(Map<String, dynamic> json) {
  return _BuildingBasicInfo.fromJson(json);
}

/// @nodoc
mixin _$BuildingBasicInfo {
  /// 건축물 주소
  String get address => throw _privateConstructorUsedError;

  /// 건축물 명칭
  String? get buildingName => throw _privateConstructorUsedError;

  /// 건축년도
  int? get buildYear => throw _privateConstructorUsedError;

  /// 구조형식
  String? get structureType => throw _privateConstructorUsedError;

  /// 건축물 용도
  String? get buildingUse => throw _privateConstructorUsedError;

  /// 지상층수
  int? get groundFloors => throw _privateConstructorUsedError;

  /// 지하층수
  int? get undergroundFloors => throw _privateConstructorUsedError;

  /// 연면적
  double? get totalArea => throw _privateConstructorUsedError;

  /// 대지면적
  double? get landArea => throw _privateConstructorUsedError;

  /// 건폐율
  double? get buildingCoverageRatio => throw _privateConstructorUsedError;

  /// 용적률
  double? get floorAreaRatio => throw _privateConstructorUsedError;

  /// 건축허가일
  String? get permitDate => throw _privateConstructorUsedError;

  /// 사용승인일
  String? get approvalDate => throw _privateConstructorUsedError;

  /// 크롤링 성공 여부
  bool get isSuccess => throw _privateConstructorUsedError;

  /// 에러 메시지
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this BuildingBasicInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BuildingBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuildingBasicInfoCopyWith<BuildingBasicInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildingBasicInfoCopyWith<$Res> {
  factory $BuildingBasicInfoCopyWith(
    BuildingBasicInfo value,
    $Res Function(BuildingBasicInfo) then,
  ) = _$BuildingBasicInfoCopyWithImpl<$Res, BuildingBasicInfo>;
  @useResult
  $Res call({
    String address,
    String? buildingName,
    int? buildYear,
    String? structureType,
    String? buildingUse,
    int? groundFloors,
    int? undergroundFloors,
    double? totalArea,
    double? landArea,
    double? buildingCoverageRatio,
    double? floorAreaRatio,
    String? permitDate,
    String? approvalDate,
    bool isSuccess,
    String? errorMessage,
  });
}

/// @nodoc
class _$BuildingBasicInfoCopyWithImpl<$Res, $Val extends BuildingBasicInfo>
    implements $BuildingBasicInfoCopyWith<$Res> {
  _$BuildingBasicInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuildingBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? buildingName = freezed,
    Object? buildYear = freezed,
    Object? structureType = freezed,
    Object? buildingUse = freezed,
    Object? groundFloors = freezed,
    Object? undergroundFloors = freezed,
    Object? totalArea = freezed,
    Object? landArea = freezed,
    Object? buildingCoverageRatio = freezed,
    Object? floorAreaRatio = freezed,
    Object? permitDate = freezed,
    Object? approvalDate = freezed,
    Object? isSuccess = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            buildingName:
                freezed == buildingName
                    ? _value.buildingName
                    : buildingName // ignore: cast_nullable_to_non_nullable
                        as String?,
            buildYear:
                freezed == buildYear
                    ? _value.buildYear
                    : buildYear // ignore: cast_nullable_to_non_nullable
                        as int?,
            structureType:
                freezed == structureType
                    ? _value.structureType
                    : structureType // ignore: cast_nullable_to_non_nullable
                        as String?,
            buildingUse:
                freezed == buildingUse
                    ? _value.buildingUse
                    : buildingUse // ignore: cast_nullable_to_non_nullable
                        as String?,
            groundFloors:
                freezed == groundFloors
                    ? _value.groundFloors
                    : groundFloors // ignore: cast_nullable_to_non_nullable
                        as int?,
            undergroundFloors:
                freezed == undergroundFloors
                    ? _value.undergroundFloors
                    : undergroundFloors // ignore: cast_nullable_to_non_nullable
                        as int?,
            totalArea:
                freezed == totalArea
                    ? _value.totalArea
                    : totalArea // ignore: cast_nullable_to_non_nullable
                        as double?,
            landArea:
                freezed == landArea
                    ? _value.landArea
                    : landArea // ignore: cast_nullable_to_non_nullable
                        as double?,
            buildingCoverageRatio:
                freezed == buildingCoverageRatio
                    ? _value.buildingCoverageRatio
                    : buildingCoverageRatio // ignore: cast_nullable_to_non_nullable
                        as double?,
            floorAreaRatio:
                freezed == floorAreaRatio
                    ? _value.floorAreaRatio
                    : floorAreaRatio // ignore: cast_nullable_to_non_nullable
                        as double?,
            permitDate:
                freezed == permitDate
                    ? _value.permitDate
                    : permitDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            approvalDate:
                freezed == approvalDate
                    ? _value.approvalDate
                    : approvalDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            isSuccess:
                null == isSuccess
                    ? _value.isSuccess
                    : isSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BuildingBasicInfoImplCopyWith<$Res>
    implements $BuildingBasicInfoCopyWith<$Res> {
  factory _$$BuildingBasicInfoImplCopyWith(
    _$BuildingBasicInfoImpl value,
    $Res Function(_$BuildingBasicInfoImpl) then,
  ) = __$$BuildingBasicInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String address,
    String? buildingName,
    int? buildYear,
    String? structureType,
    String? buildingUse,
    int? groundFloors,
    int? undergroundFloors,
    double? totalArea,
    double? landArea,
    double? buildingCoverageRatio,
    double? floorAreaRatio,
    String? permitDate,
    String? approvalDate,
    bool isSuccess,
    String? errorMessage,
  });
}

/// @nodoc
class __$$BuildingBasicInfoImplCopyWithImpl<$Res>
    extends _$BuildingBasicInfoCopyWithImpl<$Res, _$BuildingBasicInfoImpl>
    implements _$$BuildingBasicInfoImplCopyWith<$Res> {
  __$$BuildingBasicInfoImplCopyWithImpl(
    _$BuildingBasicInfoImpl _value,
    $Res Function(_$BuildingBasicInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BuildingBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? buildingName = freezed,
    Object? buildYear = freezed,
    Object? structureType = freezed,
    Object? buildingUse = freezed,
    Object? groundFloors = freezed,
    Object? undergroundFloors = freezed,
    Object? totalArea = freezed,
    Object? landArea = freezed,
    Object? buildingCoverageRatio = freezed,
    Object? floorAreaRatio = freezed,
    Object? permitDate = freezed,
    Object? approvalDate = freezed,
    Object? isSuccess = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$BuildingBasicInfoImpl(
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        buildingName:
            freezed == buildingName
                ? _value.buildingName
                : buildingName // ignore: cast_nullable_to_non_nullable
                    as String?,
        buildYear:
            freezed == buildYear
                ? _value.buildYear
                : buildYear // ignore: cast_nullable_to_non_nullable
                    as int?,
        structureType:
            freezed == structureType
                ? _value.structureType
                : structureType // ignore: cast_nullable_to_non_nullable
                    as String?,
        buildingUse:
            freezed == buildingUse
                ? _value.buildingUse
                : buildingUse // ignore: cast_nullable_to_non_nullable
                    as String?,
        groundFloors:
            freezed == groundFloors
                ? _value.groundFloors
                : groundFloors // ignore: cast_nullable_to_non_nullable
                    as int?,
        undergroundFloors:
            freezed == undergroundFloors
                ? _value.undergroundFloors
                : undergroundFloors // ignore: cast_nullable_to_non_nullable
                    as int?,
        totalArea:
            freezed == totalArea
                ? _value.totalArea
                : totalArea // ignore: cast_nullable_to_non_nullable
                    as double?,
        landArea:
            freezed == landArea
                ? _value.landArea
                : landArea // ignore: cast_nullable_to_non_nullable
                    as double?,
        buildingCoverageRatio:
            freezed == buildingCoverageRatio
                ? _value.buildingCoverageRatio
                : buildingCoverageRatio // ignore: cast_nullable_to_non_nullable
                    as double?,
        floorAreaRatio:
            freezed == floorAreaRatio
                ? _value.floorAreaRatio
                : floorAreaRatio // ignore: cast_nullable_to_non_nullable
                    as double?,
        permitDate:
            freezed == permitDate
                ? _value.permitDate
                : permitDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        approvalDate:
            freezed == approvalDate
                ? _value.approvalDate
                : approvalDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        isSuccess:
            null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BuildingBasicInfoImpl implements _BuildingBasicInfo {
  const _$BuildingBasicInfoImpl({
    required this.address,
    this.buildingName,
    this.buildYear,
    this.structureType,
    this.buildingUse,
    this.groundFloors,
    this.undergroundFloors,
    this.totalArea,
    this.landArea,
    this.buildingCoverageRatio,
    this.floorAreaRatio,
    this.permitDate,
    this.approvalDate,
    required this.isSuccess,
    this.errorMessage,
  });

  factory _$BuildingBasicInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuildingBasicInfoImplFromJson(json);

  /// 건축물 주소
  @override
  final String address;

  /// 건축물 명칭
  @override
  final String? buildingName;

  /// 건축년도
  @override
  final int? buildYear;

  /// 구조형식
  @override
  final String? structureType;

  /// 건축물 용도
  @override
  final String? buildingUse;

  /// 지상층수
  @override
  final int? groundFloors;

  /// 지하층수
  @override
  final int? undergroundFloors;

  /// 연면적
  @override
  final double? totalArea;

  /// 대지면적
  @override
  final double? landArea;

  /// 건폐율
  @override
  final double? buildingCoverageRatio;

  /// 용적률
  @override
  final double? floorAreaRatio;

  /// 건축허가일
  @override
  final String? permitDate;

  /// 사용승인일
  @override
  final String? approvalDate;

  /// 크롤링 성공 여부
  @override
  final bool isSuccess;

  /// 에러 메시지
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'BuildingBasicInfo(address: $address, buildingName: $buildingName, buildYear: $buildYear, structureType: $structureType, buildingUse: $buildingUse, groundFloors: $groundFloors, undergroundFloors: $undergroundFloors, totalArea: $totalArea, landArea: $landArea, buildingCoverageRatio: $buildingCoverageRatio, floorAreaRatio: $floorAreaRatio, permitDate: $permitDate, approvalDate: $approvalDate, isSuccess: $isSuccess, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuildingBasicInfoImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.buildingName, buildingName) ||
                other.buildingName == buildingName) &&
            (identical(other.buildYear, buildYear) ||
                other.buildYear == buildYear) &&
            (identical(other.structureType, structureType) ||
                other.structureType == structureType) &&
            (identical(other.buildingUse, buildingUse) ||
                other.buildingUse == buildingUse) &&
            (identical(other.groundFloors, groundFloors) ||
                other.groundFloors == groundFloors) &&
            (identical(other.undergroundFloors, undergroundFloors) ||
                other.undergroundFloors == undergroundFloors) &&
            (identical(other.totalArea, totalArea) ||
                other.totalArea == totalArea) &&
            (identical(other.landArea, landArea) ||
                other.landArea == landArea) &&
            (identical(other.buildingCoverageRatio, buildingCoverageRatio) ||
                other.buildingCoverageRatio == buildingCoverageRatio) &&
            (identical(other.floorAreaRatio, floorAreaRatio) ||
                other.floorAreaRatio == floorAreaRatio) &&
            (identical(other.permitDate, permitDate) ||
                other.permitDate == permitDate) &&
            (identical(other.approvalDate, approvalDate) ||
                other.approvalDate == approvalDate) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    address,
    buildingName,
    buildYear,
    structureType,
    buildingUse,
    groundFloors,
    undergroundFloors,
    totalArea,
    landArea,
    buildingCoverageRatio,
    floorAreaRatio,
    permitDate,
    approvalDate,
    isSuccess,
    errorMessage,
  );

  /// Create a copy of BuildingBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuildingBasicInfoImplCopyWith<_$BuildingBasicInfoImpl> get copyWith =>
      __$$BuildingBasicInfoImplCopyWithImpl<_$BuildingBasicInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BuildingBasicInfoImplToJson(this);
  }
}

abstract class _BuildingBasicInfo implements BuildingBasicInfo {
  const factory _BuildingBasicInfo({
    required final String address,
    final String? buildingName,
    final int? buildYear,
    final String? structureType,
    final String? buildingUse,
    final int? groundFloors,
    final int? undergroundFloors,
    final double? totalArea,
    final double? landArea,
    final double? buildingCoverageRatio,
    final double? floorAreaRatio,
    final String? permitDate,
    final String? approvalDate,
    required final bool isSuccess,
    final String? errorMessage,
  }) = _$BuildingBasicInfoImpl;

  factory _BuildingBasicInfo.fromJson(Map<String, dynamic> json) =
      _$BuildingBasicInfoImpl.fromJson;

  /// 건축물 주소
  @override
  String get address;

  /// 건축물 명칭
  @override
  String? get buildingName;

  /// 건축년도
  @override
  int? get buildYear;

  /// 구조형식
  @override
  String? get structureType;

  /// 건축물 용도
  @override
  String? get buildingUse;

  /// 지상층수
  @override
  int? get groundFloors;

  /// 지하층수
  @override
  int? get undergroundFloors;

  /// 연면적
  @override
  double? get totalArea;

  /// 대지면적
  @override
  double? get landArea;

  /// 건폐율
  @override
  double? get buildingCoverageRatio;

  /// 용적률
  @override
  double? get floorAreaRatio;

  /// 건축허가일
  @override
  String? get permitDate;

  /// 사용승인일
  @override
  String? get approvalDate;

  /// 크롤링 성공 여부
  @override
  bool get isSuccess;

  /// 에러 메시지
  @override
  String? get errorMessage;

  /// Create a copy of BuildingBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuildingBasicInfoImplCopyWith<_$BuildingBasicInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalysisProgressState _$AnalysisProgressStateFromJson(
  Map<String, dynamic> json,
) {
  return _AnalysisProgressState.fromJson(json);
}

/// @nodoc
mixin _$AnalysisProgressState {
  /// 분석 진행 중 여부
  bool get isAnalyzing => throw _privateConstructorUsedError;

  /// 현재 분석 중인 주소
  String? get currentAddress => throw _privateConstructorUsedError;

  /// 전체 분석 대상 수
  int get totalCount => throw _privateConstructorUsedError;

  /// 완료된 분석 수
  int get completedCount => throw _privateConstructorUsedError;

  /// 오류 발생한 분석 수
  int get errorCount => throw _privateConstructorUsedError;

  /// Serializes this AnalysisProgressState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalysisProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalysisProgressStateCopyWith<AnalysisProgressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisProgressStateCopyWith<$Res> {
  factory $AnalysisProgressStateCopyWith(
    AnalysisProgressState value,
    $Res Function(AnalysisProgressState) then,
  ) = _$AnalysisProgressStateCopyWithImpl<$Res, AnalysisProgressState>;
  @useResult
  $Res call({
    bool isAnalyzing,
    String? currentAddress,
    int totalCount,
    int completedCount,
    int errorCount,
  });
}

/// @nodoc
class _$AnalysisProgressStateCopyWithImpl<
  $Res,
  $Val extends AnalysisProgressState
>
    implements $AnalysisProgressStateCopyWith<$Res> {
  _$AnalysisProgressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalysisProgressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAnalyzing = null,
    Object? currentAddress = freezed,
    Object? totalCount = null,
    Object? completedCount = null,
    Object? errorCount = null,
  }) {
    return _then(
      _value.copyWith(
            isAnalyzing:
                null == isAnalyzing
                    ? _value.isAnalyzing
                    : isAnalyzing // ignore: cast_nullable_to_non_nullable
                        as bool,
            currentAddress:
                freezed == currentAddress
                    ? _value.currentAddress
                    : currentAddress // ignore: cast_nullable_to_non_nullable
                        as String?,
            totalCount:
                null == totalCount
                    ? _value.totalCount
                    : totalCount // ignore: cast_nullable_to_non_nullable
                        as int,
            completedCount:
                null == completedCount
                    ? _value.completedCount
                    : completedCount // ignore: cast_nullable_to_non_nullable
                        as int,
            errorCount:
                null == errorCount
                    ? _value.errorCount
                    : errorCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalysisProgressStateImplCopyWith<$Res>
    implements $AnalysisProgressStateCopyWith<$Res> {
  factory _$$AnalysisProgressStateImplCopyWith(
    _$AnalysisProgressStateImpl value,
    $Res Function(_$AnalysisProgressStateImpl) then,
  ) = __$$AnalysisProgressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isAnalyzing,
    String? currentAddress,
    int totalCount,
    int completedCount,
    int errorCount,
  });
}

/// @nodoc
class __$$AnalysisProgressStateImplCopyWithImpl<$Res>
    extends
        _$AnalysisProgressStateCopyWithImpl<$Res, _$AnalysisProgressStateImpl>
    implements _$$AnalysisProgressStateImplCopyWith<$Res> {
  __$$AnalysisProgressStateImplCopyWithImpl(
    _$AnalysisProgressStateImpl _value,
    $Res Function(_$AnalysisProgressStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalysisProgressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAnalyzing = null,
    Object? currentAddress = freezed,
    Object? totalCount = null,
    Object? completedCount = null,
    Object? errorCount = null,
  }) {
    return _then(
      _$AnalysisProgressStateImpl(
        isAnalyzing:
            null == isAnalyzing
                ? _value.isAnalyzing
                : isAnalyzing // ignore: cast_nullable_to_non_nullable
                    as bool,
        currentAddress:
            freezed == currentAddress
                ? _value.currentAddress
                : currentAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
        totalCount:
            null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                    as int,
        completedCount:
            null == completedCount
                ? _value.completedCount
                : completedCount // ignore: cast_nullable_to_non_nullable
                    as int,
        errorCount:
            null == errorCount
                ? _value.errorCount
                : errorCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalysisProgressStateImpl implements _AnalysisProgressState {
  const _$AnalysisProgressStateImpl({
    required this.isAnalyzing,
    this.currentAddress,
    required this.totalCount,
    required this.completedCount,
    required this.errorCount,
  });

  factory _$AnalysisProgressStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalysisProgressStateImplFromJson(json);

  /// 분석 진행 중 여부
  @override
  final bool isAnalyzing;

  /// 현재 분석 중인 주소
  @override
  final String? currentAddress;

  /// 전체 분석 대상 수
  @override
  final int totalCount;

  /// 완료된 분석 수
  @override
  final int completedCount;

  /// 오류 발생한 분석 수
  @override
  final int errorCount;

  @override
  String toString() {
    return 'AnalysisProgressState(isAnalyzing: $isAnalyzing, currentAddress: $currentAddress, totalCount: $totalCount, completedCount: $completedCount, errorCount: $errorCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisProgressStateImpl &&
            (identical(other.isAnalyzing, isAnalyzing) ||
                other.isAnalyzing == isAnalyzing) &&
            (identical(other.currentAddress, currentAddress) ||
                other.currentAddress == currentAddress) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.completedCount, completedCount) ||
                other.completedCount == completedCount) &&
            (identical(other.errorCount, errorCount) ||
                other.errorCount == errorCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isAnalyzing,
    currentAddress,
    totalCount,
    completedCount,
    errorCount,
  );

  /// Create a copy of AnalysisProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisProgressStateImplCopyWith<_$AnalysisProgressStateImpl>
  get copyWith =>
      __$$AnalysisProgressStateImplCopyWithImpl<_$AnalysisProgressStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalysisProgressStateImplToJson(this);
  }
}

abstract class _AnalysisProgressState implements AnalysisProgressState {
  const factory _AnalysisProgressState({
    required final bool isAnalyzing,
    final String? currentAddress,
    required final int totalCount,
    required final int completedCount,
    required final int errorCount,
  }) = _$AnalysisProgressStateImpl;

  factory _AnalysisProgressState.fromJson(Map<String, dynamic> json) =
      _$AnalysisProgressStateImpl.fromJson;

  /// 분석 진행 중 여부
  @override
  bool get isAnalyzing;

  /// 현재 분석 중인 주소
  @override
  String? get currentAddress;

  /// 전체 분석 대상 수
  @override
  int get totalCount;

  /// 완료된 분석 수
  @override
  int get completedCount;

  /// 오류 발생한 분석 수
  @override
  int get errorCount;

  /// Create a copy of AnalysisProgressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisProgressStateImplCopyWith<_$AnalysisProgressStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
