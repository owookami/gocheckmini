/// 법정동 정보를 나타내는 엔티티
class Bjdong {
  /// 법정동 코드 (10자리)
  final String bjdongCode;

  /// 법정동명
  final String bjdongName;

  /// 시도 코드
  final String sidoCode;

  /// 시도명
  final String sidoName;

  /// 시군구 코드
  final String sigunguCode;

  /// 시군구명
  final String sigunguName;

  /// 읍면동 구분 (읍/면/동)
  final BjdongType bjdongType;

  /// 폐지 여부
  final bool isAbolished;

  /// 생성일
  final DateTime? createdDate;

  /// 폐지일
  final DateTime? abolishedDate;

  const Bjdong({
    required this.bjdongCode,
    required this.bjdongName,
    required this.sidoCode,
    required this.sidoName,
    required this.sigunguCode,
    required this.sigunguName,
    required this.bjdongType,
    this.isAbolished = false,
    this.createdDate,
    this.abolishedDate,
  });

  /// 전체 주소 표시 (시도 + 시군구 + 법정동)
  String get fullAddress => '$sidoName $sigunguName $bjdongName';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bjdong &&
          runtimeType == other.runtimeType &&
          bjdongCode == other.bjdongCode;

  @override
  int get hashCode => bjdongCode.hashCode;

  @override
  String toString() {
    return 'Bjdong{bjdongCode: $bjdongCode, bjdongName: $bjdongName, fullAddress: $fullAddress}';
  }
}

/// 법정동 유형
enum BjdongType {
  /// 읍
  eup,

  /// 면
  myeon,

  /// 동
  dong;

  /// 한국어 표시명
  String get displayName {
    switch (this) {
      case BjdongType.eup:
        return '읍';
      case BjdongType.myeon:
        return '면';
      case BjdongType.dong:
        return '동';
    }
  }

  /// 이름에서 유형 추론
  static BjdongType fromName(String name) {
    if (name.endsWith('읍')) return BjdongType.eup;
    if (name.endsWith('면')) return BjdongType.myeon;
    return BjdongType.dong; // 기본값은 동
  }
}
