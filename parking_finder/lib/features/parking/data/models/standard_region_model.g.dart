// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_region_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StandardRegionImpl _$$StandardRegionImplFromJson(Map<String, dynamic> json) =>
    _$StandardRegionImpl(
      regionCd: json['region_cd'] as String?,
      sidoCd: json['sido_cd'] as String?,
      sggCd: json['sgg_cd'] as String?,
      umdCd: json['umd_cd'] as String?,
      riCd: json['ri_cd'] as String?,
      locatjuminCd: json['locatjumin_cd'] as String?,
      locatjijukCd: json['locatjijuk_cd'] as String?,
      locataddNm: json['locatadd_nm'] as String?,
      locatOrder: (json['locat_order'] as num?)?.toInt(),
      locatRm: json['locat_rm'] as String?,
      locathighCd: json['locathigh_cd'] as String?,
      locatlowNm: json['locatlow_nm'] as String?,
      adptDe: json['adpt_de'] as String?,
    );

Map<String, dynamic> _$$StandardRegionImplToJson(
  _$StandardRegionImpl instance,
) => <String, dynamic>{
  'region_cd': instance.regionCd,
  'sido_cd': instance.sidoCd,
  'sgg_cd': instance.sggCd,
  'umd_cd': instance.umdCd,
  'ri_cd': instance.riCd,
  'locatjumin_cd': instance.locatjuminCd,
  'locatjijuk_cd': instance.locatjijukCd,
  'locatadd_nm': instance.locataddNm,
  'locat_order': instance.locatOrder,
  'locat_rm': instance.locatRm,
  'locathigh_cd': instance.locathighCd,
  'locatlow_nm': instance.locatlowNm,
  'adpt_de': instance.adptDe,
};

_$StandardRegionResponseImpl _$$StandardRegionResponseImplFromJson(
  Map<String, dynamic> json,
) => _$StandardRegionResponseImpl(
  header: StandardRegionResponseHeader.fromJson(
    json['header'] as Map<String, dynamic>,
  ),
  body: StandardRegionResponseBody.fromJson(
    json['body'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$StandardRegionResponseImplToJson(
  _$StandardRegionResponseImpl instance,
) => <String, dynamic>{'header': instance.header, 'body': instance.body};

_$StandardRegionResponseHeaderImpl _$$StandardRegionResponseHeaderImplFromJson(
  Map<String, dynamic> json,
) => _$StandardRegionResponseHeaderImpl(
  resultCode: json['resultCode'] as String?,
  resultMsg: json['resultMsg'] as String?,
);

Map<String, dynamic> _$$StandardRegionResponseHeaderImplToJson(
  _$StandardRegionResponseHeaderImpl instance,
) => <String, dynamic>{
  'resultCode': instance.resultCode,
  'resultMsg': instance.resultMsg,
};

_$StandardRegionResponseBodyImpl _$$StandardRegionResponseBodyImplFromJson(
  Map<String, dynamic> json,
) => _$StandardRegionResponseBodyImpl(
  numOfRows: (json['numOfRows'] as num?)?.toInt(),
  pageNo: (json['pageNo'] as num?)?.toInt(),
  totalCount: (json['totalCount'] as num?)?.toInt(),
  items:
      json['items'] == null
          ? null
          : StandardRegionItems.fromJson(json['items'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StandardRegionResponseBodyImplToJson(
  _$StandardRegionResponseBodyImpl instance,
) => <String, dynamic>{
  'numOfRows': instance.numOfRows,
  'pageNo': instance.pageNo,
  'totalCount': instance.totalCount,
  'items': instance.items,
};

_$StandardRegionItemsImpl _$$StandardRegionItemsImplFromJson(
  Map<String, dynamic> json,
) => _$StandardRegionItemsImpl(
  item:
      (json['item'] as List<dynamic>?)
          ?.map((e) => StandardRegion.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$StandardRegionItemsImplToJson(
  _$StandardRegionItemsImpl instance,
) => <String, dynamic>{'item': instance.item};
