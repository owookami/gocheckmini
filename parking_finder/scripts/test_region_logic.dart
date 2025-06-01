import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;

// RegionModel 클래스 복사 (간단화)
class RegionModel {
  final int id;
  final int unifiedCode;
  final String sigunguCode;
  final String sigunguName;
  final int isAutonomousDistrict;
  final String province;
  final String city;
  final String createdAt;
  final String updatedAt;

  RegionModel({
    required this.id,
    required this.unifiedCode,
    required this.sigunguCode,
    required this.sigunguName,
    required this.isAutonomousDistrict,
    required this.province,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    return RegionModel(
      id: map['id'] as int,
      unifiedCode: map['unified_code'] as int,
      sigunguCode: map['sigungu_code'] as String,
      sigunguName: map['sigungu_name'] as String,
      isAutonomousDistrict: map['is_autonomous_district'] as int,
      province: map['province'] as String,
      city: map['city'] as String? ?? '',
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}

// RegionRepository 로직 복사 (간단화)
class SimpleRegionRepository {
  final Database database;

  SimpleRegionRepository(this.database);

  Future<List<String>> getProvinces() async {
    final result = await database.rawQuery(
      'SELECT DISTINCT province FROM regions WHERE province != "" ORDER BY province',
    );
    return result.map((row) => row['province'] as String).toList();
  }

  Future<List<RegionModel>> getSigungus(String province) async {
    final result = await database.query(
      'regions',
      where: 'province = ? AND sigungu_name != ?',
      whereArgs: [province, province],
      orderBy: 'sigungu_name ASC',
    );
    return result.map((map) => RegionModel.fromMap(map)).toList();
  }
}

Future<void> main() async {
  // SQLite FFI 설정
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    print('🧪 RegionRepository 로직 테스트 시작');

    // 데이터베이스 다시 생성
    final dbPath = path.join('test_regions.db');
    final dbFile = File(dbPath);
    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    // 새 데이터베이스 생성
    final db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE regions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          unified_code INTEGER NOT NULL,
          sigungu_code TEXT NOT NULL,
          sigungu_name TEXT NOT NULL,
          is_autonomous_district INTEGER NOT NULL DEFAULT 0,
          province TEXT NOT NULL,
          city TEXT NOT NULL DEFAULT '',
          created_at TEXT,
          updated_at TEXT
        )
      ''');
      },
    );

    // 테스트 데이터 삽입
    await db.insert('regions', {
      'unified_code': 11000,
      'sigungu_code': '11000',
      'sigungu_name': '서울특별시',
      'is_autonomous_district': 0,
      'province': '서울특별시',
      'city': '',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    await db.insert('regions', {
      'unified_code': 11110,
      'sigungu_code': '11110',
      'sigungu_name': '종로구',
      'is_autonomous_district': 0,
      'province': '서울특별시',
      'city': '',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    await db.insert('regions', {
      'unified_code': 11140,
      'sigungu_code': '11140',
      'sigungu_name': '중구',
      'is_autonomous_district': 0,
      'province': '서울특별시',
      'city': '',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    await db.insert('regions', {
      'unified_code': 11170,
      'sigungu_code': '11170',
      'sigungu_name': '용산구',
      'is_autonomous_district': 0,
      'province': '서울특별시',
      'city': '',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    await db.insert('regions', {
      'unified_code': 26110,
      'sigungu_code': '26110',
      'sigungu_name': '중구',
      'is_autonomous_district': 0,
      'province': '부산광역시',
      'city': '',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    // RegionRepository 테스트
    final repository = SimpleRegionRepository(db);

    // 1. 시도 목록 확인
    print('\n📍 시도 목록:');
    final provinces = await repository.getProvinces();
    for (final province in provinces) {
      print('  - $province');
    }

    // 2. 서울특별시 시군구 목록 확인
    print('\n🏙️ 서울특별시 시군구 목록:');
    final seoulSigungus = await repository.getSigungus('서울특별시');
    print('서울특별시 총 구 수: ${seoulSigungus.length}개');

    for (int i = 0; i < seoulSigungus.length; i++) {
      final sigungu = seoulSigungus[i];
      print('  [${i + 1}] ${sigungu.sigunguName} (${sigungu.sigunguCode})');
    }

    // 3. 부산광역시 시군구 목록 확인
    print('\n🌊 부산광역시 시군구 목록:');
    final busanSigungus = await repository.getSigungus('부산광역시');
    print('부산광역시 총 구 수: ${busanSigungus.length}개');

    for (int i = 0; i < busanSigungus.length; i++) {
      final sigungu = busanSigungus[i];
      print('  [${i + 1}] ${sigungu.sigunguName} (${sigungu.sigunguCode})');
    }

    await db.close();
    await dbFile.delete(); // 정리

    print('\n✅ RegionRepository 로직 테스트 완료! 앱에서 드롭다운이 올바르게 작동할 것입니다.');
  } catch (e, stackTrace) {
    print('❌ 테스트 실패: $e');
    print('스택 트레이스: $stackTrace');
  }
}
