/// 행정구역 정보를 나타내는 엔티티
class Region {
  /// 통합분류코드 (고유 식별자)
  final int unifiedCode;

  /// 시군구코드 (행정구역 코드)
  final String sigunguCode;

  /// 시군구명 (행정구역 이름)
  final String sigunguName;

  /// 비자치구 여부 (true: 자치구, false: 비자치구)
  final bool isAutonomousDistrict;

  /// 상위 지역 코드 (시도 단위)
  final String? parentCode;

  /// 지역 레벨 (1: 시도, 2: 시군구, 3: 읍면동)
  final int level;

  const Region({
    required this.unifiedCode,
    required this.sigunguCode,
    required this.sigunguName,
    required this.isAutonomousDistrict,
    this.parentCode,
    required this.level,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Region &&
          runtimeType == other.runtimeType &&
          unifiedCode == other.unifiedCode;

  @override
  int get hashCode => unifiedCode.hashCode;

  @override
  String toString() {
    return 'Region{unifiedCode: $unifiedCode, sigunguCode: $sigunguCode, sigunguName: $sigunguName, isAutonomousDistrict: $isAutonomousDistrict, level: $level}';
  }
}
