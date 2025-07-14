import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../core/constants/app_constants.dart';

/// SQLite 데이터베이스를 관리하는 헬퍼 클래스
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  /// 데이터베이스 인스턴스를 가져옵니다
  Future<Database> get database async {
    _database ??= await _initDatabase();
    final db = _database;
    if (db != null) {
      return db;
    }
    throw Exception('데이터베이스 초기화 실패');
  }

  /// 데이터베이스를 초기화합니다
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// 데이터베이스 테이블을 생성합니다
  Future<void> _onCreate(Database db, int version) async {
    // TODO: 테이블 생성 스크립트 구현
    // provinces, sigungus, bjdongs 테이블 생성
  }

  /// 데이터베이스 업그레이드를 처리합니다
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // TODO: 데이터베이스 마이그레이션 로직 구현
  }

  /// 데이터베이스를 닫습니다
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
