/// 주차장 정보를 나타내는 엔티티
class ParkingLot {
  /// 고유 식별자
  final String id;

  /// 주차장명
  final String name;

  /// 주소
  final String address;

  /// 상세주소
  final String? detailAddress;

  /// 주차장 구분 (일반/부설)
  final ParkingLotType type;

  /// 총 주차대수
  final int totalCapacity;

  /// 현재 주차가능 대수
  final int? availableSpots;

  /// 운영시간 시작
  final String? operatingHoursStart;

  /// 운영시간 종료
  final String? operatingHoursEnd;

  /// 주차요금 정보
  final String? feeInfo;

  /// 전화번호
  final String? phoneNumber;

  /// 위도
  final double? latitude;

  /// 경도
  final double? longitude;

  /// 시설정보
  final String? facilityInfo;

  /// 면적 (공작물관리대장용)
  final double? area;

  /// 관리기관
  final String? managementAgency;

  /// 지역 코드
  final String regionCode;

  /// 데이터 수집일시
  final DateTime? lastUpdated;

  const ParkingLot({
    required this.id,
    required this.name,
    required this.address,
    this.detailAddress,
    required this.type,
    required this.totalCapacity,
    this.availableSpots,
    this.operatingHoursStart,
    this.operatingHoursEnd,
    this.feeInfo,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.facilityInfo,
    this.area,
    this.managementAgency,
    required this.regionCode,
    this.lastUpdated,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParkingLot && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ParkingLot{id: $id, name: $name, address: $address, type: $type, totalCapacity: $totalCapacity}';
  }
}

/// 주차장 유형
enum ParkingLotType {
  /// 일반 주차장
  general,

  /// 부설 주차장
  attached,

  /// 건축인허가 공작물
  structure;

  /// 한국어 표시명
  String get displayName {
    switch (this) {
      case ParkingLotType.general:
        return '일반주차장';
      case ParkingLotType.attached:
        return '부설주차장';
      case ParkingLotType.structure:
        return '건축인허가 공작물';
    }
  }
}
