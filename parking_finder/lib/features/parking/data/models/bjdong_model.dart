import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bjdong.dart';

part 'bjdong_model.freezed.dart';
part 'bjdong_model.g.dart';

/// Bjdong 엔티티의 데이터 모델 클래스
@freezed
class BjdongModel with _$BjdongModel {
  const factory BjdongModel({
    /// 법정동 코드 (10자리)
    @JsonKey(name: 'bjdong_code') required String bjdongCode,

    /// 법정동명
    @JsonKey(name: 'bjdong_name') required String bjdongName,

    /// 시도 코드
    @JsonKey(name: 'sido_code') required String sidoCode,

    /// 시도명
    @JsonKey(name: 'sido_name') required String sidoName,

    /// 시군구 코드
    @JsonKey(name: 'sigungu_code') required String sigunguCode,

    /// 시군구명
    @JsonKey(name: 'sigungu_name') required String sigunguName,

    /// 읍면동 구분 (읍/면/동)
    @JsonKey(name: 'bjdong_type') required BjdongType bjdongType,

    /// 폐지 여부
    @JsonKey(name: 'is_abolished', fromJson: _boolFromInt, toJson: _boolToInt)
    @Default(false)
    bool isAbolished,

    /// 생성일
    @JsonKey(name: 'created_date') DateTime? createdDate,

    /// 폐지일
    @JsonKey(name: 'abolished_date') DateTime? abolishedDate,
  }) = _BjdongModel;

  const BjdongModel._();

  /// JSON에서 모델 생성
  factory BjdongModel.fromJson(Map<String, dynamic> json) =>
      _$BjdongModelFromJson(json);

  /// SQLite 호환 맵으로 변환
  Map<String, dynamic> toMap() {
    return {
      'bjdong_code': bjdongCode,
      'bjdong_name': bjdongName,
      'sido_code': sidoCode,
      'sido_name': sidoName,
      'sigungu_code': sigunguCode,
      'sigungu_name': sigunguName,
      'bjdong_type': bjdongType.name,
      'is_abolished': isAbolished ? 1 : 0,
      'created_date': createdDate?.toIso8601String(),
      'abolished_date': abolishedDate?.toIso8601String(),
    };
  }

  /// 맵에서 모델 생성
  factory BjdongModel.fromMap(Map<String, dynamic> map) {
    return BjdongModel(
      bjdongCode: map['bjdong_code'] as String,
      bjdongName: map['bjdong_name'] as String,
      sidoCode: map['sido_code'] as String,
      sidoName: map['sido_name'] as String,
      sigunguCode: map['sigungu_code'] as String,
      sigunguName: map['sigungu_name'] as String,
      bjdongType: BjdongType.values.byName(map['bjdong_type'] as String),
      isAbolished: map['is_abolished'] == 1,
      createdDate:
          map['created_date'] != null
              ? DateTime.parse(map['created_date'] as String)
              : null,
      abolishedDate:
          map['abolished_date'] != null
              ? DateTime.parse(map['abolished_date'] as String)
              : null,
    );
  }

  /// 엔티티로 변환
  Bjdong toEntity() {
    return Bjdong(
      bjdongCode: bjdongCode,
      bjdongName: bjdongName,
      sidoCode: sidoCode,
      sidoName: sidoName,
      sigunguCode: sigunguCode,
      sigunguName: sigunguName,
      bjdongType: bjdongType,
      isAbolished: isAbolished,
      createdDate: createdDate,
      abolishedDate: abolishedDate,
    );
  }

  /// 엔티티에서 모델 생성
  factory BjdongModel.fromEntity(Bjdong entity) {
    return BjdongModel(
      bjdongCode: entity.bjdongCode,
      bjdongName: entity.bjdongName,
      sidoCode: entity.sidoCode,
      sidoName: entity.sidoName,
      sigunguCode: entity.sigunguCode,
      sigunguName: entity.sigunguName,
      bjdongType: entity.bjdongType,
      isAbolished: entity.isAbolished,
      createdDate: entity.createdDate,
      abolishedDate: entity.abolishedDate,
    );
  }
}

/// SQLite 호환 bool to int 변환
int _boolToInt(bool value) => value ? 1 : 0;

/// SQLite 호환 int to bool 변환
bool _boolFromInt(dynamic value) {
  if (value is int) return value == 1;
  if (value is bool) return value;
  return false;
}
