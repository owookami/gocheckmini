import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;
import '../lib/core/database/database_helper.dart';
import '../lib/core/database/database_schema.dart';
import '../lib/core/database/migrations/sigungu_data_migration.dart';

void main() async {
  print('🔍 데이터베이스 지역 데이터 확인 및 마이그레이션 스크립트');

  // FFI 초기화
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    // 데이터베이스 헬퍼 생성
    final dbHelper = DatabaseHelper();

    print('📂 데이터베이스 초기화 중...');
    final db = await dbHelper.database;
    print('✅ 데이터베이스 연결 성공');

    // 1. regions 테이블 데이터 확인
    print('\n📊 regions 테이블 데이터 확인:');
    final regionCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable}',
    );
    final count = regionCount.first['count'] as int;
    print('  - 총 지역 수: $count');

    if (count == 0) {
      print('\n⚠️  지역 데이터가 없습니다. 마이그레이션을 실행합니다...');

      // 마이그레이션 실행
      final migrationSuccess = await SigunguDataMigration.migrate(dbHelper);

      if (migrationSuccess) {
        print('✅ 마이그레이션 성공');

        // 다시 데이터 확인
        final newRegionCount = await db.rawQuery(
          'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable}',
        );
        final newCount = newRegionCount.first['count'] as int;
        print('  - 마이그레이션 후 지역 수: $newCount');
      } else {
        print('❌ 마이그레이션 실패');
        return;
      }
    }

    // 2. 시/도별 데이터 확인
    print('\n🗺️  시/도별 지역 분포:');
    final provinceData = await db.rawQuery('''
      SELECT province, COUNT(*) as count 
      FROM ${DatabaseSchema.regionsTable} 
      WHERE province IS NOT NULL AND province != ''
      GROUP BY province 
      ORDER BY count DESC
      LIMIT 10
    ''');

    for (final row in provinceData) {
      print('  - ${row['province']}: ${row['count']}개 시/군/구');
    }

    // 3. 샘플 데이터 확인
    print('\n📝 샘플 지역 데이터 (서울특별시):');
    final seoulData = await db.query(
      DatabaseSchema.regionsTable,
      where: 'province = ?',
      whereArgs: ['서울특별시'],
      orderBy: 'sigungu_name',
      limit: 5,
    );

    for (final row in seoulData) {
      print('  - ${row['sigungu_name']} (${row['sigungu_code']})');
    }

    // 4. 테이블 구조 확인
    print('\n🏗️  regions 테이블 구조:');
    final tableInfo = await db.rawQuery(
      'PRAGMA table_info(${DatabaseSchema.regionsTable})',
    );

    for (final column in tableInfo) {
      print('  - ${column['name']}: ${column['type']}');
    }

    print('\n✅ 데이터베이스 확인 완료');
  } catch (e, stackTrace) {
    print('❌ 오류 발생: $e');
    print('Stack trace: $stackTrace');
  }

  // 스크립트가 즉시 종료되지 않도록 잠시 대기
  await Future.delayed(Duration(seconds: 1));
  exit(0);
}
