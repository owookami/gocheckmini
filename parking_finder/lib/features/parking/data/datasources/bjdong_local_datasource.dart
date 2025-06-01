import 'package:sqflite/sqflite.dart';
import 'package:logger/logger.dart';

import '../../../../core/database/database_helper.dart';
import '../../../../core/database/database_schema.dart';
import '../models/bjdong_model.dart';
import '../../domain/entities/bjdong.dart';

/// Bjdong 데이터의 로컬 데이터소스
/// SQLite 데이터베이스와의 CRUD 작업을 담당합니다.
abstract class BjdongLocalDataSource {
  /// 모든 법정동 조회
  Future<List<BjdongModel>> getAllBjdongs();

  /// 법정동 코드로 조회
  Future<BjdongModel?> getBjdongByCode(String bjdongCode);

  /// 시도 코드로 법정동들 조회
  Future<List<BjdongModel>> getBjdongsBySidoCode(String sidoCode);

  /// 시군구 코드로 법정동들 조회
  Future<List<BjdongModel>> getBjdongsBySigunguCode(String sigunguCode);

  /// 법정동 타입으로 조회
  Future<List<BjdongModel>> getBjdongsByType(BjdongType type);

  /// 폐지되지 않은 법정동만 조회
  Future<List<BjdongModel>> getActiveBjdongs();

  /// 법정동 삽입
  Future<int> insertBjdong(BjdongModel bjdong);

  /// 법정동 여러 개 일괄 삽입
  Future<void> insertBjdongs(List<BjdongModel> bjdongs);

  /// 법정동 업데이트
  Future<void> updateBjdong(BjdongModel bjdong);

  /// 법정동 삭제
  Future<void> deleteBjdong(String bjdongCode);

  /// 모든 법정동 삭제
  Future<void> deleteAllBjdongs();

  /// 법정동 개수 조회
  Future<int> getBjdongCount();

  /// 법정동명으로 검색
  Future<List<BjdongModel>> searchBjdongsByName(String searchTerm);
}

/// BjdongLocalDataSource의 구현체
class BjdongLocalDataSourceImpl implements BjdongLocalDataSource {
  final DatabaseHelper _databaseHelper;
  final Logger _logger = Logger();

  BjdongLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<List<BjdongModel>> getAllBjdongs() async {
    _logger.d('모든 법정동 조회 시작');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.bjdongsTable,
        orderBy: 'sido_code ASC, sigungu_code ASC, bjdong_code ASC',
      );

      final bjdongs = maps.map((map) => BjdongModel.fromMap(map)).toList();
      _logger.d('법정동 조회 완료: ${bjdongs.length}개');

      return bjdongs;
    } catch (e) {
      _logger.e('법정동 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<BjdongModel?> getBjdongByCode(String bjdongCode) async {
    _logger.d('법정동 조회 시작: 코드=$bjdongCode');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.bjdongsTable,
        where: 'bjdong_code = ?',
        whereArgs: [bjdongCode],
        limit: 1,
      );

      if (maps.isEmpty) {
        _logger.d('법정동을 찾을 수 없음: 코드=$bjdongCode');
        return null;
      }

      final bjdong = BjdongModel.fromMap(maps.first);
      _logger.d('법정동 조회 완료: ${bjdong.bjdongName}');

      return bjdong;
    } catch (e) {
      _logger.e('법정동 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<List<BjdongModel>> getBjdongsBySidoCode(String sidoCode) async {
    _logger.d('시도별 법정동 조회 시작: 시도코드=$sidoCode');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.bjdongsTable,
        where: 'sido_code = ?',
        whereArgs: [sidoCode],
        orderBy: 'sigungu_code ASC, bjdong_code ASC',
      );

      final bjdongs = maps.map((map) => BjdongModel.fromMap(map)).toList();
      _logger.d('시도별 법정동 조회 완료: ${bjdongs.length}개');

      return bjdongs;
    } catch (e) {
      _logger.e('시도별 법정동 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<List<BjdongModel>> getBjdongsBySigunguCode(String sigunguCode) async {
    _logger.d('시군구별 법정동 조회 시작: 시군구코드=$sigunguCode');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.bjdongsTable,
        where: 'sigungu_code = ?',
        whereArgs: [sigunguCode],
        orderBy: 'bjdong_code ASC',
      );

      final bjdongs = maps.map((map) => BjdongModel.fromMap(map)).toList();
      _logger.d('시군구별 법정동 조회 완료: ${bjdongs.length}개');

      return bjdongs;
    } catch (e) {
      _logger.e('시군구별 법정동 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<List<BjdongModel>> getBjdongsByType(BjdongType type) async {
    _logger.d('타입별 법정동 조회 시작: 타입=${type.displayName}');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.bjdongsTable,
        where: 'bjdong_type = ?',
        whereArgs: [type.name],
        orderBy: 'sido_code ASC, sigungu_code ASC, bjdong_code ASC',
      );

      final bjdongs = maps.map((map) => BjdongModel.fromMap(map)).toList();
      _logger.d('타입별 법정동 조회 완료: ${bjdongs.length}개');

      return bjdongs;
    } catch (e) {
      _logger.e('타입별 법정동 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<List<BjdongModel>> getActiveBjdongs() async {
    _logger.d('활성 법정동 조회 시작');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.bjdongsTable,
        where: 'is_abolished = ?',
        whereArgs: [0], // false는 0으로 저장됨
        orderBy: 'sido_code ASC, sigungu_code ASC, bjdong_code ASC',
      );

      final bjdongs = maps.map((map) => BjdongModel.fromMap(map)).toList();
      _logger.d('활성 법정동 조회 완료: ${bjdongs.length}개');

      return bjdongs;
    } catch (e) {
      _logger.e('활성 법정동 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<int> insertBjdong(BjdongModel bjdong) async {
    _logger.d('법정동 삽입 시작: ${bjdong.bjdongName}');

    try {
      final db = await _databaseHelper.database;
      final id = await db.insert(
        DatabaseSchema.bjdongsTable,
        bjdong.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _logger.d('법정동 삽입 완료: ${bjdong.bjdongName}');
      return id;
    } catch (e) {
      _logger.e('법정동 삽입 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<void> insertBjdongs(List<BjdongModel> bjdongs) async {
    _logger.d('법정동 일괄 삽입 시작: ${bjdongs.length}개');

    try {
      final db = await _databaseHelper.database;
      final batch = db.batch();

      for (final bjdong in bjdongs) {
        batch.insert(
          DatabaseSchema.bjdongsTable,
          bjdong.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
      _logger.d('법정동 일괄 삽입 완료: ${bjdongs.length}개');
    } catch (e) {
      _logger.e('법정동 일괄 삽입 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateBjdong(BjdongModel bjdong) async {
    _logger.d('법정동 업데이트 시작: ${bjdong.bjdongName}');

    try {
      final db = await _databaseHelper.database;
      final count = await db.update(
        DatabaseSchema.bjdongsTable,
        bjdong.toMap(),
        where: 'bjdong_code = ?',
        whereArgs: [bjdong.bjdongCode],
      );

      if (count == 0) {
        throw Exception('업데이트할 법정동을 찾을 수 없습니다: ${bjdong.bjdongCode}');
      }

      _logger.d('법정동 업데이트 완료: ${bjdong.bjdongName}');
    } catch (e) {
      _logger.e('법정동 업데이트 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteBjdong(String bjdongCode) async {
    _logger.d('법정동 삭제 시작: 코드=$bjdongCode');

    try {
      final db = await _databaseHelper.database;
      final count = await db.delete(
        DatabaseSchema.bjdongsTable,
        where: 'bjdong_code = ?',
        whereArgs: [bjdongCode],
      );

      if (count == 0) {
        throw Exception('삭제할 법정동을 찾을 수 없습니다: $bjdongCode');
      }

      _logger.d('법정동 삭제 완료: 코드=$bjdongCode');
    } catch (e) {
      _logger.e('법정동 삭제 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteAllBjdongs() async {
    _logger.d('모든 법정동 삭제 시작');

    try {
      final db = await _databaseHelper.database;
      await db.delete(DatabaseSchema.bjdongsTable);
      _logger.d('모든 법정동 삭제 완료');
    } catch (e) {
      _logger.e('모든 법정동 삭제 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<int> getBjdongCount() async {
    _logger.d('법정동 개수 조회 시작');

    try {
      final db = await _databaseHelper.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) FROM ${DatabaseSchema.bjdongsTable}',
      );
      final count = Sqflite.firstIntValue(result) ?? 0;

      _logger.d('법정동 개수 조회 완료: $count개');
      return count;
    } catch (e) {
      _logger.e('법정동 개수 조회 중 오류 발생: $e');
      rethrow;
    }
  }

  @override
  Future<List<BjdongModel>> searchBjdongsByName(String searchTerm) async {
    _logger.d('법정동명 검색 시작: $searchTerm');

    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseSchema.bjdongsTable,
        where: 'bjdong_name LIKE ? OR sido_name LIKE ? OR sigungu_name LIKE ?',
        whereArgs: ['%$searchTerm%', '%$searchTerm%', '%$searchTerm%'],
        orderBy: 'sido_code ASC, sigungu_code ASC, bjdong_code ASC',
      );

      final bjdongs = maps.map((map) => BjdongModel.fromMap(map)).toList();
      _logger.d('법정동명 검색 완료: ${bjdongs.length}개');

      return bjdongs;
    } catch (e) {
      _logger.e('법정동명 검색 중 오류 발생: $e');
      rethrow;
    }
  }
}
