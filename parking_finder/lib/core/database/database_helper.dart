import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_schema.dart';

/// 주차장 찾기 앱 메인 데이터베이스 헬퍼
/// 완전히 새로운 구조로 재설계됨
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static final Logger _logger = Logger();
  Database? _database;
  bool _isInitialized = false;
  String? _customPath;

  /// 커스텀 데이터베이스 파일 경로를 위한 생성자
  factory DatabaseHelper.file(String path) {
    final instance = DatabaseHelper._internal();
    instance._customPath = path;
    return instance;
  }

  /// 데이터베이스 인스턴스 반환
  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await _initializeDatabase();
    return _database!;
  }

  /// 데이터베이스 초기화
  Future<Database> _initializeDatabase() async {
    _logger.d('🚀 데이터베이스 초기화 시작...');

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, DatabaseSchema.databaseName);

    // 애플리케이션 문서 디렉토리의 데이터베이스 사용 (앱별로 분리)
    final database = await openDatabase(
      path,
      version: DatabaseSchema.currentVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
      onOpen: _onOpen,
    );

    _isInitialized = true;
    _logger.i('✅ 데이터베이스 초기화 완료');
    return database;
  }

  /// 데이터베이스 설정
  Future<void> _onConfigure(Database db) async {
    try {
      // 외래 키 제약 조건 활성화
      await db.execute('PRAGMA foreign_keys = ON');
      _logger.d('✅ PRAGMA foreign_keys 설정 완료');
    } catch (e) {
      _logger.w('⚠️ PRAGMA foreign_keys 설정 실패: $e');
    }

    try {
      // 성능 최적화 (안전한 설정들만)
      await db.execute('PRAGMA cache_size = 10000');
      _logger.d('✅ PRAGMA cache_size 설정 완료');
    } catch (e) {
      _logger.w('⚠️ PRAGMA cache_size 설정 실패: $e');
    }

    try {
      await db.execute('PRAGMA temp_store = MEMORY');
      _logger.d('✅ PRAGMA temp_store 설정 완료');
    } catch (e) {
      _logger.w('⚠️ PRAGMA temp_store 설정 실패: $e');
    }

    // WAL 모드는 일부 환경에서 문제를 일으킬 수 있으므로 주석 처리
    // try {
    //   await db.execute('PRAGMA journal_mode = WAL');
    //   _logger.d('✅ PRAGMA journal_mode 설정 완료');
    // } catch (e) {
    //   _logger.w('⚠️ PRAGMA journal_mode 설정 실패: $e');
    // }

    try {
      await db.execute('PRAGMA synchronous = NORMAL');
      _logger.d('✅ PRAGMA synchronous 설정 완료');
    } catch (e) {
      _logger.w('⚠️ PRAGMA synchronous 설정 실패: $e');
    }
  }

  /// 데이터베이스 생성 시 호출
  Future<void> _onCreate(Database db, int version) async {
    _logger.d('🏗️ 새 데이터베이스 테이블 생성 중...');

    // 모든 테이블 생성
    for (final createTableQuery in DatabaseSchema.createTableQueries) {
      await db.execute(createTableQuery);
      _logger.d('✅ 테이블 생성 완료');
    }

    // 인덱스 생성
    for (final indexQuery in DatabaseSchema.createIndexQueries) {
      final query = indexQuery.trim();
      if (query.isNotEmpty) {
        await db.execute(query);
      }
    }
    _logger.d('✅ 인덱스 생성 완료');

    // 초기 데이터는 MainScreen에서 별도로 처리합니다
    _logger.d('✅ 데이터베이스 스키마 생성 완료');
  }

  /// 데이터베이스 업그레이드 시 호출
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    _logger.d('🔄 데이터베이스 업그레이드: $oldVersion → $newVersion');

    await DatabaseMigration.upgradeDatabase(
      DatabaseExecutorImpl(db),
      oldVersion,
      newVersion,
    );
  }

  /// 데이터베이스 오픈 시 호출
  Future<void> _onOpen(Database db) async {
    _logger.d('📖 데이터베이스 오픈 완료');

    // 데이터 무결성 검증
    await _verifyDataIntegrity(db);
  }

  /// 데이터 무결성 검증
  Future<void> _verifyDataIntegrity(Database db) async {
    try {
      // regions 테이블 데이터 확인
      final regionCount =
          Sqflite.firstIntValue(
            await db.rawQuery(
              'SELECT COUNT(*) FROM ${DatabaseSchema.regionsTable}',
            ),
          ) ??
          0;

      _logger.d('📊 데이터 무결성 검증: regions=$regionCount');

      if (regionCount == 0) {
        _logger.w('⚠️ regions 테이블이 비어있습니다. 초기 데이터를 확인하세요.');
      }
    } catch (e) {
      _logger.e('❌ 데이터 무결성 검증 실패: $e');
    }
  }

  // ========== 지역 관련 메서드 ==========

  /// 모든 지역 조회
  Future<List<Map<String, dynamic>>> getAllRegions() async {
    final db = await database;
    return await db.query(
      DatabaseSchema.regionsTable,
      orderBy: 'province, city, district, sigungu_name',
    );
  }

  /// 시군구 코드로 지역 조회
  Future<Map<String, dynamic>?> getRegionByCode(String sigunguCode) async {
    final db = await database;
    final results = await db.query(
      DatabaseSchema.regionsTable,
      where: 'sigungu_code = ?',
      whereArgs: [sigunguCode],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// 통합 코드로 지역 조회
  Future<Map<String, dynamic>?> getRegionByUnifiedCode(int unifiedCode) async {
    final db = await database;
    final results = await db.query(
      DatabaseSchema.regionsTable,
      where: 'unified_code = ?',
      whereArgs: [unifiedCode],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// 도/시별 지역 목록 조회
  Future<List<Map<String, dynamic>>> getRegionsByProvince(
    String province,
  ) async {
    final db = await database;
    return await db.query(
      DatabaseSchema.regionsTable,
      where: 'province = ?',
      whereArgs: [province],
      orderBy: 'sigungu_name',
    );
  }

  /// 지역명으로 검색
  Future<List<Map<String, dynamic>>> searchRegionsByName(String query) async {
    final db = await database;
    return await db.query(
      DatabaseSchema.regionsTable,
      where: 'sigungu_name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'sigungu_name',
      limit: 50,
    );
  }

  /// 지역 추가
  Future<int> insertRegion(Map<String, dynamic> region) async {
    final db = await database;
    return await db.insert(
      DatabaseSchema.regionsTable,
      region,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 지역 업데이트
  Future<int> updateRegion(
    String sigunguCode,
    Map<String, dynamic> region,
  ) async {
    final db = await database;
    return await db.update(
      DatabaseSchema.regionsTable,
      region,
      where: 'sigungu_code = ?',
      whereArgs: [sigunguCode],
    );
  }

  /// 지역 삭제
  Future<int> deleteRegion(String sigunguCode) async {
    final db = await database;
    return await db.delete(
      DatabaseSchema.regionsTable,
      where: 'sigungu_code = ?',
      whereArgs: [sigunguCode],
    );
  }

  // ========== 유틸리티 메서드 ==========

  /// 데이터베이스 통계 조회
  Future<Map<String, int>> getDatabaseStats() async {
    final db = await database;

    final regionCount =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM ${DatabaseSchema.regionsTable}',
          ),
        ) ??
        0;

    return {'regions': regionCount};
  }

  /// 데이터베이스 백업
  Future<bool> backupDatabase(String backupPath) async {
    try {
      if (_database == null) return false;

      final dbPath = _database!.path;
      final dbFile = File(dbPath);
      final backupFile = File(backupPath);

      await dbFile.copy(backupPath);
      _logger.i('✅ 데이터베이스 백업 완료: $backupPath');
      return true;
    } catch (e) {
      _logger.e('❌ 데이터베이스 백업 실패: $e');
      return false;
    }
  }

  /// 데이터베이스 복원
  Future<bool> restoreDatabase(String backupPath) async {
    try {
      final backupFile = File(backupPath);
      if (!await backupFile.exists()) {
        _logger.e('❌ 백업 파일이 존재하지 않습니다: $backupPath');
        return false;
      }

      await close();

      final dbPath = join(
        await getDatabasesPath(),
        DatabaseSchema.databaseName,
      );
      await backupFile.copy(dbPath);

      _database = await _initializeDatabase();
      _logger.i('✅ 데이터베이스 복원 완료: $backupPath');
      return true;
    } catch (e) {
      _logger.e('❌ 데이터베이스 복원 실패: $e');
      return false;
    }
  }

  /// 데이터베이스 연결 닫기
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      _isInitialized = false;
      _logger.d('🔐 데이터베이스 연결 종료');
    }
  }

  /// 데이터베이스 삭제
  Future<void> deleteDatabase() async {
    await close();
    final dbPath = join(await getDatabasesPath(), DatabaseSchema.databaseName);
    await databaseFactory.deleteDatabase(dbPath);
    _logger.d('🗑️ 데이터베이스 삭제 완료');
  }

  /// 초기화 상태 확인
  bool get isInitialized => _isInitialized;

  /// 데이터베이스 경로 반환
  Future<String> get databasePath async {
    if (_customPath != null) {
      return _customPath!;
    }
    final documentsPath = await getDatabasesPath();
    return join(documentsPath, DatabaseSchema.databaseName);
  }
}

/// 배치 작업 정의
class BatchOperation {
  final BatchOperationType type;
  final String table;
  final Map<String, Object?>? values;
  final String? where;
  final List<Object?>? whereArgs;
  final ConflictAlgorithm? conflictAlgorithm;
  final String? sql;
  final List<Object?>? arguments;

  const BatchOperation({
    required this.type,
    required this.table,
    this.values,
    this.where,
    this.whereArgs,
    this.conflictAlgorithm,
    this.sql,
    this.arguments,
  });

  /// Insert 배치 작업 생성
  factory BatchOperation.insert(
    String table,
    Map<String, Object?> values, {
    ConflictAlgorithm? conflictAlgorithm,
  }) {
    return BatchOperation(
      type: BatchOperationType.insert,
      table: table,
      values: values,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  /// Update 배치 작업 생성
  factory BatchOperation.update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) {
    return BatchOperation(
      type: BatchOperationType.update,
      table: table,
      values: values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  /// Delete 배치 작업 생성
  factory BatchOperation.delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) {
    return BatchOperation(
      type: BatchOperationType.delete,
      table: table,
      where: where,
      whereArgs: whereArgs,
    );
  }
}

/// 배치 작업 타입
enum BatchOperationType {
  insert,
  update,
  delete,
  rawInsert,
  rawUpdate,
  rawDelete,
}

/// 데이터베이스 마이그레이션 관리 클래스
class DatabaseMigration {
  static Future<void> upgradeDatabase(
    DatabaseExecutor executor,
    int oldVersion,
    int newVersion,
  ) async {
    // 현재는 버전 1만 지원하므로 업그레이드 로직 없음
    // 향후 버전 업그레이드 시 여기에 마이그레이션 스크립트 추가
  }
}

/// DatabaseExecutor 인터페이스
abstract class DatabaseExecutor {
  Future<void> execute(String sql, [List<Object?>? arguments]);
  Future<List<Map<String, Object?>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  });
  Future<int> insert(String table, Map<String, Object?> values);
  Future<int> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
  });
  Future<int> delete(String table, {String? where, List<Object?>? whereArgs});
}

/// DatabaseExecutor 구현 클래스
class DatabaseExecutorImpl implements DatabaseExecutor {
  final Database _db;

  DatabaseExecutorImpl(this._db);

  @override
  Future<void> execute(String sql, [List<Object?>? arguments]) async {
    await _db.execute(sql, arguments);
  }

  @override
  Future<List<Map<String, Object?>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return await _db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<int> insert(String table, Map<String, Object?> values) async {
    return await _db.insert(table, values);
  }

  @override
  Future<int> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    return await _db.update(table, values, where: where, whereArgs: whereArgs);
  }

  @override
  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    return await _db.delete(table, where: where, whereArgs: whereArgs);
  }
}
