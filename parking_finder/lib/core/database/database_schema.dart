import 'package:sqflite/sqflite.dart';

/// 주차장 찾기 앱 데이터베이스 스키마
/// API_guide.txt와 sigungu.txt를 기반으로 설계
class DatabaseSchema {
  DatabaseSchema._();

  static const String databaseName = 'parking_finder.db';
  static const int currentVersion = 3;

  // 테이블 이름들
  static const String regionsTable = 'regions';
  static const String bjdongsTable = 'bjdongs';
  static const String legalDistrictsTable = 'legal_districts';

  /// 법정동코드 테이블 생성 쿼리 (모든 행정구역 레벨 포함)
  static const String createLegalDistrictsTableQuery = '''
    CREATE TABLE $legalDistrictsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      region_cd TEXT NOT NULL,                    -- 법정동코드 (예: 1111010100)
      sido_cd TEXT,                               -- 시도코드 (예: 11)
      sgg_cd TEXT,                                -- 시군구코드 (예: 11110)
      umd_cd TEXT,                                -- 읍면동코드 (예: 1111010100)
      ri_cd TEXT,                                 -- 리코드
      locatadd_nm TEXT NOT NULL,                  -- 지역주소명 (예: 서울특별시 종로구 청운효자동)
      sido_nm TEXT,                               -- 시도명 (예: 서울특별시)
      sgg_nm TEXT,                                -- 시군구명 (예: 종로구)
      umd_nm TEXT,                                -- 읍면동명 (예: 청운효자동)
      ri_nm TEXT,                                 -- 리명
      mountain_yn TEXT DEFAULT 'N',               -- 산 여부
      land_type_cd TEXT,                          -- 지목코드
      land_type_nm TEXT,                          -- 지목명
      admin_yn TEXT DEFAULT 'Y',                  -- 행정동 여부
      is_active INTEGER DEFAULT 1,               -- 활성 상태 (1: 활성, 0: 비활성)
      level_type INTEGER NOT NULL,               -- 레벨 타입 (1: 시도, 2: 시군구, 3: 읍면동, 4: 리)
      parent_region_cd TEXT,                      -- 상위 지역 코드
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    );
  ''';

  /// 기존 regions 테이블 (시군구 데이터용 - 호환성 유지)
  static const String createRegionsTableQuery = '''
    CREATE TABLE $regionsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      unified_code INTEGER NOT NULL,
      sigungu_code TEXT NOT NULL,
      sigungu_name TEXT NOT NULL,
      is_autonomous_district INTEGER DEFAULT 0,
      province TEXT NOT NULL,
      city TEXT NOT NULL,
      district TEXT,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    );
  ''';

  /// 읍면동 테이블 (기존 호환성 유지)
  static const String createBjdongsTableQuery = '''
    CREATE TABLE $bjdongsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      sigungu_code TEXT NOT NULL,
      bjdong_name TEXT NOT NULL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL,
      FOREIGN KEY (sigungu_code) REFERENCES $regionsTable (sigungu_code)
    );
  ''';

  /// 모든 테이블 생성 쿼리 목록
  static const List<String> createTableQueries = [
    createLegalDistrictsTableQuery,
    createRegionsTableQuery,
    createBjdongsTableQuery,
  ];

  /// 인덱스 생성 쿼리들
  static const List<String> createIndexQueries = [
    // 법정동코드 테이블 인덱스
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_region_cd ON $legalDistrictsTable(region_cd);',
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_sido_cd ON $legalDistrictsTable(sido_cd);',
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_sgg_cd ON $legalDistrictsTable(sgg_cd);',
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_umd_cd ON $legalDistrictsTable(umd_cd);',
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_level_type ON $legalDistrictsTable(level_type);',
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_parent_region_cd ON $legalDistrictsTable(parent_region_cd);',
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_sido_nm ON $legalDistrictsTable(sido_nm);',
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_sgg_nm ON $legalDistrictsTable(sgg_nm);',
    'CREATE INDEX IF NOT EXISTS idx_legal_districts_active ON $legalDistrictsTable(is_active);',

    // 기존 테이블 인덱스 (호환성 유지)
    'CREATE INDEX IF NOT EXISTS idx_regions_province ON $regionsTable(province);',
    'CREATE INDEX IF NOT EXISTS idx_regions_sigungu_code ON $regionsTable(sigungu_code);',
    'CREATE INDEX IF NOT EXISTS idx_bjdongs_sigungu_code ON $bjdongsTable(sigungu_code);',
  ];

  /// 테이블 삭제 쿼리들 (개발/테스트용)
  static const List<String> dropTableQueries = [
    'DROP TABLE IF EXISTS $legalDistrictsTable;',
    'DROP TABLE IF EXISTS $bjdongsTable;',
    'DROP TABLE IF EXISTS $regionsTable;',
  ];

  /// 데이터베이스 초기화 쿼리 (모든 데이터 삭제)
  static const List<String> clearDataQueries = [
    'DELETE FROM $legalDistrictsTable;',
    'DELETE FROM $bjdongsTable;',
    'DELETE FROM $regionsTable;',
  ];

  /// 지역 레벨 타입 상수
  static const int levelSido = 1; // 시도
  static const int levelSigungu = 2; // 시군구
  static const int levelUmd = 3; // 읍면동
  static const int levelRi = 4; // 리

  /// 지역 레벨 타입 이름
  static const Map<int, String> levelNames = {
    levelSido: '시도',
    levelSigungu: '시군구',
    levelUmd: '읍면동',
    levelRi: '리',
  };
}

/// 데이터베이스 마이그레이션 클래스
class DatabaseMigration {
  static Future<void> upgradeDatabase(
    DatabaseExecutor db,
    int oldVersion,
    int newVersion,
  ) async {
    // 향후 데이터베이스 버전 업그레이드 시 사용
    if (oldVersion < newVersion) {
      // 마이그레이션 로직
    }
  }
}

/// 데이터베이스 실행자 추상 클래스
abstract class DatabaseExecutor {
  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  });

  Future<int> insert(
    String table,
    Map<String, dynamic> values, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  });

  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  });

  Future<int> delete(String table, {String? where, List<dynamic>? whereArgs});

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]);

  Future<int> rawInsert(String sql, [List<dynamic>? arguments]);

  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]);

  Future<int> rawDelete(String sql, [List<dynamic>? arguments]);
}

/// 데이터베이스 실행자 구현 클래스
class DatabaseExecutorImpl implements DatabaseExecutor {
  final Database _database;

  DatabaseExecutorImpl(this._database);

  @override
  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    return _database.query(
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
  Future<int> insert(
    String table,
    Map<String, dynamic> values, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) {
    return _database.insert(
      table,
      values,
      nullColumnHack: nullColumnHack,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  @override
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) {
    return _database.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  @override
  Future<int> delete(String table, {String? where, List<dynamic>? whereArgs}) {
    return _database.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) {
    return _database.rawQuery(sql, arguments);
  }

  @override
  Future<int> rawInsert(String sql, [List<dynamic>? arguments]) {
    return _database.rawInsert(sql, arguments);
  }

  @override
  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]) {
    return _database.rawUpdate(sql, arguments);
  }

  @override
  Future<int> rawDelete(String sql, [List<dynamic>? arguments]) {
    return _database.rawDelete(sql, arguments);
  }
}
