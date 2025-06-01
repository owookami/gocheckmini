import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/region.dart';

part 'region_model.freezed.dart';
part 'region_model.g.dart';

/// Region 엔티티의 데이터 모델 클래스
@freezed
class RegionModel with _$RegionModel {
  const factory RegionModel({
    /// 데이터베이스 ID (자동 증가)
    @JsonKey(name: 'id') int? id,

    /// 통합분류코드 (고유 식별자)
    @JsonKey(name: 'unified_code') @Default(0) int unifiedCode,

    /// 시군구코드 (행정구역 코드)
    @JsonKey(name: 'sigungu_code') @Default('') String sigunguCode,

    /// 시군구명 (행정구역 이름)
    @JsonKey(name: 'sigungu_name') @Default('') String sigunguName,

    /// 비자치구 여부 (true: 자치구, false: 비자치구)
    @JsonKey(
      name: 'is_autonomous_district',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    @Default(false)
    bool isAutonomousDistrict,

    /// 시도명 (상위 지역)
    @JsonKey(name: 'province') @Default('') String province,

    /// 시/군명
    @JsonKey(name: 'city') @Default('') String city,

    /// 생성일시
    @JsonKey(name: 'created_at') String? createdAt,

    /// 수정일시
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _RegionModel;

  const RegionModel._();

  /// JSON에서 모델 생성 (자동 생성 사용)
  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      _$RegionModelFromJson(json);

  /// SQLite용 Map으로 변환
  Map<String, dynamic> toMap() => toJson();

  /// 엔티티로 변환 (호환성 유지)
  Region toEntity() {
    return Region(
      unifiedCode: unifiedCode,
      sigunguCode: sigunguCode,
      sigunguName: sigunguName,
      isAutonomousDistrict: isAutonomousDistrict,
      parentCode: null, // 현재 스키마에는 없음
      level: 2, // 시군구 레벨로 고정
    );
  }

  /// 엔티티에서 모델 생성 (호환성 유지)
  factory RegionModel.fromEntity(Region entity) {
    return RegionModel(
      unifiedCode: entity.unifiedCode,
      sigunguCode: entity.sigunguCode,
      sigunguName: entity.sigunguName,
      isAutonomousDistrict: entity.isAutonomousDistrict,
      province: '', // 기본값
      city: entity.sigunguName, // 시군구명을 city로 사용
    );
  }
}

/// SQLite의 int값을 bool로 변환 (null 안전성 추가)
bool _boolFromInt(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is int) return value != 0;
  if (value is String) return value.toLowerCase() == 'true' || value == '1';
  return false;
}

/// bool값을 SQLite의 int로 변환
int _boolToInt(bool value) => value ? 1 : 0;
