import 'package:sqflite/sqflite.dart';
import 'package:logger/logger.dart';

import '../../../../core/database/database_helper.dart';
import '../../../../core/database/database_schema.dart';
import '../models/region_model.dart';

/// Region 데이터의 로컬 데이터소스
/// SQLite 데이터베이스와의 CRUD 작업을 담당합니다.
abstract class RegionLocalDataSource {
  /// 모든 지역 조회
  Future<List<RegionModel>> getAllRegions();

  /// ID로 지역 조회
  Future<RegionModel?> getRegionById(int unifiedCode);

  /// 시군구 코드로 지역 조회
  Future<RegionModel?> getRegionBySigunguCode(String sigunguCode);

  /// 레벨별 지역 조회
  Future<List<RegionModel>> getRegionsByLevel(int level);

  /// 상위 지역 코드로 하위 지역들 조회
  Future<List<RegionModel>> getRegionsByParentCode(String parentCode);

  /// 지역 삽입
  Future<int> insertRegion(RegionModel region);

  /// 지역 여러 개 일괄 삽입
  Future<void> insertRegions(List<RegionModel> regions);

  /// 지역 업데이트
  Future<void> updateRegion(RegionModel region);

  /// 지역 삭제
  Future<void> deleteRegion(int unifiedCode);

  /// 모든 지역 삭제
  Future<void> deleteAllRegions();

  /// 지역 개수 조회
  Future<int> getRegionCount();

  /// 지역명으로 검색
  Future<List<RegionModel>> searchRegionsByName(String searchTerm);
}

/// RegionLocalDataSource의 구현체
class RegionLocalDataSourceImpl implements RegionLocalDataSource {
  final DatabaseHelper _databaseHelper;
  final Logger _logger = Logger();

  RegionLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<List<RegionModel>> getAllRegions() async {
    _logger.d('모든 지역 조회 시작');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.regionsTable,
        orderBy: 'level ASC, sigungu_code ASC',
      );

      final regions = maps.map((map) => RegionModel.fromJson(map)).toList();
      _logger.d('지역 조회 완료: ${regions.length}개');

      return regions;
    } catch (e) {
      _logger.e('지역 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<RegionModel?> getRegionById(int unifiedCode) async {
    _logger.d('지역 조회 시작: ID=$unifiedCode');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.regionsTable,
        where: 'unified_code = ?',
        whereArgs: [unifiedCode],
        limit: 1,
      );

      if (maps.isEmpty) {
        _logger.d('지역을 찾을 수 없음: ID=$unifiedCode');
        return null;
      }

      final region = RegionModel.fromJson(maps.first);
      _logger.d('지역 조회 완료: ${region.sigunguName}');

      return region;
    } catch (e) {
      _logger.e('지역 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<RegionModel?> getRegionBySigunguCode(String sigunguCode) async {
    _logger.d('지역 조회 시작: 시군구코드=$sigunguCode');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.regionsTable,
        where: 'sigungu_code = ?',
        whereArgs: [sigunguCode],
        limit: 1,
      );

      if (maps.isEmpty) {
        _logger.d('지역을 찾을 수 없음: 시군구코드=$sigunguCode');
        return null;
      }

      final region = RegionModel.fromJson(maps.first);
      _logger.d('지역 조회 완료: ${region.sigunguName}');

      return region;
    } catch (e) {
      _logger.e('지역 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<List<RegionModel>> getRegionsByLevel(int level) async {
    _logger.d('레벨별 지역 조회 시작: level=$level');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.regionsTable,
        where: 'level = ?',
        whereArgs: [level],
        orderBy: 'sigungu_code ASC',
      );

      final regions = maps.map((map) => RegionModel.fromJson(map)).toList();
      _logger.d('레벨별 지역 조회 완료: ${regions.length}개');

      return regions;
    } catch (e) {
      _logger.e('레벨별 지역 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<List<RegionModel>> getRegionsByParentCode(String parentCode) async {
    _logger.d('하위 지역 조회 시작: parentCode=$parentCode');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.regionsTable,
        where: 'parent_code = ?',
        whereArgs: [parentCode],
        orderBy: 'sigungu_code ASC',
      );

      final regions = maps.map((map) => RegionModel.fromJson(map)).toList();
      _logger.d('하위 지역 조회 완료: ${regions.length}개');

      return regions;
    } catch (e) {
      _logger.e('하위 지역 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<int> insertRegion(RegionModel region) async {
    _logger.d('지역 삽입 시작: ${region.sigunguName}');

    try {
      final db = await _databaseHelper.database;
      final id = await db.insert(
        DatabaseSchema.regionsTable,
        region.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _logger.d('지역 삽입 완료: ${region.sigunguName}');
      return id;
    } catch (e) {
      _logger.e('지역 삽입 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<void> insertRegions(List<RegionModel> regions) async {
    _logger.d('지역 일괄 삽입 시작: ${regions.length}개');

    try {
      final db = await _databaseHelper.database;
      final batch = db.batch();

      for (final region in regions) {
        batch.insert(
          DatabaseSchema.regionsTable,
          region.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
      _logger.d('지역 일괄 삽입 완료: ${regions.length}개');
    } catch (e) {
      _logger.e('지역 일괄 삽입 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateRegion(RegionModel region) async {
    _logger.d('지역 업데이트 시작: ${region.sigunguName}');

    try {
      final db = await _databaseHelper.database;
      final count = await db.update(
        DatabaseSchema.regionsTable,
        region.toJson(),
        where: 'unified_code = ?',
        whereArgs: [region.unifiedCode],
      );

      if (count == 0) {
        throw Exception('업데이트할 지역을 찾을 수 없습니다: ${region.unifiedCode}');
      }

      _logger.d('지역 업데이트 완료: ${region.sigunguName}');
    } catch (e) {
      _logger.e('지역 업데이트 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteRegion(int unifiedCode) async {
    _logger.d('지역 삭제 시작: ID=$unifiedCode');

    try {
      final db = await _databaseHelper.database;
      final count = await db.delete(
        DatabaseSchema.regionsTable,
        where: 'unified_code = ?',
        whereArgs: [unifiedCode],
      );

      if (count == 0) {
        throw Exception('삭제할 지역을 찾을 수 없습니다: $unifiedCode');
      }

      _logger.d('지역 삭제 완료: ID=$unifiedCode');
    } catch (e) {
      _logger.e('지역 삭제 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteAllRegions() async {
    _logger.d('모든 지역 삭제 시작');

    try {
      final db = await _databaseHelper.database;
      await db.delete(DatabaseSchema.regionsTable);
      _logger.d('모든 지역 삭제 완료');
    } catch (e) {
      _logger.e('모든 지역 삭제 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<int> getRegionCount() async {
    _logger.d('지역 개수 조회 시작');

    try {
      final db = await _databaseHelper.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) FROM ${DatabaseSchema.regionsTable}',
      );
      final count = Sqflite.firstIntValue(result) ?? 0;

      _logger.d('지역 개수 조회 완료: $count개');
      return count;
    } catch (e) {
      _logger.e('지역 개수 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<List<RegionModel>> searchRegionsByName(String searchTerm) async {
    _logger.d('지역명 검색 시작: $searchTerm');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.regionsTable,
        where: 'sigungu_name LIKE ?',
        whereArgs: ['%$searchTerm%'],
        orderBy: 'level ASC, sigungu_code ASC',
      );

      final regions = maps.map((map) => RegionModel.fromJson(map)).toList();
      _logger.d('지역명 검색 완료: ${regions.length}개');

      return regions;
    } catch (e) {
      _logger.e('지역명 검색 중 오류 발생: $e');
      rethrow;
    }
  }
}
