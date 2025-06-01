import 'package:freezed_annotation/freezed_annotation.dart';

part 'parking_analysis_model.freezed.dart';
part 'parking_analysis_model.g.dart';

/// 건축물 구조 분석 모델
@freezed
class ParkingAnalysisModel with _$ParkingAnalysisModel {
  const factory ParkingAnalysisModel({
    /// 건축년도 (2000년대 이후 → 철골데크 가능성 높음)
    required int buildYear,

    /// 층수 (3층 이상 → 철골데크 적합)
    required int floors,

    /// 연면적 (넓은 면적 → 철골데크 선호)
    required double area,

    /// 건축물 용도 (상업지역 → 철골데크 가능성)
    required String buildingUse,

    /// 구조형식 (철골구조, 철근콘크리트구조 등)
    required String structureType,

    /// 지역 구분 (상업지역, 공업지역 등)
    required String location,

    /// 철골데크 확률 (0.0 ~ 1.0)
    required double steelDeckProbability,

    /// 건축물 주소
    required String address,

    /// 건축물 명칭
    String? buildingName,

    /// 건축허가일
    String? permitDate,

    /// 사용승인일
    String? approvalDate,

    /// 대지면적
    double? landArea,

    /// 건폐율
    double? buildingCoverageRatio,

    /// 용적률
    double? floorAreaRatio,

    /// 지상층수
    int? groundFloors,

    /// 지하층수
    int? undergroundFloors,

    /// 분석 일시
    DateTime? analysisDateTime,
  }) = _ParkingAnalysisModel;

  factory ParkingAnalysisModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingAnalysisModelFromJson(json);
}

/// 건축물 구조 분석 결과 모델
@freezed
class StructureAnalysisResult with _$StructureAnalysisResult {
  const factory StructureAnalysisResult({
    /// 철골데크 확률 점수
    required double probability,

    /// 분석 상세 점수
    required AnalysisScoreDetails scoreDetails,

    /// 추천 여부
    required bool isRecommended,

    /// 신뢰도 (0.0 ~ 1.0)
    required double confidence,

    /// 분석 결과 설명
    required String explanation,

    /// 위험 요소들
    required List<String> riskFactors,

    /// 장점들
    required List<String> advantages,
  }) = _StructureAnalysisResult;

  factory StructureAnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$StructureAnalysisResultFromJson(json);
}

/// 분석 점수 상세 정보
@freezed
class AnalysisScoreDetails with _$AnalysisScoreDetails {
  const factory AnalysisScoreDetails({
    /// 건축년도 점수 (0.0 ~ 0.3)
    required double buildYearScore,

    /// 층수 점수 (0.0 ~ 0.4)
    required double floorsScore,

    /// 면적 점수 (0.0 ~ 0.2)
    required double areaScore,

    /// 구조형식 점수 (0.0 ~ 0.1)
    required double structureTypeScore,

    /// 건축물 용도 점수 (0.0 ~ 0.1)
    required double buildingUseScore,

    /// 총 점수
    required double totalScore,
  }) = _AnalysisScoreDetails;

  factory AnalysisScoreDetails.fromJson(Map<String, dynamic> json) =>
      _$AnalysisScoreDetailsFromJson(json);
}

/// 건축물 기본 정보 (크롤링 결과)
@freezed
class BuildingBasicInfo with _$BuildingBasicInfo {
  const factory BuildingBasicInfo({
    /// 건축물 주소
    required String address,

    /// 건축물 명칭
    String? buildingName,

    /// 건축년도
    int? buildYear,

    /// 구조형식
    String? structureType,

    /// 건축물 용도
    String? buildingUse,

    /// 지상층수
    int? groundFloors,

    /// 지하층수
    int? undergroundFloors,

    /// 연면적
    double? totalArea,

    /// 대지면적
    double? landArea,

    /// 건폐율
    double? buildingCoverageRatio,

    /// 용적률
    double? floorAreaRatio,

    /// 건축허가일
    String? permitDate,

    /// 사용승인일
    String? approvalDate,

    /// 크롤링 성공 여부
    required bool isSuccess,

    /// 에러 메시지
    String? errorMessage,
  }) = _BuildingBasicInfo;

  factory BuildingBasicInfo.fromJson(Map<String, dynamic> json) =>
      _$BuildingBasicInfoFromJson(json);
}

/// 분석 진행 상태 모델
@freezed
class AnalysisProgressState with _$AnalysisProgressState {
  const factory AnalysisProgressState({
    /// 분석 진행 중 여부
    required bool isAnalyzing,

    /// 현재 분석 중인 주소
    String? currentAddress,

    /// 전체 분석 대상 수
    required int totalCount,

    /// 완료된 분석 수
    required int completedCount,

    /// 오류 발생한 분석 수
    required int errorCount,
  }) = _AnalysisProgressState;

  factory AnalysisProgressState.fromJson(Map<String, dynamic> json) =>
      _$AnalysisProgressStateFromJson(json);
}
