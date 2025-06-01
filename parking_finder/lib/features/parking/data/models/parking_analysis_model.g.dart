// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_analysis_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParkingAnalysisModelImpl _$$ParkingAnalysisModelImplFromJson(
  Map<String, dynamic> json,
) => _$ParkingAnalysisModelImpl(
  buildYear: (json['buildYear'] as num).toInt(),
  floors: (json['floors'] as num).toInt(),
  area: (json['area'] as num).toDouble(),
  buildingUse: json['buildingUse'] as String,
  structureType: json['structureType'] as String,
  location: json['location'] as String,
  steelDeckProbability: (json['steelDeckProbability'] as num).toDouble(),
  address: json['address'] as String,
  buildingName: json['buildingName'] as String?,
  permitDate: json['permitDate'] as String?,
  approvalDate: json['approvalDate'] as String?,
  landArea: (json['landArea'] as num?)?.toDouble(),
  buildingCoverageRatio: (json['buildingCoverageRatio'] as num?)?.toDouble(),
  floorAreaRatio: (json['floorAreaRatio'] as num?)?.toDouble(),
  groundFloors: (json['groundFloors'] as num?)?.toInt(),
  undergroundFloors: (json['undergroundFloors'] as num?)?.toInt(),
  analysisDateTime:
      json['analysisDateTime'] == null
          ? null
          : DateTime.parse(json['analysisDateTime'] as String),
);

Map<String, dynamic> _$$ParkingAnalysisModelImplToJson(
  _$ParkingAnalysisModelImpl instance,
) => <String, dynamic>{
  'buildYear': instance.buildYear,
  'floors': instance.floors,
  'area': instance.area,
  'buildingUse': instance.buildingUse,
  'structureType': instance.structureType,
  'location': instance.location,
  'steelDeckProbability': instance.steelDeckProbability,
  'address': instance.address,
  'buildingName': instance.buildingName,
  'permitDate': instance.permitDate,
  'approvalDate': instance.approvalDate,
  'landArea': instance.landArea,
  'buildingCoverageRatio': instance.buildingCoverageRatio,
  'floorAreaRatio': instance.floorAreaRatio,
  'groundFloors': instance.groundFloors,
  'undergroundFloors': instance.undergroundFloors,
  'analysisDateTime': instance.analysisDateTime?.toIso8601String(),
};

_$StructureAnalysisResultImpl _$$StructureAnalysisResultImplFromJson(
  Map<String, dynamic> json,
) => _$StructureAnalysisResultImpl(
  probability: (json['probability'] as num).toDouble(),
  scoreDetails: AnalysisScoreDetails.fromJson(
    json['scoreDetails'] as Map<String, dynamic>,
  ),
  isRecommended: json['isRecommended'] as bool,
  confidence: (json['confidence'] as num).toDouble(),
  explanation: json['explanation'] as String,
  riskFactors:
      (json['riskFactors'] as List<dynamic>).map((e) => e as String).toList(),
  advantages:
      (json['advantages'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$$StructureAnalysisResultImplToJson(
  _$StructureAnalysisResultImpl instance,
) => <String, dynamic>{
  'probability': instance.probability,
  'scoreDetails': instance.scoreDetails,
  'isRecommended': instance.isRecommended,
  'confidence': instance.confidence,
  'explanation': instance.explanation,
  'riskFactors': instance.riskFactors,
  'advantages': instance.advantages,
};

_$AnalysisScoreDetailsImpl _$$AnalysisScoreDetailsImplFromJson(
  Map<String, dynamic> json,
) => _$AnalysisScoreDetailsImpl(
  buildYearScore: (json['buildYearScore'] as num).toDouble(),
  floorsScore: (json['floorsScore'] as num).toDouble(),
  areaScore: (json['areaScore'] as num).toDouble(),
  structureTypeScore: (json['structureTypeScore'] as num).toDouble(),
  buildingUseScore: (json['buildingUseScore'] as num).toDouble(),
  totalScore: (json['totalScore'] as num).toDouble(),
);

Map<String, dynamic> _$$AnalysisScoreDetailsImplToJson(
  _$AnalysisScoreDetailsImpl instance,
) => <String, dynamic>{
  'buildYearScore': instance.buildYearScore,
  'floorsScore': instance.floorsScore,
  'areaScore': instance.areaScore,
  'structureTypeScore': instance.structureTypeScore,
  'buildingUseScore': instance.buildingUseScore,
  'totalScore': instance.totalScore,
};

_$BuildingBasicInfoImpl _$$BuildingBasicInfoImplFromJson(
  Map<String, dynamic> json,
) => _$BuildingBasicInfoImpl(
  address: json['address'] as String,
  buildingName: json['buildingName'] as String?,
  buildYear: (json['buildYear'] as num?)?.toInt(),
  structureType: json['structureType'] as String?,
  buildingUse: json['buildingUse'] as String?,
  groundFloors: (json['groundFloors'] as num?)?.toInt(),
  undergroundFloors: (json['undergroundFloors'] as num?)?.toInt(),
  totalArea: (json['totalArea'] as num?)?.toDouble(),
  landArea: (json['landArea'] as num?)?.toDouble(),
  buildingCoverageRatio: (json['buildingCoverageRatio'] as num?)?.toDouble(),
  floorAreaRatio: (json['floorAreaRatio'] as num?)?.toDouble(),
  permitDate: json['permitDate'] as String?,
  approvalDate: json['approvalDate'] as String?,
  isSuccess: json['isSuccess'] as bool,
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$$BuildingBasicInfoImplToJson(
  _$BuildingBasicInfoImpl instance,
) => <String, dynamic>{
  'address': instance.address,
  'buildingName': instance.buildingName,
  'buildYear': instance.buildYear,
  'structureType': instance.structureType,
  'buildingUse': instance.buildingUse,
  'groundFloors': instance.groundFloors,
  'undergroundFloors': instance.undergroundFloors,
  'totalArea': instance.totalArea,
  'landArea': instance.landArea,
  'buildingCoverageRatio': instance.buildingCoverageRatio,
  'floorAreaRatio': instance.floorAreaRatio,
  'permitDate': instance.permitDate,
  'approvalDate': instance.approvalDate,
  'isSuccess': instance.isSuccess,
  'errorMessage': instance.errorMessage,
};

_$AnalysisProgressStateImpl _$$AnalysisProgressStateImplFromJson(
  Map<String, dynamic> json,
) => _$AnalysisProgressStateImpl(
  isAnalyzing: json['isAnalyzing'] as bool,
  currentAddress: json['currentAddress'] as String?,
  totalCount: (json['totalCount'] as num).toInt(),
  completedCount: (json['completedCount'] as num).toInt(),
  errorCount: (json['errorCount'] as num).toInt(),
);

Map<String, dynamic> _$$AnalysisProgressStateImplToJson(
  _$AnalysisProgressStateImpl instance,
) => <String, dynamic>{
  'isAnalyzing': instance.isAnalyzing,
  'currentAddress': instance.currentAddress,
  'totalCount': instance.totalCount,
  'completedCount': instance.completedCount,
  'errorCount': instance.errorCount,
};
