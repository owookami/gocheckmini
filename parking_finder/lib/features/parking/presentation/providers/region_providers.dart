import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_helper.dart';
import '../../data/models/region_model.dart';
import '../../data/repositories/region_repository.dart';

/// DatabaseHelper Provider
final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper();
});

/// RegionRepository Provider
final regionRepositoryProvider = Provider<RegionRepository>((ref) {
  final databaseHelper = ref.watch(databaseHelperProvider);
  return RegionRepository(databaseHelper);
});

/// 선택된 시/도 Provider
final selectedProvinceProvider = StateProvider<String?>((ref) => null);

/// 선택된 시/군/구 Provider
final selectedSigunguProvider = StateProvider<RegionModel?>((ref) => null);

/// 선택된 읍/면/동 Provider
final selectedBjdongProvider = StateProvider<String?>((ref) => null);

/// 시/도 목록 Provider
final provincesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(regionRepositoryProvider);
  return await repository.getProvinces();
});

/// 선택된 시/도의 시/군/구 목록 Provider
final sigungusProvider = FutureProvider.family<List<RegionModel>, String>((
  ref,
  province,
) async {
  final repository = ref.watch(regionRepositoryProvider);
  return await repository.getSigungus(province);
});

/// 선택된 시/군/구의 읍/면/동 목록 Provider
final bjdongsProvider = FutureProvider.family<List<String>, String>((
  ref,
  sigunguCode,
) async {
  final repository = ref.watch(regionRepositoryProvider);
  return await repository.getBjdongs(sigunguCode);
});

/// 지역 검색 Provider
final regionSearchProvider = FutureProvider.family<List<RegionModel>, String>((
  ref,
  query,
) async {
  if (query.trim().isEmpty) return [];

  final repository = ref.watch(regionRepositoryProvider);
  return await repository.searchRegions(query);
});

/// 지역 데이터 로딩 상태 관리 Provider
class RegionLoadingState {
  final bool isProvincesLoading;
  final bool isSigungusLoading;
  final bool isBjdongsLoading;
  final String? error;

  const RegionLoadingState({
    this.isProvincesLoading = false,
    this.isSigungusLoading = false,
    this.isBjdongsLoading = false,
    this.error,
  });

  RegionLoadingState copyWith({
    bool? isProvincesLoading,
    bool? isSigungusLoading,
    bool? isBjdongsLoading,
    String? error,
  }) {
    return RegionLoadingState(
      isProvincesLoading: isProvincesLoading ?? this.isProvincesLoading,
      isSigungusLoading: isSigungusLoading ?? this.isSigungusLoading,
      isBjdongsLoading: isBjdongsLoading ?? this.isBjdongsLoading,
      error: error ?? this.error,
    );
  }
}

/// 지역 로딩 상태 Provider
final regionLoadingStateProvider = StateProvider<RegionLoadingState>((ref) {
  return const RegionLoadingState();
});

/// 지역 선택 완료 여부 Provider
final isRegionSelectionCompleteProvider = Provider<bool>((ref) {
  final selectedProvince = ref.watch(selectedProvinceProvider);
  final selectedSigungu = ref.watch(selectedSigunguProvider);
  final selectedBjdong = ref.watch(selectedBjdongProvider);

  return selectedProvince != null &&
      selectedSigungu != null &&
      selectedBjdong != null;
});

/// 지역 선택 초기화 Provider
final regionSelectionActionsProvider = Provider<RegionSelectionActions>((ref) {
  return RegionSelectionActions(ref);
});

/// 지역 선택 액션 클래스
class RegionSelectionActions {
  final Ref _ref;

  RegionSelectionActions(this._ref);

  /// 시/도 선택
  void selectProvince(String? province) {
    _ref.read(selectedProvinceProvider.notifier).state = province;
    // 하위 지역 초기화
    _ref.read(selectedSigunguProvider.notifier).state = null;
    _ref.read(selectedBjdongProvider.notifier).state = null;
  }

  /// 시/군/구 선택
  void selectSigungu(RegionModel? sigungu) {
    _ref.read(selectedSigunguProvider.notifier).state = sigungu;
    // 하위 지역 초기화
    _ref.read(selectedBjdongProvider.notifier).state = null;
  }

  /// 읍/면/동 선택
  void selectBjdong(String? bjdong) {
    _ref.read(selectedBjdongProvider.notifier).state = bjdong;
  }

  /// 모든 선택 초기화
  void resetSelection() {
    _ref.read(selectedProvinceProvider.notifier).state = null;
    _ref.read(selectedSigunguProvider.notifier).state = null;
    _ref.read(selectedBjdongProvider.notifier).state = null;
  }

  /// 현재 선택된 지역 정보 가져오기
  Map<String, dynamic> getCurrentSelection() {
    final province = _ref.read(selectedProvinceProvider);
    final sigungu = _ref.read(selectedSigunguProvider);
    final bjdong = _ref.read(selectedBjdongProvider);

    return {
      'province': province,
      'sigungu': sigungu,
      'sigunguCode': sigungu?.sigunguCode,
      'bjdong': bjdong,
    };
  }
}
