import 'package:freezed_annotation/freezed_annotation.dart';

part 'standard_region_model.freezed.dart';
part 'standard_region_model.g.dart';

/// 행정안전부 표준 지역 코드 모델
@freezed
class StandardRegion with _$StandardRegion {
  const factory StandardRegion({
    @JsonKey(name: 'region_cd') String? regionCd, // 지역코드 (10자리)
    @JsonKey(name: 'sido_cd') String? sidoCd, // 시도코드 (2자리)
    @JsonKey(name: 'sgg_cd') String? sggCd, // 시군구코드 (3자리)
    @JsonKey(name: 'umd_cd') String? umdCd, // 읍면동코드 (3자리)
    @JsonKey(name: 'ri_cd') String? riCd, // 리코드 (2자리)
    @JsonKey(name: 'locatjumin_cd') String? locatjuminCd, // 지역코드_주민
    @JsonKey(name: 'locatjijuk_cd') String? locatjijukCd, // 지역코드_지적
    @JsonKey(name: 'locatadd_nm') String? locataddNm, // 지역주소명
    @JsonKey(name: 'locat_order') int? locatOrder, // 서열
    @JsonKey(name: 'locat_rm') String? locatRm, // 비고
    @JsonKey(name: 'locathigh_cd') String? locathighCd, // 상위지역코드
    @JsonKey(name: 'locatlow_nm') String? locatlowNm, // 최하위지역명
    @JsonKey(name: 'adpt_de') String? adptDe, // 생성일
  }) = _StandardRegion;

  factory StandardRegion.fromJson(Map<String, dynamic> json) =>
      _$StandardRegionFromJson(json);
}

/// 지역 유형 enum
enum RegionType {
  sido, // 시도 (sgg_cd, umd_cd가 000 또는 null)
  sigungu, // 시군구 (umd_cd가 000 또는 null, sgg_cd는 000이 아님)
  umd, // 읍면동 (umd_cd가 000이 아님)
}

/// 표준 지역 확장 메서드
extension StandardRegionX on StandardRegion {
  /// 지역 유형 판별
  RegionType get type {
    if (sggCd == null || sggCd == '000') {
      return RegionType.sido;
    } else if (umdCd == null || umdCd == '000') {
      return RegionType.sigungu;
    } else {
      return RegionType.umd;
    }
  }

  /// 시도명 추출
  String get sidoName {
    final name = locataddNm ?? '';
    if (name.contains(' ')) {
      return name.split(' ').first;
    }
    return name;
  }

  /// 시군구명 추출
  String get sigunguName {
    final name = locataddNm ?? '';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return parts[1];
    }
    return '';
  }

  /// 읍면동명 추출
  String get umdName {
    final name = locataddNm ?? '';
    final parts = name.split(' ');
    if (parts.length >= 3) {
      return parts[2];
    }
    return '';
  }

  /// 표시용 이름 (계층에 따라 다르게)
  String get displayName {
    switch (type) {
      case RegionType.sido:
        return sidoName;
      case RegionType.sigungu:
        return sigunguName.isNotEmpty ? sigunguName : (locataddNm ?? '');
      case RegionType.umd:
        return umdName.isNotEmpty ? umdName : (locataddNm ?? '');
    }
  }

  /// 주차장 API에서 사용할 지역 코드 조합
  String get apiRegionCode {
    // 주차장 API는 sigunguCd + bjdongCd 형식
    final baseCode = sidoCd ?? '';
    final sggCode = sggCd ?? '000';
    return baseCode + sggCode;
  }

  /// 법정동 코드 (읍면동 코드)
  String get bjdongCode {
    return umdCd ?? '000';
  }

  /// 전체 지역 코드 (10자리)
  String get fullRegionCode {
    final sido = sidoCd ?? '00';
    final sgg = sggCd ?? '000';
    final umd = umdCd ?? '000';
    final ri = riCd ?? '00';
    return sido + sgg + umd + ri;
  }
}

/// 표준 지역 코드 API 응답 래퍼
@freezed
class StandardRegionResponse with _$StandardRegionResponse {
  const factory StandardRegionResponse({
    required StandardRegionResponseHeader header,
    required StandardRegionResponseBody body,
  }) = _StandardRegionResponse;

  factory StandardRegionResponse.fromJson(Map<String, dynamic> json) =>
      _$StandardRegionResponseFromJson(json);
}

/// API 응답 헤더
@freezed
class StandardRegionResponseHeader with _$StandardRegionResponseHeader {
  const factory StandardRegionResponseHeader({
    @JsonKey(name: 'resultCode') String? resultCode,
    @JsonKey(name: 'resultMsg') String? resultMsg,
  }) = _StandardRegionResponseHeader;

  factory StandardRegionResponseHeader.fromJson(Map<String, dynamic> json) =>
      _$StandardRegionResponseHeaderFromJson(json);
}

/// API 응답 바디
@freezed
class StandardRegionResponseBody with _$StandardRegionResponseBody {
  const factory StandardRegionResponseBody({
    @JsonKey(name: 'numOfRows') int? numOfRows,
    @JsonKey(name: 'pageNo') int? pageNo,
    @JsonKey(name: 'totalCount') int? totalCount,
    @JsonKey(name: 'items') StandardRegionItems? items,
  }) = _StandardRegionResponseBody;

  factory StandardRegionResponseBody.fromJson(Map<String, dynamic> json) =>
      _$StandardRegionResponseBodyFromJson(json);
}

/// API 응답 아이템 래퍼
@freezed
class StandardRegionItems with _$StandardRegionItems {
  const factory StandardRegionItems({
    @JsonKey(name: 'item') List<StandardRegion>? item,
  }) = _StandardRegionItems;

  factory StandardRegionItems.fromJson(Map<String, dynamic> json) =>
      _$StandardRegionItemsFromJson(json);
}
