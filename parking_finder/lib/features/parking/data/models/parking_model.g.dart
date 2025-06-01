// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeneralParkingModelImpl _$$GeneralParkingModelImplFromJson(
  Map<String, dynamic> json,
) => _$GeneralParkingModelImpl(
  parkingName: json['prkplceNm'] as String?,
  roadAddress: json['rdnmadr'] as String?,
  lotAddress: json['lnmadr'] as String?,
  parkingCapacity: json['prkcmprt'] as String?,
  feedingType: json['feedingSe'] as String?,
  enforceType: json['enforceSe'] as String?,
  operatingDays: json['operDay'] as String?,
  weekdayOpenTime: json['weekdayOperOpenHhmm'] as String?,
  weekdayCloseTime: json['weekdayOperColseHhmm'] as String?,
  satOpenTime: json['satOperOperOpenHhmm'] as String?,
  satCloseTime: json['satOperCloseHhmm'] as String?,
  holidayOpenTime: json['holidayOperOpenHhmm'] as String?,
  holidayCloseTime: json['holidayCloseOpenHhmm'] as String?,
  parkingFeeInfo: json['parkingchrgeInfo'] as String?,
  basicTime: json['basicTime'] as String?,
  basicCharge: json['basicCharge'] as String?,
  addUnitTime: json['addUnitTime'] as String?,
  addUnitCharge: json['addUnitCharge'] as String?,
  dayTicket: json['dayCmmtkt'] as String?,
  monthTicket: json['monthCmmtkt'] as String?,
  paymentMethod: json['metpay'] as String?,
  specialNote: json['spcmnt'] as String?,
  institutionName: json['institutionNm'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
  referenceDate: json['referenceDate'] as String?,
);

Map<String, dynamic> _$$GeneralParkingModelImplToJson(
  _$GeneralParkingModelImpl instance,
) => <String, dynamic>{
  'prkplceNm': instance.parkingName,
  'rdnmadr': instance.roadAddress,
  'lnmadr': instance.lotAddress,
  'prkcmprt': instance.parkingCapacity,
  'feedingSe': instance.feedingType,
  'enforceSe': instance.enforceType,
  'operDay': instance.operatingDays,
  'weekdayOperOpenHhmm': instance.weekdayOpenTime,
  'weekdayOperColseHhmm': instance.weekdayCloseTime,
  'satOperOperOpenHhmm': instance.satOpenTime,
  'satOperCloseHhmm': instance.satCloseTime,
  'holidayOperOpenHhmm': instance.holidayOpenTime,
  'holidayCloseOpenHhmm': instance.holidayCloseTime,
  'parkingchrgeInfo': instance.parkingFeeInfo,
  'basicTime': instance.basicTime,
  'basicCharge': instance.basicCharge,
  'addUnitTime': instance.addUnitTime,
  'addUnitCharge': instance.addUnitCharge,
  'dayCmmtkt': instance.dayTicket,
  'monthCmmtkt': instance.monthTicket,
  'metpay': instance.paymentMethod,
  'spcmnt': instance.specialNote,
  'institutionNm': instance.institutionName,
  'phoneNumber': instance.phoneNumber,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'referenceDate': instance.referenceDate,
};

_$AttachedParkingModelImpl _$$AttachedParkingModelImplFromJson(
  Map<String, dynamic> json,
) => _$AttachedParkingModelImpl(
  platPlc: json['platPlc'] as String?,
  bldNm: json['bldNm'] as String?,
  totPkngCnt: (json['totPkngCnt'] as num?)?.toInt(),
  curPkngCnt: (json['curPkngCnt'] as num?)?.toInt(),
  pkngPosblCnt: (json['pkngPosblCnt'] as num?)?.toInt(),
  useYn: json['useYn'] as String?,
  ngtUseYn: json['ngtUseYn'] as String?,
  feeYn: json['feeYn'] as String?,
  pkngChrg: json['pkngChrg'] as String?,
  oprDay: json['oprDay'] as String?,
  satSttTm: json['satSttTm'] as String?,
  satEndTm: json['satEndTm'] as String?,
  hldSttTm: json['hldSttTm'] as String?,
  hldEndTm: json['hldEndTm'] as String?,
  syncTime: json['syncTime'] as String?,
  institutionCode: json['institutionCode'] as String?,
  institutionName: json['institutionName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
);

Map<String, dynamic> _$$AttachedParkingModelImplToJson(
  _$AttachedParkingModelImpl instance,
) => <String, dynamic>{
  'platPlc': instance.platPlc,
  'bldNm': instance.bldNm,
  'totPkngCnt': instance.totPkngCnt,
  'curPkngCnt': instance.curPkngCnt,
  'pkngPosblCnt': instance.pkngPosblCnt,
  'useYn': instance.useYn,
  'ngtUseYn': instance.ngtUseYn,
  'feeYn': instance.feeYn,
  'pkngChrg': instance.pkngChrg,
  'oprDay': instance.oprDay,
  'satSttTm': instance.satSttTm,
  'satEndTm': instance.satEndTm,
  'hldSttTm': instance.hldSttTm,
  'hldEndTm': instance.hldEndTm,
  'syncTime': instance.syncTime,
  'institutionCode': instance.institutionCode,
  'institutionName': instance.institutionName,
  'phoneNumber': instance.phoneNumber,
};
