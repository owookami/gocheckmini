import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:logger/logger.dart';

import '../database_helper.dart';
import '../../../features/parking/data/models/region_model.dart';

/// 초기 시군구 데이터 마이그레이션 클래스
/// scripts/sigungu.txt 파일의 데이터를 데이터베이스에 삽입합니다.
class InitialRegionDataMigration {
  static final Logger _logger = Logger();

  /// 시군구 데이터 마이그레이션 실행
  static Future<void> migrate(DatabaseHelper databaseHelper) async {
    _logger.i('시군구 데이터 마이그레이션 시작');

    try {
      // 이미 데이터가 있는지 확인
      final db = await databaseHelper.database;
      final count = await db.rawQuery('SELECT COUNT(*) as count FROM regions');
      final existingCount = count.first['count'] as int;

      if (existingCount > 0) {
        _logger.i('시군구 데이터가 이미 존재함 (${existingCount}개)');
        return;
      }

      // 시군구 데이터 파일 읽기
      final data = await _loadSigunguData();

      if (data.isEmpty) {
        _logger.w('시군구 데이터가 비어있음');
        return;
      }

      // 배치로 데이터 삽입
      await _insertRegionsInBatch(databaseHelper, data);

      _logger.i('시군구 데이터 마이그레이션 완료 (${data.length}개)');
    } catch (e) {
      _logger.e('시군구 데이터 마이그레이션 실패: $e');
      rethrow;
    }
  }

  /// 시군구 데이터 파일 로드
  static Future<List<RegionModel>> _loadSigunguData() async {
    try {
      // 먼저 assets에서 시도
      String content;
      try {
        content = await rootBundle.loadString('assets/data/sigungu.txt');
      } catch (e) {
        // assets에 없으면 scripts 폴더에서 직접 로드
        final file = File('scripts/sigungu.txt');
        if (await file.exists()) {
          content = await file.readAsString();
        } else {
          _logger.e('시군구 데이터 파일을 찾을 수 없음');
          return [];
        }
      }

      return _parseSigunguData(content);
    } catch (e) {
      _logger.e('시군구 데이터 파일 로드 실패: $e');
      return [];
    }
  }

  /// 시군구 데이터 파싱
  static List<RegionModel> _parseSigunguData(String content) {
    final regions = <RegionModel>[];
    final lines = content.split('\n');

    for (int i = 1; i < lines.length; i++) {
      // 첫 번째 줄은 헤더이므로 스킵
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      try {
        final parts = line.split(' ');
        if (parts.length >= 4) {
          final unifiedCode = int.parse(parts[0]);
          final sigunguCode = parts[1];
          final sigunguName = parts[2];
          final isAutonomousString = parts[3];

          // "비자치구 여부"가 "해당"이면 true, "미해당"이면 false
          final isAutonomousDistrict = isAutonomousString == '해당';

          final region = RegionModel(
            unifiedCode: unifiedCode,
            sigunguCode: sigunguCode,
            sigunguName: sigunguName,
            isAutonomousDistrict: isAutonomousDistrict,
            level: 2, // 시군구 레벨
          );

          regions.add(region);
        }
      } catch (e) {
        _logger.w('시군구 데이터 파싱 오류 (라인 $i): $line - $e');
        continue;
      }
    }

    _logger.i('시군구 데이터 파싱 완료: ${regions.length}개');
    return regions;
  }

  /// 배치로 시군구 데이터 삽입
  static Future<void> _insertRegionsInBatch(
    DatabaseHelper databaseHelper,
    List<RegionModel> regions,
  ) async {
    final batchOperations =
        regions.map((region) {
          return BatchOperation.insert('regions', region.toMap());
        }).toList();

    await databaseHelper.batch(batchOperations);
  }

  /// 특정 시도의 시군구 데이터만 로드 (옵션)
  static Future<List<RegionModel>> getRegionsBySido(String sidoName) async {
    final allRegions = await _loadSigunguData();
    return allRegions
        .where((region) => region.sigunguName.startsWith(sidoName))
        .toList();
  }

  /// 시군구 데이터 유효성 검사
  static Future<bool> validateMigration(DatabaseHelper databaseHelper) async {
    try {
      final db = await databaseHelper.database;

      // 기본 개수 확인
      final countResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM regions',
      );
      final count = countResult.first['count'] as int;

      // 최소한의 데이터가 있는지 확인
      if (count < 100) {
        _logger.w('시군구 데이터가 너무 적음: $count개');
        return false;
      }

      // 주요 시도 데이터 확인
      final majorCities = ['서울특별시', '부산광역시', '대구광역시', '인천광역시'];
      for (final city in majorCities) {
        final result = await db.query(
          'regions',
          where: 'sigungu_name LIKE ?',
          whereArgs: ['$city%'],
        );

        if (result.isEmpty) {
          _logger.w('주요 도시 데이터 누락: $city');
          return false;
        }
      }

      _logger.i('시군구 데이터 유효성 검사 통과: $count개');
      return true;
    } catch (e) {
      _logger.e('시군구 데이터 유효성 검사 실패: $e');
      return false;
    }
  }
}
