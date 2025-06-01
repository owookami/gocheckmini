import 'package:logger/logger.dart';
import '../models/parking_analysis_model.dart';

/// 철골데크 구조 분석 서비스
class SteelDeckAnalysisService {
  final Logger _logger = Logger();

  /// 건축물 정보를 기반으로 철골데크 확률을 계산
  StructureAnalysisResult calculateSteelDeckProbability(
    BuildingBasicInfo buildingInfo,
  ) {
    try {
      _logger.i('철골데크 확률 계산 시작: ${buildingInfo.address}');

      // 기본 점수 계산
      final scoreDetails = _calculateDetailedScores(buildingInfo);
      final totalScore = scoreDetails.totalScore;

      // 확률로 변환 (0.0 ~ 1.0)
      final probability = (totalScore).clamp(0.0, 1.0);

      // 추천 여부 결정 (70% 이상일 때 추천)
      final isRecommended = probability >= 0.7;

      // 신뢰도 계산
      final confidence = _calculateConfidence(buildingInfo, scoreDetails);

      // 설명 생성
      final explanation = _generateExplanation(
        buildingInfo,
        scoreDetails,
        probability,
      );

      // 위험 요소 및 장점 분석
      final riskFactors = _analyzeRiskFactors(buildingInfo, scoreDetails);
      final advantages = _analyzeAdvantages(buildingInfo, scoreDetails);

      return StructureAnalysisResult(
        probability: probability,
        scoreDetails: scoreDetails,
        isRecommended: isRecommended,
        confidence: confidence,
        explanation: explanation,
        riskFactors: riskFactors,
        advantages: advantages,
      );
    } catch (e, stackTrace) {
      _logger.e('철골데크 확률 계산 실패: $e', error: e, stackTrace: stackTrace);

      return const StructureAnalysisResult(
        probability: 0.0,
        scoreDetails: AnalysisScoreDetails(
          buildYearScore: 0.0,
          floorsScore: 0.0,
          areaScore: 0.0,
          structureTypeScore: 0.0,
          buildingUseScore: 0.0,
          totalScore: 0.0,
        ),
        isRecommended: false,
        confidence: 0.0,
        explanation: '분석 중 오류가 발생했습니다.',
        riskFactors: ['분석 데이터 부족'],
        advantages: [],
      );
    }
  }

  /// 상세 점수 계산
  AnalysisScoreDetails _calculateDetailedScores(
    BuildingBasicInfo buildingInfo,
  ) {
    double buildYearScore = 0.0;
    double floorsScore = 0.0;
    double areaScore = 0.0;
    double structureTypeScore = 0.0;
    double buildingUseScore = 0.0;

    // 1. 건축년도 점수 (최대 0.3점)
    if (buildingInfo.buildYear != null) {
      final year = buildingInfo.buildYear!;
      if (year >= 2010) {
        buildYearScore = 0.3; // 2010년 이후: 매우 높음
      } else if (year >= 2000) {
        buildYearScore = 0.25; // 2000-2009년: 높음
      } else if (year >= 1990) {
        buildYearScore = 0.15; // 1990-1999년: 보통
      } else if (year >= 1980) {
        buildYearScore = 0.05; // 1980-1989년: 낮음
      } else {
        buildYearScore = 0.0; // 1980년 이전: 매우 낮음
      }
    }

    // 2. 층수 점수 (최대 0.4점)
    final totalFloors =
        (buildingInfo.groundFloors ?? 0) +
        (buildingInfo.undergroundFloors ?? 0);
    if (totalFloors >= 5) {
      floorsScore = 0.4; // 5층 이상: 매우 적합
    } else if (totalFloors >= 3) {
      floorsScore = 0.3; // 3-4층: 적합
    } else if (totalFloors >= 2) {
      floorsScore = 0.15; // 2층: 보통
    } else {
      floorsScore = 0.0; // 1층: 부적합
    }

    // 3. 면적 점수 (최대 0.2점)
    if (buildingInfo.totalArea != null) {
      final area = buildingInfo.totalArea!;
      if (area >= 3000) {
        areaScore = 0.2; // 3000㎡ 이상: 매우 적합
      } else if (area >= 1500) {
        areaScore = 0.15; // 1500-2999㎡: 적합
      } else if (area >= 500) {
        areaScore = 0.1; // 500-1499㎡: 보통
      } else {
        areaScore = 0.05; // 500㎡ 미만: 낮음
      }
    }

    // 4. 구조형식 점수 (최대 0.1점)
    if (buildingInfo.structureType != null) {
      final structure = buildingInfo.structureType!.toLowerCase();
      if (structure.contains('철골') || structure.contains('steel')) {
        structureTypeScore = 0.1; // 이미 철골구조: 매우 적합
      } else if (structure.contains('철근콘크리트') || structure.contains('rc')) {
        structureTypeScore = 0.05; // RC구조: 보통
      } else if (structure.contains('목구조') || structure.contains('wood')) {
        structureTypeScore = 0.0; // 목구조: 부적합
      } else {
        structureTypeScore = 0.03; // 기타: 낮음
      }
    }

    // 5. 건축물 용도 점수 (최대 0.1점)
    if (buildingInfo.buildingUse != null) {
      final use = buildingInfo.buildingUse!.toLowerCase();
      if (use.contains('주차장') || use.contains('차고')) {
        buildingUseScore = 0.1; // 주차장: 매우 적합
      } else if (use.contains('창고') ||
          use.contains('물류') ||
          use.contains('공장')) {
        buildingUseScore = 0.08; // 창고/공장: 적합
      } else if (use.contains('상업') ||
          use.contains('업무') ||
          use.contains('사무')) {
        buildingUseScore = 0.06; // 상업/업무: 보통
      } else if (use.contains('주거') ||
          use.contains('아파트') ||
          use.contains('연립')) {
        buildingUseScore = 0.02; // 주거: 낮음
      } else {
        buildingUseScore = 0.04; // 기타: 보통
      }
    }

    final totalScore =
        buildYearScore +
        floorsScore +
        areaScore +
        structureTypeScore +
        buildingUseScore;

    return AnalysisScoreDetails(
      buildYearScore: buildYearScore,
      floorsScore: floorsScore,
      areaScore: areaScore,
      structureTypeScore: structureTypeScore,
      buildingUseScore: buildingUseScore,
      totalScore: totalScore,
    );
  }

  /// 신뢰도 계산
  double _calculateConfidence(
    BuildingBasicInfo buildingInfo,
    AnalysisScoreDetails scoreDetails,
  ) {
    double confidence = 0.5; // 기본 신뢰도 50%

    // 데이터 완성도에 따른 신뢰도 조정
    int dataCompleteness = 0;

    if (buildingInfo.buildYear != null) dataCompleteness++;
    if (buildingInfo.groundFloors != null) dataCompleteness++;
    if (buildingInfo.totalArea != null) dataCompleteness++;
    if (buildingInfo.structureType != null) dataCompleteness++;
    if (buildingInfo.buildingUse != null) dataCompleteness++;

    // 데이터 완성도가 높을수록 신뢰도 증가
    confidence += (dataCompleteness / 5.0) * 0.4; // 최대 40% 추가

    // 극단적인 점수일 때 신뢰도 조정
    if (scoreDetails.totalScore > 0.8 || scoreDetails.totalScore < 0.2) {
      confidence += 0.1; // 확실한 경우 신뢰도 증가
    }

    return confidence.clamp(0.0, 1.0);
  }

  /// 설명 생성
  String _generateExplanation(
    BuildingBasicInfo buildingInfo,
    AnalysisScoreDetails scoreDetails,
    double probability,
  ) {
    final buffer = StringBuffer();

    // 전체 평가
    if (probability >= 0.8) {
      buffer.write('철골데크 구조에 매우 적합한 건축물입니다. ');
    } else if (probability >= 0.6) {
      buffer.write('철골데크 구조에 적합한 건축물입니다. ');
    } else if (probability >= 0.4) {
      buffer.write('철골데크 구조 적용이 가능한 건축물입니다. ');
    } else if (probability >= 0.2) {
      buffer.write('철골데크 구조 적용에 제한적인 건축물입니다. ');
    } else {
      buffer.write('철골데크 구조에 적합하지 않은 건축물입니다. ');
    }

    // 주요 요인별 설명
    final factors = <String>[];

    if (scoreDetails.buildYearScore >= 0.2) {
      factors.add('최신 건축 기술 적용 가능');
    }
    if (scoreDetails.floorsScore >= 0.3) {
      factors.add('적절한 층수로 구조적 안정성 확보');
    }
    if (scoreDetails.areaScore >= 0.15) {
      factors.add('충분한 면적으로 경제성 확보');
    }
    if (scoreDetails.structureTypeScore >= 0.05) {
      factors.add('기존 구조와의 호환성');
    }
    if (scoreDetails.buildingUseScore >= 0.06) {
      factors.add('용도에 적합한 구조 방식');
    }

    if (factors.isNotEmpty) {
      buffer.write('주요 긍정 요인: ${factors.join(', ')}');
    }

    return buffer.toString();
  }

  /// 위험 요소 분석
  List<String> _analyzeRiskFactors(
    BuildingBasicInfo buildingInfo,
    AnalysisScoreDetails scoreDetails,
  ) {
    final risks = <String>[];

    if (scoreDetails.buildYearScore < 0.1) {
      risks.add('오래된 건축물로 구조 변경 시 안전성 검토 필요');
    }

    if (scoreDetails.floorsScore < 0.15) {
      risks.add('낮은 층수로 철골데크의 경제적 효과 제한적');
    }

    if (scoreDetails.areaScore < 0.1) {
      risks.add('작은 면적으로 철골데크 시공 비용 대비 효과 낮음');
    }

    if (buildingInfo.structureType?.contains('목구조') == true) {
      risks.add('목구조 건물로 철골데크 적용 시 구조 안전성 우려');
    }

    if (buildingInfo.buildingUse?.contains('주거') == true) {
      risks.add('주거용 건물로 소음 및 진동 문제 발생 가능');
    }

    if (buildingInfo.buildYear != null && buildingInfo.buildYear! < 1980) {
      risks.add('노후 건축물로 내진 설계 기준 미달 가능성');
    }

    return risks;
  }

  /// 장점 분석
  List<String> _analyzeAdvantages(
    BuildingBasicInfo buildingInfo,
    AnalysisScoreDetails scoreDetails,
  ) {
    final advantages = <String>[];

    if (scoreDetails.buildYearScore >= 0.25) {
      advantages.add('최신 건축 기술 적용으로 시공성 우수');
    }

    if (scoreDetails.floorsScore >= 0.3) {
      advantages.add('다층 구조로 철골데크의 구조적 장점 극대화');
    }

    if (scoreDetails.areaScore >= 0.15) {
      advantages.add('대면적으로 철골데크 시공 경제성 확보');
    }

    if (buildingInfo.structureType?.contains('철골') == true) {
      advantages.add('기존 철골구조와의 호환성으로 시공 용이');
    }

    if (buildingInfo.buildingUse?.contains('주차장') == true) {
      advantages.add('주차장 용도로 하중 조건 및 공간 활용성 최적');
    }

    if (buildingInfo.buildingUse?.contains('창고') == true) {
      advantages.add('창고 용도로 넓은 무주공간 구현 가능');
    }

    if (scoreDetails.totalScore >= 0.7) {
      advantages.add('전체적으로 철골데크 적용 조건 우수');
    }

    return advantages;
  }

  /// 간단한 확률 계산 (기존 로직과 호환)
  double calculateSimpleSteelDeckProbability(ParkingAnalysisModel info) {
    double score = 0.0;

    if (info.buildYear > 2000) score += 0.3;
    if (info.floors >= 3) score += 0.4;
    if (info.area > 1000) score += 0.3;

    return score.clamp(0.0, 1.0);
  }

  /// BuildingBasicInfo를 ParkingAnalysisModel로 변환
  ParkingAnalysisModel convertToParkingAnalysis(
    BuildingBasicInfo buildingInfo,
  ) {
    final analysisResult = calculateSteelDeckProbability(buildingInfo);

    return ParkingAnalysisModel(
      buildYear: buildingInfo.buildYear ?? 1990,
      floors:
          (buildingInfo.groundFloors ?? 1) +
          (buildingInfo.undergroundFloors ?? 0),
      area: buildingInfo.totalArea ?? 0.0,
      buildingUse: buildingInfo.buildingUse ?? '미상',
      structureType: buildingInfo.structureType ?? '미상',
      location: '미상', // 추후 지역 정보 추가 시 업데이트
      steelDeckProbability: analysisResult.probability,
      address: buildingInfo.address,
      buildingName: buildingInfo.buildingName,
      permitDate: buildingInfo.permitDate,
      approvalDate: buildingInfo.approvalDate,
      landArea: buildingInfo.landArea,
      buildingCoverageRatio: buildingInfo.buildingCoverageRatio,
      floorAreaRatio: buildingInfo.floorAreaRatio,
      groundFloors: buildingInfo.groundFloors,
      undergroundFloors: buildingInfo.undergroundFloors,
      analysisDateTime: DateTime.now(),
    );
  }
}
