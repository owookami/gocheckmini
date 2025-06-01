// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParkingLotResponseImpl _$$ParkingLotResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ParkingLotResponseImpl(
  resultCode: json['resultCode'] as String,
  resultMsg: json['resultMsg'] as String,
  numOfRows: (json['numOfRows'] as num).toInt(),
  pageNo: (json['pageNo'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  items:
      (json['items'] as List<dynamic>)
          .map((e) => ParkingLotInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$ParkingLotResponseImplToJson(
  _$ParkingLotResponseImpl instance,
) => <String, dynamic>{
  'resultCode': instance.resultCode,
  'resultMsg': instance.resultMsg,
  'numOfRows': instance.numOfRows,
  'pageNo': instance.pageNo,
  'totalCount': instance.totalCount,
  'items': instance.items,
};

_$AttachedParkingLotResponseImpl _$$AttachedParkingLotResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AttachedParkingLotResponseImpl(
  resultCode: json['resultCode'] as String,
  resultMsg: json['resultMsg'] as String,
  numOfRows: (json['numOfRows'] as num).toInt(),
  pageNo: (json['pageNo'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  items:
      (json['items'] as List<dynamic>)
          .map(
            (e) => AttachedParkingLotInfo.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$$AttachedParkingLotResponseImplToJson(
  _$AttachedParkingLotResponseImpl instance,
) => <String, dynamic>{
  'resultCode': instance.resultCode,
  'resultMsg': instance.resultMsg,
  'numOfRows': instance.numOfRows,
  'pageNo': instance.pageNo,
  'totalCount': instance.totalCount,
  'items': instance.items,
};

_$ParkingLotInfoImpl _$$ParkingLotInfoImplFromJson(Map<String, dynamic> json) =>
    _$ParkingLotInfoImpl(
      parkingPlaceNo: json['prkplceNo'] as String,
      parkingPlaceName: json['prkplceNm'] as String,
      parkingPlaceType: json['prkplceSe'] as String,
      parkingType: json['prkplceType'] as String,
      roadAddress: json['rdnmadr'] as String,
      address: json['lnmadr'] as String,
      parkingSpace: (json['prkcmprt'] as num).toInt(),
      feeType: json['feedSe'] as String,
      enforceType: json['enforceSe'] as String,
      operatingDays: json['operDay'] as String,
      operatingStartTime: json['operOpenHm'] as String,
      operatingEndTime: json['operColseHm'] as String,
      satOperatingStartTime: json['satOperOpenHm'] as String,
      satOperatingEndTime: json['satOperCloseHm'] as String,
      holidayOperatingStartTime: json['holidayOperOpenHm'] as String,
      holidayOperatingEndTime: json['holidayCloseOpenHm'] as String,
      parkingFeeInfo: json['parkingchrgeInfo'] as String,
      basicTime: json['basicTime'] as String,
      basicCharge: json['basicCharge'] as String,
      addUnitTime: json['addUnitTime'] as String,
      addUnitCharge: json['addUnitCharge'] as String,
      dayCommutingTicket: json['dayCmmtkt'] as String,
      monthCommutingTicket: json['monthCmmtkt'] as String,
      paymentMethod: json['metpay'] as String,
      specialNote: json['spcmnt'] as String,
      institutionName: json['institutionNm'] as String,
      phoneNumber: json['phoneNumber'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      referenceDate: json['referenceDate'] as String,
      institutionCode: json['instt_code'] as String,
      institutionProviderName: json['instt_nm'] as String,
    );

Map<String, dynamic> _$$ParkingLotInfoImplToJson(
  _$ParkingLotInfoImpl instance,
) => <String, dynamic>{
  'prkplceNo': instance.parkingPlaceNo,
  'prkplceNm': instance.parkingPlaceName,
  'prkplceSe': instance.parkingPlaceType,
  'prkplceType': instance.parkingType,
  'rdnmadr': instance.roadAddress,
  'lnmadr': instance.address,
  'prkcmprt': instance.parkingSpace,
  'feedSe': instance.feeType,
  'enforceSe': instance.enforceType,
  'operDay': instance.operatingDays,
  'operOpenHm': instance.operatingStartTime,
  'operColseHm': instance.operatingEndTime,
  'satOperOpenHm': instance.satOperatingStartTime,
  'satOperCloseHm': instance.satOperatingEndTime,
  'holidayOperOpenHm': instance.holidayOperatingStartTime,
  'holidayCloseOpenHm': instance.holidayOperatingEndTime,
  'parkingchrgeInfo': instance.parkingFeeInfo,
  'basicTime': instance.basicTime,
  'basicCharge': instance.basicCharge,
  'addUnitTime': instance.addUnitTime,
  'addUnitCharge': instance.addUnitCharge,
  'dayCmmtkt': instance.dayCommutingTicket,
  'monthCmmtkt': instance.monthCommutingTicket,
  'metpay': instance.paymentMethod,
  'spcmnt': instance.specialNote,
  'institutionNm': instance.institutionName,
  'phoneNumber': instance.phoneNumber,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'referenceDate': instance.referenceDate,
  'instt_code': instance.institutionCode,
  'instt_nm': instance.institutionProviderName,
};

_$AttachedParkingLotInfoImpl _$$AttachedParkingLotInfoImplFromJson(
  Map<String, dynamic> json,
) => _$AttachedParkingLotInfoImpl(
  parkingPlaceNo: json['prkplceNo'] as String,
  parkingPlaceName: json['prkplceNm'] as String,
  parkingPlaceType: json['prkplceSe'] as String,
  parkingType: json['prkplceType'] as String,
  roadAddress: json['rdnmadr'] as String,
  address: json['lnmadr'] as String,
  parkingSpace: (json['prkcmprt'] as num).toInt(),
  feeType: json['feedSe'] as String,
  enforceType: json['enforceSe'] as String,
  operatingDays: json['operDay'] as String,
  operatingStartTime: json['operOpenHm'] as String,
  operatingEndTime: json['operColseHm'] as String,
  satOperatingStartTime: json['satOperOpenHm'] as String,
  satOperatingEndTime: json['satOperCloseHm'] as String,
  holidayOperatingStartTime: json['holidayOperOpenHm'] as String,
  holidayOperatingEndTime: json['holidayCloseOpenHm'] as String,
  parkingFeeInfo: json['parkingchrgeInfo'] as String,
  basicTime: json['basicTime'] as String,
  basicCharge: json['basicCharge'] as String,
  addUnitTime: json['addUnitTime'] as String,
  addUnitCharge: json['addUnitCharge'] as String,
  dayCommutingTicket: json['dayCmmtkt'] as String,
  monthCommutingTicket: json['monthCmmtkt'] as String,
  paymentMethod: json['metpay'] as String,
  specialNote: json['spcmnt'] as String,
  institutionName: json['institutionNm'] as String,
  phoneNumber: json['phoneNumber'] as String,
  latitude: json['latitude'] as String,
  longitude: json['longitude'] as String,
  referenceDate: json['referenceDate'] as String,
  institutionCode: json['instt_code'] as String,
  institutionProviderName: json['instt_nm'] as String,
);

Map<String, dynamic> _$$AttachedParkingLotInfoImplToJson(
  _$AttachedParkingLotInfoImpl instance,
) => <String, dynamic>{
  'prkplceNo': instance.parkingPlaceNo,
  'prkplceNm': instance.parkingPlaceName,
  'prkplceSe': instance.parkingPlaceType,
  'prkplceType': instance.parkingType,
  'rdnmadr': instance.roadAddress,
  'lnmadr': instance.address,
  'prkcmprt': instance.parkingSpace,
  'feedSe': instance.feeType,
  'enforceSe': instance.enforceType,
  'operDay': instance.operatingDays,
  'operOpenHm': instance.operatingStartTime,
  'operColseHm': instance.operatingEndTime,
  'satOperOpenHm': instance.satOperatingStartTime,
  'satOperCloseHm': instance.satOperatingEndTime,
  'holidayOperOpenHm': instance.holidayOperatingStartTime,
  'holidayCloseOpenHm': instance.holidayOperatingEndTime,
  'parkingchrgeInfo': instance.parkingFeeInfo,
  'basicTime': instance.basicTime,
  'basicCharge': instance.basicCharge,
  'addUnitTime': instance.addUnitTime,
  'addUnitCharge': instance.addUnitCharge,
  'dayCmmtkt': instance.dayCommutingTicket,
  'monthCmmtkt': instance.monthCommutingTicket,
  'metpay': instance.paymentMethod,
  'spcmnt': instance.specialNote,
  'institutionNm': instance.institutionName,
  'phoneNumber': instance.phoneNumber,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'referenceDate': instance.referenceDate,
  'instt_code': instance.institutionCode,
  'instt_nm': instance.institutionProviderName,
};
