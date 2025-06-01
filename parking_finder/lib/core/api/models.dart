import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// 일반 주차장 API 응답 모델
@freezed
class ParkingLotResponse with _$ParkingLotResponse {
  const factory ParkingLotResponse({
    required String resultCode,
    required String resultMsg,
    required int numOfRows,
    required int pageNo,
    required int totalCount,
    required List<ParkingLotInfo> items,
  }) = _ParkingLotResponse;

  factory ParkingLotResponse.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotResponseFromJson(json);
}

/// 부설 주차장 API 응답 모델
@freezed
class AttachedParkingLotResponse with _$AttachedParkingLotResponse {
  const factory AttachedParkingLotResponse({
    required String resultCode,
    required String resultMsg,
    required int numOfRows,
    required int pageNo,
    required int totalCount,
    required List<AttachedParkingLotInfo> items,
  }) = _AttachedParkingLotResponse;

  factory AttachedParkingLotResponse.fromJson(Map<String, dynamic> json) =>
      _$AttachedParkingLotResponseFromJson(json);
}

/// 주차장 정보 모델 - 일반 주차장
@freezed
class ParkingLotInfo with _$ParkingLotInfo {
  const factory ParkingLotInfo({
    @JsonKey(name: 'prkplceNo') required String parkingPlaceNo, // 주차장관리번호
    @JsonKey(name: 'prkplceNm') required String parkingPlaceName, // 주차장명
    @JsonKey(name: 'prkplceSe') required String parkingPlaceType, // 주차장구분
    @JsonKey(name: 'prkplceType') required String parkingType, // 주차장유형
    @JsonKey(name: 'rdnmadr') required String roadAddress, // 소재지도로명주소
    @JsonKey(name: 'lnmadr') required String address, // 소재지지번주소
    @JsonKey(name: 'prkcmprt') required int parkingSpace, // 주차구획수
    @JsonKey(name: 'feedSe') required String feeType, // 급지구분
    @JsonKey(name: 'enforceSe') required String enforceType, // 부제시행구분
    @JsonKey(name: 'operDay') required String operatingDays, // 운영요일
    @JsonKey(name: 'operOpenHm') required String operatingStartTime, // 평일운영시작시각
    @JsonKey(name: 'operColseHm') required String operatingEndTime, // 평일운영종료시각
    @JsonKey(name: 'satOperOpenHm')
    required String satOperatingStartTime, // 토요일운영시작시각
    @JsonKey(name: 'satOperCloseHm')
    required String satOperatingEndTime, // 토요일운영종료시각
    @JsonKey(name: 'holidayOperOpenHm')
    required String holidayOperatingStartTime, // 공휴일운영시작시각
    @JsonKey(name: 'holidayCloseOpenHm')
    required String holidayOperatingEndTime, // 공휴일운영종료시각
    @JsonKey(name: 'parkingchrgeInfo') required String parkingFeeInfo, // 주차요금정보
    @JsonKey(name: 'basicTime') required String basicTime, // 주차기본시간
    @JsonKey(name: 'basicCharge') required String basicCharge, // 주차기본요금
    @JsonKey(name: 'addUnitTime') required String addUnitTime, // 추가단위시간
    @JsonKey(name: 'addUnitCharge') required String addUnitCharge, // 추가단위요금
    @JsonKey(name: 'dayCmmtkt') required String dayCommutingTicket, // 일주차권요금
    @JsonKey(name: 'monthCmmtkt')
    required String monthCommutingTicket, // 월정기권요금
    @JsonKey(name: 'metpay') required String paymentMethod, // 결제방법
    @JsonKey(name: 'spcmnt') required String specialNote, // 특기사항
    @JsonKey(name: 'institutionNm') required String institutionName, // 관리기관명
    @JsonKey(name: 'phoneNumber') required String phoneNumber, // 전화번호
    @JsonKey(name: 'latitude') required String latitude, // 위도
    @JsonKey(name: 'longitude') required String longitude, // 경도
    @JsonKey(name: 'referenceDate') required String referenceDate, // 데이터기준일자
    @JsonKey(name: 'instt_code') required String institutionCode, // 제공기관코드
    @JsonKey(name: 'instt_nm') required String institutionProviderName, // 제공기관명
  }) = _ParkingLotInfo;

  factory ParkingLotInfo.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotInfoFromJson(json);
}

/// 부설 주차장 정보 모델 - 부설 주차장
@freezed
class AttachedParkingLotInfo with _$AttachedParkingLotInfo {
  const factory AttachedParkingLotInfo({
    @JsonKey(name: 'prkplceNo') required String parkingPlaceNo, // 주차장관리번호
    @JsonKey(name: 'prkplceNm') required String parkingPlaceName, // 주차장명
    @JsonKey(name: 'prkplceSe') required String parkingPlaceType, // 주차장구분
    @JsonKey(name: 'prkplceType') required String parkingType, // 주차장유형
    @JsonKey(name: 'rdnmadr') required String roadAddress, // 소재지도로명주소
    @JsonKey(name: 'lnmadr') required String address, // 소재지지번주소
    @JsonKey(name: 'prkcmprt') required int parkingSpace, // 주차구획수
    @JsonKey(name: 'feedSe') required String feeType, // 급지구분
    @JsonKey(name: 'enforceSe') required String enforceType, // 부제시행구분
    @JsonKey(name: 'operDay') required String operatingDays, // 운영요일
    @JsonKey(name: 'operOpenHm') required String operatingStartTime, // 평일운영시작시각
    @JsonKey(name: 'operColseHm') required String operatingEndTime, // 평일운영종료시각
    @JsonKey(name: 'satOperOpenHm')
    required String satOperatingStartTime, // 토요일운영시작시각
    @JsonKey(name: 'satOperCloseHm')
    required String satOperatingEndTime, // 토요일운영종료시각
    @JsonKey(name: 'holidayOperOpenHm')
    required String holidayOperatingStartTime, // 공휴일운영시작시각
    @JsonKey(name: 'holidayCloseOpenHm')
    required String holidayOperatingEndTime, // 공휴일운영종료시각
    @JsonKey(name: 'parkingchrgeInfo') required String parkingFeeInfo, // 주차요금정보
    @JsonKey(name: 'basicTime') required String basicTime, // 주차기본시간
    @JsonKey(name: 'basicCharge') required String basicCharge, // 주차기본요금
    @JsonKey(name: 'addUnitTime') required String addUnitTime, // 추가단위시간
    @JsonKey(name: 'addUnitCharge') required String addUnitCharge, // 추가단위요금
    @JsonKey(name: 'dayCmmtkt') required String dayCommutingTicket, // 일주차권요금
    @JsonKey(name: 'monthCmmtkt')
    required String monthCommutingTicket, // 월정기권요금
    @JsonKey(name: 'metpay') required String paymentMethod, // 결제방법
    @JsonKey(name: 'spcmnt') required String specialNote, // 특기사항
    @JsonKey(name: 'institutionNm') required String institutionName, // 관리기관명
    @JsonKey(name: 'phoneNumber') required String phoneNumber, // 전화번호
    @JsonKey(name: 'latitude') required String latitude, // 위도
    @JsonKey(name: 'longitude') required String longitude, // 경도
    @JsonKey(name: 'referenceDate') required String referenceDate, // 데이터기준일자
    @JsonKey(name: 'instt_code') required String institutionCode, // 제공기관코드
    @JsonKey(name: 'instt_nm') required String institutionProviderName, // 제공기관명
  }) = _AttachedParkingLotInfo;

  factory AttachedParkingLotInfo.fromJson(Map<String, dynamic> json) =>
      _$AttachedParkingLotInfoFromJson(json);
}
