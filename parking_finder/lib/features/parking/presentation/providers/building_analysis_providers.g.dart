// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_analysis_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$buildingInfoServiceHash() =>
    r'd1e80d20a362210a1d8fdda898c17f3b2c835df4';

/// 건축물 정보 서비스 Provider
///
/// Copied from [buildingInfoService].
@ProviderFor(buildingInfoService)
final buildingInfoServiceProvider =
    AutoDisposeProvider<BuildingInfoService>.internal(
      buildingInfoService,
      name: r'buildingInfoServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$buildingInfoServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BuildingInfoServiceRef = AutoDisposeProviderRef<BuildingInfoService>;
String _$steelDeckAnalysisServiceHash() =>
    r'b7cb60392d4a04ae3fc59cf21e5dd4ebab1fd486';

/// 철골데크 분석 서비스 Provider
///
/// Copied from [steelDeckAnalysisService].
@ProviderFor(steelDeckAnalysisService)
final steelDeckAnalysisServiceProvider =
    AutoDisposeProvider<SteelDeckAnalysisService>.internal(
      steelDeckAnalysisService,
      name: r'steelDeckAnalysisServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$steelDeckAnalysisServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SteelDeckAnalysisServiceRef =
    AutoDisposeProviderRef<SteelDeckAnalysisService>;
String _$searchBuildingInfoHash() =>
    r'415d51e8c85f376505e2590fa896dc5c5d87b8bb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 주소로 건축물 정보 검색 Provider
///
/// Copied from [searchBuildingInfo].
@ProviderFor(searchBuildingInfo)
const searchBuildingInfoProvider = SearchBuildingInfoFamily();

/// 주소로 건축물 정보 검색 Provider
///
/// Copied from [searchBuildingInfo].
class SearchBuildingInfoFamily extends Family<AsyncValue<BuildingBasicInfo>> {
  /// 주소로 건축물 정보 검색 Provider
  ///
  /// Copied from [searchBuildingInfo].
  const SearchBuildingInfoFamily();

  /// 주소로 건축물 정보 검색 Provider
  ///
  /// Copied from [searchBuildingInfo].
  SearchBuildingInfoProvider call(String address) {
    return SearchBuildingInfoProvider(address);
  }

  @override
  SearchBuildingInfoProvider getProviderOverride(
    covariant SearchBuildingInfoProvider provider,
  ) {
    return call(provider.address);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchBuildingInfoProvider';
}

/// 주소로 건축물 정보 검색 Provider
///
/// Copied from [searchBuildingInfo].
class SearchBuildingInfoProvider
    extends AutoDisposeFutureProvider<BuildingBasicInfo> {
  /// 주소로 건축물 정보 검색 Provider
  ///
  /// Copied from [searchBuildingInfo].
  SearchBuildingInfoProvider(String address)
    : this._internal(
        (ref) => searchBuildingInfo(ref as SearchBuildingInfoRef, address),
        from: searchBuildingInfoProvider,
        name: r'searchBuildingInfoProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$searchBuildingInfoHash,
        dependencies: SearchBuildingInfoFamily._dependencies,
        allTransitiveDependencies:
            SearchBuildingInfoFamily._allTransitiveDependencies,
        address: address,
      );

  SearchBuildingInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<BuildingBasicInfo> Function(SearchBuildingInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchBuildingInfoProvider._internal(
        (ref) => create(ref as SearchBuildingInfoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BuildingBasicInfo> createElement() {
    return _SearchBuildingInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchBuildingInfoProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchBuildingInfoRef on AutoDisposeFutureProviderRef<BuildingBasicInfo> {
  /// The parameter `address` of this provider.
  String get address;
}

class _SearchBuildingInfoProviderElement
    extends AutoDisposeFutureProviderElement<BuildingBasicInfo>
    with SearchBuildingInfoRef {
  _SearchBuildingInfoProviderElement(super.provider);

  @override
  String get address => (origin as SearchBuildingInfoProvider).address;
}

String _$analyzeBuildingStructureHash() =>
    r'249aaaa21e63f02d18422d69d9cc0b125d1b0d6a';

/// 건축물 구조 분석 Provider
///
/// Copied from [analyzeBuildingStructure].
@ProviderFor(analyzeBuildingStructure)
const analyzeBuildingStructureProvider = AnalyzeBuildingStructureFamily();

/// 건축물 구조 분석 Provider
///
/// Copied from [analyzeBuildingStructure].
class AnalyzeBuildingStructureFamily
    extends Family<AsyncValue<StructureAnalysisResult>> {
  /// 건축물 구조 분석 Provider
  ///
  /// Copied from [analyzeBuildingStructure].
  const AnalyzeBuildingStructureFamily();

  /// 건축물 구조 분석 Provider
  ///
  /// Copied from [analyzeBuildingStructure].
  AnalyzeBuildingStructureProvider call(String address) {
    return AnalyzeBuildingStructureProvider(address);
  }

  @override
  AnalyzeBuildingStructureProvider getProviderOverride(
    covariant AnalyzeBuildingStructureProvider provider,
  ) {
    return call(provider.address);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'analyzeBuildingStructureProvider';
}

/// 건축물 구조 분석 Provider
///
/// Copied from [analyzeBuildingStructure].
class AnalyzeBuildingStructureProvider
    extends AutoDisposeFutureProvider<StructureAnalysisResult> {
  /// 건축물 구조 분석 Provider
  ///
  /// Copied from [analyzeBuildingStructure].
  AnalyzeBuildingStructureProvider(String address)
    : this._internal(
        (ref) => analyzeBuildingStructure(
          ref as AnalyzeBuildingStructureRef,
          address,
        ),
        from: analyzeBuildingStructureProvider,
        name: r'analyzeBuildingStructureProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$analyzeBuildingStructureHash,
        dependencies: AnalyzeBuildingStructureFamily._dependencies,
        allTransitiveDependencies:
            AnalyzeBuildingStructureFamily._allTransitiveDependencies,
        address: address,
      );

  AnalyzeBuildingStructureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<StructureAnalysisResult> Function(
      AnalyzeBuildingStructureRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AnalyzeBuildingStructureProvider._internal(
        (ref) => create(ref as AnalyzeBuildingStructureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<StructureAnalysisResult> createElement() {
    return _AnalyzeBuildingStructureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnalyzeBuildingStructureProvider &&
        other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AnalyzeBuildingStructureRef
    on AutoDisposeFutureProviderRef<StructureAnalysisResult> {
  /// The parameter `address` of this provider.
  String get address;
}

class _AnalyzeBuildingStructureProviderElement
    extends AutoDisposeFutureProviderElement<StructureAnalysisResult>
    with AnalyzeBuildingStructureRef {
  _AnalyzeBuildingStructureProviderElement(super.provider);

  @override
  String get address => (origin as AnalyzeBuildingStructureProvider).address;
}

String _$analysisResultCacheHash() =>
    r'aacea5d3efaee8094cc1a989fcf85fbb2cdd521a';

/// 분석 결과 캐시 관리 Provider
///
/// Copied from [AnalysisResultCache].
@ProviderFor(AnalysisResultCache)
final analysisResultCacheProvider = AutoDisposeNotifierProvider<
  AnalysisResultCache,
  Map<String, StructureAnalysisResult>
>.internal(
  AnalysisResultCache.new,
  name: r'analysisResultCacheProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$analysisResultCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AnalysisResultCache =
    AutoDisposeNotifier<Map<String, StructureAnalysisResult>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
