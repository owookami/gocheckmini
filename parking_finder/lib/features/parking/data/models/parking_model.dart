import 'package:freezed_annotation/freezed_annotation.dart';

part 'parking_model.freezed.dart';
part 'parking_model.g.dart';

/// 일반 주차장 모델
@freezed
class GeneralParkingModel with _$GeneralParkingModel {
  const factory GeneralParkingModel({
    @JsonKey(name: 'prkplceNm') String? parkingName, // 주차장명
    @JsonKey(name: 'rdnmadr') String? roadAddress, // 도로명주소
    @JsonKey(name: 'lnmadr') String? lotAddress, // 지번주소
    @JsonKey(name: 'prkcmprt') String? parkingCapacity, // 주차면수
    @JsonKey(name: 'feedingSe') String? feedingType, // 급지구분
    @JsonKey(name: 'enforceSe') String? enforceType, // 단속구분
    @JsonKey(name: 'operDay') String? operatingDays, // 운영요일
    @JsonKey(name: 'weekdayOperOpenHhmm') String? weekdayOpenTime, // 평일운영시작시각
    @JsonKey(name: 'weekdayOperColseHhmm') String? weekdayCloseTime, // 평일운영종료시각
    @JsonKey(name: 'satOperOperOpenHhmm') String? satOpenTime, // 토요일운영시작시각
    @JsonKey(name: 'satOperCloseHhmm') String? satCloseTime, // 토요일운영종료시각
    @JsonKey(name: 'holidayOperOpenHhmm') String? holidayOpenTime, // 공휴일운영시작시각
    @JsonKey(name: 'holidayCloseOpenHhmm')
    String? holidayCloseTime, // 공휴일운영종료시각
    @JsonKey(name: 'parkingchrgeInfo') String? parkingFeeInfo, // 주차요금정보
    @JsonKey(name: 'basicTime') String? basicTime, // 기본시간
    @JsonKey(name: 'basicCharge') String? basicCharge, // 기본요금
    @JsonKey(name: 'addUnitTime') String? addUnitTime, // 추가단위시간
    @JsonKey(name: 'addUnitCharge') String? addUnitCharge, // 추가단위요금
    @JsonKey(name: 'dayCmmtkt') String? dayTicket, // 일일주차권요금
    @JsonKey(name: 'monthCmmtkt') String? monthTicket, // 월정기권요금
    @JsonKey(name: 'metpay') String? paymentMethod, // 결제방법
    @JsonKey(name: 'spcmnt') String? specialNote, // 특기사항
    @JsonKey(name: 'institutionNm') String? institutionName, // 관리기관명
    @JsonKey(name: 'phoneNumber') String? phoneNumber, // 전화번호
    @JsonKey(name: 'latitude') String? latitude, // 위도
    @JsonKey(name: 'longitude') String? longitude, // 경도
    @JsonKey(name: 'referenceDate') String? referenceDate, // 데이터기준일자
  }) = _GeneralParkingModel;

  factory GeneralParkingModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralParkingModelFromJson(json);
}

/// 부설 주차장 모델
@freezed
class AttachedParkingModel with _$AttachedParkingModel {
  const factory AttachedParkingModel({
    @JsonKey(name: 'platPlc') String? platPlc, // 소재지(주소)
    @JsonKey(name: 'bldNm') String? bldNm, // 건물명
    @JsonKey(name: 'totPkngCnt') int? totPkngCnt, // 총 주차면수
    @JsonKey(name: 'curPkngCnt') int? curPkngCnt, // 현재 주차대수
    @JsonKey(name: 'pkngPosblCnt') int? pkngPosblCnt, // 주차가능대수
    @JsonKey(name: 'useYn') String? useYn, // 사용여부
    @JsonKey(name: 'ngtUseYn') String? ngtUseYn, // 야간사용여부
    @JsonKey(name: 'feeYn') String? feeYn, // 유료여부
    @JsonKey(name: 'pkngChrg') String? pkngChrg, // 주차요금
    @JsonKey(name: 'oprDay') String? oprDay, // 운영요일
    @JsonKey(name: 'satSttTm') String? satSttTm, // 토요일시작시간
    @JsonKey(name: 'satEndTm') String? satEndTm, // 토요일종료시간
    @JsonKey(name: 'hldSttTm') String? hldSttTm, // 공휴일시작시간
    @JsonKey(name: 'hldEndTm') String? hldEndTm, // 공휴일종료시간
    @JsonKey(name: 'syncTime') String? syncTime, // 동기화시간
    @JsonKey(name: 'institutionCode') String? institutionCode, // 기관코드
    @JsonKey(name: 'institutionName') String? institutionName, // 기관명
    @JsonKey(name: 'phoneNumber') String? phoneNumber, // 전화번호
  }) = _AttachedParkingModel;

  factory AttachedParkingModel.fromJson(Map<String, dynamic> json) =>
      _$AttachedParkingModelFromJson(json);
}
