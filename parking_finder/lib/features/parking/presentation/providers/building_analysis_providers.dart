import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/parking_analysis_model.dart';
import '../../data/services/building_info_service.dart';
import '../../data/services/steel_deck_analysis_service.dart';

part 'building_analysis_providers.g.dart';

/// 건축물 정보 서비스 Provider
@riverpod
BuildingInfoService buildingInfoService(BuildingInfoServiceRef ref) {
  return BuildingInfoService();
}

/// 철골데크 분석 서비스 Provider
@riverpod
SteelDeckAnalysisService steelDeckAnalysisService(
  SteelDeckAnalysisServiceRef ref,
) {
  return SteelDeckAnalysisService();
}

/// 주소로 건축물 정보 검색 Provider
@riverpod
Future<BuildingBasicInfo> searchBuildingInfo(
  SearchBuildingInfoRef ref,
  String address,
) async {
  final service = ref.watch(buildingInfoServiceProvider);
  return await service.searchBuildingByAddress(address);
}

/// 건축물 구조 분석 Provider
@riverpod
Future<StructureAnalysisResult> analyzeBuildingStructure(
  AnalyzeBuildingStructureRef ref,
  String address,
) async {
  // 1. 건축물 정보 검색
  final buildingInfo = await ref.watch(
    searchBuildingInfoProvider(address).future,
  );

  if (!buildingInfo.isSuccess) {
    throw Exception(buildingInfo.errorMessage ?? '건축물 정보를 찾을 수 없습니다.');
  }

  // 2. 구조 분석 수행
  final analysisService = ref.watch(steelDeckAnalysisServiceProvider);
  return analysisService.calculateSteelDeckProbability(buildingInfo);
}

/// 분석 결과 캐시 관리 Provider
@riverpod
class AnalysisResultCache extends _$AnalysisResultCache {
  @override
  Map<String, StructureAnalysisResult> build() {
    return {};
  }

  /// 분석 결과 캐시에 저장
  void cacheResult(String address, StructureAnalysisResult result) {
    state = {...state, address: result};
  }

  /// 캐시된 결과 조회
  StructureAnalysisResult? getCachedResult(String address) {
    return state[address];
  }

  /// 캐시 초기화
  void clearCache() {
    state = {};
  }

  /// 특정 주소의 캐시 삭제
  void removeCachedResult(String address) {
    final newState = Map<String, StructureAnalysisResult>.from(state);
    newState.remove(address);
    state = newState;
  }
}
